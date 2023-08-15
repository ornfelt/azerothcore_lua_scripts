#include "GameTime.h"
#include "Player.h"
#include "Map.h"
#include "HungerGamesStore.h"

bool  HungerGameStore::IsPlayerInsideEventArea(Player *p)
{
    if (p->FindMap() == NULL)
        return false;
    if (p->IsBeingTeleported() == true || p->IsInWorld() == false || p->IsLoading() == true)
        return true;
    if (p->GetMap()->GetId() != EventMapId)
        return false;
    if (ZoneIdBound != 0 && p->GetZoneId() != ZoneIdBound)
        return false;
    if (ZoneIdBound != 0 && p->GetAreaId() != AreaIdBound)
        return false;
//    float pZ = p->GetPositionZ();
    Position pos(EventCenterX, EventCenterY, EventCenterZ);
    float Dist = pos.GetExactDist2dSq(p->GetPosition());
    float NeedDistance = EventRadius * EventRadius;
    if (NeedDistance < Dist)
        return false;
    return true;
}

void WorldAnnounce(const char *str);
void HungerGameStore::MidFightUpdates(Map *map)
{
    if (Status == HG_ONGOING)
    {
        if (NeedsOneTimeInit == true)
        {
            RemoveAllSpawnedChests(map);
            DespawnTempGameObjects(map);
            //spawn gates and other temp spawns
            SpawnTempGameObjects(map);
            // spawn creatures to an initial state
            SpawnCreaturesInitial(map);
            // spawn a few initial crates
            while (SpawnNewCrate(map));
            NeedsOneTimeInit = false;
        }

        //maybe some players deserted the scene
        std::set<ObjectGuid>    PlayersArrived = PlayersQueued;
        for (auto itr = PlayersArrived.begin(); itr != PlayersArrived.end(); itr++)
        {
            Player *p = map->GetPlayer(*itr);
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

            //remove from groups
            if (p->GetGroup())
                p->RemoveFromGroup();

            //set PVP and FFA. Avoid the bug that allows players to toggle it out
            p->SetPvP(true);
            p->SetByteFlag(UNIT_FIELD_BYTES_2, UNIT_BYTES_2_OFFSET_PVP_FLAG, UNIT_BYTE2_FLAG_FFA_PVP);

            //check if player has all the non stop active buffs
            for (auto j = PeriodicCastBuffs.begin(); j != PeriodicCastBuffs.end(); j++)
                if (p->HasAura(*j) == false)
                    p->AddAura(*j, p);

            for (auto j = OutOfCombatBuffs.begin(); j != OutOfCombatBuffs.end(); j++)
            {
                if (p->IsInCombat() == true)
                    p->RemoveAura(*j);
                else if (p->HasAura(*j) == false)
                    p->AddAura(*j, p);
            }
        }

        //do we have a winner ?
        if (PlayersQueued.size() == 1)
        {
            //            Player *p = sWorld->GetOnlinePlayer(*PlayersQueued.begin());
            Player *p = map->GetPlayer(*PlayersQueued.begin());
            if (p)
            {
                p->TeleportTo(KickToMap, KickToX, KickToY, KickToZ, 0.0f);
                if (DeserterPlayersCount == TeleportedPlayersAtStart - 1)
                    p->BroadcastMessage("Sadly all other players quit. No reward has been given");
                else
                {
                    p->AddCredits(OnWinCreditReward);
                    p->BroadcastMessage("Congratulations for winning the Hunger Games, you have been rewarded %d Credits", OnWinCreditReward);
                    p->BroadcastMessage("Please wait 10 minutes for our system to update credits in to your web account");
                    char t[500];
                    sprintf_s(t, sizeof(t), "%s has been rewarded 25 Credits for winning the last Hunger Games match", p->GetName().c_str());
                    WorldAnnounce(t);
                }
            }
        }
    }
}
