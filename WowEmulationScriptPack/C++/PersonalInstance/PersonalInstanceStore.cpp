#include "AccountMgr.h"
#include "Player.h"
#include "Creature.h"
#include "GameObject.h"
#include "DatabaseEnv.h"
#include "WorldSession.h"
#include "MapManager.h"
#include "ObjectMgr.h"
#include "PersonalInstance.h"
#include "ObjectExtension.cpp"
#include "GameTime.h"

#define DEBUG_PERSONAL_INSTANCE                 false //show debug info in console
#define DEFAULT_PERSONAL_INSTANCE_MAP               // to not require to creae one for every account, we are allowed to use these by default
#define PERSONAL_INSTANCE_FACTION               35  // friendly to everyone
#define DEFAULT_CREATURE_SPAWN_LIMIT            10
#define DEFAULT_GAMEOBJECT_SPAWN_LIMIT          50
#define ENABLE_DEFAULT_GAMOBJECT_ENTRY_LIST         // a list of gameobject will be available to all players even if they did not donate
#define ENABLE_DEFAULT_CREATURE_ENTRY_LIST          // a list of creatures will be available to all players even if they did not donate

void SpawnAssistant(Player *player, PersonalInstanceStore *Pi);

uint32 PersonalInstanceStore::GetInstanceID(uint32 MapId)
{
    int RetID;
    if (InstanceIDs.find(MapId) == InstanceIDs.end())
    {
        RetID = sMapMgr->GenerateInstanceId();
        InstanceIDs[MapId] = RetID;
    }
    else
    {
        RetID = InstanceIDs[MapId];
    }
    return RetID;
}

bool PersonalInstanceStore::CanAccesMap(uint32 MapId)
{
    return AllowedMaps.find(MapId) != AllowedMaps.end();
}

PersonalInstanceStore::PersonalInstanceStore(Player *player)
{
    PlayerGUID = player->GetGUID().GetRawValue();
    CreatureLimit = DEFAULT_CREATURE_SPAWN_LIMIT;
    GameobjectLimit = DEFAULT_GAMEOBJECT_SPAWN_LIMIT;
    EnteredMapFrom = player->GetWorldLocation(); // avoid uninitialized values
    LoadFromDB(player);
}

PersonalInstanceStore::~PersonalInstanceStore()
{
    std::list<PersonalSpawnStore*>::iterator it;
    for (it = MapSpawns.begin(); it != MapSpawns.end(); it++)
        delete *it;
    MapSpawns.clear();
}

void PersonalInstanceStore::LoadFromDB(Player *player)
{
    //load settings
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "Select CreatureLimit,GameobjectLimit from account_PersonalMapSettings where AcctId=%d", (uint32)PlayerGUID);
    QueryResult result = CharacterDatabase.Query(Query);
    if (result)
    {
        Field* fields = result->Fetch();
        CreatureLimit = DEFAULT_CREATURE_SPAWN_LIMIT + fields[0].GetUInt32();
        GameobjectLimit = DEFAULT_GAMEOBJECT_SPAWN_LIMIT + fields[1].GetUInt32();
    }

    //load allowed maps from DB
    sprintf_s(Query, sizeof(Query), "Select MapId from account_PersonalMaps where AcctId=%d", (uint32)player->GetSession()->GetAccountId());
    QueryResult result2 = CharacterDatabase.Query(Query);
    if (result2)
    {
        do {
            Field* fields = result2->Fetch();
            uint32 MapId = fields[0].GetUInt32();
            AllowedMaps.insert(MapId);
        } while (result2->NextRow());
    }

    //in case this is a new account. By default we will allow them to use these maps
#ifdef DEFAULT_PERSONAL_INSTANCE_MAP
    AllowedMaps.insert(615);
    AllowedMaps.insert(ENDURANCE_MAP);
#endif

    //load what kinda spawns can we use
    sprintf_s(Query, sizeof(Query), "Select SpawnType,SpawnEntry from account_PersonalMapAllowedEntries where AcctId=%d", (uint32)player->GetSession()->GetAccountId());
    QueryResult result3 = CharacterDatabase.Query(Query);
    if (result3)
    {
        do {
            Field* fields = result3->Fetch();
            uint32 SpawnType = fields[0].GetUInt32();
            uint32 SpawnEntry = fields[1].GetUInt32();
            if (SpawnType == 0)
                AllowedCreatures.insert(SpawnEntry);
            else
                AllowedGameObjects.insert(SpawnEntry);
        } while (result3->NextRow());
    }

