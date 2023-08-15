#include "Creature.h"
#include "HungerGamesStore.h"
#include "GameTime.h"
#include "World.h"
#include "Player.h"
#include "Map.h"
#include "ScriptedGossip.h"
#include "ObjectExtension.cpp"

std::set<HungerGameStore*> HungerGameStores;
static int HungerGamesGUID = 1000;

HungerGameStore::HungerGameStore()
{
    Status = HG_WAITING_FOR_QUEUE;
    EndedAt = 0;
    GUID = HungerGamesGUID++;
    ProgresiveLootSwitchPeriod = 180;
    ForceSetPlayerLevel = 0;
    ForceResetTalents = 0;
    ForceResetSpells = 0;
    MaxPlayersToQueue = 666;
    WaitUntilNextQueueStarts = 2 * 60;
    ForceEndMatchAfterXSeconds = 15 * 60;
    MinPlayersToQueue = 2;
    SpawnsReducedToMid = false;
    ZoneIdBound = 0;
    AreaIdBound = 0;
    ChestSpawnPeriod = 20;
    LastChestSpawnedAt = 0;
    CreatureSpawnPeriod = 20;
    LastCreatureSpawnedAt = 0;
    NextCreatureSpawnLocation = 0;
    OnWinCreditReward = 0;
}

void HungerGameStore::UpdateHungerGameStatus(Map *map)
{
    //this needs to run all the time even if the instanced map is not yet made
    PreFightSetupAndUpdates();

    //needs to shut down the instance if players left the map
    PostFightDeinit();

    if (GetMap() != map->GetId())
        return;

    CheckProtectZone(map);
    MidFightUpdates(map);
    PeriodicGiveHints(map);
}

time_t HungerGameStore::GetTimePassed()
{
    if (GetStatus() != HG_ONGOING)
        return 0;
    return GameTime::GetGameTime() - StartedAt;
}

HungerGameStore *IsHungerGamesActiveForPlayer(Player *p)
{
    //only Hunger games players will have their loot denied
    PlayerHungerGamesStore *hgs = p->GetExtension<PlayerHungerGamesStore>(OE_PLAYER_HUNGER_GAMES_STORE);
    if (hgs == NULL)
        return NULL;

    for (auto itr = HungerGameStores.begin(); itr != HungerGameStores.end(); itr++)
    {
        //not the HG the player is queued for
        if ((*itr)->GetGuid() != hgs->HungerGamesGuid)
            continue;
        //can only list hunger games that are not already ongoing
        if ((*itr)->GetStatus() != HG_ONGOING)
            return NULL;
        return (*itr);
    }

    //player has an invalid HG guid
    return NULL;
}
