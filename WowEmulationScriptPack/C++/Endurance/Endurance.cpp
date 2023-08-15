#include "Endurance.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ObjectExtension.h"
#include "ObjectExtension.cpp"
#include "WorldSession.h"
#include "DatabaseEnv.h"
#include "Map.h"
#include "Creature.h"
#include "GameEventCallbacks.h"
#include "GossipDef.h"
#include "GameTime.h"
#include "PersonalInstance\PersonalInstance.h"

#define CREATURE_ENTRY_TO_FIGHT     35465   // Zhaagrym -> should have diminishing returns enabled
#define CREATURE_FACTION_TO_FIGHT   189     // something that is neutral to everyone yet can eb attacked
#define EnduranceScalePerLevel      1.10f   // 10% per level ? So it will take ages to fully scale to your potential. So what ?
#define CREATURE_DMG_BASE           10
#define CREATURE_HEALTH_BASE        8000
#define CREAURE_DMG_SCALE_SCALER    100000  // for the sake of float to into conversion. This will truncate precission
#define CREATURE_RESPAWN_COOLDOWN   2000    // do not allow macro to spam spawns

//static uint32 RandomEntry[] = { 46,126,127,171,285,422,456,458,513,515,517,544,545,548,578,732,735,747,1024,1083,1541,4359,8796,15356,15357,15359,15360,15668,17102,17190 };


bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);

EnduranceStore::EnduranceStore(ObjectGuid pg, int32 pAccountID, int32 pClass)
{
    PlayerGUID = pg;
    AccountID = pAccountID;
    PlayerClass = pClass;
    HighestDefeated = 1;
    LoadFromDB();
    SpawnStamp = 0;
}


void EnduranceStore::LoadFromDB()
{
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "SELECT MAX(HighestDefeated) FROM account_Endurance where CharId=%d", (uint32)PlayerGUID);
    QueryResult result = CharacterDatabase.Query(Query);
    if (result)
    {
        Field* fields = result->Fetch();
        HighestDefeated = fields[0].GetUInt32();
    }
}

void EnduranceStore::SaveToDB()
{
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "REPLACE INTO account_Endurance (CharId, Classid, HighestDefeated, FightDuration) VALUES (%d, %d, %d, %d)", (uint32)PlayerGUID, PlayerClass, HighestDefeated, (uint32)(FightEndedAt - FightStartedAt));
    CharacterDatabase.Execute(Query);
}

uint64  EnduranceStore::GetMSSincePrevSpawn()
{
    return GameTime::GetGameTimeMS() - SpawnStamp;
}

void EnduranceStore::FightStarted(bool ForceReset, uint64 pCreatureGUID)
{
    if(FightStartedAt == 0)
        FightStartedAt = GameTime::GetGameTime();
    if (ForceReset)
        FightStartedAt = 0;
    if (pCreatureGUID != 0)
        CreatureGUID = pCreatureGUID;
}

void EnduranceStore::FightEnded()
{
    FightEndedAt = GameTime::GetGameTime();
    HighestDefeated++;
    SaveToDB();
    FightStartedAt = 0;
}

// 1.01 , 1.02, 1.03.....Level 10 means 10%, level 100 means 100% ?
// 1.05 , 1.10, 1.15.....Level 10 means 50%, level 100 means 500% ?
// 1.10 , 1.20, 1.30.....Level 10 means 10x, level 100 means 10x ?
float  EnduranceStore::GetNextEndurancePCTScaler()
{
    float ret = 1;
    for (int32 i = 0; i < HighestDefeated; i++)
        ret *= EnduranceScalePerLevel;
    return ret;
}

EnduranceStore *GetES(Player *player)
{
    EnduranceStore *pi = player->GetExtension<EnduranceStore>(OE_PLAYER_ENDURANCE_STATUS_STORE);
    if (pi == NULL)
    {
        pi = new EnduranceStore(player->GetGUID(),player->GetSession()->GetAccountId(),player->getClass());
        player->SetExtension<EnduranceStore>(OE_PLAYER_ENDURANCE_STATUS_STORE, pi);
    }
    if (pi == NULL)
    {
        printf("Error, could not allocate memory\n");
        return NULL;
    }
    return pi;
}

bool IsEnduranceOngoind(Player *player)
{
    EnduranceStore *pi = player->GetExtension<EnduranceStore>(OE_PLAYER_ENDURANCE_STATUS_STORE);
    if (pi == NULL)
        return false;
    Creature *et = player->GetMap()->GetCreature(ObjectGuid(pi->GetCreatureGUID()));
    if (et == NULL)
        return false;
    if (et->IsAlive() == false)
        return false;
    return true;
}

