// Importing necessary header files for AzerothCore functionalities
#include "ScriptMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"

// Main class definition for the custom spell "Scorch"
class spell_mage_scorch_execute : public SpellScriptLoader
{
public:
    // Constructor to initialize the parent class
    spell_mage_scorch_execute() : SpellScriptLoader("spell_mage_scorch_execute") { }

    // Nested class to handle the actual spell logic
    class spell_mage_scorch_execute_SpellScript : public SpellScript
    {
        // Prepare the spell script for further customization
        PrepareSpellScript(spell_mage_scorch_execute_SpellScript);

        // Function to handle what happens when the spell hits a target
        void HandleOnHit()
        {
            // Check if the spell has hit a unit (like a player or NPC)
            if (Unit* target = GetHitUnit())
            {
                // Check if the target's health is below 35%
                if (target->GetHealthPct() < 35.0f)
                {
                    // Increase the spell's damage by 350%
                    int32 damage = GetHitDamage();
                    SetHitDamage(int32(damage * 4.5f));

                    // Check if the caster has a specific aura with ID 880044
                    if (Unit* caster = GetCaster())
                    {
                        // If the caster has the aura, then proceed
                        if (caster->HasAura(880044))
                        {
                            // Add a new aura with ID 811095 to the caster
                            caster->AddAura(811095, caster);
                        }
                    }
                }
            }
        }

        // Register the function to be called when the spell hits a target
        void Register() override
        {
            OnHit += SpellHitFn(spell_mage_scorch_execute_SpellScript::HandleOnHit);
        }
    };

    // Create a new object of the nested class and return it
    SpellScript* GetSpellScript() const override
    {
        return new spell_mage_scorch_execute_SpellScript();
    }
};

// Function to add the custom spell to the AzerothCore system
void AddSC_spell_mage_scorch_execute()
{
    // Create a new object of the main class to activate the custom spell
    new spell_mage_scorch_execute();
}
