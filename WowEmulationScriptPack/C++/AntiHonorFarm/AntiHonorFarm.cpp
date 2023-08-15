#include "ScriptMgr.h"
#include "Player.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "GameTime.h"

#define WaitTicksToReUpdateState            20      // 1 game tick avg it takes 50ms
#define MIN_WALK_DISTANCE_TO_ALLOW_KILL     5.0f
#define MAX_COOLDOWN_MULTIPLIER             3       // max X minutes cooldown between 2 kills
#define TRACK_LAST_X_KILLERS                5       // number of players to track that try to farm us
#ifdef _DEBUG
    #define REQUIRED_TIME_MS_SINCE_LAST_KILL    10000
#else
    #define REQUIRED_TIME_MS_SINCE_LAST_KILL    60000
#endif
#define AVOID_MULTI_RESET_COOLDOWN          500

// a bit messed up script. Multiple scripts will tell us we died. The second script can no longer detect how much we moved in our previous life or who killed us when
// this is solved by having 2 lifes. It's not 100% accurate check how much we moved or time passed since last kill event
// we should only reset position, orientation and killer after all scripts finished asking us about killer status
class PlayerAntiDieFarmStore
{
public:
    //track who is farming us
    struct RecentKiller {
        RecentKiller()
        {
            Killer.Clear();
            NextAllowedKillStamp = 0;       // do not award credit if get killed by same attacker before timer expires
            KilledSameTargetCount = 0;      // same killer is killing us over and over again ? Increase the timer limit
        }
        ObjectGuid  Killer;
        uint32      NextAllowedKillStamp;  //this extends when you kill the same target
        uint32      KilledSameTargetCount;
    };

    //constructor
    PlayerAntiDieFarmStore()
    {
        DistanceWalkedSinceLastKill = 0;     // 1 game tick avg it takes 50ms
        Last_x = 0;
        Last_y = 0;
        OrientationChanges = -1;
        RecentKillers[0].NextAllowedKillStamp = 0;
        RecentKillers[0].KilledSameTargetCount = 0;
    }

    //this player is yet to do something ?
    bool IsInitialized()
    {
        return OrientationChanges >= 0;
    }

    //can happen on kill or on periodic update
    void PlayerStatusUpdate(Player *Victim)
    {
        //did player position change since last event ?
        float DistNow = Victim->GetPosition().GetExactDist2d(Position(Last_x, Last_y));
        DistanceWalkedSinceLastKill += DistNow;
        Last_x = Victim->GetPositionX();
        Last_y = Victim->GetPositionY();
        if (Victim->GetOrientation() != Last_o)
            OrientationChanges++;
        Last_o = Victim->GetOrientation();
    }

    //condition list for an attacker to get credit
    bool CanReceiveCreditForPlayer(Player *Attacker,Player *Victim)
    {
        uint32 TimeNow =  GameTime::GetGameTimeMS();

        //can't decide if farmed or not at this point
        if (IsInitialized() == false)
        {
            PrevDeathFarmCheckResult = true;
            PrevDeathStamp = TimeNow / 500;
            return true;
        }

        if (PrevDeathStamp == TimeNow / 500)
            return PrevDeathFarmCheckResult;

        //this seems to be a new death, make the check once
        PrevDeathFarmCheckResult = false;

        //make sure we update since last update. This will check if we changed since last Die event
        PlayerStatusUpdate(Victim);

        //we are not standing still and doing nothing
        if (DistanceWalkedSinceLastKill < MIN_WALK_DISTANCE_TO_ALLOW_KILL)
            return false;

        // not even look around ?
        if (OrientationChanges <= 0)
            return false;

        //repeated kills of the same attacker in short interval ?
        for (uint32 i = 0; i < TRACK_LAST_X_KILLERS; i++)
        {
            if (RecentKillers[i].Killer == Attacker->GetGUID() && RecentKillers[i].NextAllowedKillStamp > TimeNow)
                return false;
        }

        //nothing is blocking us from considering the killer a hero
        PrevDeathFarmCheckResult = true;
        PrevDeathStamp = TimeNow / 500;

        return true;
    }

    // reset coutners when we die
    // multiple scripts will call this. We should only use tha values after revive
    void OnPlayerDiedResurrectedLostFight(Player *Attacker, Player *Victim);
private:
    //status variables
    float           DistanceWalkedSinceLastKill;                    // this victim needs to move around in order to get some credit
    int32           OrientationChanges;                             // at least change facing

    float           Last_x, Last_y, Last_o;                         // track victim movement. If he is standing still, something might be wrong
    RecentKiller    RecentKillers[TRACK_LAST_X_KILLERS];            // list of our killers recently. If they farm us, we will require more and more time to give credit

