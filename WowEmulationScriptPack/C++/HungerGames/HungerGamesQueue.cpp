#include "World.h"
#include "Player.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "CreatureAI.h"
#include "Creature.h"
#include "Map.h"
#include "ObjectExtension.cpp"
#include "HungerGamesStore.h"
#include "WorldSession.h"
#include "Item.h"

#define CREATURE_ENTRY_ASISSTANT        123457  // auto spawn it once we enter our instance
#define NPC_TEXT_ID_QUEUE_CLOSED        98
#define NPC_TEXT_ID_QUEUE_OPEN          99

void AddGossipItemForArcemu(Player* player, uint32 icon, std::string const& text, uint32 MenuId);
bool CheckPlayerHasItems(Player *Plr);

uint32 GenerateHungerGamesMenuForPlayer(Player *Plr)
{
    uint32 MenusAdded = 0;
    for (auto itr = HungerGameStores.begin(); itr != HungerGameStores.end(); itr++)
    {
        //can only list hunger games that are not already ongoing
        if ((*itr)->CanAcceptMorePlayersToQueue() == false)
            continue;

        MenusAdded++;
        //show queue status for existing hunger games
        if ((*itr)->IsPlayerQueued(Plr) == false)
        {
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "Queue for %s", (*itr)->GetName());
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, Query, (*itr)->GetGuid());
        }
        else
        {
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "Remove from %s", (*itr)->GetName());
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_TAXI, Query, (*itr)->GetGuid());
        }
    }
    return MenusAdded;
}

void GenerateHungerGamesMenuForPlayerWithChecks(Player *Plr, Creature *me)
{
    ClearGossipMenuFor(Plr);

    //check player if he has items
    if (CheckPlayerHasItems(Plr) == true)
    {
        Plr->BroadcastMessage("You can only join hunger games if you own 0 items and no extra bags. Please remove your items and try again");
        return;
    }

    if (Plr->Ironman() == true || Plr->Hardcore() == true)
    {
        Plr->BroadcastMessage("Please join with a character you specially made for Hunger Games");
        return;
    }

    //open for registration
    uint32 MenusAdded = GenerateHungerGamesMenuForPlayer(Plr);

    //if all hunger game instances are ongoing we tell the player to come back later
    if (MenusAdded == 0)
        SendGossipMenuFor(Plr, NPC_TEXT_ID_QUEUE_CLOSED, me->GetGUID());
    else
    {
        //dummy menu just to do nothing
        AddGossipItemForArcemu(Plr, GOSSIP_ICON_DOT, "Close", 10000);
        SendGossipMenuFor(Plr, NPC_TEXT_ID_QUEUE_OPEN, me->GetGUID());
    }

}
void TogglePlayerQueue(Player *player, uint32 HungerGamesGUID)
{
    for (auto itr = HungerGameStores.begin(); itr != HungerGameStores.end(); itr++)
    {
        if ((*itr)->GetGuid() != HungerGamesGUID)
            continue;
        if ((*itr)->IsPlayerQueued(player))
        {
            (*itr)->RemovePlayerFromQueue(player,false);
            (*itr)->AdvertiseQueueChange(player, "Hunger Games : %s has left the queue. %d remaining");
        }
        else
        {
            (*itr)->QueuePlayer(player);
            (*itr)->AdvertiseQueueChange(player, "Hunger Games : %s has joined. %d players total");
        }
        break;
    }
}

bool HungerGameStore::CanAcceptMorePlayersToQueue()
{
    if (PlayersQueued.size() >= MaxPlayersToQueue)
        return false;
    if (GetStatus() == HG_WAITING_FOR_QUEUE || GetStatus() == HG_WAITING_FOR_QUEUE_COUNTDOWN_END || GetStatus() == HG_WAITING_FOR_QUEUE_COUNTDOWN_START)
        return true;
    return false;
}

void HungerGameStore::AdvertiseQueueChange(Player *player, const char *Message)
{
    for (auto itr = PlayersQueued.begin(); itr != PlayersQueued.end(); itr++)
    {
        Player *p = sWorld->GetOnlinePlayer(*itr);
        if (p && p != player)
        {
            p->BroadcastMessage(Message, player->GetName().c_str(),(uint32)PlayersQueued.size());
        }
    }
}

void WorldAnnounce(const char *str)
{
    const SessionMap m_sessions = sWorld->GetAllSessions();
    for (SessionMap::const_iterator itr = m_sessions.begin(); itr != m_sessions.end(); ++itr)
    {
        if (!itr->second || !itr->second->GetPlayer() || !itr->second->GetPlayer()->IsInWorld())
            continue;

        itr->second->GetPlayer()->BroadcastMessage(str);
    }
}

void WorldAnnounce(const char *str, uint32 count /*= 0*/, uint32 max)
{
    char TempBuffer[5000];
    sprintf_s(TempBuffer, sizeof(TempBuffer), str, count, max);
    WorldAnnounce(TempBuffer);
}

