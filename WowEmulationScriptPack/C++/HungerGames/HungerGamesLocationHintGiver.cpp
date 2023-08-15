#include "HungerGamesStore.h"
#include "GameTime.h"
#include "Player.h"

void HungerGameStore::PeriodicGiveHints(Map *map)
{
    //no need to give hints unless there are players to give hints to
    if (Status != HG_ONGOING)
        return;

    //allow free game for a while, than start spamming hints
    time_t TimeSpent = GameTime::GetGameTime() - StartedAt;
    if (TimeSpent < HungerGamesWaitUntilGiveHintsSeconds)
        return;

    //not yet time to give another hint
    if (NextGameHintStamp > GameTime::GetGameTime())
        return;
    NextGameHintStamp = GameTime::GetGameTime() + HungerGamesPeriodicHintTimerSeconds;

    //for each player, search for the closest player and hint he's location
    for (auto itr = PlayersQueued.begin(); itr != PlayersQueued.end(); itr++)
    {
        Player *p = map->GetPlayer(*itr);
        if (p == NULL)
            continue;
        //search closest player to him
        Player      *ClosestPlayer = NULL;
        float       BestDist = 999999999.0f;
        for (auto itr2 = PlayersQueued.begin(); itr2 != PlayersQueued.end(); itr2++)
        {
            //self is the closest, so no need to check that
            if (*itr == *itr2)
                continue;
            Player *p2 = map->GetPlayer(*itr2);
            if (p2 == NULL)
                continue;
            float curDist = p->GetPosition().GetExactDist2dSq(p2->GetPosition());
            if (curDist < BestDist)
            {
                ClosestPlayer = p2;
                BestDist = curDist;
            }
        }

        //found a close player ?
        if (ClosestPlayer != NULL)
        {
            if (p->GetPositionX() < ClosestPlayer->GetPositionX() && p->GetPositionY() < ClosestPlayer->GetPositionY())
                p->BroadcastMessage("HG Hint : Closest player is to NW");
            if (p->GetPositionX() < ClosestPlayer->GetPositionX() && p->GetPositionY() > ClosestPlayer->GetPositionY())
                p->BroadcastMessage("HG Hint : Closest player is to NE");
            if (p->GetPositionX() > ClosestPlayer->GetPositionX() && p->GetPositionY() < ClosestPlayer->GetPositionY())
                p->BroadcastMessage("HG Hint : Closest player is to SW");
            if (p->GetPositionX() > ClosestPlayer->GetPositionX() && p->GetPositionY() > ClosestPlayer->GetPositionY())
                p->BroadcastMessage("HG Hint : Closest player is to SE");
        }
    }
}
