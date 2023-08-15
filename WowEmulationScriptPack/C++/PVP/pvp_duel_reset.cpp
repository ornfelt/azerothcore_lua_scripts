#include "ScriptPCH.h"

class Reset_OnDuelEnd : public PlayerScript
{
    public:
        Reset_OnDuelEnd() : PlayerScript("Reset_OnDuelEnd") {}

    void OnDuelEnd(Player *winner, Player *looser, DuelCompleteType type)
    {
						// Resets Players 1
                        winner->RemoveArenaSpellCooldowns();
					    winner->SetHealth(winner->GetMaxHealth());
                        winner->SetPower(winner->getPowerType(), winner->GetMaxPower(winner->getPowerType()));
						// Resets Player 2
						looser->RemoveArenaSpellCooldowns();
                        looser->SetHealth(looser->GetMaxHealth());
                        looser->SetPower(looser->getPowerType(), looser->GetMaxPower(looser->getPowerType()));
             //   }
    }
};

void AddSC_Reset()
{
    new Reset_OnDuelEnd;
}
