--[[ Netherstorm -- Disembodied Protector.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 24th, 2008. ]]

function Protector_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Protector_Strike",1000,0)
    Unit:RegisterEvent("Protector_Smite",2500,0)
end

function Protector_Strike(Unit,Event)
    Unit:FullCastSpellOnTarget(36647,Unit:GetClosestPlayer())
end

function Protector_Smite(Unit,Event)
    Unit:FullCastSpellOnTarget(9734,Unit:GetClosestPlayer())
end

function Protector_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Protector_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (18873, 1, "Protector_OnEnterCombat")
RegisterUnitEvent (18873, 2, "Protector_OnLeaveCombat")
RegisterUnitEvent (18873, 4, "Protector_OnDied")