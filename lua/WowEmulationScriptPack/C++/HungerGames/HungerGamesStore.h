#pragma once

#ifdef _DEBUG
    #define WaitAdditionalSubscriptionToMinimum 1
    #define WarnPlayerTeleportIncommingSeconds  1
    #define WaitPlayerTeleportSeconds           60  //players who are stuck on teleport screen should be kicked
    #define HungerGamesPeriodicHintTimerSeconds 2
    #define HungerGamesWaitUntilGiveHintsSeconds 1
#else
    #define WaitAdditionalSubscriptionToMinimum 60
    #define WarnPlayerTeleportIncommingSeconds  10
    #define WaitPlayerTeleportSeconds           60  //players who are stuck on teleport screen should be kicked
    #define HungerGamesPeriodicHintTimerSeconds 10
    #define HungerGamesWaitUntilGiveHintsSeconds 5*60
#endif
#define MAX_LOOT_TIERS                          5

class HungerGameStore;

extern std::set<HungerGameStore*> HungerGameStores;

HungerGameStore *IsHungerGamesActiveForPlayer(Player *p);

enum HungerGamesRunStatus
{
    HG_WAITING_FOR_QUEUE = 1,
    HG_WAITING_FOR_QUEUE_COUNTDOWN_END,     // even though we have enough playrs, we will wait for X seconds after the previous fight ended to allow players to leave zone
    HG_WAITING_FOR_QUEUE_COUNTDOWN_START,   // Even if we reached min player count to start the game, maybe more would like to subscribe
    HG_STARTING,            // waiting for players to teleport in
    HG_TELEPORTING,         // waiting for players to teleport in
    HG_ONGOING,             // waiting for players to kill each other
    HG_ENDED                // ended
};

class PlayerHungerGamesStore
{
public:
    PlayerHungerGamesStore()
    {
        HungerGamesGuid = 0;
    }
    uint32 HungerGamesGuid;
};

class ObjectsSpawnStore
{
public:
    ObjectsSpawnStore(Position *tpos)
    {
        Entry = 0;
        SpawnGuid = ObjectGuid::Empty;
        pos = *tpos;
    }
    ObjectsSpawnStore(uint32 pE, float px, float py, float pz, float po)
    {
        Entry = pE;
        pos.m_positionX = px;
        pos.m_positionY = py;
        pos.m_positionZ = pz;
        pos.SetOrientation(po);
        SpawnGuid = ObjectGuid::Empty;
    }
    ObjectGuid  SpawnGuid;  // should have a value when object got spawned
    uint32      Entry;
    Position    pos;
};

