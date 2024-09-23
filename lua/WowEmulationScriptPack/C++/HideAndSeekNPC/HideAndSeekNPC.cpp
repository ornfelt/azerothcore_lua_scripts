#include "ScriptMgr.h"
#include "Creature.h"
#include "Map.h"
#include "Random.h"
#include "DatabaseEnv.h"
#include "Player.h"
#include "GameEventCallbacks.h"

#define NUMBER_OF_ACTIVE_HIDE_AND_SEEK_SPAWNS   20
#define CreatureEntryToBeFound                  123460
#define CreatureFactionCanBeKilled              189

// needs periodic update
// needs to track active spawns
// needs to be able to pick a new random accesible location
// should give out hints about location
// needs clickable NPC

struct HideAndSeekNPCSpawn
{
    Position    pos;
    uint32      map;
    ObjectGuid  GUID;
};

class HideAndSeekSupervisor
{
public:
    //init locations
    HideAndSeekSupervisor()
    {
        uint32 PossibleMaps[] = { 0,1,530,571 };
        uint32 PossibleMapCount = _countof(PossibleMaps);
        for (uint32 i = 0; i < NUMBER_OF_ACTIVE_HIDE_AND_SEEK_SPAWNS; i++)
        {
            uint32 SelectedMapId = PossibleMaps[rand32() % PossibleMapCount];
            Spawns[i].GUID = ObjectGuid::Empty;
            Spawns[i].map = SelectedMapId;
        }
    }

    void GenerateNewSpawnLocation(uint32 AtLoc)
    {
        Spawns[AtLoc].GUID = ObjectGuid::Empty;
        //pick a random spawn on this map and copy it's location
        uint32 SelectedRow = 0;
        //this goes hand in hand with PossibleMaps list. Got the numbers from DB
        if (Spawns[AtLoc].map == 0)
            SelectedRow = rand32() % 30046;
        else if (Spawns[AtLoc].map == 1)
            SelectedRow = rand32() % 29202;
        else if (Spawns[AtLoc].map == 530)
            SelectedRow = rand32() % 30257;
        else if (Spawns[AtLoc].map == 571)
            SelectedRow = rand32() % 34385;
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "select position_x, position_y, position_z, orientation from creature where map = %d limit %d, 1", (uint32)Spawns[AtLoc].map, (uint32)SelectedRow);
        QueryResult result = WorldDatabase.Query(Query);
        if (result)
        {
            Field* fields = result->Fetch();
            Spawns[AtLoc].pos.m_positionX = fields[0].GetFloat() + 1.0f;
            Spawns[AtLoc].pos.m_positionY = fields[1].GetFloat() + 1.0f;
            Spawns[AtLoc].pos.m_positionZ = fields[2].GetFloat() + 1.0f;
            Spawns[AtLoc].pos.SetOrientation( fields[3].GetFloat() );
        }        
    }

    void CheckNeedsSpawnRespawn(Map *map)
    {
        for (uint32 i = 0; i < NUMBER_OF_ACTIVE_HIDE_AND_SEEK_SPAWNS; i++)
        {
            //not the right map
            if (Spawns[i].map != map->GetId())
                continue;

            //check if he exists and it's alive
            if (Spawns[i].GUID != ObjectGuid::Empty)
            {
                Creature * c = map->GetCreature(Spawns[i].GUID);
                if (c == NULL || c->IsAlive() == false)
                    Spawns[i].GUID = ObjectGuid::Empty;
            }

            //spawn it if it is not yet spawned
            if (Spawns[i].GUID == ObjectGuid::Empty)
            {
                //generate new location where to spawn it
                GenerateNewSpawnLocation(i);

                //create a new creature
                Creature* creature = new Creature();
                if (!creature->Create(map->GenerateLowGuid<HighGuid::Unit>(), map, PHASEMASK_NORMAL, CreatureEntryToBeFound, Spawns[i].pos, NULL, 0, true))
                {
                    delete creature;
                    return;
                }

                //make sure he can be killed
                creature->SetFaction(CreatureFactionCanBeKilled);

                //remove any AI it may have
                creature->SetAI(NULL);

                //avoid running out of this world
                creature->SetHomePosition(creature->GetPosition());

                //try tp push it to the map
                if (!map->AddToMap(creature))
                {
                    delete creature;
                    return;
                }

                //remember this creature
                Spawns[i].GUID = creature->GetGUID();
            }
        }
    }
private:
    HideAndSeekNPCSpawn Spawns[NUMBER_OF_ACTIVE_HIDE_AND_SEEK_SPAWNS];
};

HideAndSeekSupervisor HideAndSeekGlobalSuperVisor;

void HideAndSeekSpawnMonitor(void *p, void *)
{
    CP_MAP_PERIODIC_UPDATE *params = PointerCast(CP_MAP_PERIODIC_UPDATE, p);
    if (params->map == NULL || params->map->GetId() != 0)
        return;

    //eliminate non active spawns
    HideAndSeekGlobalSuperVisor.CheckNeedsSpawnRespawn(params->map);
}

void WorldAnnounce(const char *str);
class TC_GAME_API HideAndSeakScoreGiveRegisterScript : public PlayerScript
{
public:
    HideAndSeakScoreGiveRegisterScript() : PlayerScript("HideAndSeakScoreGiveRegisterScript") {}

    void OnCreatureKill(Player* killer, Creature* killed)
    {
        //sanity checks
        if (killer == NULL || killed == NULL)
            return;
        if (killed->GetEntry() != CreatureEntryToBeFound)
            return;

        //give credit to player
        killer->AddCredits(10);

        //save statistics to DB. This is only to check if someone found an exploit or something
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "INSERT INTO character_HideAndSeek(GUID, TimesFound) VALUES(%d,1) ON DUPLICATE KEY UPDATE TimesFound = TimesFound + 1", (uint32)killer->GetGUID().GetRawValue());
        CharacterDatabase.Execute(Query);

        //announce winner
        sprintf_s(Query, sizeof(Query), "Hide&Seek : %s found a hidden creature", killer->GetName().c_str());
        WorldAnnounce(Query);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_HideAndSeek where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void AddHideAndSeekNPCScripts()
{
    /*
    # just to track if players found an exploit / abuse
    CREATE TABLE IF NOT EXISTS `character_HideAndSeek` (
    `GUID` int(11) NOT NULL,
    `TimesFound` int(11) DEFAULT NULL,
    UNIQUE KEY `relation` (`GUID`),
    KEY `RowUniqueId` (`GUID`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
    #
    insert INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `dmgschool`, `BaseAttackTime`, `RangeAttackTime`, `BaseVariance`, `RangeVariance`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `HoverHeight`, `HealthModifier`, `ManaModifier`, `ArmorModifier`, `DamageModifier`, `ExperienceModifier`, `RacialLeader`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `spell_school_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES (123460, 0, 0, 0, 0, 0, 28216, 0, 0, 0, '', 'Hide&Seek|h', '', 0, 1, 1, 2, 189, 0, 1, 1.14286, 2, 0, 0, 2000, 2000, 1, 1, 2, 0, 2048, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 1, 10, 10, 1, 10.8, 1, 0, 121, 1, 0, 0, 1048576, '', 12340);
    */

    RegisterCallbackFunction(CALLBACK_TYPE_MAP_PERIODIC_UPDATE, HideAndSeekSpawnMonitor, NULL);
    new HideAndSeakScoreGiveRegisterScript();
}
