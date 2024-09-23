#include "GameObject.h"
#include "Random.h"
#include "ObjectMgr.h"
#include "GameTime.h"
#include "LootItemStorage.h"
#include "LootMgr.h"
#include "HungerGamesStore.h"
#include "ObjectExtension.cpp"
#include "Item.h"

#ifdef _DEBUG
    #define NumberOfAciveChecksOnMap    10       // stop spawning chests if we reached this amount of chests on the map
    #define CHEST_ENTRY_LOOT_ITEM       5       // add items to this chest, we will only drop 1 item
    #define SPAWN_CHEST_EVERY_X_SECONDS 20       // Every X seconds a new chest will get spawned that players can loot
    #define PROGRESSIVE_LOOT_PERIOD     30       // since the map started we will give out better and better items. This is a catch up mechanism to balance the game
#else
    #define NumberOfAciveChecksOnMap    5       // stop spawning chests if we reached this amount of chests on the map
    #define CHEST_ENTRY_LOOT_ITEM       5       // add items to this chest, we will only drop 1 item
    #define SPAWN_CHEST_EVERY_X_SECONDS 180       // Every X seconds a new chest will get spawned that players can loot
    #define PROGRESSIVE_LOOT_PERIOD     180       // since the map started we will give out better and better items. This is a catch up mechanism to balance the game
#endif

#define MARK_GO_LOOT_GENERATED 66

bool HungerGameStore::SpawnNewCrate(Map *map)
{
    if (PossibleChestLocations.empty() == true)
        return false;

    //are we allowed to spawn more chests ? Maybe we are full
    //clean up our chest list. Ditch already looted chests
    uint32 ActiveChestCount = 0;
    for (auto itr = PossibleChestLocations.begin(); itr != PossibleChestLocations.end(); itr++)
    {
        GameObject *go = map->GetGameObject((*itr)->SpawnGuid);

        //remove looted objects and spawn new ones instead
        if (go != NULL && go->loot.isLooted() && go->loot.maxDuplicates == MARK_GO_LOOT_GENERATED)
        {
            go->AddObjectToRemoveList();
            continue;
        }

        //gameobject got removed, we can spawn a new instead of it
        if (go == NULL)
        {
            (*itr)->SpawnGuid = ObjectGuid::Empty;
            continue;
        }
        ActiveChestCount++;
    }

    //we got enough chests on the map. Nothing more to do
    if (ActiveChestCount >= MaxAllowedChestsActiveOnMap)
        return false;

    //try to randomly pick a location that is not yet taken
    ObjectsSpawnStore *tspawn = NULL;
    uint32 MaxLocations = (uint32)PossibleChestLocations.size();
    for (int RandomTry = 0; RandomTry < 50; RandomTry++)
    {
        uint32 RandomLoc = rand32() % MaxLocations;
        tspawn = PossibleChestLocations.at(RandomLoc);
        if (tspawn->SpawnGuid != ObjectGuid::Empty && map->GetGameObject(tspawn->SpawnGuid) != NULL)
            continue;
        //check if we are allowed to spawn at this distance
        if (SpawnsReducedToMid == true)
        {
            time_t TimeSpent = GameTime::GetGameTime() - StartedAt;
            float TimeRemainingPCT = 1 - (float)TimeSpent / (float)ForceEndMatchAfterXSeconds;
            float DistanceAllowed = EventRadius * TimeRemainingPCT;
            if (tspawn->pos.GetExactDist2dSq(Position(EventCenterX, EventCenterY)) > DistanceAllowed * DistanceAllowed)
                continue;// this spawn is too far from center. Deny spawning it
        }
        break;
    }

    //if we could not get a random location, we will pick first available
    if (tspawn == NULL)
    {
        for (auto itr = PossibleChestLocations.begin(); itr != PossibleChestLocations.end(); itr++)
        {
            GameObject *go = map->GetGameObject((*itr)->SpawnGuid);
            if (go == NULL)
            {
                tspawn = (*itr);
                break;
            }
        }
    }

    //we can't spawn more chests
    if (tspawn == NULL)
    {
        return false;
    }

    //spawn a check at the location
    GameObjectTemplate const* objectInfo = sObjectMgr->GetGameObjectTemplate(CHEST_ENTRY_LOOT_ITEM);
    if (objectInfo == NULL)
    {
        printf("Holy moly, gameobject template missing from DB");
        return false;
    }
    GameObject* object = new GameObject();
    ObjectGuid::LowType guidLow = map->GenerateLowGuid<HighGuid::GameObject>();

    QuaternionData rot = QuaternionData::fromEulerAnglesZYX(tspawn->pos.GetOrientation(), 0.f, 0.f);
    if (!object->Create(guidLow, CHEST_ENTRY_LOOT_ITEM, map, PHASEMASK_NORMAL, tspawn->pos, rot, 255, GO_STATE_READY))
    {
        printf("Could not create gameobject");
        delete object;
        return false;
    }

    //try tp push it to the map
    if (!map->AddToMap(object))
    {
        delete object;
        printf("Could not add Gameobject to the map\n");
        return false;
    }

    //need to despawn these after the HG ends
    tspawn->SpawnGuid = object->GetGUID();

    return true;
}

void HungerGameStore::CheckSpawnLootChests(Map *map)
{
    //if the fight ended or not started yet, we despawn all our chests
    if (GetStatus() != HG_ONGOING)
    {
        RemoveAllSpawnedChests(map);
        return;
    }

    time_t TimePassed = GameTime::GetGameTime() - LastChestSpawnedAt;
    if (TimePassed < ChestSpawnPeriod)
        return;

    // do not spam this function
    LastChestSpawnedAt = GameTime::GetGameTime();

    SpawnNewCrate(map);
}

