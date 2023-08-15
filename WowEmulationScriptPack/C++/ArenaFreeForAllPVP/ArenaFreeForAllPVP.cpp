#include "World.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "CreatureAI.h"
#include "Creature.h"
#include "Map.h"
#include "ObjectExtension.cpp"
#include "WorldSession.h"
#include "Item.h"
#include "ArenaFreeForAllPVPStore.h"
#include "DatabaseEnv.h"

void GenerateArenaFFAMenuForPlayerWithChecks(Player *Plr, Creature *me);
void TogglePlayerQueueArenaFFA(Player *player, uint32 ArenaFFAGUID);

class ArenaFFAQueueNPC : public CreatureScript
{
public:
    ArenaFFAQueueNPC() : CreatureScript("ArenaFFAQueueNPC") { }

    struct ArenaFFAQueueNPCAI : public CreatureAI
    {
        ArenaFFAQueueNPCAI(Creature* creature) : CreatureAI(creature) {}
        ~ArenaFFAQueueNPCAI()
        {
        }
        void UpdateAI(uint32 diff) override {}//does nothing unless we say so

                                              //construct gossip menu to show to player
        bool GossipHello(Player* Plr)
        {

            GenerateArenaFFAMenuForPlayerWithChecks(Plr, me);

            //handled like a pro
            return true;
        }

        //when player clicks on a gossip menu, we call the callback function
        bool GossipSelect(Player* Plr, uint32 menuId, uint32 gossipListId)
        {
            uint32 const IntId = Plr->PlayerTalkClass->GetGossipOptionAction(gossipListId);

            //if player was queued, unque, else register to queue
            TogglePlayerQueueArenaFFA(Plr, IntId);

            CloseGossipMenuFor(Plr);
            return true;
        }
    };
    CreatureAI* GetAI(Creature* creature) const override
    {
        return new ArenaFFAQueueNPCAI(creature);
    }
};

class TC_GAME_API ArenaFFAScoreRegisterScript : public PlayerScript
{
public:
    ArenaFFAScoreRegisterScript() : PlayerScript("ArenaFFAScoreRegisterScript") {}

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_ArenaFFA where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void UpdateFFAPVPEventStatus(void *p, void *context);
void AddArenaFreeForAllPVPScripts()
{
    /*
    // Queue NPC
    INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (123466, 0, 0, 0, 0, 0, 7342, 28586, 7951, 0, 'PVPMassacre queue', '', '', 0, 80, 80, 0, 35, 3, 1, 1.14286, 2, 0, 0, 2000, 2000, 1, 1, 1, 768, 2048, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 3, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 'ArenaFFAQueueNPC', 12340);
    // Queue NPC offer queue
    INSERT INTO npc_text (id,text0_0) VALUES (100,"The queue is closed for now. Wait for the current match to finish.");
    INSERT INTO npc_text (id,text0_0) VALUES (101,"The PVPMassacre is a free for all PVP game. The player that survives the event will be the winner. You all start in an arena map and clash on each other until only one survives");
    //highscores
    CREATE TABLE IF NOT EXISTS `character_ArenaFFA` (
    `GUID` int(11) NOT NULL,
    `WinCount` int(11) DEFAULT NULL,
    UNIQUE KEY `relation` (`GUID`),
    KEY `RowUniqueId` (`GUID`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
    */

    new ArenaFFAQueueNPC();

    RegisterCallbackFunction(CALLBACK_TYPE_MAP_PERIODIC_UPDATE, UpdateFFAPVPEventStatus, NULL);

    ArenaFreeForAllPVPStore *GoodForAll = new ArenaFreeForAllPVPStore;
    GoodForAll->SetName("PVPMassacre");
    GoodForAll->AddMapToSpawnOn(WorldLocation(615, 3245, 527, 60, 4.6f));
    GoodForAll->AddMapToSpawnOn(WorldLocation(576, 301, -5.4f, -14, 3.1f));
    GoodForAll->AddMapToSpawnOn(WorldLocation(616, 758, 1302, 267, 2.39f));
    GoodForAll->AddMapToSpawnOn(WorldLocation(578, 959, 1048, 360, 0.0f));
    GoodForAll->AddMapToSpawnOn(WorldLocation(608, 1890, 809, 39, 4.3f));
    GoodForAll->AddMapToSpawnOn(WorldLocation(632, 5298, 2504, 687, 3.0f));
    ArenaFFAPVPs.push_back(GoodForAll);
}
