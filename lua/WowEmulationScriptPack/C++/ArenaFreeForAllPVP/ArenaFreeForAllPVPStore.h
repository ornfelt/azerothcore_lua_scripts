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

enum ArenaFFARunStatus
{
    HG_WAITING_FOR_QUEUE = 1,
    HG_WAITING_FOR_QUEUE_COUNTDOWN_END,     // even though we have enough playrs, we will wait for X seconds after the previous fight ended to allow players to leave zone
    HG_WAITING_FOR_QUEUE_COUNTDOWN_START,   // Even if we reached min player count to start the game, maybe more would like to subscribe
    HG_STARTING,            // waiting for players to teleport in
    HG_TELEPORTING,         // waiting for players to teleport in
    HG_ONGOING,             // waiting for players to kill each other
    HG_ENDED                // ended
};

class PlayerAreanFFAStore
{
public:
    uint32 ArenaGuid;
};

class ArenaFreeForAllPVPStore
{
public:
    ArenaFreeForAllPVPStore();
    bool CanAcceptMorePlayersToQueue();
    ArenaFFARunStatus GetStatus() { return Status; }
    void AdvertiseQueueChange(Player *player, const char *Message);
    void QueuePlayer(Player *player);
    void RemovePlayerFromQueue(Player *player, bool KickOut);
    void RemovePlayerFromQueue(ObjectGuid player, bool KickOut = false);
    bool IsPlayerQueued(Player *player);
    uint32 GetGuid() { return GUID; }
    void SetKickToPosition(uint32 pKickToMap, float pKickToX, float pKickToY, float pKickToZ);
    void UpdateEventStatus(Map *map);
    const char *GetName() { return Name.c_str(); }
    void SetName(std::string NewName) { Name = NewName; }
    void AddMapToSpawnOn(WorldLocation loc);
private:
    bool IsPlayerInsideEventArea(Player *p);
    void SelectDestinationMap();
    void PreFightSetupAndUpdates();
    void PreFightWaitForQueueFill();
    void PreFightWaitForQueueFillCountDown();
    void PreFightStartTeleporting();
    void PreFightTeleportWaitFinish();
    void MidFightUpdates(Map *map);
    void PostFightDeinit();
    uint32 GetSelectedMapId();
    uint32 MaxPlayersToQueue;
    uint32 MinPlayersToQueue;
    std::set<ObjectGuid> PlayersQueued;
    ArenaFFARunStatus Status;
    uint32 KickToMap;
    float KickToX, KickToY, KickToZ;
    uint32 GUID;
    time_t StartedAt, EndedAt;
    uint32 QueuedPlayersAtStart;
    uint32 TeleportedPlayersAtStart;
    uint32 DeserterPlayersCount;
//    std::vector<WorldLocation*>  PossiblePlayerLocations;
    Map *MapActive;  //only use this to see if update comes for ourself. Do not cast this as Map pointer
//    bool NeedsOneTimeInit;
    std::vector<WorldLocation*> MapSpawnPoints;  // dynamically populate this list. Needs to support FFA. Needs to be instantiable. Should be small to avoid players from hiding. Should not have map scripts ( like arena )
    uint32 SelectedMap;     //once the map starts, select a map. Teleport all players to this location
    std::string Name;
    uint32 WaitUntilNextQueueStarts;
    uint32 ForceEndMatchAfterXSeconds;
    uint32 OnWinCreditReward;
};

extern std::list<ArenaFreeForAllPVPStore*> ArenaFFAPVPs;

void WorldAnnounce(const char *str);
void WorldAnnounce(const char *str, uint32 count /*= 0*/, uint32 max);
