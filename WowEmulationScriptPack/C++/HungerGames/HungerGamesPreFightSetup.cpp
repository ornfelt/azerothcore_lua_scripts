#include "GameTime.h"
#include "World.h"
#include "Player.h"
#include "Map.h"
#include "ObjectMgr.h"
#include "GameObject.h"
#include "SpellHistory.h"
#include "HungerGamesStore.h"
#include "Item.h"
#include "ObjectExtension.cpp"

bool CheckPlayerHasItems(Player *Plr)
{
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
        if (Plr->GetItemByPos(INVENTORY_SLOT_BAG_0, i) != NULL)
            return true;
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        if (Plr->GetItemByPos(INVENTORY_SLOT_BAG_0, i) != NULL)
            return true;
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
        if (Plr->GetItemByPos(INVENTORY_SLOT_BAG_0, i) != NULL)
            return true;
    return false;
}

void RemoveAllItemsFromPlayer(Player *Plr)
{
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
        Plr->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
        Plr->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
        Plr->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
}

void HungerGameStore::SpawnTempGameObjects(Map *map)
{
    for (auto i = TemporaryGameObjects.begin(); i != TemporaryGameObjects.end(); i++)
    {
        uint32 Entry = (*i)->Entry;
        GameObjectTemplate const* objectInfo = sObjectMgr->GetGameObjectTemplate(Entry);
        if (objectInfo == NULL)
        {
            printf("Holy moly, temp gameobject template missing from DB");
            return;
        }
        GameObject* object = new GameObject();
        ObjectGuid::LowType guidLow = map->GenerateLowGuid<HighGuid::GameObject>();

        QuaternionData rot = QuaternionData::fromEulerAnglesZYX((*i)->pos.GetOrientation(), 0.f, 0.f);
        if (!object->Create(guidLow, Entry, map, PHASEMASK_NORMAL, (*i)->pos, rot, 255, GO_STATE_READY))
        {
            printf("Could not create gameobject");
            delete object;
            return;
        }

        //try tp push it to the map
        if (!map->AddToMap(object))
        {
            delete object;
            printf("Could not add Gameobject to the map\n");
            return;
        }

        //if we managed to spawn it, store the guid later so we can despawn it
        (*i)->SpawnGuid = object->GetGUID();
    }
}

bool AddTempItemToplayer(Player *p, uint32 Entry)
{
    int32 count = 1;
    uint32 noSpaceForCount = 0;
    ItemPosCountVec dest;
    InventoryResult msg = p->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, Entry, count, &noSpaceForCount);
    if (msg != EQUIP_ERR_OK)
        count -= noSpaceForCount;

    if (count == 0 || dest.empty())
        return false;

    //store a new item for the player
    Item* item = p->StoreNewItem(dest, Entry, true);
    if (item)
        item->GetCreateExtension<bool>(OE_ITEM_IS_TEMPORARY);

    p->SendNewItem(item, 1, false, false, true);

    /*
    //try to auto equip this item
    uint32 EquipSlot = p->FindEquipSlot(item->GetTemplate(), NULL_SLOT, true);
    if(EquipSlot != NULL_SLOT)
    p->EquipItem(EquipSlot, item, true); */
    return true;
}

