#include "ScriptMgr.h"
#include "GameEventCallbacks.h"
#include "Creature.h"
#include "ObjectExtension.cpp"
#include "Map.h"
#include "DBCStore.h"
#include "DBCStores.h"
#include "DBCStructure.h"
#include "Player.h"
#include "Random.h"
#include <set>

#define ZOMBIE_ENTRY_TO_FIGHT       30030   // simple zombie ? Or maybe i should make a list of zombie entries ?
#define ZOMBIE_CREATURE_FACTION     18      // something hostie to everyone
#define ZOMBIEScaleDMG              2.0f    //
#define ZOMBIEScaleHP               4.0f    //
#define ZOMBIEScaleLevel            5       //


static uint32 ZombieModels[] = { 137,414,519,559,569,570,571,646,828,829,987,1065,1197,1201,2676,4631,5432,10030,10256,10487,10626,10630,10970,10971,10973,10975,10976,10979,14708,16480,22124,22496,24275,24992,24993,24994,24995,24996,24997,24998,24999,25000,25399,25526,25527,25542,26002,26079,26329,26942,27804,27987,28283,28292,28733,30643,30644,30645,30647,30648,30649,31812 };        // random looks for zombies. These are only looks. HP and dmg will be inherited from the citizen

class ZombieApocalipseStore
{
public:
    ZombieApocalipseStore()
    {
        NeedToTurnIntoZombie = 1;
    }
    uint8 NPCRespawnedNeedTurn()
    {
        uint8 PrevVal = NeedToTurnIntoZombie;
        NeedToTurnIntoZombie = 1 - NeedToTurnIntoZombie;
        return PrevVal;
    }
private:
    uint8   NeedToTurnIntoZombie;
};

//can't really attach this to anything. Need to make sure i keep it clean as much as possible
std::set<uint32> SpawnIDsToTurn;

void ZombieApocalipseMobRespawn(void *p, void *)
{
    CP_CREATURE_SPAWN *params = PointerCast(CP_CREATURE_SPAWN, p);

    //safety first
    if (params->Spawn == NULL || params->map == NULL)
    {
        //        printf("Invalid params. Early exiting\n");
        return;
    }

    //do we need ot turn ?
/*
    ZombieApocalipseStore *zas = params->Spawn->GetExtension<ZombieApocalipseStore>(OE_CREATURE_ZOMBIE_APOCALIPSE_STORE);
    if (zas == NULL)
        return;
    uint8 NeedToTurn = zas->NPCRespawnedNeedTurn();
    if (NeedToTurn == 0)
        return;
*/
    if (SpawnIDsToTurn.find(params->Spawn->GetSpawnId()) == SpawnIDsToTurn.end())
        return;
    //remove from queue
    SpawnIDsToTurn.erase(params->Spawn->GetSpawnId());
    //pick a random look
    uint32 ListSize = sizeof(ZombieModels) / sizeof(uint32);
    uint32 RandomIndex = rand32() % ListSize;
    params->Spawn->SetUInt32Value(UNIT_FIELD_DISPLAYID, ZombieModels[RandomIndex]);
    //set entry
    params->Spawn->SetEntry(ZOMBIE_ENTRY_TO_FIGHT);
    //set faction
    params->Spawn->SetFaction(ZOMBIE_CREATURE_FACTION);
    //set hp
    params->Spawn->SetMaxHealth( (uint32)(params->Spawn->GetMaxHealth() * ZOMBIEScaleHP));
    params->Spawn->SetFullHealth();
    //set dmg
    params->Spawn->SetBaseWeaponDamage(WeaponAttackType::BASE_ATTACK, WeaponDamageRange::MINDAMAGE, params->Spawn->GetWeaponDamageRange(WeaponAttackType::BASE_ATTACK, WeaponDamageRange::MINDAMAGE) * ZOMBIEScaleDMG);
    params->Spawn->SetBaseWeaponDamage(WeaponAttackType::BASE_ATTACK, WeaponDamageRange::MAXDAMAGE, params->Spawn->GetWeaponDamageRange(WeaponAttackType::BASE_ATTACK, WeaponDamageRange::MAXDAMAGE) * ZOMBIEScaleDMG);
    //set attack speed
    params->Spawn->ApplyAttackTimePercentMod(WeaponAttackType::BASE_ATTACK, -1 / ZOMBIEScaleDMG, true);
    //make sure anyone can attack it
    params->Spawn->SetPvP(true);
    //slightly add to level
    params->Spawn->SetLevel(params->Spawn->getLevel()+ ZOMBIEScaleLevel);
}

class TC_GAME_API ZombieApocalipseCreatureDieRegister : public PlayerScript
{
public:
    ZombieApocalipseCreatureDieRegister() : PlayerScript("ZombieApocalipseCreatureDieRegister") {}

    void OnCreatureKill(Player* killer, Creature* killed)
    {
        //        printf("Player killed a creature\n");
        if (killed == NULL)
        {
            //            printf("Killer is missing\n");
            return;
        }
        if (killer == NULL)
        {
            //            printf("Killer is null\n");
            return;
        }

        //not in dungeons
        if (killer->GetMap()->IsDungeon() || killer->GetMap()->IsBattlegroundOrArena())
        {
//            printf("Zone is marked as dungeon or sanctuary\n");
            return;
        }

        //not a normal spawn. Could be a temp summon
        if (killed->GetSpawnId() == 0)
        {
//            printf("Only a temp summon\n");
            return;
        }

        //are we in a city ?
        AreaTableEntry const* zone = sAreaTableStore.LookupEntry(killer->GetZoneId());
        if (!zone)
        {
//            printf("Player does not have zone set\n");
            return;
        }

        //somecities cannot be raided
        if (zone->IsSanctuary())
        {
//            printf("Zone is sancuary\n");
            return;
        }

        //are there other cities also ?
        if ((zone->flags & (AREA_FLAG_CAPITAL| AREA_FLAG_SLAVE_CAPITAL| AREA_FLAG_SLAVE_CAPITAL2| AREA_FLAG_TOWN)) == 0)                     // Is in a capital city
        {
 //           printf("Not inside city\n");
            return;
        }

        //queue the turn
        SpawnIDsToTurn.insert(killed->GetSpawnId());
/*
        ZombieApocalipseStore *zas = killed->GetExtension<ZombieApocalipseStore>(OE_CREATURE_ZOMBIE_APOCALIPSE_STORE);
        if (zas == NULL)
        {
            zas = new ZombieApocalipseStore;
            killed->SetExtension<ZombieApocalipseStore>(OE_CREATURE_ZOMBIE_APOCALIPSE_STORE, zas);
        } */
    }
};

void AddZombieApocalipseScripts()
{
    new ZombieApocalipseCreatureDieRegister();
    RegisterCallbackFunction(CALLBACK_TYPE_CREATURE_SPAWN, ZombieApocalipseMobRespawn, NULL);
}
