--[[ Netherstorm -- Sunfury Astromancer.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Astromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("Astromancer_Focus", 6000, 0)
Unit:RegisterEvent("Astromancer_Intellect", 1000, 1)
Unit:RegisterEvent("Astromancer_Scorch", 4000, 0)
end

function Astromancer_Focus(Unit, Event) 
Unit:CastSpell(35914) 
end

function Astromancer_Intellect(Unit, Event) 
Unit:CastSpell(35917) 
end

function Astromancer_Scorch(Unit, Event) 
Unit:FullCastSpellOnTarget(38391, Unit:GetMainTank()) 
end

function Astromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Astromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Astromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(19643, 1, "Astromancer_OnCombat")
RegisterUnitEvent(19643, 2, "Astromancer_OnLeaveCombat")
RegisterUnitEvent(19643, 3, "Astromancer_OnKilledTarget")
RegisterUnitEvent(19643, 4, "Astromancer_OnDied")