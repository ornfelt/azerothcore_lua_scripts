#include "ScriptMgr.h"
#include "SpellScript.h"
#include "Player.h"

class spell_divine_steed_charges : public SpellScript
{
    PrepareSpellScript(spell_divine_steed_charges);

    void HandleOnCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            // If the hidden spell is NOT on cooldown, cast it to represent the first charge being used
            // This spell should have the cooldown baked into it, so we don't need to apply a cooldown to the spell
            if (!player->HasSpellCooldown(300130))
            {
                player->CastSpell(player, 300130, false); 
            }
            else
            {
                // If the hidden spell IS on cooldown, apply the cooldown to Divine Steed, representing the second charge being used
                // This spell should not have a baked in cooldown
                player->AddSpellCooldown(GetSpellInfo()->Id, 0, 35 * IN_MILLISECONDS); // Apply 35-second cooldown to the spell
                player->CastSpell(player, 300131, true); // Cast  visual indicator spell.

            }
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_divine_steed_charges::HandleOnCast);
    }
};

void AddSC_spell_divine_steed_charges()
{
    RegisterSpellScript(spell_divine_steed_charges);
}
