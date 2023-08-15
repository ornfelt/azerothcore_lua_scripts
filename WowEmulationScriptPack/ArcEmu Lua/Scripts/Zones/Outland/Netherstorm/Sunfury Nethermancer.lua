--[[ Netherstorm -- Sunfury Nethermancer.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Nethermancer_OnCombat(Unit, Event)
Unit:RegisterEvent("Nethermancer_Surge", 10000, 0)
Unit:RegisterEvent("Nethermancer_Bolt", 5000, 0)
Unit:RegisterEvent("Nethermance_Summon",20000,0)
end

function Nethermancer_Surge(Unit, Event) 
Unit:CastSpell(35778) 
end

function Nethermance_Summon(Unit,Event)
    local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	local o = Unit:GetO()
    Unit:CastSpell(36477)
    Unit:SpawnCreature(21267, x-1, y, z, o, 14, o)
end

function Nethermancer_Bolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function Nethermancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Nethermancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Nethermancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20248, 1, "Nethermancer_OnCombat")
RegisterUnitEvent(20248, 2, "Nethermancer_OnLeaveCombat")
RegisterUnitEvent(20248, 3, "Nethermancer_OnKilledTarget")
RegisterUnitEvent(20248, 4, "Nethermancer_OnDied")
