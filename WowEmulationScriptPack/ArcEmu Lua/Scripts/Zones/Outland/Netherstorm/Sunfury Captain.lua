--[[ Netherstorm -- Sunfury Captain.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Captain_OnCombat(Unit, Event)
Unit:RegisterEvent("Captain_Shout", 1000, 3)
Unit:RegisterEvent("Captain_Enrage", 25000, 1)
Unit:RegisterEvent("Captain_Breaker", 10000, 0)
Unit:RegisterEvent("Captain_Breaker", 10000, 0)
end

function Captain_Shout(Unit, Event) 
Unit:CastSpellOnTarget(32064, Unit:GetRandomFriend(0)) 
end

function Captain_Enrage(Unit, Event) 
Unit:CastSpell(8599) 
end

function Captain_Breaker(Unit, Event) 
Unit:CastSpell(35871) 
end

function Captain_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Captain_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Captain_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19453, 1, "Captain_OnCombat")
RegisterUnitEvent(19453, 2, "Captain_OnLeaveCombat")
RegisterUnitEvent(19453, 3, "Captain_OnKilledTarget")
RegisterUnitEvent(19453, 4, "Captain_OnDied")