void OnEnduranceMobDmgReceived(void *p, void *)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    //in case this is called more than once
    if (params->OriDamage == 0 || params->Attacker == NULL || params->Victim == NULL)
    {
//        printf("No attacker or victim\n");
        return;
    }
    //is the attacker the one who created the endurance mob ? Or is the mob an endurance target ?
    bool IsAttackerEnduranceMob = false;
    Player *plr = params->Attacker->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (plr == NULL)
    {
        //if this is the mob attacking the player. Scale it's damage
        int64 *Scaler10000 = params->Attacker->GetCreateIn64Extension(OE_CREAURE_ENDURANCE_SCALER, true);
        if (Scaler10000 != NULL)
        {
            params->FlatMods += CREATURE_DMG_BASE * (*Scaler10000) / CREAURE_DMG_SCALE_SCALER;
//            printf("Damage is scaled\n");
            return;
        }
        else
        {
//            printf("Attacker is not a player or summon of the endurance mob. Exiting\n");
            params->ForceDamageAbsorb();
            return;
        }
    }
    //if attacker player is not the one who created us. Deny dmg
    int64 *MobSpawner = params->Victim->GetCreateIn64Extension(OE_CREAURE_ENDURANCE_OWNER);
    if (MobSpawner == NULL || (int64)(plr->GetGUID().GetRawValue()) != *MobSpawner)
    {
//        printf("Mob is either not an endurance mob anymore or attacker is not the one who is doung endurance\n");
        params->ForceDamageAbsorb();
        return;
    }
    //mod damage based on map setting
    if (params->Attacker->GetMap() != NULL)
    {
        int64 *InstanceCreator = params->Attacker->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR, true);
        if (InstanceCreator != NULL && (int64)(plr->GetGUID().GetRawValue()) != *InstanceCreator)
        {
//            printf("Instance is a custom map, but player is not the owner. Deny dmg\n");
            params->ForceDamageAbsorb();
            return;
        }
    }
    //in case this is the first hit, mark it as the start of the fight
    EnduranceStore *es = GetES(plr);
    es->FightStarted();
//    printf("Try to trigger fight on hit. Player hit the mob\n");
}

void ScaleEnduranceMobHealthOnSpawn(void *p, void *)
{
    CP_CREATURE_SPAWN *params = PointerCast(CP_CREATURE_SPAWN, p);

    //safety first
    if (params->Spawn == NULL || params->map == NULL)
    {
//        printf("Invalid params. Early exiting\n");
        return;
    }

    //get the creator of us
    uint64 *MobSpawner = (uint64 *)params->Spawn->GetCreateIn64Extension(OE_CREAURE_ENDURANCE_OWNER,true);
    if (MobSpawner == NULL)
    {
//        printf("ScaleEnduranceMobHealthOnSpawn: Mob is not an endurance mob anymore\n");
        return;
    }
    Player *plr = params->map->GetPlayer(ObjectGuid(*MobSpawner));
    if(plr==NULL)
    {
//        printf("Could not find the player who spawned us\n");
        return;
    }

    //check hes endurance status
    EnduranceStore *es = GetES(plr);
    if ( es )
    {
        float Scaler = es->GetNextEndurancePCTScaler();

        //set HP based on instance difficulty
        uint32 MaxHealth = (uint32)( CREATURE_HEALTH_BASE * Scaler);
        if (MaxHealth > 0x0FFFFFFF)
            MaxHealth = 0x0FFFFFFF;
        *params->Spawn->GetCreateExtension<uint32>(OE_CREATURE_ENDURANCE_HEALTH) = MaxHealth;
        params->Spawn->SetCreateHealth(MaxHealth);
        params->Spawn->SetMaxHealth(MaxHealth);
        params->Spawn->SetHealth(MaxHealth);

        //always have level of player to reduce hit / miss chances
        params->Spawn->SetLevel( plr->getLevel() );

        //scale the dmg also
        *params->Spawn->GetCreateIn64Extension(OE_CREAURE_ENDURANCE_SCALER, false, (int64)(Scaler*CREAURE_DMG_SCALE_SCALER));

//        printf("Scaled mob health,lvl,dmg based on endurance level\n");
    }

    //make them run fast to catch up with ranged kiting players
    params->Spawn->SetSpeed(UnitMoveType::MOVE_RUN, plr->GetSpeed(UnitMoveType::MOVE_RUN) * 2.0f);
    params->Spawn->SetSpeed(UnitMoveType::MOVE_WALK, plr->GetSpeed(UnitMoveType::MOVE_WALK) * 2.0f);

    //allow it to fly
    params->Spawn->SetCanFly(true);
    params->Spawn->SetWaterWalking(true);
    params->Spawn->SetHover(true);
    params->Spawn->SetSwim(true);

    //make him PVP enabled
    params->Spawn->SetPvP(true);

    //disable agro range
    params->Spawn->SetFaction(CREATURE_FACTION_TO_FIGHT);

    //it would be enough to have diminishing return on these
/*    {
    static uint32 const placeholderSpellId = std::numeric_limits<uint32>::max();
    for (uint32 i = MECHANIC_NONE + 1; i < MAX_MECHANIC; ++i)
        params->Spawn->ApplySpellImmune(placeholderSpellId, IMMUNITY_MECHANIC, i, true);
    }/**/

    //instead full immunity, grant him the ability for diminishing returns
//    params->Spawn->GetCreatureTemplate()->flags_extra |= CREATURE_FLAG_EXTRA_ALL_DIMINISH;
}