#ifdef ENABLE_DEFAULT_GAMOBJECT_ENTRY_LIST
    //Normal Players default spawns
    //Chairs
    AllowedGameObjects.insert(22713); //Wooden Chair 1
    AllowedGameObjects.insert(2489); //High Back Chair
    AllowedGameObjects.insert(28611); //Dwarven High Back Chair
    AllowedGameObjects.insert(186715); //Wooden Bench
    AllowedGameObjects.insert(174698); //Stone Bench
    AllowedGameObjects.insert(136929); //Stone Throne 1
    AllowedGameObjects.insert(142947); //Stone Throne 2
    AllowedGameObjects.insert(191244); //Wood Bench X
    AllowedGameObjects.insert(191886); //small weird chair
    //Tables
    AllowedGameObjects.insert(177724);  // Dredan's Table (Simple Wood)
    AllowedGameObjects.insert(183994);  //Amadi Table (Wood taller)
    AllowedGameObjects.insert(180885);  //Inn Table
    AllowedGameObjects.insert(180698);  //Party Table
    AllowedGameObjects.insert(180884);  //DwarvenTableSmall
    AllowedGameObjects.insert(183105);  //Orc Table
    AllowedGameObjects.insert(184657);  //Ironridge Table
    //Banners
    AllowedGameObjects.insert(180773);  // Banner

    //Donators Only by Rank
    if (player->GetSession())
    {
        uint32 rank = AccountMgr::GetSecurity(player->GetSession()->GetAccountId(), 1); //1 is RealmId
        if (rank = SEC_BRONZE)
        {
            //chairs
            AllowedGameObjects.insert(184732); //Chair with small tables X
            AllowedGameObjects.insert(184733); //Prev as Set X
            AllowedGameObjects.insert(178934); //The chair X
            //tables
            AllowedGameObjects.insert(182093);  //Blood Elf Table - Small
            AllowedGameObjects.insert(180879);  //ElvenWoodenTable
        }
        if (rank = SEC_SILVER)
        {
            //chairs
            AllowedGameObjects.insert(112068); //Festive Red Chair X
            AllowedGameObjects.insert(182654); //Red Royal X
            //tables
            AllowedGameObjects.insert(189289);  //Long Table set 1
            AllowedGameObjects.insert(190190);  //Long Table set 2
        }
        if (rank = SEC_GOLD)
        {
            //chairs
            AllowedGameObjects.insert(182598); //Blue Royal 1 X
            AllowedGameObjects.insert(184671); //Blue Royal 2 X
            //tables
            AllowedGameObjects.insert(195191);  //Dwarven Table Simple 05 (Zen)
            AllowedGameObjects.insert(193701);  //Doodad_gnometable01 (Fine)
        }
        if (rank = SEC_PLATINUM)
        {
            //chairs
            AllowedGameObjects.insert(182762); //Black Royal X
            AllowedGameObjects.insert(183753); //Imperial X
            AllowedGameObjects.insert(186695); //Imperial High X
            //tables
            AllowedGameObjects.insert(190689);  //Apothecary Table, Round
            AllowedGameObjects.insert(191785);  //Horde Table (circle flat with horns)
        }
        if (rank = SEC_DIAMOND)
        {
            //chairs
            AllowedGameObjects.insert(192010); //Yellow X
            AllowedGameObjects.insert(191475); //Futurist X
            AllowedGameObjects.insert(190683); //Barbershop Chair (HIGH DONATION) X
            //tables
            AllowedGameObjects.insert(180324);  //Dwarven Table Ornate 01
            AllowedGameObjects.insert(187114);  //Alchemy Table (Lux design)
            AllowedGameObjects.insert(184949);  //Doctor's Alchemy Table
        }
    }
#endif

    //load spawns 
    sprintf_s(Query, sizeof(Query), "SELECT MapId,x,y,z,o,entry,spawntype FROM account_PersonalMapSpawns where AcctId=%d", (uint32)player->GetSession()->GetAccountId());
    QueryResult result4 = CharacterDatabase.Query(Query);
    if (result4)
    {
        do {
            Field* fields = result4->Fetch();
            PersonalSpawnStore *ps = new PersonalSpawnStore;
            ps->MapId = fields[0].GetUInt32();
            ps->pos = Position(fields[1].GetFloat(), fields[2].GetFloat(), fields[3].GetFloat(), fields[4].GetFloat());
            ps->Entry = fields[5].GetUInt32();
            ps->SpawnType = fields[6].GetUInt32();

            MapSpawns.push_back(ps);
        } while (result4->NextRow());
    }
