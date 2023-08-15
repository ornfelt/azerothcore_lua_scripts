--[[ Nagrand - Boulderfist Saboteur.lua

This script was written and is protected
by the GPL v2. This script was released
by Performer/Performa of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Performa, August 26th, 2008. ]]

function Boulderfistsaboteur_Spell(Unit, event, miscunit, misc)
    Unit:FullCastSpellOnTarget(32248,Unit:GetClosestPlayer())
end

function Boulderfistsaboteur(Unit, event, miscunit, misc)
    Unit:RegisterEvent("Boulderfistsaboteur_Spell",5000,0)
end

function Boulderfistsaboteur_Death(Unit)
    Unit:RemoveEvents()
end

function Boulderfistsaboteur_OnLeaveCombat(Unit)
    Unit:RemoveEvents()
end

RegisterUnitEvent(18352, 1, "Boulderfistsaboteur")
RegisterUnitEvent(18352, 2, "Boulderfistsaboteur_OnLeaveCombat")
RegisterUnitEvent(18352, 3, "Boulderfistsaboteur_Death")