void EnduranceStore::EventSpawnedCreature(Creature *c)
{
    SpawnStamp = GameTime::GetGameTimeMS();
}

void SpawnEnduranceTarget(Player *player)
{
    //if player is not ingame than abandon the plan
    if (player->FindMap() == NULL)
    {
        return;
    }
    //it needs to be a custom instance to summon endurance mode
    if (player->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR) == NULL)
    {
        player->BroadcastMessage("This command can only be used in your own instance");
        return;
    }
    //it needs to be our own custom instance to summon endurance mode
    if (*player->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR) != player->GetGUID().GetRawValue())
    {
        player->BroadcastMessage("This command can only be used in your own instance");
        return;
    }
    if (player->GetMap()->GetPlayers().getSize() != 1)
    {
        player->BroadcastMessage("Too many players present on the map to start endurance");
        return;
    }

    EnduranceStore *es = GetES(player);

    //if there is already a spawn, try to remove it from the map
    if (es->GetCreatureGUID())
    {
        Creature *c = player->GetMap()->GetCreature(ObjectGuid(es->GetCreatureGUID()));
        if (c)
        {
            if (es->GetMSSincePrevSpawn() < CREATURE_RESPAWN_COOLDOWN)
                return; //pretend nothing happened if player is trying to crash the server with a macro
            else
                player->GetMap()->AddObjectToRemoveList(c);
        }
    }
    //uint32 ListSize = sizeof(RandomEntry) / sizeof(uint32);
    //uint32 RandomIndex = rand32() % ListSize;

    //spawn monster
    Creature* creature = new Creature();
    if (!creature->Create(player->GetMap()->GenerateLowGuid<HighGuid::Unit>(), player->GetMap(), player->GetPhaseMaskForSpawn(), CREATURE_ENTRY_TO_FIGHT, *player, NULL, 0, true))
        //if (!creature->Create(player->GetMap()->GenerateLowGuid<HighGuid::Unit>(), player->GetMap(), player->GetPhaseMaskForSpawn(), RandomEntry[RandomIndex], *player, NULL, 0, true))
    {
        delete creature;
        player->BroadcastMessage("Could not spawn creature");
        return;
    }

    //handle internal states
    es->EventSpawnedCreature(creature);

    //mark for this player that our endurance mob exists
    creature->GetCreateIn64Extension(OE_CREAURE_ENDURANCE_OWNER, false, player->GetGUID().GetRawValue());

    //scale mob hp
    //TriggerCallbackFunctions(CALLBACK_TYPE_CREATURE_SPAWN, &CP_CREATURE_SPAWN(creature, player->GetMap()));

    //try tp push it to the map
    if (!player->GetMap()->AddToMap(creature))
    {
        delete creature;
        player->BroadcastMessage("Could not spawn creature");
        return;
    }
    creature->SetHomePosition(creature->GetPosition());

    //register dmg monitor callback. Deny all dmg not comming from player who spawned us. Not like we 
    creature->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, &OnEnduranceMobDmgReceived);
    creature->RegisterCallbackFunc(CALLBACK_TYPE_DMG_RECEIVED, &OnEnduranceMobDmgReceived);
    player->BroadcastMessage("Spawned endurance target %d. You need to be alone in the instance or you will not get your score recorded", es->GetBestLevel());

    // force the fight timer to reset
    es->FightStarted(true, creature->GetGUID().GetRawValue());
}

