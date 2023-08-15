#include "ScriptMgr.h"
#include "Unit.h"
#include "Map.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "Player.h"
#include "WorldSession.h"
#include "Map.h"
#include "ObjectExtension.cpp"
#include "Creature.h"
#include "GameEventCallbacks.h"
#include "Group.h"
#include "World.h"
#include "ItemTemplate.h"
#include "Group.h"
#include "DatabaseEnv.h"
#include "GameTime.h"

/*
Adjust difficulty of the next instance you will open
Mobs spawned on difficulty set maps will get their : level, hp, damage changed based on the difficulty set
Mobs spawned on difficulty set maps will get their : loot items, loot gold, loot XP scaled based on the difficulty set
Instance difficulty does not get saved on server restart
TODO : when group finishes ( kills all booses ) in the instance, if they have a difficulty set, they should be recorded in a scoreboard : instance, group players, difficulty, timestamp, time duration
*/
bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);

class TC_GAME_API ScaledInstanceChatListnerScript : public PlayerScript
{
public:
    ScaledInstanceChatListnerScript() : PlayerScript("ScaledInstanceChatListnerScript") {}
    void OnMapChanged(Player* player)
    {
        if (player && player->FindMap() && player->GetMap()->IsDungeon())
        {
            //Register creation time. Just so we can compare close scores
            player->GetMap()->GetCreateIn64Extension(OE_MAP_CREATE_TIME, false, GameTime::GetGameTime());
            SetMapDiffForGroup(player);
        }
    }

    void OnBindToInstance(Player* player, Difficulty difficulty, uint32 mapId, bool permanent, uint8 extendState)
    {
//        printf("!!!! Onbind %d %d %d %d\n", difficulty, mapId, (int)permanent, extendState); // stockade was 0, 34, 0, 1
        if (player && player->FindMap() && player->GetMap()->IsDungeon())
            SetMapDiffForGroup(player);
    }
    void SetMapDiffForGroup(Player* player)
    {
        Player *GroupLeader = player;
        if (GroupLeader->GetGroup() && GroupLeader->GetGroup()->GetLeaderGUID() != GroupLeader->GetGUID())
        {
            ObjectGuid LeaderGUID = GroupLeader->GetGroup()->GetLeaderGUID();
            GroupLeader = sWorld->GetOnlinePlayer(LeaderGUID);
            if (GroupLeader == NULL || GroupLeader->FindMap() == NULL)
                GroupLeader = player;
        }
        int64 DifficultyToUse = 0;
        if (GroupLeader != NULL && GroupLeader->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER) != NULL && *GroupLeader->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER) != 0)
            DifficultyToUse = *GroupLeader->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER);
        else if(player != NULL && player->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER) != NULL && *player->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER) != 0)
            DifficultyToUse = *player->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER);
        if (DifficultyToUse > sWorld->getIntConfig(CONFIG_INSTANCE_MAX_DIFFICULTY))
            DifficultyToUse = sWorld->getIntConfig(CONFIG_INSTANCE_MAX_DIFFICULTY);
//            printf("!!!! Onbind %d\n", player->GetMap()->IsDungeon()); // stockade was 0, 34, 0, 1
        SetMapDifficultyScale(player, DifficultyToUse);
        player->BroadcastMessage("Instance difficulty set to %d %%", (int32)(100+DifficultyToUse));
    }
    void SetMapDifficultyScale(Player *player, int64 Diff)
    {
//        printf("Trying to set map difficulty\n");
        if(player->GetMap())
        {
//            printf("Player has a map and does have instance difficulty set\n");
            int64 *InstanceScaleMap = player->GetMap()->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER);
            if ( InstanceScaleMap == NULL )
            {
//                printf("Map does not have difficulty set yet\n");
                InstanceScaleMap = player->GetMap()->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER);
                *InstanceScaleMap = Diff;
            }
        }
    }
    void OnGiveXP(Player* player, uint32& amount, Unit* victim)
    {
        if (player == NULL || player->FindMap() == NULL)
            return;
        int64 *InstanceScale = player->GetMap()->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER, true);
        if (InstanceScale != NULL)
        {
            int64 PCTScaler = *InstanceScale;
//            printf("Instance difficulty is set to %d. We should modify Xp by %d.\n", (int)*InstanceScale, PCTScaler, (int32)(amount * PCTScaler / 100));
            amount += (uint32)( amount * PCTScaler / 100 );
        }
    }
};

