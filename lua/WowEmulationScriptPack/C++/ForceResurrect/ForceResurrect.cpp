#include "ScriptMgr.h"
#include "Player.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"

#define WaitTicksToReUpdateState        80  // 1 game tick avg it takes 50ms

class PlayerPeriodicUpdateRessurectState
{
public:
    PlayerPeriodicUpdateRessurectState()
    {
        TicksRemainingToUpdate = 0;     // 1 game tick avg it takes 50ms
    }
    void StartCountdown()
    {
        TicksRemainingToUpdate = WaitTicksToReUpdateState;
    }
    uint32  TicksRemainingToUpdate;
};

PlayerPeriodicUpdateRessurectState *GetPI(Player *player)
{
    PlayerPeriodicUpdateRessurectState *prs = player->GetCreateExtension<PlayerPeriodicUpdateRessurectState>(OE_PLAYER_FORCE_RESURRECT_STORE);
    return prs;
}

void PlayerPeriodicUpdate(void *p, void *)
{
    Player *player = (Player*)p;
    PlayerPeriodicUpdateRessurectState *prs = GetPI(player);
    if (prs->TicksRemainingToUpdate == WaitTicksToReUpdateState / 2 || prs->TicksRemainingToUpdate == 1)
    {
        //if we are alive, make sure we do not show client side effects that would make us dead
        if (player->IsAlive())
        {
            player->RemoveAurasDueToSpell(8326);
            player->RemoveAurasDueToSpell(20584);
            player->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST);
            player->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_IS_OUT_OF_BOUNDS);
        }

        //if we are dead, make sure we show death effects client side
        if (player->isDead())
        {
            if (player->getRace() == RACE_NIGHTELF)
                player->CastSpell(player, 20584, true);
            player->CastSpell(player, 8326, true);
            player->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_GHOST);
        }

        //toggle the helm flag just in case
        if(player->HasFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM))
            player->RemoveFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM);
        else
            player->SetFlag(PLAYER_FLAGS, PLAYER_FLAGS_HIDE_HELM);
    }
    if (prs->TicksRemainingToUpdate > 0)
        prs->TicksRemainingToUpdate--;
}

void PlayerReviveForceUpdate(void *p, void *)
{
    Player *player = (Player*)p;
    PlayerPeriodicUpdateRessurectState *prs = GetPI(player);
    prs->StartCountdown();
}

class TC_GAME_API ForceResurrectHandler : public PlayerScript
{
public:
    ForceResurrectHandler() : PlayerScript("ForceResurrectHandler") {}
    void OnPlayerRepop(Player* player)
    {
        PlayerPeriodicUpdateRessurectState *prs = GetPI(player);
        prs->StartCountdown();
    }
    void OnLogin(Player* player, bool firstLogin)
    {
        player->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, PlayerPeriodicUpdate);
        player->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_REVIVE, PlayerReviveForceUpdate);
        PlayerPeriodicUpdateRessurectState *prs = GetPI(player);
        prs->StartCountdown();
    }
};

void AddForceResurrectScripts()
{
    new ForceResurrectHandler();
}