#ifdef ENABLE_DEFAULT_CREATURE_ENTRY_LIST 
    AllowedCreatures.insert(123456);   //Taxi
#endif
}

Map *PersonalInstanceStore::GetPersonalMap(uint32 MapId, bool CreateNew)
{
    bool IsNew = false;

    // do we have an active instance already ? Fetch that
    uint32 InstanceIdForMap = GetInstanceID(MapId);

    // get our personal instance ID for this map type
    if (InstanceIdForMap == 0)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Error. Could not obtain instance ID to use for this map\n");
        return NULL;
    }
    // Get the base map that has a list of instances
    Map *m = sMapMgr->CreateBaseMap(MapId);
    if (!m)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Failed to create/obtain base map");
        return NULL;
    }

    //unique maps can not have instances
    if (m->Instanceable() == false)
    {
        return m;
    }

    // check if we already have our personal map instantiated
    Map *map = ((MapInstanced*)m)->FindInstanceMap(InstanceIdForMap);
    //if not, create a new one
    if (!map)
    {
        if (CreateNew == true)
        {
            map = ((MapInstanced*)m)->CreateInstance(InstanceIdForMap, nullptr, Difficulty::REGULAR_DIFFICULTY);
            IsNew = true;
            //            printf("Could not find existing map. Created a new one\n");
        }
    }
    else
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Found existing map. Will try to enter that\n");
        //        if (map->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE))
        //            printf("The reused map is a custom instance map\n");
    }

    // make sure this map does not load default spawns on it
    if (map && IsNew == true)
    {
        map->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE, false, InstanceIdForMap);
        map->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR, false, PlayerGUID);
    }

    return map;
}

void PersonalInstanceStore::TeleportPlayerToPersonalInstance(Player *player, uint32 MapId)
{
    // teleport player inside the instance
    const AreaTrigger *areaTrigger = sObjectMgr->GetMapEntranceTrigger(MapId);
    if (areaTrigger == NULL)
    {
        player->BroadcastMessage("Could not find the entrance to the instance");
        return;
    }

    //if this is not a personal map. Remember the location where we go back
    if (player->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL)
    {
        EnteredMapFrom = player->GetWorldLocation();
    }

    //force player to change map to this newly created one
    if (player->TeleportTo(MapId, areaTrigger->target_X, areaTrigger->target_Y, areaTrigger->target_Z, areaTrigger->target_Orientation) == false)
    {
        player->BroadcastMessage("Could not teleport to the instance");
        return;
    }

    //make sure we will join a personal instance on next "enter map"
    QueuePersonalInstanceNextTeleport(player, MapId);
}

void PersonalInstanceStore::BindToPersonalInstance(Player *player, Map *map)
{
    uint32 MapId = map->GetId();
    uint32 InstanceId = map->GetInstanceId();
    InstanceIDs[MapId] = InstanceId;
    //bind player to this map
    InstancePlayerBind* playerBind = player->GetBoundInstance(MapId, Difficulty::DUNGEON_DIFFICULTY_NORMAL);
    //get rid of the old bind
    if (playerBind != NULL)
        player->UnbindInstance(MapId, Difficulty::DUNGEON_DIFFICULTY_NORMAL);
    //get the save to this map
    InstanceSave* mapSave = sInstanceSaveMgr->GetInstanceSave(InstanceId);
    if (!mapSave)
        mapSave = sInstanceSaveMgr->AddInstanceSave(MapId, InstanceId, Difficulty::DUNGEON_DIFFICULTY_NORMAL, 0, true, false);
    //bind to this save
    if (playerBind == NULL || playerBind->save != mapSave)
        player->BindToInstance(mapSave, false);
}

//have to find out how to force a player to enter a specific instance
void PersonalInstanceStore::QueuePersonalInstanceNextTeleport(Player *player, uint32 MapId)
{
    //get the map of the personal instance
    Map *map = GetPersonalMap(MapId);
    if (!map)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Failed to create new map instance\n");
        player->BroadcastMessage("Failed to create instance");
        return;
    }
    QueuePersonalInstanceNextTeleport(player, map);
}

