--[[ Netherstorm -- Overseer Seylanna.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 29th, 2008. ]]

function Seylanna_OnEnterCombat(Unit,Event)
    Unit:RegisterEvent("Seylanna_Crystal",2000,0)
    Unit:RegisterEvent("Seylanna_Beam",4000,0)
end

function Seylanna_Crystal(Unit,Event)
    Unit:CastSpell(36179)
end   
   
function Seylanna_Beam(Unit,Event)
    Unit:FullCastSpellOnTarget(35919,Unit:GetClosestPlayer())
end
    
function Seylanna_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function Seylanna_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20397, 1, "Seylanna_OnEnterCombat")
RegisterUnitEvent (20397, 2, "Seylanna_OnLeaveCombat")
RegisterUnitEvent (20397, 4, "Seylanna_OnDied")