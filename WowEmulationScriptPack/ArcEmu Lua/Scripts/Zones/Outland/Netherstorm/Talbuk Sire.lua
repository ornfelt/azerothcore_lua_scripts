--[[ Netherstorm -- Talbuk Sire.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Sire_OnCombat(Unit, Event)
Unit:RegisterEvent("Sire_Stomp", 6000, 0)
end

function Sire_Stomp(Unit, Event) 
Unit:FullCastSpellOnTarget(32023, Unit:GetMainTank()) 
end

function Sire_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Sire_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Sire_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(20777, 1, "Sire_OnCombat")
RegisterUnitEvent(20777, 2, "Sire_OnLeaveCombat")
RegisterUnitEvent(20777, 3, "Sire_OnKilledTarget")
RegisterUnitEvent(20777, 4, "Sire_OnDied")