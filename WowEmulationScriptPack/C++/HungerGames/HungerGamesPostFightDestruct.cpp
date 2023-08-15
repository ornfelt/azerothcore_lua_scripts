#include "GameTime.h"
#include "Player.h"
#include "Map.h"
#include "GameObject.h"
#include "HungerGamesStore.h"
#include "World.h"

void HungerGameStore::DespawnTempGameObjects(Map *map)
{
    for (auto itr = TemporaryGameObjects.begin(); itr != TemporaryGameObjects.end(); itr++)
    {
        GameObject *go = map->GetGameObject((*itr)->SpawnGuid);
        if (go == NULL)
            continue;
        go->AddObjectToRemoveList();
    }
    TemporaryGameObjects.clear();
}

void HungerGameStore::RemoveAllSpawnedChests(Map *map)
{
    for (auto itr = PossibleChestLocations.begin(); itr != PossibleChestLocations.end(); itr++)
    {
        GameObject *go = map->GetGameObject((*itr)->SpawnGuid);
        if (go == NULL)
        {
            (*itr)->SpawnGuid = ObjectGuid::Empty;
            continue;
        }
        go->AddObjectToRemoveList();
    }
}

void HungerGameStore::PostFightDeinit()
{
    // this HG ended. Start a new one
    if (Status == HG_ONGOING)
    {
        //check if players are still on the map. we need to check on global list of players because maps without any players will not get updated.
        std::set<ObjectGuid>    PlayersArrived = PlayersQueued;
        for (auto itr = PlayersArrived.begin(); itr != PlayersArrived.end(); itr++)
        {
            Player *p = sWorld->GetOnlinePlayer(*itr);
            // player DCed. We consider this cheating
            if (p == NULL)
            {
                DeserterPlayersCount++;
                RemovePlayerFromQueue(*itr);
                continue;
            }

            //player fled. Deserter
            if (IsPlayerInsideEventArea(p) == false)
            {
                DeserterPlayersCount++;
                RemovePlayerFromQueue(p,false);
                continue;
            }
        }

        if (PlayersQueued.size() <= 1 || StartedAt + ForceEndMatchAfterXSeconds < GameTime::GetGameTime())
        {
            //remove all players
            auto PlayersQueued2 = PlayersQueued;
            for (auto itr = PlayersQueued2.begin(); itr != PlayersQueued2.end(); itr++)
                RemovePlayerFromQueue(*itr,true);
            //mark map in finished state
            Status = HG_WAITING_FOR_QUEUE_COUNTDOWN_END;
            EndedAt = GameTime::GetGameTime();
        }
    }

    if (Status == HG_WAITING_FOR_QUEUE_COUNTDOWN_END)
    {
        if (EndedAt + WaitUntilNextQueueStarts > GameTime::GetGameTime())
            return;
        Status = HG_WAITING_FOR_QUEUE;
    }
}