void PersonalInstanceStore::QueuePersonalInstanceNextTeleport(Player *player, Map *map)
{
    if (map == NULL)
        return;
    //force the player to join this specific map on the next teleport. Yuck. There has gotto be a better way to do this
    ScriptQueuedMapJoin *QI = player->GetCreateExtension<ScriptQueuedMapJoin>(OE_PLAYER_QUEUE_JOIN_SPECIFIC_INSTANCE);
    QI->MapId = map->GetId();
    QI->InstanceId = map->GetInstanceId();

    //bind it to this new instance
    BindToPersonalInstance(player, map);
}

void SpawnAssistantFollowing(Player *player);
void PersonalInstanceStore::SpawnObjectsOnMap(Player *player)
{
    Map *m = player->GetMap();
    uint32 MapId = m->GetId();
    if (m->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE_CREATURE_SPAWNS) == NULL)
    {
        int64 *CreaturesSpawend = m->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATURE_SPAWNS);
        int64 *GameobjectsSpawend = m->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_GAMEOBJECT_SPAWNS);
        std::list<PersonalSpawnStore*>::iterator it;
        for (it = MapSpawns.begin(); it != MapSpawns.end(); it++)
            if ((*it)->MapId == MapId)
            {
                if ((*it)->SpawnType == SPAWN_TYPE_CREATURE)
                {
                    SpawnCreature(player, (*it)->Entry, &(*it)->pos, true);
                }
                else if ((*it)->SpawnType == SPAWN_TYPE_GAMEOBJECT)
                {
                    if (MapId == ENDURANCE_MAP) //don't spawn objects on Endurance map
                        return;
                    //create a new gameobject spawn
                    SpawnGameObject(player, (*it)->Entry, &(*it)->pos, true);
                }
            }
    }
    else
        if (DEBUG_PERSONAL_INSTANCE) printf("Map should already have spawns. Skipping respawning\n");

    if (MapId == ENDURANCE_MAP) //spawn Assistant only on Endurance map
        SpawnAssistant(player, this);
    else
        SpawnAssistantFollowing(player);
}

bool PersonalInstanceStore::InitMapRetry(Player *player)
{
    //not yet time to initialize
    if (GameTime::GetGameTimeMS() < MapInitStartStamp)
        return false;

    //already initialized
    if (MapInitStartStamp == 0)
        return true;

    //no more need to initialize map
    MapInitStartStamp = 0;

    // it's time to spawn stuff
    SpawnObjectsOnMap(player);

    return true;
}

void DelayMapInit(void *p, void *)
{
    Player *player = (Player*)p;
    //not ingame yet ? Kicked out ?
    if (player->FindMap() == NULL)
        return;
    //not ingame yet ? Kicked out ?
    if (player->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL)
        return;
    PersonalInstanceStore *pi = player->GetExtension<PersonalInstanceStore>(OE_PLAYER_CUSTOM_INSTANCE_STORE);
    //not ingame yet ? Kicked out ?
    if (pi == NULL)
        return;
    //could not initialize yet
    if (pi->InitMapRetry(player) == false)
        return;
    //must be the last thing we do. This suicides self
    player->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, DelayMapInit);
}

void PersonalInstanceStore::OnMapChanged(Player *player)
{
    player->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, DelayMapInit);
    MapInitStartStamp = GameTime::GetGameTimeMS() + 2000; // because spawning mobs right when player enters map will make some of the spawns not show
}

