#ifndef _ENDURANCE_STORE_H_
#define _ENDURANCE_STORE_H_

#include "Common.h"
#include "ObjectGuid.h"

class Creature;

class EnduranceStore
{
public:
    // handle all info regarding Endurance script
    EnduranceStore(ObjectGuid pg, int32 AccountID, int32 pClass);
    //call this first time we agro our endurance target
    void    FightStarted(bool ForceReset = false, uint64 CreatureGUID = 0);
    //call this when targte was slain
    void    FightEnded();
    //generate the next tough enemy we need to defeat
    float   GetNextEndurancePCTScaler();
    //check if we fight the same mob we spawned earlier
    uint64  GetCreatureGUID() { return CreatureGUID; }
    uint64  GetMSSincePrevSpawn();
    void    EventSpawnedCreature(Creature *c);
    uint32  GetBestLevel() { return HighestDefeated; }
private:
    // on creating this structure we will load data from DB
    void            LoadFromDB();
    // if we managed to beat the next level, we will store it in DB
    void            SaveToDB();
    // player who we belong to
    ObjectGuid      PlayerGUID;
    // Acct is used in DB
    int32           AccountID;
    // Player class
    int32           PlayerClass;
    //stats that will get saved to the DB in the leaderboards section
    int32           HighestDefeated;
    time_t          FightStartedAt;
    time_t          FightEndedAt;
    // the guid of the creature we intend to fight
    uint64          CreatureGUID;
    // last spawned guid at stamp
    uint64          SpawnStamp; //core seems to crash if spawning too many at too short intervals
};
#endif