class HungerGameStore
{
public:
    HungerGameStore();
    ~HungerGameStore()
    {
        for (auto i = PossibleChestLocations.begin(); i != PossibleChestLocations.end(); i++)
            delete *i;
        PossibleChestLocations.clear();
    }
    void QueuePlayer(Player *player);
    void RemovePlayerFromQueue(ObjectGuid player, bool KickOut = false);
    void RemovePlayerFromQueue(Player *player, bool KickOut);
    bool IsPlayerQueued(Player *player);
    HungerGamesRunStatus    GetStatus()
    {
        return Status;
    }
    void UpdateHungerGameStatus(Map *map);
    void CheckProtectZone(Map *map);
    void SetName(const char *pName)
    {
        Name = pName;
    }
    const char *GetName()
    {
        return Name.c_str();
    }
    void SetCenter(uint32 pMap, float x, float y, float z, float Radius)
    {
        EventMapId = pMap;
        EventCenterX = x;
        EventCenterY = y;
        EventCenterZ = z;
        EventRadius = Radius;
    }
    void SetKickTo(uint32 pMap, float x, float y, float z)
    {
        KickToMap = pMap;
        KickToX = x;
        KickToY = y;
        KickToZ = z;
    }
    uint32 GetGuid()
    {
        return GUID;
    }
    uint32 GetMap()
    {
        return EventMapId;
    }
    void CheckSpawnLootChests(Map *map);
    void CheckSpawnRandomCreatures(Map *map);
    void SetChestSpawnPeriod(uint32 NewPeriod)
    {
        ChestSpawnPeriod = NewPeriod;
    }
    void SetMaxActiveChests(uint32 NewLimit)
    {
        MaxAllowedChestsActiveOnMap = NewLimit;
    }
    void SetMaxActiveCreatures(uint32 NewLimit)
    {
        MaxAllowedCreaturesActiveOnMap = NewLimit;
    }
    void AddChestSpawnLocation(ObjectsSpawnStore *p)
    {
        PossibleChestLocations.push_back(p);
    }
    void AddCreatureSpawnLocation(Position *p)
    {
        PossibleCreatureLocations.push_back(new ObjectsSpawnStore(p));
    }
    void AddPlayerSpawnLocation(Position *p)
    {
        PossiblePlayerLocations.push_back(p);
    }
    void AddPossibleItemLoot(uint32 QualityTier, uint32 Entry);
    void SetProgressiveLootPeriod(uint32 Period)
    {
        ProgresiveLootSwitchPeriod = Period;
    }
    void SetPlayerLevel(uint32 NewLevel)
    {
        ForceSetPlayerLevel = NewLevel;
    }
    void ResetTalents(uint32 Toggle)
    {
        ForceResetTalents = Toggle;
    }
    void ResetSpells(uint32 Toggle)
    {
        ForceResetSpells = Toggle;
    }
    void SetWinCreditReward(uint32 NewReward)
    {
        OnWinCreditReward = NewReward;
    }
    void AddPlayerStartItem(uint32 Entry)
    {
        StartItems.push_back(Entry);
    }
    void AddTempObjectSpawn(ObjectsSpawnStore *TempSpawn)
    {
        TemporaryGameObjects.push_back(TempSpawn);
    }
    bool CanAcceptMorePlayersToQueue();
    void SetPlayerQueueLimit(uint32 NewMaxQueue)
    {
        MaxPlayersToQueue = NewMaxQueue;
    }
    std::vector<uint32> *GetLootList();
    void        RemoveAllSpawnedChests(Map *map);
    time_t      GetTimePassed();
    void        AdvertiseQueueChange(Player *player, const char *Message);
    void        SetMatchTimout(uint32 NewTimeout)
    {
        ForceEndMatchAfterXSeconds = NewTimeout;
    }
    void        AddLearnSpell(uint32 NewSpell)
    {
        LearnSpells.insert(NewSpell);
    }
    void        AddConstantBuff(uint32 NewSpell)
    {
        PeriodicCastBuffs.insert(NewSpell);
    }
    void        AddOutOfCombatBuff(uint32 NewSpell)
    {
        OutOfCombatBuffs.insert(NewSpell);
    }
    void        SetSpawningRadiusReduction(bool Enabled)
    {
        SpawnsReducedToMid = Enabled;
    }
    void SetZoneAreaBind(uint32 NewZoneId, uint32 NewAreaId)
    {
        ZoneIdBound = NewZoneId;
        AreaIdBound = NewAreaId;
    }
    bool IsPlayerInsideEventArea(Player *p);
    void SetMinMaxPlayers(uint32 MinPlayers, uint32 MaxPlayers)
    {
        MinPlayersToQueue = MinPlayers;
        MaxPlayersToQueue = MaxPlayers;
    }
    void AddCreatureEntryToSapwn(uint32 Entry)
    {
        RandomlySpawnedCreatureEntries.push_back(Entry);
    }
private:
    void        SpawnTempGameObjects(Map *map);
    void        DespawnTempGameObjects(Map *map);
    void        PreFightSetupAndUpdates();
    void        MidFightUpdates(Map *map);
    void        PostFightDeinit();
    void        RemoveAllSpawnedMobs(Map *map);
    bool        SpawnNewCreature(Map *map);
    bool        SpawnNewCrate(Map *map);
    void        SpawnCreaturesInitial(Map *map);
    void        PeriodicGiveHints(Map *map);
    float       GetTimeRemainPCT();
    ObjectGuid  SpawnCreature(Map *map, uint32 Entry,Position *pos);
    uint32                  MinPlayersToQueue;
    uint32                  MaxPlayersToQueue;
    // these players need to get ported to event location
    std::set<ObjectGuid>    PlayersQueued;
//    std::set<ObjectGuid>    PlayersPlayed;  // should remove items from these players
    // Measure time passed. If something got stuck, kick players, reset
    uint32                  WaitUntilNextQueueStarts;
    uint32                  ForceEndMatchAfterXSeconds;
    time_t                  StartedAt,EndedAt;
    //where we hold this event
    uint32                  EventMapId;
    float                   EventCenterX, EventCenterY, EventCenterZ;
    float                   EventRadius;
    // players getting kicked need to be teleported here
    uint32                  KickToMap;
    float                   KickToX, KickToY, KickToZ;
    HungerGamesRunStatus    Status;
    uint32                  QueuedPlayersAtStart;
    uint32                  TeleportedPlayersAtStart;
    uint32                  DeserterPlayersCount;
    std::string             Name;
    uint32                  GUID;   // when we reference it with queue menu
    uint32                  ChestSpawnPeriod;   // spawn a new chest every X seconds
    time_t                  LastChestSpawnedAt;
    uint32                  CreatureSpawnPeriod;
    time_t                  LastCreatureSpawnedAt;
    bool                    SpawnsReducedToMid;    // in time, chests will spawn only at the center of the map to force players to group up
    uint32                  MaxAllowedChestsActiveOnMap;
    uint32                  MaxAllowedCreaturesActiveOnMap;
    uint32                  NextCreatureSpawnLocation;
    std::vector<ObjectsSpawnStore*> PossibleChestLocations;
    std::vector<ObjectsSpawnStore*> PossibleCreatureLocations;
    std::vector<Position*>  PossiblePlayerLocations;
    uint32                  ProgresiveLootSwitchPeriod; // intervals at which loot will become better
    std::vector<uint32>     PossibleItemQualityLoots[MAX_LOOT_TIERS];
    uint32                  ForceSetPlayerLevel;
    uint32                  ForceResetTalents;
    uint32                  ForceResetSpells;
    std::list<uint32>       StartItems;
    std::list<ObjectsSpawnStore*>   TemporaryGameObjects;   // gates and other contraptions that should be removed after fight ends
    std::set<uint32>        LearnSpells;    // learn these spells at the beggnining of the fight. Should remove them on logout
    std::set<uint32>        PeriodicCastBuffs;
    std::set<uint32>        OutOfCombatBuffs;
    std::vector<uint32>     RandomlySpawnedCreatureEntries;
    uint32                  ZoneIdBound, AreaIdBound;
    bool                    NeedsOneTimeInit;
    uint32                  OnWinCreditReward;
    time_t                  NextGameHintStamp;
};