class TC_GAME_API EnduranceChatListnerScript : public PlayerScript
{
public:
    EnduranceChatListnerScript() : PlayerScript("EnduranceChatListnerScript") {}
    void OnCreatureKill(Player* killer, Creature* killed)
    {
        //        printf("Player killed a creature\n");
        if (killed == NULL)
        {
            //            printf("Killer is missing\n");
            return;
        }
        if (killed->GetExtension<int64>(OE_CREAURE_ENDURANCE_OWNER) == NULL)
        {
            //            printf("Mob is not endurance mob\n");
            return;
        }
        if (*killed->GetCreateIn64Extension(OE_CREAURE_ENDURANCE_OWNER) != (int64)killer->GetGUID().GetRawValue())
        {
            //            printf("Endurance mob owner is not the killer\n");
            return;
        }
        if (killer == NULL)
        {
            //            printf("Killer is null\n");
            return;
        }
        if (killed->GetThreatManager().GetThreatListSize() > 2)
        {
            //            printf("More than 2 attackers. Consider this an unfair fight\n");
            return;
        }
        //enslaved creature ?
        if (killed->GetOwner() != NULL)
        {
            killer->BroadcastMessage("Endurance:Something went fishy. No score awarded. Error 1");
            return;
        }
        //maybe other ways to seduce it ?
        if (killed->GetFaction() != CREATURE_FACTION_TO_FIGHT)
        {
            killer->BroadcastMessage("Endurance:Something went fishy. No score awarded. Error 2");
            return;
        }
        if (*killed->GetCreateExtension<uint32>(OE_CREATURE_ENDURANCE_HEALTH) > killed->GetMaxHealth())
        {
            killer->BroadcastMessage("Endurance:Something went fishy. No score awarded. Error 3");
            return;
        }
        if(killer->GetMap()->GetPlayersCountExceptGMs() > 1)
        {
            killer->BroadcastMessage("Endurance:Something went fishy. No score awarded. Error 4");
            return;
        }
        EnduranceStore *es = GetES(killer);
        if (es->GetCreatureGUID() != killed->GetGUID().GetRawValue())
        {
            //            printf("Not the same endurance creature we spawned earlier\n");
            return;
        }
        //        printf("Mark end of the endurance fight\n");
        killer->BroadcastMessage("Congratulations on killing endurance target level %d", es->GetBestLevel());

        es->FightEnded();

        killer->ModifyMoney((int32)(es->GetBestLevel() + 1) * 50000);
        killer->BroadcastMessage("You won %d Gold, keep going!", (int32)((es->GetBestLevel() + 1))*5);
    }

    void OnPlayerKilledByCreature(Creature* killer, Player* killed)
    {
        if (killer->GetExtension<int64>(OE_CREAURE_ENDURANCE_OWNER) != NULL)
        {
            //destoying object. Eeeeek
            killer->AddObjectToRemoveList();
            return;
        }
    }

    //when we teleport to the map, we will spawn an NPC that you can interract with. He will help you spawn endurance targets ( just in case you did not know about the command )
    void OnMapChanged(Player* player)
    {
        //sanity checks
        if (player == NULL || player->FindMap() == NULL)
            return;

        //we will only spawn this creature in personal instances
        if (player->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL)
            return;

        //in theory there is already an assistant waiting for us that has the endurance menu
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from account_endurance where CharId=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void RBAC_StartEndurance(Player* player) {
    if(player->GetMap()->GetId() == ENDURANCE_MAP)
        SpawnEnduranceTarget(player);
    else
        player->BroadcastMessage("You may not start Endurance here, first enter Endurance Map.");
}

void EnParseClientUserCommand(Player* player, uint32 type, const char *cmsg)
{
    //        printf("got command %s\n", cmsg);
    if (CheckValidClientCommand(cmsg, type, NULL) == false)
    {
        return;
    }
    if (player->GetGroup())
    {
        player->BroadcastMessage("You can not use this command while in a group");
        return;
    }
    //do we want to set the difficulty ?
    if (strstr(cmsg, "#csStartEndurance") == cmsg)
    {
        SpawnEnduranceTarget(player);
    }
}

void EnOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    EnParseClientUserCommand(params->SenderPlayer, params->MsgType, params->Msg->c_str());
}

void AddEnduranceScripts()
{
    //store endurance state, in case server restarts
    //CREATE TABLE `account_endurance` (`AcctId` INT NULL, `CharId` INT NULL, `ClassId` INT NULL, `HighestDefeated` INT NULL, `FightDuration` INT NULL);
    //ALTER TABLE `account_endurance` ADD INDEX `AcctId` (`AcctId`, `CharId`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON account_endurance(AcctId, CharId);
    //alter table `account_endurance` drop column `AcctId`,change `CharId` `CharId` int(12) UNSIGNED NOT NULL, change `Classid` `Classid` int(12) UNSIGNED NULL , change `HighestDefeated` `HighestDefeated` int(12) UNSIGNED NULL , change `FightDuration` `FightDuration` int(12) UNSIGNED NULL , add primary key(`CharId`)
    //some creature that anyone can attack. Murlocks ?

    //make the NPC be able to fly to the player attacking it
    //insert into creature_template_movement values(35465,1,1,1,0);
    //make the NPC attack from far to avoid people abusing terrain can't reach issues
    //update creature_model_info set CombatReach=15 where displayid=1913 

    new EnduranceChatListnerScript();
    RegisterCallbackFunction(CALLBACK_TYPE_CREATURE_SPAWN, ScaleEnduranceMobHealthOnSpawn, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, EnOnChatMessageReceived, NULL);
}
