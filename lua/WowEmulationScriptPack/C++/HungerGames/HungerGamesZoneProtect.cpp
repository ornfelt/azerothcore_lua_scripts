#include "ScriptMgr.h"
#include "SpellMgr.h"
#include "ScriptedCreature.h"
#include "HungerGamesStore.h"
#include "Map.h"
#include "Player.h"
#include "GameEventCallbacks.h"

/*
Periodically check all players on current map
If players are within the protected zone, but they are not in the protected list ( hunger games ), they will be teleported out
*/

void HungerGameStore::CheckProtectZone(Map *map)
{
    if (GetStatus() != HG_ONGOING)
        return;

    //get a list of units / players in this area
    Map::PlayerList const& players = map->GetPlayers();
    for (Map::PlayerList::const_iterator iter = players.begin(); iter != players.end(); ++iter)
    {
        Player* Plr = iter->GetSource();

        if (!Plr || !Plr->GetSession())
            continue;

        // player is just trying to watch the hunger games. So we kick him anyway
        if (this->IsPlayerQueued(Plr) == false && IsPlayerInsideEventArea(Plr) == true && !Plr->IsGameMaster() && !(Plr->IsBeingTeleported() == true || Plr->IsInWorld() == false || Plr->IsLoading() == true))
        {
            Plr->TeleportTo(KickToMap, KickToX, KickToY, KickToZ, 0.0f);
            Plr->SetPvP(false);
            Plr->BroadcastMessage("Hunger games zone protection kicked you out. Wait for it to finish");
            continue;
        }

        //teleport out players that do not belong to that zone
        //out of bounds player does not need adjustments
        //player is dead, eliminate him
        if (this->IsPlayerQueued(Plr) == true && ( IsPlayerInsideEventArea(Plr) == false || Plr->IsAlive() == false ) && !Plr->IsGameMaster() && !(Plr->IsBeingTeleported() == true || Plr->IsInWorld() == false || Plr->IsLoading() == true))
        {
            this->RemovePlayerFromQueue(Plr,true);
            Plr->BroadcastMessage("Hunger games zone protection kicked you out.");
            continue;
        }
    }
}

void HungerGamesPeriodicMapUpdateProtectZones(void *p, void *)
{
    CP_MAP_PERIODIC_UPDATE *params = PointerCast(CP_MAP_PERIODIC_UPDATE, p);
    for (auto itr = HungerGameStores.begin(); itr != HungerGameStores.end(); itr++)
    {
        if ((*itr)->GetMap() == params->map->GetId())
            (*itr)->CheckProtectZone(params->map);
    }
}

void AddHGZoneProtectScripts()
{
    RegisterCallbackFunction(CALLBACK_TYPE_MAP_PERIODIC_UPDATE, HungerGamesPeriodicMapUpdateProtectZones, NULL);
}
