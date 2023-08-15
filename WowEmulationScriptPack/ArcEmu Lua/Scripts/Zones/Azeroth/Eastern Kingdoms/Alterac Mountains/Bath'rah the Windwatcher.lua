--[[ AscendScripting Script - 
This software is provided as free and open source by the
staff of The AscendScripting Team.This script was
written and is protected by the GPL v2. The following
script was released by a AscendScripting Staff Member.
Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- AscendScripting Staff, February 26, 2009. ]]

function Windwatcher_OnCombat(Unit, Event)
	Unit:RegisterEvent("Windwatcher_Cyclone", 15000, 0)
	Unit:RegisterEvent("Windwatcher_Totem", 10000, 0)
end

function Windwatcher_Totem(pUnit, Event) 
    local x = pUnit:GetX()
	local y = pUnit:GetY()
	local z = pUnit:GetZ()
	local o = pUnit:GetO()
    pUnit:CastSpell(25000)
    pUnit:SpawnCreature(15363, x-1, y, z, o, 14, o)
end

function Windwatcher_Cyclone(pUnit, Event) 
	pUnit:CastSpell(8606) 
end

function Windwatcher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Windwatcher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6176, 1, "Windwatcher_OnCombat")
RegisterUnitEvent(6176, 2, "Windwatcher_OnLeaveCombat")
RegisterUnitEvent(6176, 4, "Windwatcher_OnDied")