void ScaleMobDamage(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    //in case this is called more than once
    if (params->OriDamage <= 0 || params->Attacker == NULL)
        return;
    if (params->Victim == NULL)
        return;

    if (params->Attacker->GetGUID().IsPlayer())
    {
        //            printf("attacker is a player\n");
        return;
    }
    if (params->Attacker->GetCharmerOrOwnerPlayerOrPlayerItself() != NULL)
    {
        //            printf("attacker is a player summon or something\n");
        return;
    }
    //target needs to be a player or pet
    Player *PlayerTarget = params->Victim->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (PlayerTarget == NULL)
    {
        //            printf("target is not a player or summon\n");
        return;
    }
    //mod damage based on map setting
    int64 *InstanceScale = params->Attacker->GetMap()->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER, true);
    if (InstanceScale != NULL)
    {
        int64 PCTScaler = *InstanceScale;
        //            printf("Instance difficulty is set to %d. We should modify dmg by %d. old dmg %d, new damage %d\n", (int)*InstanceScale, PCTScaler, damage, damage + damage * PCTScaler / 100);
        params->FlatMods += (uint32)(params->OriDamage * PCTScaler / 100);
    }

}

void ScaleMobDamageTaken(void *p, void *context)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    //in case this is called more than once
    if (params->OriDamage <= 0 || params->Attacker == NULL)
        return;
    if (params->Victim == NULL)
        return;

    if (params->Attacker->GetGUID().IsPlayer())
    {
        //            printf("attacker is a player\n");
        return;
    }
    if (params->Attacker->GetCharmerOrOwnerPlayerOrPlayerItself() != NULL)
    {
        //            printf("attacker is a player summon or something\n");
        return;
    }
    //target needs to be a player or pet
    Player *PlayerTarget = params->Victim->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (PlayerTarget == NULL)
    {
        //            printf("target is not a player or summon\n");
        return;
    }
    //mod damage based on map setting
    int64 *InstanceScale = params->Attacker->GetMap()->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER, true);
    if (InstanceScale != NULL)
    {
        int64 PCTScaler = *InstanceScale;
        //            printf("Instance difficulty is set to %d. We should modify dmg by %d. old dmg %d, new damage %d\n", (int)*InstanceScale, PCTScaler, damage, damage + damage * PCTScaler / 100);
        params->FlatMods -= (uint32)(params->OriDamage * PCTScaler * 2 / 100 / 100);
    }

}

void ScaleMobHealthOnSpawn(void *p, void *)
{
    CP_CREATURE_SPAWN *params = PointerCast(CP_CREATURE_SPAWN, p);
    //set HP based on instance difficulty
//    if (map == NULL || spawn == NULL)
//      return;
    if (params->Spawn->GetCreatureData() == NULL)
        return;
    {
        int64 *InstanceScale = params->map->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER, true);
        if (InstanceScale != NULL)
        {
            int64 PCTScaler = *InstanceScale;

//            int64 MaxHealth = params->Spawn->GetCreatureData()->curhealth;
            int64 MaxHealth = params->Spawn->GetCreateHealth();
            MaxHealth += MaxHealth * PCTScaler / 100;
            if (MaxHealth > 0x0FFFFFFF)
                MaxHealth = 0x0FFFFFFF;
            if (MaxHealth > 0)
            {
                params->Spawn->SetCreateHealth((uint32)MaxHealth);
                params->Spawn->SetMaxHealth((uint32)MaxHealth);
                params->Spawn->SetHealth((uint32)MaxHealth);
            }

            int64 Level = params->Spawn->GetCreatureTemplate()->minlevel;
            //Level += Level * PCTScaler / 10 / 100; // at 1000%( or 10x ) instance this would do 2x lvl ?
            Level += Level * PCTScaler / 4 / 100; // at 1000%( or 10x ) instance this would do 5x lvl ?
            if (Level > DEFAULT_MAX_LEVEL)
                Level = DEFAULT_MAX_LEVEL;
            if (Level < 1)
                Level = 1;
            params->Spawn->SetLevel((uint8)Level);

//            printf("Instance difficulty is set to %d. We should modify health by %d%%\n", (int)*InstanceScale, PCTScaler);
        }
//        else printf("Spawning a mob. This map does not have a difficulty scale set yet\n");
    }
}

