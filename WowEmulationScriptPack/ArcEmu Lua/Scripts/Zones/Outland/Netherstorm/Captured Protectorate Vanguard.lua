--[[ Netherstorm -- Captured Protectorate Vanguard.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, July, 23th, 2008. ]]

function Captured_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Captured_Glaive",1000,0)
    Unit:RegisterEvent("Captured_Hamstring",10000,0)
end

function Captured_Glaive(Unit,Event)
    Unit:FullCastSpellOnTarget(36500,Unit:GetClosestPlayer())
end

function Captured_Hamstring(Unit,Event)
    Unit:FullCastSpellOnTarget(31553,Unit:GetClosestPlayer())
end

function Captured_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Captured_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20763, 1, "Captured_OnEnterCombat")
RegisterUnitEvent (20763, 2, "Captured_OnLeaveCombat")
RegisterUnitEvent (20763, 4, "Captured_OnDied")

