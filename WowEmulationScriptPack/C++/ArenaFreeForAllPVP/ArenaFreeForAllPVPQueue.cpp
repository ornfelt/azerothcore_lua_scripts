#include "World.h"
#include "Player.h"
#include "Map.h"
#include "ObjectExtension.cpp"
#include "WorldSession.h"
#include "ScriptedGossip.h"
#include "ArenaFreeForAllPVPStore.h"

#define CREATURE_ENTRY_ASISSTANT        123466
#define NPC_TEXT_ID_QUEUE_CLOSED        100
#define NPC_TEXT_ID_QUEUE_OPEN          101

bool ArenaFreeForAllPVPStore::CanAcceptMorePlayersToQueue()
{
    if (PlayersQueued.size() >= MaxPlayersToQueue)
        return false;
    if (GetStatus() == HG_WAITING_FOR_QUEUE || GetStatus() == HG_WAITING_FOR_QUEUE_COUNTDOWN_END || GetStatus() == HG_WAITING_FOR_QUEUE_COUNTDOWN_START)
        return true;
    return false;
}

void ArenaFreeForAllPVPStore::AdvertiseQueueChange(Player *player, const char *Message)
{
    for (auto itr = PlayersQueued.begin(); itr != PlayersQueued.end(); itr++)
    {
        Player *p = sWorld->GetOnlinePlayer(*itr);
        if (p && p != player)
        {
            p->BroadcastMessage(Message, player->GetName().c_str(), (uint32)PlayersQueued.size());
        }
    }
}

void ArenaFreeForAllPVPStore::QueuePlayer(Player *player)
{
    PlayersQueued.insert(player->GetGUID());

    player->GetCreateExtension<PlayerAreanFFAStore>(OE_PLAYER_ARENAFFA_STORE)->ArenaGuid = GetGuid();
    player->BroadcastMessage("You have been queued to PVP massacre");
    if (GetStatus() == HG_WAITING_FOR_QUEUE)
        WorldAnnounce("PVPMasacre: %d/%d players in queue.", (uint32)PlayersQueued.size(), MinPlayersToQueue);
}

void ArenaFreeForAllPVPStore::RemovePlayerFromQueue(Player *player, bool KickOut)
{
    // HG forgets about player
    PlayersQueued.erase(player->GetGUID());
    // player forgets HG
    player->DeleteExtension<PlayerAreanFFAStore>(OE_PLAYER_ARENAFFA_STORE);

    //if he got kicked because he died, revive him
    if (player->IsAlive() == false)
        player->ResurrectPlayer(100, false);

    //let him know what happened
    player->BroadcastMessage("You have been removed from PVPMassacre queue");
    if (GetStatus() == HG_WAITING_FOR_QUEUE)
        WorldAnnounce("PVPMasacre: %d/%d players in queue.", (uint32)PlayersQueued.size(), MinPlayersToQueue);

    if (KickOut)
    {
        player->TeleportTo(KickToMap, KickToX, KickToY, KickToZ, 0.0f);
        player->SetPvP(false);
        player->RemoveByteFlag(UNIT_FIELD_BYTES_2, UNIT_BYTES_2_OFFSET_PVP_FLAG, UNIT_BYTE2_FLAG_FFA_PVP);

    }
}

void ArenaFreeForAllPVPStore::RemovePlayerFromQueue(ObjectGuid player, bool KickOut)
{
    Player *p = sWorld->GetOnlinePlayer(player);
    if (p)
        RemovePlayerFromQueue(p, KickOut);
    else
        PlayersQueued.erase(player);

}

bool ArenaFreeForAllPVPStore::IsPlayerQueued(Player *player)
{
    PlayerAreanFFAStore *hgs = player->GetExtension<PlayerAreanFFAStore>(OE_PLAYER_ARENAFFA_STORE);
    //no extension, no queue
    if (hgs == NULL)
        return false;
    //not queued to this HG
    if (hgs->ArenaGuid != GetGuid())
        return false;
    //double check if HG thinks the same
    if (PlayersQueued.find(player->GetGUID()) == PlayersQueued.end())
        return false;
    //seems like he is queued to this HG
    return true;
}

uint32 GenerateArenaFFAMenuForPlayer(Player *Plr)
{
    uint32 MenusAdded = 0;
    for (auto itr = ArenaFFAPVPs.begin(); itr != ArenaFFAPVPs.end(); itr++)
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
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_BATTLE, Query, 1, (*itr)->GetGuid(), "", 0);
        }
        else
        {
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "Remove from %s", (*itr)->GetName());
            Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_TAXI, Query, 1, (*itr)->GetGuid(), "", 0);
        }
    }
    return MenusAdded;
}

void GenerateArenaFFAMenuForPlayerWithChecks(Player *Plr, Creature *me)
{
    ClearGossipMenuFor(Plr);

    //open for registration
    uint32 MenusAdded = GenerateArenaFFAMenuForPlayer(Plr);

    //if all hunger game instances are ongoing we tell the player to come back later
    if (MenusAdded == 0)
        SendGossipMenuFor(Plr, NPC_TEXT_ID_QUEUE_CLOSED, me->GetGUID());
    else
    {
        //dummy menu just to do nothing
        Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,GOSSIP_ICON_DOT, "Close", 1, 10000, "", 0);
        SendGossipMenuFor(Plr, NPC_TEXT_ID_QUEUE_OPEN, me->GetGUID());
    }

}

void TogglePlayerQueueArenaFFA(Player *player, uint32 ArenaFFAGUID)
{
    for (auto itr = ArenaFFAPVPs.begin(); itr != ArenaFFAPVPs.end(); itr++)
    {
        if ((*itr)->GetGuid() != ArenaFFAGUID)
            continue;
        if ((*itr)->IsPlayerQueued(player))
        {
            (*itr)->RemovePlayerFromQueue(player, false);
            (*itr)->AdvertiseQueueChange(player, "PVPMasacre : %s has left the queue. %d remaining");
        }
        else
        {
            (*itr)->QueuePlayer(player);
            (*itr)->AdvertiseQueueChange(player, "PVPMasacre : %s has joined. %d players total");
        }
        break;
    }
}