void HungerGamesPlayerLootedItem(void *p, void *NOTUSED);
void HungerGamesPlayerLootXp(void *p, void *NOTUSED);
void HungerGamesPlayerAttackCreature(void *p, void *NOTUSED);
void HungerGamesPlayerLootAura(void *p, void *NOTUSED);
void HungerGamesPlayerLootSpell(void *p, void *NOTUSED);
void HungerGamesPlayerLootItemFromCreature(void *p, void *NOTUSED);
void HungerGameStore::QueuePlayer(Player *player)
{
    // HG knows about the player
    PlayersQueued.insert(player->GetGUID());
    // player knows about HG
    player->GetCreateExtension<PlayerHungerGamesStore>(OE_PLAYER_HUNGER_GAMES_STORE)->HungerGamesGuid = GetGuid();
    player->BroadcastMessage("You have been queued to Hunger Games");
    if(GetStatus() == HG_WAITING_FOR_QUEUE)
        WorldAnnounce("Hunger Games: %d/%d players in queue.", (uint32)PlayersQueued.size(), MinPlayersToQueue);
}

void HungerGameStore::RemovePlayerFromQueue(Player *player, bool KickOut)
{
    // HG forgets about player
    PlayersQueued.erase(player->GetGUID());
    // player forgets HG
    player->DeleteExtension<int64>(OE_PLAYER_HUNGER_GAMES_STORE);
    // all loot is valid from now on
    player->UnRegisterCallbackFunc(CALLBACK_TYPE_LOOT_ITEM, HungerGamesPlayerLootedItem);
    // XP loot
    player->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, HungerGamesPlayerLootXp);
    player->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, HungerGamesPlayerLootXp);
    player->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, HungerGamesPlayerLootAura);
    player->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, HungerGamesPlayerLootSpell);
    player->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_KILL_CREATURE, HungerGamesPlayerLootItemFromCreature);

    // remove all forced auras from him
    for (auto j = PeriodicCastBuffs.begin(); j != PeriodicCastBuffs.end(); j++)
        player->RemoveAura(*j);

    // remove temporary items from him
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
    {
        Item *it = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it != NULL && it->GetExtension<bool>(OE_ITEM_IS_TEMPORARY))
            player->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
    }
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item *it = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it != NULL && it->GetExtension<bool>(OE_ITEM_IS_TEMPORARY))
            player->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);
    }

    //if he got kicked because he died, revive him
    if(player->IsAlive() == false)
        player->ResurrectPlayer(100, false);

    //let him know what happened
    player->BroadcastMessage("You have been removed from Hunger Games queue");
    if (GetStatus() == HG_WAITING_FOR_QUEUE)
        WorldAnnounce("Hunger Games: %d/%d players in queue.", (uint32)PlayersQueued.size(), MinPlayersToQueue);

    if (KickOut)
    {
        player->TeleportTo(KickToMap, KickToX, KickToY, KickToZ, 0.0f);
        player->SetPvP(false);
        player->RemoveByteFlag(UNIT_FIELD_BYTES_2, UNIT_BYTES_2_OFFSET_PVP_FLAG, UNIT_BYTE2_FLAG_FFA_PVP);

    }
}

void HungerGameStore::RemovePlayerFromQueue(ObjectGuid player, bool KickOut)
{
    Player *p = sWorld->GetOnlinePlayer(player);
    if (p)
        RemovePlayerFromQueue(p, KickOut);
    else
        PlayersQueued.erase(player);

}

bool HungerGameStore::IsPlayerQueued(Player *player)
{
    PlayerHungerGamesStore *hgs = player->GetExtension<PlayerHungerGamesStore>(OE_PLAYER_HUNGER_GAMES_STORE);
    //no extension, no queue
    if (hgs == NULL)
        return false;
    //not queued to this HG
    if (hgs->HungerGamesGuid != GetGuid())
        return false;
    //double check if HG thinks the same
    if (PlayersQueued.find(player->GetGUID()) == PlayersQueued.end())
        return false;
    //seems like he is queued to this HG
    return true;
}

class HungerGamesQueueNPC : public CreatureScript
{
public:
    HungerGamesQueueNPC() : CreatureScript("HungerGamesQueueNPC") { }

    struct HungerGamesQueueNPCAI : public CreatureAI
    {
        HungerGamesQueueNPCAI(Creature* creature) : CreatureAI(creature) {}
        ~HungerGamesQueueNPCAI()
        {
        }
        void UpdateAI(uint32 diff) override {}//does nothing unless we say so

                                              //construct gossip menu to show to player
        bool GossipHello(Player* Plr)
        {

            GenerateHungerGamesMenuForPlayerWithChecks(Plr, me);

            //handled like a pro
            return true;
        }

        //when player clicks on a gossip menu, we call the callback function
        bool GossipSelect(Player* Plr, uint32 menuId, uint32 gossipListId)
        {
            uint32 const IntId = Plr->PlayerTalkClass->GetGossipOptionAction(gossipListId);

            //if player was queued, unque, else register to queue
            TogglePlayerQueue(Plr, IntId);

            CloseGossipMenuFor(Plr);
            return true;
        }
    };
    CreatureAI* GetAI(Creature* creature) const override
    {
        return new HungerGamesQueueNPCAI(creature);
    }
};

void AddHGQueueScripts()
{
    new HungerGamesQueueNPC();
}