void ScaleMobDropsOnLoot(void *p, void *)
{
    CP_LOOT_ROLL_CHANCE *params = PointerCast(CP_LOOT_ROLL_CHANCE, p);
//    printf("asking for modified loot drop chance. has loot owner %d\n", params->LooterPlayer != NULL);
    //set loot chance based on instance difficulty
    if (params->LooterPlayer != NULL && params->LooterPlayer->GetMap() != NULL )
    {
        Map *map = params->LooterPlayer->GetMap();
        int64 *InstanceScale = map->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER, true);
        if (InstanceScale != NULL)
        {
            int64 PCTScaler = *InstanceScale;
            float DropChance = *params->chance;
            DropChance += DropChance * PCTScaler / 100.0f;
            //stop dropping crap. leave room for good loot : 
            if (params->Item)
            {
                if (PCTScaler >= 300 && params->Item->InventoryType == INVTYPE_NON_EQUIP)
                    DropChance = 0.01f;
                if (PCTScaler >= 200 && params->Item->Quality <= 1)
                    DropChance = 0.01f;
                else if (PCTScaler >= 100 && params->Item->Quality <= 0)
                    DropChance = 0.01f;
            }
//            printf("Instance difficulty is set to %d. We should modify dropchance by %d. Old chance %f, new chance %f\n", (int)*InstanceScale, PCTScaler, *params->chance, DropChance);
            *params->chance = DropChance;
        }
//        else printf("Rolling for mob loot\n");
    }
}

void ScaleMobGoldDropOnLoot(void *p, void *)
{
    CP_INT32_PARAM *params = PointerCast(CP_INT32_PARAM, p);
    //    printf("asking for modified loot drop chance. has loot owner %d\n", params->LooterPlayer != NULL);
    //set loot chance based on instance difficulty
    if (params->Player != NULL && params->Player->GetMap() != NULL)
    {
        Map *map = params->Player->GetMap();
        int64 *InstanceScale = map->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER, true);
        if (InstanceScale != NULL)
        {
            int64 PCTScaler = *InstanceScale;
            float DropChance = (float)(*params->Value);
            DropChance += DropChance * PCTScaler / 100.0f;
//            printf("Instance difficulty is set to %d. We should modify dropchance by %d. Old chance %f, new chance %f\n", (int)*InstanceScale, PCTScaler, *params->chance, DropChance);
            *params->Value = (int32)DropChance;
        }
        //        else printf("Rolling for mob loot\n");
    }
}

void SIParseClientUserCommand(Player* player, uint32 type, const char *cmsg)
{
    //        printf("got command %s\n",cmsg);
    if (CheckValidClientCommand(cmsg, type, NULL) == false)
        return;
    //do we want to set the difficulty ?
    const char *CommandStart = strstr(cmsg, "#csInstanceDiffSet "); //addon message does not start at the beggining
    if (CommandStart != NULL)
    {
        int32 InstanceDiff = atoi(CommandStart + strlen("#csInstanceDiffSet "));
        if (InstanceDiff > 2000)
            InstanceDiff = 2000; // make mobs stronger
        if (InstanceDiff < -90)
            InstanceDiff = -90;  // make mobs weaker
        *player->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER) = InstanceDiff;
        //            printf("want to set instance diff to %d\n", InstanceDiff);
        player->BroadcastMessage("Instance difficulty set to %d %%. Only new instances will inherit this difficulty. Group Leader setting will be used if in group.", (100 + InstanceDiff));

        //            SetMapDifficultyScale(player);//just because debugging
    }
}

void SIOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    SIParseClientUserCommand(params->SenderPlayer, params->MsgType, params->Msg->c_str());
}

void AddScalingInstancesScripts()
{
    //CREATE TABLE `group_InstanceClears` ( `MapId` INT NULL, `Difficulty` INT NULL, `DifficultyScaler` INT NULL, `ClearTime` INT NULL, `PlayerGuidList` CHAR(250) NULL );

    new ScaledInstanceChatListnerScript();
//    new MobScalerAI();
    RegisterCallbackFunction(CALLBACK_TYPE_CREATURE_SPAWN, ScaleMobHealthOnSpawn, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_LOOT_ITEM_ROOL, ScaleMobDropsOnLoot, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_LOOT_GOLD_GENERATED, ScaleMobGoldDropOnLoot, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, SIOnChatMessageReceived, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_DMG_DONE, ScaleMobDamage, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_DMG_RECEIVED, ScaleMobDamageTaken, NULL);
}

