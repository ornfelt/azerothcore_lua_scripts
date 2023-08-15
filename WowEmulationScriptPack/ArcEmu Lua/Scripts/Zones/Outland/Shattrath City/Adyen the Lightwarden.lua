--[[ Shattrath City -- Adyen the Lightwarden.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 28th, 2008. ]]

function Lightwarden_OnCombat(Unit, Event)
Unit:RegisterEvent("Lightwarden_Strike", 6000, 0)
Unit:RegisterEvent("Lightwarden_Hammer", 1000, 0)
Unit:RegisterEvent("Lightwarden_Heal", 7000, 0)
end

function Lightwarden_Strike(Unit, Event) 
Unit:FullCastSpellOnTarget(14518, Unit:GetMainTank()) 
end

function Lightwarden_Hammer(Unit, Event) 
Unit:FullCastSpellOnTarget(13005, Unit:GetMainTank()) 
end

function Lightwarden_Heal(Unit, Event) 
Unit:CastSpell(13952) 
end

function Lightwarden_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Lightwarden_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Lightwarden_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18537, 1, "Lightwarden_OnCombat")
RegisterUnitEvent(18537, 2, "Lightwarden_OnLeaveCombat")
RegisterUnitEvent(18537, 3, "Lightwarden_OnKilledTarget")
RegisterUnitEvent(18537, 4, "Lightwarden_OnDied")