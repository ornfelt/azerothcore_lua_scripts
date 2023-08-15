--[[ Netherstorm -- Nexus-King Salhadaar.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, September, 29th, 2008. ]]

function King_OnEnterCombat(Unit,Event)
    if Unit:GetHealthPct() == 99 then
    Unit:RegisterEvent("King_Phase1",1000,0)
end
end

function King_Phase1(Unit,Event)
    Unit:RegisterEvent("King_Damagebuff",1000,(1))
    Unit:RegisterEvent("King_Gravity",2500,0)
    Unit:RegisterEvent("King_Statis",12000,0)
    Unit:RegisterEvent("King_Phase2",1000,0)
end

function King_Dambagebuff(Unit,Event)
    Unit:CastSpell(37075)
end   
   
function King_Gravity(Unit,Event)
    Unit:CastSpell(36533)
end

function King_Statis(Unit,Event)
    Unit:FullCastSpellOnTarget(36527,Unit:GetRandomPlayer(0))
    Unit:FullCastSpellOnTarget(36527,Unit:GetRandomPlayer(0))
end

function King_Phase2(Unit,Event)
    if Unit:GetHealthPct() == 50 then
    Unit:RegisterEvent("King_Damagebuff",1000,(1))
    Unit:RegisterEvent("King_Gravity",2500,0)
    Unit:RegisterEvent("King_Statis",6000,0)
    Unit:RegisterEvent("King_Mirror1",1000,(1))
    Unit:RegisterEvent("King_Mirror2",1000,(1))
end
end
    

function King_Mirror1(Unit,Event)
    local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	local o = Unit:GetO()
    Unit:CastSpell(36847)
    Unit:SpawnCreature(21425, x-1, y, z, o, 14, o)
end

function King_Mirror2(Unit,Event)
    local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	local o = Unit:GetO()
    Unit:CastSpell(36848)
    Unit:SpawnCreature(21425, x-1, y, z, o, 14, o)
end
    
function King_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function King_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent (20454, 1, "King_OnEnterCombat")
RegisterUnitEvent (20454, 2, "King_OnLeaveCombat")
RegisterUnitEvent (20454, 4, "King_OnDied")