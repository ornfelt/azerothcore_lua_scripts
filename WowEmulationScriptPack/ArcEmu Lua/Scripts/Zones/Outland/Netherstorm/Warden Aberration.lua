--[[ Netherstorm -- Warden Aberration.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Aberration_OnCombat(Unit, Event)
Unit:RegisterEvent("Aberration_Shield", 1000, 1)
Unit:RegisterEvent("Aberration_Storm", 20000, 0)
end

function Aberration_Shield(Unit, Event) 
Unit:CastSpell(36640) 
end

function Aberration_Storm(Unit, Event) 
    local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	local o = Unit:GetO()
    Unit:CastSpell(36577)
    Unit:SpawnCreature(21322, x-1, y, z, o, 14, o)
end

function Aberration_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Aberration_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Aberration_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18865, 1, "Aberration_OnCombat")
RegisterUnitEvent(18865, 2, "Aberration_OnLeaveCombat")
RegisterUnitEvent(18865, 3, "Aberration_OnKilledTarget")
RegisterUnitEvent(18865, 4, "Aberration_OnDied")