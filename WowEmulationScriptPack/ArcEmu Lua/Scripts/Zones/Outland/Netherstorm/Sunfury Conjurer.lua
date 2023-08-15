--[[ Netherstorm -- Sunfury Conjurer.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Conjurer_OnCombat(Unit, Event)
Unit:RegisterEvent("Conjurer_Surge", 10000, 0)
Unit:RegisterEvent("Conjurer_Flamestrike", 8000, 0)
Unit:RegisterEvent("Conjurer_Frostbolt", 6000, 0)
end

function Conjurer_Surge(Unit, Event) 
Unit:CastSpell(35778) 
end

function Conjurer_Flamestrike(Unit, Event) 
Unit:FullCastSpellOnTarget(11829, Unit:GetMainTank()) 
end

function Conjurer_Frostbolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9672, Unit:GetMainTank()) 
end

function Conjurer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Conjurer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Conjurer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20139, 1, "Conjurer_OnCombat")
RegisterUnitEvent(20139, 2, "Conjurer_OnLeaveCombat")
RegisterUnitEvent(20139, 3, "Conjurer_OnKilledTarget")
RegisterUnitEvent(20139, 4, "Conjurer_OnDied")