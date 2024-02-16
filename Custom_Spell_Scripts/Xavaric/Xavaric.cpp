#include "Player.h"
#include "SpellAuras.h"
#include "SpellScript.h"

enum SpellIds
{
    SPELL_XAVERIC_SHIELD = 103368 // The spell ID for the absorb shield
};

class Xaveric : public SpellScriptLoader
{
public:
    Xaveric() : SpellScriptLoader("Xaveric") {}

    class Xaveric_SpellScript : public SpellScript
    {
        PrepareSpellScript(Xaveric_SpellScript);

        void HandleAfterCast()
        {
            // Get the caster of the spell
            Player* player = GetCaster()->ToPlayer();
            if (!player)
                return;

            // Calculate the absorb amount as 25% of the player's health
            int32 absorbAmount = static_cast<int32>(round(player->GetMaxHealth() * 0.25));

            // Apply the absorb shield using the calculated absorb amount
            Aura* xavericShieldAura = player->GetAura(SPELL_XAVERIC_SHIELD);
            if (xavericShieldAura)
            {
                AuraEffect* absorbEffect = xavericShieldAura->GetEffect(EFFECT_0);
                if (absorbEffect)
                {
                    absorbEffect->SetAmount(absorbAmount);
                }
            }
        }

        void Register() override
        {
            AfterCast += SpellCastFn(Xaveric_SpellScript::HandleAfterCast);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new Xaveric_SpellScript();
    }
};

void AddSC_Xaveric()
{
    new Xaveric();
}