void HungerGamesPeriodUpdateChestLoots(void *p, void *)
{
    CP_MAP_PERIODIC_UPDATE *params = PointerCast(CP_MAP_PERIODIC_UPDATE, p);
    for (auto itr = HungerGameStores.begin(); itr != HungerGameStores.end(); itr++)
    {
        if ((*itr)->GetMap() == params->map->GetId())
        {
            (*itr)->CheckSpawnLootChests(params->map);
            (*itr)->CheckSpawnRandomCreatures(params->map);
        }
    }
}

void HungerGameStore::AddPossibleItemLoot(uint32 QualityTier, uint32 Entry)
{
    if (QualityTier >= MAX_LOOT_TIERS)
    {
        printf("Error:Can't add item to loot table if higher than max tier. Increase max tier ?\n");
        return;
    }
    PossibleItemQualityLoots[QualityTier].push_back(Entry);
}

std::vector<uint32> *HungerGameStore::GetLootList()
{
    //loot quality will progress in time. Check how much time has passed
    time_t TimePassed = GetTimePassed();
    uint32 LootLevel = (uint32)TimePassed / ProgresiveLootSwitchPeriod;
    if (LootLevel >= MAX_LOOT_TIERS)
        LootLevel = MAX_LOOT_TIERS - 1;

    //get a list that actually has items in it. Maybe not all lists have been filled
    for (; LootLevel > 0; LootLevel--)
        if (PossibleItemQualityLoots[LootLevel].empty() == false)
            break;

    return &PossibleItemQualityLoots[LootLevel];
}

bool CanPickItem(Player *p, uint32 Entry)
{
    //already has this item ? skip adding it
    if (p->GetItemCount(Entry) > 0)
        return false;
    //can't use it ? skip it
    if (p->CanUseItem(sObjectMgr->GetItemTemplate(Entry)) != EQUIP_ERR_OK)
        return false;
    // can we equip it ?
    uint16 dest;
    InventoryResult result = EQUIP_ERR_NONE;
    Item* pItem = Item::CreateItem(Entry, 1, p);
    if (pItem)
    {
        result = p->CanEquipItem(NULL_SLOT, dest, pItem, true, false);
        delete pItem;
    }
    if (result != EQUIP_ERR_OK)
        return false;
    return true;
}

uint32 PickGoodItemForPlayer(Player *p, std::vector<uint32> *ItemList)
{
    uint32 ItemListSize = (uint32)ItemList->size();

    // we should pick an item in random order
    for (int32 i = 0; i < 50; i++)
    {
        uint32 RandomIndex = rand32() % ItemListSize;
        uint32 Entry = ItemList->at(RandomIndex);
        if (CanPickItem(p, Entry) == true)
            return Entry;
    }

    //no chance in hell to pick a random item, we will pick the first good item
    for (int32 i = ItemListSize - 1; i >= 0; i--)
    {
        uint32 Entry = ItemList->at(i);
        if (CanPickItem(p, Entry) == true)
            return Entry;
    }

    //no good item found
    return 0;
}

void HungerGamesAlwaysDropsGoodLoot(void *p, void *)
{
    CP_LOOT_SEND *params = PointerCast(CP_LOOT_SEND, p);
    //sanity check
    if (params->Looter == NULL)
        return;

    // is the player participating in any valid ongoing hunger games ?
    HungerGameStore *ActiveHG = IsHungerGamesActiveForPlayer(params->Looter);
    if (ActiveHG == NULL)
        return;

    //if this chest was already looted. Skip generating loot second time
    if (params->Loot->maxDuplicates == 66)
        return;

    // clear loot list ( or maybe it was cleared already ? )
    params->Loot->clear();
    params->Loot->gold = 0;
    params->Loot->maxDuplicates = MARK_GO_LOOT_GENERATED;

    uint32 SelectedEntry = PickGoodItemForPlayer(params->Looter, ActiveHG->GetLootList());

    //could not get an item to be given to the player
    if (SelectedEntry != 0)
    {
        LootStoreItem lsi(SelectedEntry, 0, 100, false, LOOT_MODE_DEFAULT, 0, 1, 1);
        params->Loot->AddItem(lsi);
        //also add 2 potions
        LootStoreItem lsi2(33447, 0, 100, false, LOOT_MODE_DEFAULT, 0, 1, 1);
        params->Loot->AddItem(lsi2);
        LootStoreItem lsi3(33448, 0, 100, false, LOOT_MODE_DEFAULT, 0, 1, 1);
        params->Loot->AddItem(lsi3);
    }
}

void HungerGamesPlayerLootedItem(void *p, void *)
{
    CP_ITEM_LOOTED *params = PointerCast(CP_ITEM_LOOTED, p);

    //sanity check
    if (params->Owner == NULL)
        return;

    //the game is not up yet
    if (IsHungerGamesActiveForPlayer(params->Owner) == false)
        return;

    //seems like he is a hunger games players
    params->Item->GetCreateExtension<bool>(OE_ITEM_IS_TEMPORARY);
}

void AddHugerGamesLootMonitorScripts()
{
    RegisterCallbackFunction(CALLBACK_TYPE_MAP_PERIODIC_UPDATE, HungerGamesPeriodUpdateChestLoots, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_LOOT_SEND, HungerGamesAlwaysDropsGoodLoot, NULL);
}
