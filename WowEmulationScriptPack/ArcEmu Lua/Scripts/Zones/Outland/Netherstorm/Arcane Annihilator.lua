--[[ Netherstorm -- Arcane Annihilator.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 21th, 2008. ]]

function Annihilator_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Annihilator_Explosion",1500,0)
    Unit:RegisterEvent("Annihilator_Suppression",3000,0)
end

function Annihilator_Explosion(Unit,Event)
    Unit:FullCastSpellOnTarget(33860, Unit:GetClosestPlayer())
end

function Annihilator_Suppression(Unit,Event)
    Unit:FullCastSpellOnTarget(35892, Unit:GetClosestPlayer())
end

function Annihilator_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Annihilator_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18856, 1, "Annihilator_OnEnterCombat")
RegisterUnitEvent (18856, 2, "Annihilator_OnLeaveCombat")
RegisterUnitEvent (18856, 4, "Annihilator_OnDied")