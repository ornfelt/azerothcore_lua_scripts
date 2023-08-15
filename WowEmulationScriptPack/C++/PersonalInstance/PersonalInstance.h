#ifndef _PERSONAL_INSTANCE_H_
#define _PERSONAL_INSTANCE_H_

#define ENDURANCE_MAP   565

struct ScriptQueuedMapJoin
{
    uint32          MapId;
    uint32          InstanceId;
    ObjectGuid      Summoner;
    WorldLocation   Pos;
};

class PersonalInstanceStore
{
public:
    struct PersonalSpawnStore
    {
        uint32      MapId;
        Position    pos;
        uint32      Entry;
        uint32      SpawnType;  //mob or go
    };
    enum SpawnTypes
    {
        SPAWN_TYPE_CREATURE = 0,
        SPAWN_TYPE_GAMEOBJECT = 1,
    };
    PersonalInstanceStore(Player *plr);
    ~PersonalInstanceStore();
    //return a map that should persist even when we reset bind instances
    Map     *GetPersonalMap(uint32 MapId, bool CreateNew = true);
    //teleport to a specific map ID that will persist account wise
    void    TeleportPlayerToPersonalInstance(Player *player, uint32 MapId);
    // when we want to teleport multiple players at once to a specific personal map
    void    QueuePersonalInstanceNextTeleport(Player *player, Map *map);
    // can we teleport to a specific map ?
    bool    CanAccesMap(uint32 MapId);
    // can we spawn this creature entry
    bool    HasCreatureEntry(uint32 Entry) { return AllowedCreatures.find(Entry) != AllowedCreatures.end(); }
    bool    HasGameObjectEntry(uint32 Entry) { return AllowedGameObjects.find(Entry) != AllowedGameObjects.end(); }
    //register a delayed event
    void    OnMapChanged(Player *player);
    // this will fail until some time passed since player is ingame
    bool    InitMapRetry(Player *player);
    // spawn a creature if possible. Save it to DB
    bool    SpawnCreature(Player *player, uint32 Entry, Position *pos, bool FromDB, bool TempSpawn=false);
    // delete an already spawned creature. From DB also
    void    DeleteCreature(Player *player, Creature *spawn);
    // spawn a gameobject if possible. Save it to DB
    Object  *SpawnGameObject(Player *player, uint32 Entry, Position *pos, bool FromDB);
    // delete an already spawned gameobject. From DB also
    void    DeleteGameObject(Player *player, GameObject *spawn);
    //unbind from a map with same id. Bind to a new map that is probably our personal instance
    void    BindToPersonalInstance(Player *player, Map *map);
    //get the list of maps that we can iterate through
    const std::set<uint32> &GetAllowedMaps() { return AllowedMaps; }
    const std::set<uint32> &GetAllowedGOs() { return AllowedGameObjects; }
    const std::set<uint32> &GetAllowedCreatures() { return AllowedCreatures; }
    //when we want to teleport back from where we came
    WorldLocation &GetEntrancePoint() { return EnteredMapFrom; }
private:
    // spawn objects from DB on map if not yet spawned
    void    SpawnObjectsOnMap(Player *player);
    void    LoadFromDB(Player *player);
    void    SaveSettingsDB(Player *player);
    void    SaveSpawnToDB(Player *player, PersonalSpawnStore *sp);
    void    DeleteSpawnFromDB(Player *player, PersonalSpawnStore *sp);
    uint64  PlayerGUID;
    //we should have account wise 1 single instance to this map
    uint32  GetInstanceID(uint32 MapId);
    //have to find out how to force a player to enter a specific instance
    void    QueuePersonalInstanceNextTeleport(Player *player, uint32 MapId);
    //bind map IDs and instance IDs that we could reuse even if we join other instances or reset the current one
    std::map<uint32, uint32>        InstanceIDs;
    std::set<uint32>                AllowedMaps;
    std::set<uint32>                AllowedCreatures;
    std::set<uint32>                AllowedGameObjects;
    uint32                          CreatureLimit;
    uint32                          GameobjectLimit;
    std::list<PersonalSpawnStore*>  MapSpawns;
    WorldLocation                   EnteredMapFrom;
    uint32                          MapInitStartStamp;
};

#endif
