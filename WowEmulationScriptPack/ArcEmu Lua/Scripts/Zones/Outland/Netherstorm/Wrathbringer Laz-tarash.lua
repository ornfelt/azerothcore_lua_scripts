--[[ Netherstorm -- Wrathbringer Laz-tarash.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Laztarash_OnCombat(Unit, Event)
Unit:RegisterEvent("Laztarash_Hamstring", 8000, 0)
end

function Laztarash_Hamstring(Unit, Event) 
Unit:FullCastSpellOnTarget(31553, Unit:GetMainTank()) 
end

function Laztarash_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Laztarash_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Laztarash_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20789, 1, "Laztarash_OnCombat")
RegisterUnitEvent(20789, 2, "Laztarash_OnLeaveCombat")
RegisterUnitEvent(20789, 3, "Laztarash_OnKilledTarget")
RegisterUnitEvent(20789, 4, "Laztarash_OnDied")