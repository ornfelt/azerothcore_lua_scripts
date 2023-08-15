/*
- Gossip to teleport to your own personal instance
- load instance content
- load player settings : max allowed gameobjects
- add GM commands to add / select / delete gameobjects in your instance. Most be limited to X amount fo spawns
- add GM command to summon a player to your map
- add GM command to kick all players from map
- save instance
- on player delete delete all spawns from instance

possible later features :
 - perform endurance with mobs
 - perform duel bot challange
 - perform 3D maze challange
 - make personal upgrades
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "ObjectExtension.cpp"
#include "PersonalInstance.h"
#include "MapManager.h"
#include "GridNotifiers.h"
#include "DatabaseEnv.h"
#include "World.h"
#include "Group.h"

#define DEBUG_PERSONAL_INSTANCE         false //show debug info in console

const char *FindNextParam(const char *str);
int FindNextIntParam(const char *str);
bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);
void InitAssistant();
void InitFollowingAssistant();
void SpawnAssistantFollowing(Player *player);

PersonalInstanceStore *GetPIS(Player *player)
{
    PersonalInstanceStore *pi = player->GetExtension<PersonalInstanceStore>(OE_PLAYER_CUSTOM_INSTANCE_STORE);
    if (pi == NULL)
    {
        pi = new PersonalInstanceStore(player);
        player->SetExtension<PersonalInstanceStore>(OE_PLAYER_CUSTOM_INSTANCE_STORE, pi);
    }
    if (pi == NULL)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Error, could not allocate memory\n");   // should never happen
        return NULL;
    }
    return pi;
}

Map *GetPersonalMap(Player *player, uint32 MapId, bool CreateNew = true)
{
    PersonalInstanceStore *pi = GetPIS(player);
    return pi->GetPersonalMap(MapId, CreateNew);
}

Map *GetQueuedPersonalMap(Player *player, uint32 MapId)
{
    ScriptQueuedMapJoin *QI = player->GetExtension<ScriptQueuedMapJoin>(OE_PLAYER_QUEUE_JOIN_SPECIFIC_INSTANCE);
    if (QI != NULL
//        && player->GetGroup() == NULL
        )
    {
        if (QI->MapId == MapId)
        {
            uint32 InstanceId = QI->InstanceId;
            //remove this map from the queue
            player->DeleteExtension<ScriptQueuedMapJoin>(OE_PLAYER_QUEUE_JOIN_SPECIFIC_INSTANCE);
            //teleporting to an already existing instance ?
            if(InstanceId)
                return sMapMgr->FindMap(MapId, InstanceId);
            // check if we have personalized instances initialized
            return GetPersonalMap(player, MapId);
        }
    }
    else
    {
        Map *newMap = sMapMgr->CreateMap(MapId, player);
        if (newMap->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) != NULL)
        {
            // unbind this instance from us, let him enter a normal instance
            player->UnbindInstance(MapId, Difficulty::DUNGEON_DIFFICULTY_NORMAL);
        }
    }
    return NULL;
}

void CheckRedirectToPersonalInstance(void *p, void *Context)
{
    CP_MAP_CHANGED *params = PointerCast(CP_MAP_CHANGED, p);
    Map *RedirectToMap = GetQueuedPersonalMap(params->Player, params->NewMap->GetId());
    if (RedirectToMap != NULL)
        *params->pNewMap = RedirectToMap;
}

//this does not make the player teleport. Instead, if the player tries to teleport to this map id, he will be teleported to the custom version
void QueueTeleportSpecificMap(Player *player, Map *map)
{
    PersonalInstanceStore *pi = GetPIS(player);
    pi->QueuePersonalInstanceNextTeleport(player, map);
}

void TeleportToPersonalInstanceMap(Player *player, int MapId, bool LoadPersonalSpawns = false)
{
    // check if we have personalized instances initialized
    PersonalInstanceStore *pi = GetPIS(player);
    pi->TeleportPlayerToPersonalInstance(player, MapId);
}

void TeleportToPersonalInstanceMapWithChecks(Player *player, int MapId, bool LoadPersonalSpawns = false)
{
    // check if we have personalized instances initialized
    if (player->IsInCombat())
    {
        player->BroadcastMessage("You can not use this command while in combat");
        return;
    }
    if (player->IsInFlight())
    {
        player->BroadcastMessage("You can not use this command while flying");
        return;
    }
    if (player->GetGroup())
    {
        player->BroadcastMessage("You can not use this command while in a group");
        return;
    }
    if (player->GetExtension<ScriptQueuedMapJoin>(OE_PLAYER_QUEUE_JOIN_SPECIFIC_INSTANCE) != NULL)
    {
        player->BroadcastMessage("You are queued for a teleport. Please wait");
        return;
    }
    if (player->FindMap() && (player->GetMap()->IsDungeon() == true || player->GetMap()->IsBattlegroundOrArena() == true) && player->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL)
    {
        player->BroadcastMessage("You can't teleport from here.");
        return;
    }
    //check if we are allowed to use this map ID for this account
    PersonalInstanceStore *pi = GetPIS(player);
    if (pi->CanAccesMap(MapId) == false && player->isGMVisible() == false)
    {
        player->BroadcastMessage("You can't access this map as personal instance.");
        return;
    }
    TeleportToPersonalInstanceMap(player, MapId, true);
}

void FlightToggle(Player *player, bool Enable)
{
    //sanity checks
    if (player == NULL || player->GetSession() == NULL)
        return;

    WorldPacket data(12);
    if (Enable==true)
        data.SetOpcode(SMSG_MOVE_SET_CAN_FLY);
    else
        data.SetOpcode(SMSG_MOVE_UNSET_CAN_FLY);
    data << player->GetPackGUID();
    data << uint32(0);                                      // unknown
    player->SendMessageToSet(&data, true);
}

bool IsEnduranceOngoind(Player *player);
class TC_GAME_API PersonalInstanceChatListnerScript : public PlayerScript
{
public:
    PersonalInstanceChatListnerScript() : PlayerScript("PersonalInstanceChatListnerScript") {}
    void OnMapChanged(Player* player)
    {
        //sanity checks
        if (player == NULL || player->FindMap() == NULL)
            return;

        // make sure this is a custom map
        if (player->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL || *player->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR) != (int64)player->GetGUID().GetRawValue())
        {
            FlightToggle(player, false);
            return;
        }

        // load our current spawns on it, if not yet loaded
        PersonalInstanceStore *pi = GetPIS(player);
        pi->OnMapChanged(player);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from account_PersonalMapSpawns where AcctId=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void PersonalInstanceSummonPlayer(Player *Summoner, const char *SummonedPlayerName)
{
    if (SummonedPlayerName == NULL)
        return;
    if (Summoner->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL || *Summoner->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR) != (int64)Summoner->GetGUID().GetRawValue())
    {
        Summoner->BroadcastMessage("Command can only be used in personal instance");
        return;
    }
    //get this online player
    Player* SummonedPlayer = ObjectAccessor::FindPlayerByName(std::string(SummonedPlayerName));
    if (SummonedPlayer == NULL)
    {
        Summoner->BroadcastMessage("Summon Error:Could not find player with that name");
        return;
    }
    if (SummonedPlayer == Summoner)
    {
        Summoner->BroadcastMessage("Summon Error:Can't self summon");
        return;
    }
    if (IsEnduranceOngoind(Summoner))
    {
        Summoner->BroadcastMessage("Summon Error:Can't summon while endurance target is present");
        return;
    }
    //tell the player we are trying to summon him
    SummonedPlayer->BroadcastMessage("PersonalInstance: %s is trying to summon you. Type #csAccpetSummon", Summoner->GetName().c_str());
    ScriptQueuedMapJoin *ss = SummonedPlayer->GetCreateExtension<ScriptQueuedMapJoin>(OE_PLAYER_PERSONAL_INSTANCE_SUMMON_STORE);
    ss->Summoner = Summoner->GetGUID();
    ss->InstanceId = Summoner->GetMap()->GetInstanceId();
    ss->Pos = Summoner->GetWorldLocation();
    Summoner->BroadcastMessage("Summon invitation has been sent to %s", SummonedPlayer->GetName().c_str());
}

void PersonalInstanceKickPlayer(Player *Kicker, const char *KickedPlayerName)
{
    if (KickedPlayerName == NULL)
        return;
    if (Kicker->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL || *Kicker->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR) != (int64)Kicker->GetGUID().GetRawValue())
    { 
        Kicker->BroadcastMessage("Command can only be used in personal instance");
        return; 
    }
    //get this online player
    Player* KickedPlayer = ObjectAccessor::FindPlayerByName(std::string(KickedPlayerName));
    if (KickedPlayer == NULL)
    {
        Kicker->BroadcastMessage("Kick Error:Could not find player with that name");
        return;
    }
    if (KickedPlayer == Kicker)
    {
        Kicker->BroadcastMessage("Kick Error:Can't self kick");
        return;
    }
    if (KickedPlayer->GetMap() != Kicker->GetMap())
    {
        Kicker->BroadcastMessage("Kick Error:Player is not in this map");
        return;
    }

    //tell the player we are trying to summon him
    KickedPlayer->BroadcastMessage("PersonalInstance: %s kicked you out of the instance", Kicker->GetName().c_str());
    KickedPlayer->TeleportTo(KickedPlayer->m_homebindMapId, KickedPlayer->m_homebindX, KickedPlayer->m_homebindY, KickedPlayer->m_homebindZ, 0.0f);
    Kicker->BroadcastMessage("Player %s has been kicked", KickedPlayer->GetName().c_str());
}

void PersonalInstanceKickAllPlayers(Player *Kicker)
{
    if (Kicker->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL || *Kicker->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR) != (int64)Kicker->GetGUID().GetRawValue())
    {
        Kicker->BroadcastMessage("Command can only be used in personal instance");
        return;
    }
    Map::PlayerList const& players = Kicker->GetMap()->GetPlayers();
    if (!players.isEmpty())
        for (Map::PlayerList::const_iterator it = players.begin(); it != players.end(); ++it)
        {
            Player* KickedPlayer = it->GetSource();
            if (KickedPlayer != NULL && KickedPlayer != Kicker)
            {
                KickedPlayer->BroadcastMessage("PersonalInstance: %s kicked you out of the instance", Kicker->GetName().c_str());
                KickedPlayer->TeleportTo(KickedPlayer->m_homebindMapId, KickedPlayer->m_homebindX, KickedPlayer->m_homebindY, KickedPlayer->m_homebindZ, 0.0f);
            }
        }
    Kicker->BroadcastMessage("All players have been kicked out of this instance");
}

void PIParseClientUserCommand(Player* player, uint32 type, const char *cmsg)
{
    if (DEBUG_PERSONAL_INSTANCE) printf("got command %s\n", cmsg);
    if (CheckValidClientCommand(cmsg, type, NULL) == false)
    {
        return;
    }

    //do we want to set the difficulty ?
    if (strstr(cmsg, "#csEnterMyInstance ") == cmsg)
    {
        uint32 MapId = FindNextIntParam(cmsg);

        //queue player to teleport to own instance. Map will be created when entering world. Hook adding personal spawns when he enters that world
        TeleportToPersonalInstanceMapWithChecks(player, MapId, true);
    }

#define CHECK_PERSONAL_INSTANCE_IS_OURS             if (player->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL || *player->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR) != (int64)player->GetGUID().GetRawValue()) \
        { \
            player->BroadcastMessage("Command can only be used in personal instance"); \
            return; \
        }

    if (strstr(cmsg, "#csMyInstanceSpawnCreature ") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

            //is the creature a valid creature entry ?
        int CreatureEntry = FindNextIntParam(cmsg);
        if (CreatureEntry == 0)
        {
            player->BroadcastMessage("Creature entry is not valid : %d", CreatureEntry);
            return;
        }

        //spawn the creature and add it to DB
        PersonalInstanceStore *pi = GetPIS(player);
        pi->SpawnCreature(player, CreatureEntry, &player->GetPosition(), false);
    }

    if (strstr(cmsg, "#csMyInstanceDeleteCreature") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

        Creature *obj = player->GetMap()->GetCreature(player->GetTarget());
        if (obj == NULL)
        {
            player->BroadcastMessage("You need to select a creature first");
            return;
        }
        //spawn the creature and add it to DB
        PersonalInstanceStore *pi = GetPIS(player);
        pi->DeleteCreature(player, obj);
    }

    if (strstr(cmsg, "#csMyInstanceSpawnGameObject ") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

            //is the creature a valid creature entry ?
        int GOEntry = FindNextIntParam(cmsg);
        if (GOEntry == 0)
        {
            player->BroadcastMessage("GameObject entry is not valid : %d", GOEntry);
            return;
        }

        //spawn the creature and add it to DB
        PersonalInstanceStore *pi = GetPIS(player);
        pi->SpawnGameObject(player, GOEntry, &player->GetPosition(), false);
    }

    if (strstr(cmsg, "#csMyInstanceSelectGameObject") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

        GameObject* obj = nullptr;
        Trinity::NearestGameObjectCheck check(*player);
        Trinity::GameObjectLastSearcher<Trinity::NearestGameObjectCheck> searcher(player, obj, check);
        Cell::VisitGridObjects(player, searcher, SIZE_OF_GRIDS);
        if (obj == NULL)
        {
            player->BroadcastMessage("No nearby object to select");
            return;
        }

        //make the player select this gameobject
        player->SetSelection(obj->GetGUID());

        //show the player some quick info about the selected object to make sure he selected what he wanted
        GameObjectTemplate const* gameObjectInfo = obj->GetGOInfo();
        if (!gameObjectInfo)
        {
            printf("The impossible happened. Found a spawned GO without a template\n");
            return;
        }
        player->BroadcastMessage("Selected:%s, Entry:%d, Display:%d, Type:%d", gameObjectInfo->name.c_str(), gameObjectInfo->entry, gameObjectInfo->displayId, gameObjectInfo->type);
    }

    if (strstr(cmsg, "#csMyInstanceDeleteGameObject") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

        GameObject *obj = player->GetMap()->GetGameObject(player->GetTarget());
        if (obj == NULL)
        {
            player->BroadcastMessage("You need to select an object first. Maybe use : #csMyInstanceSelectGameObject ?");
            return;
        }
        //spawn the creature and add it to DB
        PersonalInstanceStore *pi = GetPIS(player);
        pi->DeleteGameObject(player, obj);
    }

    if (strstr(cmsg, "#csMyInstanceFly ") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

            const char *args = FindNextParam(cmsg);
        if (strncmp(args, "on", 3) == 0)
            FlightToggle(player, true);
        else if (strncmp(args, "off", 4) == 0)
            FlightToggle(player, false);
    }

    if (strstr(cmsg, "#csMyInstanceSummonPlayer ") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

        const char *args = FindNextParam(cmsg);
        if (args == NULL || args[0] == 0)
        {
            player->BroadcastMessage("Summon Error:Invalid player name");
            return;
        }
        PersonalInstanceSummonPlayer(player, args);
    }
    if (strstr(cmsg, "#csAcceptSummon") == cmsg)
    {
        if (player->GetMap()->IsBattlegroundOrArena() == true)
        {
            player->BroadcastMessage("Summon error: Can't accept summon wile in BG");
            return;
        }
        if (player->IsInCombat() == true)
        {
            player->BroadcastMessage("Summon error: Can't accept summon wile in combat");
            return;
        }
        ScriptQueuedMapJoin *ss = player->GetExtension<ScriptQueuedMapJoin>(OE_PLAYER_PERSONAL_INSTANCE_SUMMON_STORE);
        if (ss == NULL)
        {
            player->BroadcastMessage("Summon error: Can't accept summon without invite");
            return;
        }
        Player *SummoningPlayer = sWorld->GetOnlinePlayer(ss->Summoner);
        if (SummoningPlayer == NULL)
        {
            player->BroadcastMessage("Summon error: Can't accept summon. Summoner no longer ingame");
            return;
        }
        if(SummoningPlayer->GetInstanceId() != ss->InstanceId)
        {
            player->BroadcastMessage("Summon error: Can't accept summon. Summoner no longer in instance");
            return;
        }
        if (IsEnduranceOngoind(SummoningPlayer))
        {
            player->BroadcastMessage("Summon Error:Can't summon while endurance target is present");
            return;
        }

        //force player teleport to redirect him to this specific instance
       ScriptQueuedMapJoin *QI = player->GetCreateExtension<ScriptQueuedMapJoin>(OE_PLAYER_QUEUE_JOIN_SPECIFIC_INSTANCE);
       QI->MapId = ss->Pos.GetMapId();
       QI->InstanceId = ss->InstanceId;

       //bind player to the destination player instance
       PersonalInstanceStore *pi = GetPIS(SummoningPlayer);
       pi->BindToPersonalInstance(player, SummoningPlayer->GetMap());

       //initiate the teleport
       player->TeleportTo(ss->Pos, TELE_TO_GM_MODE);

       //we no longer need to handle accept anymore
       player->DeleteExtension<ScriptQueuedMapJoin>(OE_PLAYER_PERSONAL_INSTANCE_SUMMON_STORE);
    }

    if (strstr(cmsg, "#csMyInstanceKickPlayer ") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

        const char *args = FindNextParam(cmsg);
        if (args == NULL || args[0] == 0)
        {
            player->BroadcastMessage("Kick Error:Invalid player name");
            return;
        }
        PersonalInstanceKickPlayer(player, args);
    }

    if (strstr(cmsg, "#csMyInstanceKickPlayers") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS
        PersonalInstanceKickAllPlayers(player);
    }

    if (strstr(cmsg, "#csMyInstanceLeave") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS
        PersonalInstanceStore *PIS = GetPIS(player);
        player->TeleportTo(PIS->GetEntrancePoint());
    }

    if (strstr(cmsg, "#csMyInstanceReload") == cmsg)
    {
        player->DeleteExtension<PersonalInstanceStore>(OE_PLAYER_CUSTOM_INSTANCE_STORE);
        player->BroadcastMessage("Make sure to leave and reset your personal instance if you expect new data to be visible");
    }

    if (strstr(cmsg, "#csSpawnAssistant") == cmsg)
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS
        SpawnAssistantFollowing(player);
        player->BroadcastMessage("Personal assistant has been respawned");
    }

}

void RBAC_HomeCommands(Player *player, int type, const char *entryId) {
    if (type == 0) //spawn creature
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

        //is the creature a valid creature entry ?
        int CreatureEntry = atoi(entryId);
        if (CreatureEntry == 0)
        {
            player->BroadcastMessage("Creature entry is not valid : %s", entryId);
            return;
        }

        //spawn the creature and add it to DB
        PersonalInstanceStore *pi = GetPIS(player);
        pi->SpawnCreature(player, CreatureEntry, &player->GetPosition(), false);
    }

    if (type == 1) //delete creature
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

        Creature *obj = player->GetMap()->GetCreature(player->GetTarget());
        if (obj == NULL)
        {
            player->BroadcastMessage("You need to select a creature first");
            return;
        }
        //spawn the creature and add it to DB
        PersonalInstanceStore *pi = GetPIS(player);
        pi->DeleteCreature(player, obj);
    }

    if (type == 2) //spawn game object
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

        //is the creature a valid creature entry ?
        int GOEntry = atoi(entryId);
        if (GOEntry == 0)
        {
            player->BroadcastMessage("GameObject entry is not valid : %s", entryId);
            return;
        }

        //spawn the creature and add it to DB
        PersonalInstanceStore *pi = GetPIS(player);
        pi->SpawnGameObject(player, GOEntry, &player->GetPosition(), false);
    }

    if (type == 3) //select game object
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

            GameObject* obj = nullptr;
        Trinity::NearestGameObjectCheck check(*player);
        Trinity::GameObjectLastSearcher<Trinity::NearestGameObjectCheck> searcher(player, obj, check);
        Cell::VisitGridObjects(player, searcher, SIZE_OF_GRIDS);
        if (obj == NULL)
        {
            player->BroadcastMessage("No nearby object to select");
            return;
        }

        //make the player select this gameobject
        player->SetSelection(obj->GetGUID());

        //show the player some quick info about the selected object to make sure he selected what he wanted
        GameObjectTemplate const* gameObjectInfo = obj->GetGOInfo();
        if (!gameObjectInfo)
        {
            printf("The impossible happened. Found a spawned GO without a template\n");
            return;
        }
        player->BroadcastMessage("Selected:%s, Entry:%d, Display:%d, Type:%d", gameObjectInfo->name.c_str(), gameObjectInfo->entry, gameObjectInfo->displayId, gameObjectInfo->type);
    }

    if (type == 4) //delete game object
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

            GameObject *obj = player->GetMap()->GetGameObject(player->GetTarget());
        if (obj == NULL)
        {
            player->BroadcastMessage("You need to select an object first. Maybe use : #csMyInstanceSelectGameObject ?");
            return;
        }
        //spawn the creature and add it to DB
        PersonalInstanceStore *pi = GetPIS(player);
        pi->DeleteGameObject(player, obj);
    }

    if (type == 5) //fly
    {
        CHECK_PERSONAL_INSTANCE_IS_OURS

        if (strncmp(entryId, "on", 3) == 0)
            FlightToggle(player, true);
        else if (strncmp(entryId, "off", 4) == 0)
            FlightToggle(player, false);
    }
}

void PIOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    PIParseClientUserCommand(params->SenderPlayer, params->MsgType, params->Msg->c_str());
}

void AddPersonalInstanceScripts()
{
    //CREATE TABLE `account_PersonalMapSettings` ( `AcctId` INT NULL, `CreatureLimit` INT NULL, `GameobjectLimit` INT NULL );
    //ALTER TABLE `account_PersonalMapSettings` ADD INDEX `AcctId` (`AcctId`) USING BTREE;

    //CREATE TABLE `account_PersonalMaps` ( `AcctId` INT NULL, `MapId` INT NULL );
    //ALTER TABLE `account_PersonalMaps` ADD INDEX `AcctId` (`AcctId`, `MapId`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON account_PersonalMaps (AcctId, MapId);

    //CREATE TABLE `account_PersonalMapAllowedEntries` ( `AcctId` INT NULL, `SpawnType` INT NULL, `SpawnEntry` INT NULL );

    //CREATE TABLE `account_PersonalMapSpawns` ( `AcctId` INT NULL, `MapId` INT NULL, `x` float NULL, `y` float NULL, `z` float NULL, `o` float NULL, `Entry` INT NULL, `SpawnType` INT NULL );
    //ALTER TABLE `account_PersonalMapSpawns` ADD INDEX `AcctId` (`AcctId`, `MapId`) USING BTREE;

    //REPLACE INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (123457, 0, 0, 0, 0, 0, 27572, 0, 0, 0, 'Instance assistant', '', '', 0, 80, 80, 0, 35, 3, 1, 1.14286, 3, 0, 0, 2000, 2000, 1, 1, 1, 768, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 'PersonalInstanceAssistantNPC', 12340);
    //insert into `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) values('123465','0','0','0','0','0','26725','0','0','0','Assistant','','','0','80','80','2','35','1','1','0.99206','0.2','0','0','2000','2000','1','1','1','32768','2048','0','0','0','0','0','0','6','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','','0','2','1','1','1','1','1','0','0','1','8388624','0','0','FollowingPersonalInstanceAssistantNPC','12340');
    //INSERT INTO `creature_template_movement` VALUES (123465, 2, 1, 1, 0);
    //INSERT INTO `creature_template_addon` VALUES (123465, 0, 0, 50331648, 257, 0, '');
    //INSERT INTO npc_text (id,text0_0) VALUES (100,"You can create macros to most of these commands. Check forum for more info");


    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, PIOnChatMessageReceived, NULL);

    new PersonalInstanceChatListnerScript();

    RegisterCallbackFunction(CALLBACK_TYPE_PLAYER_MAP_CHANGE, CheckRedirectToPersonalInstance, NULL);
    InitAssistant();
    InitFollowingAssistant();
}