bool CanPickItem(Player *p, uint32 Entry);
void WorldAnnounce(const char *str);
void HungerGamesPlayerLootedItem(void *p, void *NOTUSED);
void HungerGamesPlayerLootXp(void *p, void *NOTUSED);
void HungerGamesPlayerAttackCreature(void *p, void *NOTUSED);
void HungerGamesPlayerLootAura(void *p, void *NOTUSED);
void HungerGamesPlayerLootSpell(void *p, void *NOTUSED);
void HungerGamesPlayerLootItemFromCreature(void *p, void *NOTUSED);
void HungerGameStore::PreFightSetupAndUpdates()
{
    //have enough players to start map ?
    if (Status == HG_WAITING_FOR_QUEUE)
    {
        if (PlayersQueued.size() < MinPlayersToQueue)
            return;

        //mark it as started
        Status = HG_WAITING_FOR_QUEUE_COUNTDOWN_START;
        StartedAt = GameTime::GetGameTime();

        //Tell Players we will start teleporting them shortly
        for (auto itr = PlayersQueued.begin(); itr != PlayersQueued.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);
            if (p)
                p->BroadcastMessage("Do NOT try to equip anything or you will be kicked!");
        }
        WorldAnnounce("Hunger games has enough players in queue to start. Waiting for last second subscriptions");

        QueuedPlayersAtStart = (uint32)PlayersQueued.size();
    }

    if (Status == HG_WAITING_FOR_QUEUE_COUNTDOWN_START)
    {
        if (StartedAt + WaitAdditionalSubscriptionToMinimum > GameTime::GetGameTime() && PlayersQueued.size() < MaxPlayersToQueue)
            return;

        StartedAt = GameTime::GetGameTime();

        //Tell Players we will start teleporting them shortly
        for (auto itr = PlayersQueued.begin(); itr != PlayersQueued.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);
            if (p)
                p->BroadcastMessage("You will be teleported to Hunger Games arena shortly");
        }

        Status = HG_STARTING;
    }

    if (Status == HG_STARTING)
    {
        if (StartedAt + WarnPlayerTeleportIncommingSeconds > GameTime::GetGameTime())
            return;

        StartedAt = GameTime::GetGameTime();
        Status = HG_TELEPORTING;
        uint32 TeleportLocationNext = 0;
        uint32 MaxAvailableTeleportLocations = (uint32)PossiblePlayerLocations.size();
        //sanity check
        if (MaxAvailableTeleportLocations == 0)
        {
            PossiblePlayerLocations.push_back(new Position(EventCenterX, EventCenterY, EventCenterZ));
            MaxAvailableTeleportLocations = 1;
        }
        for (auto itr = PlayersQueued.begin(); itr != PlayersQueued.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);
            if (p)
            {
                Position *pos = PossiblePlayerLocations.at(TeleportLocationNext);
                TeleportLocationNext = (TeleportLocationNext + 1) % MaxAvailableTeleportLocations;
                p->SetHealth(p->GetMaxHealth());
                p->SetPower(POWER_MANA, p->GetMaxPower(POWER_MANA));
                p->SetPower(POWER_RAGE, 0);
                p->SetPower(POWER_ENERGY, p->GetMaxPower(POWER_ENERGY));
                p->RemoveArenaSpellCooldowns(true);
                p->SetPvP(true);
                p->TeleportTo(EventMapId, pos->GetPositionX(), pos->GetPositionY(), pos->GetPositionZ(), pos->GetOrientation());
            }
        }
    }

    if (Status == HG_TELEPORTING)
    {
        // wait one second
        if (StartedAt + 1 > GameTime::GetGameTime())
            return;

        //check all players arrived earlier than timeout
        bool                    WaitForMorePlayers = false;
        std::set<ObjectGuid>    PlayersArrived = PlayersQueued;
        for (auto itr = PlayersArrived.begin(); itr != PlayersArrived.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);
            //will remove this player later
            if (p == NULL)
                continue;

            if (IsPlayerInsideEventArea(p) == false || p->IsBeingTeleported() == true || p->IsInWorld() == false || p->IsLoading() == true)
            {
                WaitForMorePlayers = true;
                break;
            }
        }

        // did all players arrive ?
        if (WaitForMorePlayers == true && StartedAt + WaitPlayerTeleportSeconds > GameTime::GetGameTime())
            return;

        //kick players that did not make it
        for (auto itr = PlayersArrived.begin(); itr != PlayersArrived.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);

            //delete players that DCed
            if (p == NULL)
            {
                RemovePlayerFromQueue(*itr);
                continue;
            }

            //delete players that failed to teleport
            if (IsPlayerInsideEventArea(p) == false)
            {
                RemovePlayerFromQueue(p,false);
                continue;
            }

            // just in case they tried to cheat
            //RemoveAllItemsFromPlayer(p);

            //double check. Should not trigger
            if (CheckPlayerHasItems(p) == true)
            {
                RemovePlayerFromQueue(p,true);
                continue;
            }

            //maybe we want to force player to have a specific level at the beggining
            if (ForceSetPlayerLevel != 0)
                p->SetLevel(ForceSetPlayerLevel);

            //new level might mean new talent point count. Reset them
            if (ForceResetTalents != 0)
                p->ResetTalents(true);

            // maybe there is some mechanic to learn new spells
            if (ForceResetSpells != 0)
                p->ResetSpells(true);// would be best. Not working atm

            //maybe we want to add items to players
            for (auto i = StartItems.begin(); i != StartItems.end(); i++)
                if (CanPickItem(p, *i) == true) // can we add this specific item ?
                    AddTempItemToplayer(p, *i);

            //enable PVP with FFA
            p->SetPvP(true);
            p->SetByteFlag(UNIT_FIELD_BYTES_2, UNIT_BYTES_2_OFFSET_PVP_FLAG, UNIT_BYTE2_FLAG_FFA_PVP);

            //remove all buffs and debuffs
            p->RemoveAllAuras();

            // register our hooks
            // mark all received loot temporaray
            p->RegisterCallbackFunc(CALLBACK_TYPE_LOOT_ITEM, HungerGamesPlayerLootedItem);
            p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, HungerGamesPlayerLootXp);
            p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, HungerGamesPlayerLootAura);
            p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, HungerGamesPlayerLootSpell);
            p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, HungerGamesPlayerLootItemFromCreature);
            p->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, HungerGamesPlayerAttackCreature);
        }

        //set ongoing status
        Status = HG_ONGOING;
        TeleportedPlayersAtStart = (uint32)PlayersQueued.size();
        //        PlayersPlayed = PlayersQueued; // we should remove items from these players
        DeserterPlayersCount = 0;
        LastChestSpawnedAt = 0;
        NeedsOneTimeInit = true;
        NextGameHintStamp = 0;

        StartedAt = GameTime::GetGameTime(); // reset timer again
    }
}
