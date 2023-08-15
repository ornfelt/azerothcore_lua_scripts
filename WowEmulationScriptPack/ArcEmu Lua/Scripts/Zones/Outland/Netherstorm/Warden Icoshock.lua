--[[ Netherstorm -- Warden Icoshock.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Icoshock_OnCombat(Unit, Event)
Unit:RegisterEvent("Icoshock_Surge", 7000, 0)
Unit:RegisterEvent("Icoshock_Drain", 1000, 1)
end

function Icoshock_Surge(Unit, Event) 
Unit:FullCastSpellOnTarget(36517, Unit:GetMainTank()) 
end

function Icoshock_Drain(Unit, Event) 
Unit:CastSpell(36515) 
end

function Icoshock_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Icoshock_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Icoshock_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20770, 1, "Icoshock_OnCombat")
RegisterUnitEvent(20770, 2, "Icoshock_OnLeaveCombat")
RegisterUnitEvent(20770, 3, "Icoshock_OnKilledTarget")
RegisterUnitEvent(20770, 4, "Icoshock_OnDied")