// spawn a creature if possible. Save it to DB
bool PersonalInstanceStore::SpawnCreature(Player *player, uint32 Entry, Position *pos, bool FromDB, bool TempSpawn)
{
    if (player->FindMap() == NULL)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Player is not in a map. Can't spawn now\n");
        return false;
    }

    int64 *CreaturesSpawend = player->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATURE_SPAWNS);

    if (DEBUG_PERSONAL_INSTANCE) printf("Creatures spawned: %I64d Limit: %d\n", *CreaturesSpawend, CreatureLimit);
    //do we have enough spawn slots to add more spawns ?
    if (TempSpawn == false)
    {
        if (*CreaturesSpawend >= CreatureLimit)
        {
            if (DEBUG_PERSONAL_INSTANCE) printf("Creature spawn limit reached\n");
            if (FromDB == false)
                player->BroadcastMessage("You can't spawn more creatures");
            return false;
        }

        //are we allowed to spawn this creature ?
        if (HasCreatureEntry(Entry) == false)
        {
            if (DEBUG_PERSONAL_INSTANCE) printf("Creature is not added to account\n");
            if (FromDB == false)
                player->BroadcastMessage("You do not have this creature in your spawn list");
            return false;
        }
    }

    //create a new creature spawn
    Creature* creature = new Creature();
    if (DEBUG_PERSONAL_INSTANCE) printf("Create creature %s\n", creature->GetName().c_str());
    if (!creature->Create(player->GetMap()->GenerateLowGuid<HighGuid::Unit>(), player->GetMap(), player->GetPhaseMaskForSpawn(), Entry, *pos, NULL, 0, true))
    {
        delete creature;
        if (DEBUG_PERSONAL_INSTANCE) printf("Could not create creature\n");
        if (FromDB == false)
            player->BroadcastMessage("Could not create creature");
        return false;
    }

    //make sure he is friendly to everyone
    creature->SetFaction(PERSONAL_INSTANCE_FACTION);

    //mark him we are he's owner
    creature->SetGuidValue(OBJECT_FIELD_CREATED_BY, player->GetGUID());

    //remove any AI it may have
    creature->SetAI(NULL);

    //pimp their health hard
    creature->SetMaxHealth(0x07FFFFFF);
    creature->SetHealth(0x07FFFFFF);

    //try tp push it to the map
    if (!player->GetMap()->AddToMap(creature))
    {
        delete creature;
        if (DEBUG_PERSONAL_INSTANCE) printf("Could not add creature to the map\n");
        if (FromDB == false)
            player->BroadcastMessage("Could not add creature to the map");
        return false;
    }

    creature->SetHomePosition(creature->GetPosition());

    if (TempSpawn == false)
    {
        //note down the number of spawns we have
        *CreaturesSpawend += 1;

        //save creature to the DB
        if (FromDB == false)
        {
            PersonalSpawnStore *sp = new PersonalSpawnStore;
            sp->Entry = Entry;
            sp->MapId = player->GetMap()->GetId();
            sp->SpawnType = SPAWN_TYPE_CREATURE;
            sp->pos = *pos;

            //real db save
            SaveSpawnToDB(player, sp);

            //also add to local spawn list in case the player resets it's instance
            MapSpawns.push_back(sp);
        }
    }
    return true;
}

// delete an already spawned creature. From DB also
void PersonalInstanceStore::DeleteCreature(Player *player, Creature *spawn)
{
    //sanity checks
    if (player == NULL || player->GetMap() == NULL || spawn == NULL)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Sanity check failed. Exiting \n");
        return;
    }
    //make sure he is our spawn
    if (spawn->GetGuidValue(OBJECT_FIELD_CREATED_BY) != player->GetGUID())
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Creature belongs to another player\n");
        player->BroadcastMessage("Creature belongs to another player");
        return;
    }
    //find it in our list of spawns
    std::list<PersonalSpawnStore*>::iterator it;
    PersonalSpawnStore *ps = NULL;
    for (it = MapSpawns.begin(); it != MapSpawns.end(); it++)
        if ((*it)->pos == spawn->GetHomePosition() && (*it)->Entry == spawn->GetEntry())
        {
            ps = *it;
            break;
        }
    if (it == MapSpawns.end() || ps == NULL)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Could not find spawn in spawn list\n");
        player->BroadcastMessage("Creature belongs to another player");
        return;
    }

    //delete from list
    MapSpawns.remove(ps);

    //delete from DB
    DeleteSpawnFromDB(player, ps);

    //delete object
    delete ps;

    //remove from world
    spawn->AddObjectToRemoveList();
}

