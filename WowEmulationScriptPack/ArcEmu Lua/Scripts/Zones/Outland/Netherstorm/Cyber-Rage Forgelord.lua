--[[ Netherstorm -- Cyber-Rage Forgelord.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Forgelord_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Forgelord_Nova",2000,0)
    Unit:RegisterEvent("Forgelord_Enrage",120000,0)
end

function Forgelord_Nova(Unit,Event)
    Unit:FullCastSpellOnTarget(36255, Unit:GetClosestPlayer())
end

function Forgelord_Enrage(Unit,Event)
    Unit:CastSpell(8599)
end

function Forgelord_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Forgelord_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (16943, 1, "Forgelord_OnEnterCombat")
RegisterUnitEvent (16943, 2, "Forgelord_OnLeaveCombat")
RegisterUnitEvent (16943, 4, "Forgelord_OnDied")