    uint32          PrevDeathStamp;
    bool            PrevDeathFarmCheckResult;
};

PlayerAntiDieFarmStore *GetAKF(Player *player)
{
    PlayerAntiDieFarmStore *prs = player->GetCreateExtension<PlayerAntiDieFarmStore>(OE_PLAYER_ANTI_KILL_FARM_STORE);
    return prs;
}

bool CanPlayerAwardKillReward(Player *Attacker, Player *Victim)
{
    PlayerAntiDieFarmStore *prs = GetAKF(Victim);

    bool Ret = prs->CanReceiveCreditForPlayer(Attacker,Victim); //anything changes since we last died ?

    //always reset counter
    prs->OnPlayerDiedResurrectedLostFight(Attacker, Victim);

    return Ret;
}
/*
class TC_GAME_API AntiHonorFarmCheckerAdd : public PlayerScript
{
public:
    AntiHonorFarmCheckerAdd() : PlayerScript("AntiHonorFarmCheckerAdd") {}

    void OnPlayerRepop(Player* player)
    {

    }
    void OnPVPKill(Player* killer, Player* killed)
    {
        //sanity checks
        if (killer == killed || killer == NULL || killed == NULL)
            return;
        GetAKF(killed)->OnPlayerDiedResurrectedLostFight(killer, killed);
    }

    void OnDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
    {
        GetAKF(loser)->OnPlayerDiedResurrectedLostFight(winner, loser);
    }
};
*/

void HonorAntiFarmChecker(void *p,void *)
{
    CP_HONOR_RECEIVE *params = PointerCast(CP_HONOR_RECEIVE, p);

    //sanity checks
    if (params->Victim == NULL || params->Victim->ToPlayer() == NULL)
        return;

    // if vitim did not walk at all since last kill, than do no award him honor
    if (CanPlayerAwardKillReward(params->Attacker, params->Victim->ToPlayer()) == false)
    {
        *params->Honor = 0;
        params->Attacker->BroadcastMessage("Player might be kill farmed. No reward awarded");
    }
}

void PlayerAntiDieFarmStore::OnPlayerDiedResurrectedLostFight(Player *Attacker, Player *Victim)
{
    //make sure we reset the counter
    DistanceWalkedSinceLastKill = 0;

    //the new position where we should start counting the move
    Last_x = Victim->GetPositionX();
    Last_y = Victim->GetPositionY();
    //orientation change is a lot more sensible than movement change
    Last_o = Victim->GetOrientation();
    OrientationChanges = 0;

    uint32 TimeNow = GameTime::GetGameTimeMS();

    //get the oldest killer or same killer position
    uint32 OldestKiller = RecentKillers[0].NextAllowedKillStamp;
    uint32 OldestKillerIndex = 0;
    bool FoundSameKiller = false;
    for (uint32 i = 0; i < TRACK_LAST_X_KILLERS; i++)
    {
        //we found the same killer in our list. We should treat him in a special way
        if (RecentKillers[i].Killer == Attacker->GetGUID())
        {
            OldestKillerIndex = i;
            //did the counter expire ? Also add 1 more itnerval because this guy is suspicious
            if (TimeNow + REQUIRED_TIME_MS_SINCE_LAST_KILL < RecentKillers[OldestKillerIndex].NextAllowedKillStamp)
            {
                if(RecentKillers[i].KilledSameTargetCount<MAX_COOLDOWN_MULTIPLIER)
                    RecentKillers[i].KilledSameTargetCount++;   // same killer, Increase the interval at which he can kill us again
            }
            else
                RecentKillers[i].KilledSameTargetCount = 1;   // same killer, Increase the interval at which he can kill us again
            FoundSameKiller = true;
            break;
        }

        if (RecentKillers[i].NextAllowedKillStamp < OldestKiller)
            OldestKillerIndex = i;
    }

    //if this is a new killer, allow him to to kill us in minimum time
    if (FoundSameKiller == false)
    {
        RecentKillers[OldestKillerIndex].KilledSameTargetCount = 1;
        //this attacker is not allowed to kill us within the time limit
        RecentKillers[OldestKillerIndex].Killer = Attacker->GetGUID();
    }

    //reset kill timer
    RecentKillers[OldestKillerIndex].NextAllowedKillStamp = TimeNow + REQUIRED_TIME_MS_SINCE_LAST_KILL * RecentKillers[OldestKillerIndex].KilledSameTargetCount;
}

void AddAntiHonorFarmScripts()
{
//    new AntiHonorFarmCheckerAdd();
    RegisterCallbackFunction(CALLBACK_TYPE_PLAYER_HONOR_CALC, HonorAntiFarmChecker, NULL);
}