// spawn a gameobject if possible. Save it to DB
Object *PersonalInstanceStore::SpawnGameObject(Player *player, uint32 Entry, Position *pos, bool FromDB)
{
    if (player->FindMap() == NULL)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Player is not in a map. Can't spawn now\n");
        return NULL;
    }

    if (player->GetMap()->GetId() == ENDURANCE_MAP) //Skip on Endurance
        return NULL;

    int64 *GOsSpawend = player->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_GAMEOBJECT_SPAWNS);

    //do we have enough spawn slots to add more spawns ?
    if (*GOsSpawend >= GameobjectLimit)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("gameobjects spawn limit reached\n");
        if (FromDB == false)
            player->BroadcastMessage("You can't spawn more gameobjects");
        return NULL;
    }

    //are we allowed to spawn this creature ?
    if (HasGameObjectEntry(Entry) == false)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("gameobjects is not added to account\n");
        if (FromDB == false)
            player->BroadcastMessage("You do not have this gameobjects in your spawn list");
        return NULL;
    }

    GameObjectTemplate const* objectInfo = sObjectMgr->GetGameObjectTemplate(Entry);
    if (objectInfo == NULL)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("gameobject template does not exist\n");
        if (FromDB == false)
            player->BroadcastMessage("Gameobject template does not exist");
        return NULL;
    }
    GameObject* object = new GameObject();
    ObjectGuid::LowType guidLow = player->GetMap()->GenerateLowGuid<HighGuid::GameObject>();

    QuaternionData rot = QuaternionData::fromEulerAnglesZYX(pos->GetOrientation(), 0.f, 0.f);
    if (!object->Create(guidLow, Entry, player->GetMap(), player->GetPhaseMaskForSpawn(), *pos, rot, 255, GO_STATE_READY))
    {
        delete object;
        return NULL;
    }

    //note down the number of spawns we have
    *GOsSpawend += 1;

    //save creature to the DB
    if (FromDB == false)
    {
        PersonalSpawnStore *sp = new PersonalSpawnStore;
        sp->Entry = Entry;
        sp->MapId = player->GetMap()->GetId();
        sp->SpawnType = SPAWN_TYPE_GAMEOBJECT;
        sp->pos = *pos;

        //real db save
        SaveSpawnToDB(player, sp);

        //also add to local spawn list in case the player resets it's instance
        MapSpawns.push_back(sp);
    }

    //try tp push it to the map
    if (!player->GetMap()->AddToMap(object))
    {
        delete object;
        if (DEBUG_PERSONAL_INSTANCE) printf("Could not add Gameobject to the map\n");
        if (FromDB == false)
            player->BroadcastMessage("Could not add Gameobject to the map");
        return NULL;
    }

    //mark him we are he's owner
    object->SetGuidValue(OBJECT_FIELD_CREATED_BY, player->GetGUID());

    return object;
}

// delete an already spawned gameobject. From DB also
void PersonalInstanceStore::DeleteGameObject(Player *player, GameObject *spawn)
{
    //sanity checks
    if (player == NULL || player->GetMap() == NULL || spawn == NULL)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Sanity check failed. Exiting \n");
        return;
    }

    if (player->GetMap()->GetId() == ENDURANCE_MAP) //Skip on Endurance, just to be safe, should not happen
        return;

    //make sure he is our spawn
    if (spawn->GetOwnerGUID() != player->GetGUID())
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("GameObject belongs to another player\n");
        player->BroadcastMessage("GameObject belongs to another player");
        return;
    }
    //find it in our list of spawns
    std::list<PersonalSpawnStore*>::iterator it;
    PersonalSpawnStore *ps = NULL;
    for (it = MapSpawns.begin(); it != MapSpawns.end(); it++)
        if ((*it)->pos == spawn->GetPosition() && (*it)->Entry == spawn->GetEntry())
        {
            ps = *it;
            break;
        }
    if (it == MapSpawns.end() || ps == NULL)
    {
        if (DEBUG_PERSONAL_INSTANCE) printf("Could not find spawn in spawn list\n");
        player->BroadcastMessage("GameObject belongs to another player");
        return;
    }
    else
    {
        //delete from list
        MapSpawns.remove(ps);
    }

    //delete from DB
    DeleteSpawnFromDB(player, ps);

    //delete object
    delete ps;

    //remove from world
    spawn->AddObjectToRemoveList();
}

// save a spawn to the DB
void PersonalInstanceStore::SaveSpawnToDB(Player *player, PersonalSpawnStore *sp)
{
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "INSERT into account_PersonalMapSpawns (AcctId,MapId,x,y,z,o,entry,spawntype) values (%d,%d,%f,%f,%f,%f,%d,%d)",
        player->GetSession()->GetAccountId(), sp->MapId, sp->pos.GetPositionX(), sp->pos.GetPositionY(), sp->pos.GetPositionZ(), sp->pos.GetOrientation(), sp->Entry, sp->SpawnType);
    CharacterDatabase.Execute(Query);
}

void PersonalInstanceStore::DeleteSpawnFromDB(Player *player, PersonalSpawnStore *sp)
{
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "Delete from account_PersonalMapSpawns where AcctId=%d and MapId=%d and ABS(x-%f)<0.1 and ABS(y-%f)<0.1 and ABS(z-%f)<0.1 and ABS(o-%f)<0.1 and entry=%d and spawntype=%d",
        player->GetSession()->GetAccountId(), sp->MapId, sp->pos.GetPositionX(), sp->pos.GetPositionY(), sp->pos.GetPositionZ(), sp->pos.GetOrientation(), sp->Entry, sp->SpawnType);
    CharacterDatabase.Execute(Query);
}
