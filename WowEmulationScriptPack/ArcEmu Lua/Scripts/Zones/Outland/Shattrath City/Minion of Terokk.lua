--[[ Shattrath City -- Minion of Terokk.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0  of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 30th, 2008. ]]

function MTerokk_OnCombat(Unit, Event)
Unit:RegisterEvent("MTerokk_Dmg", 7000, 0)
end

function MTerokk_Dmg(Unit, Event) 
Unit:FullCastSpellOnTarget(38021, Unit:GetMainTank()) 
end

function MTerokk_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MTerokk_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MTerokk_OnKilledTarget(Unit, Event) 
Unit:RemoveEvents()
end

RegisterUnitEvent(22376, 1, "MTerokk_OnCombat")
RegisterUnitEvent(22376, 2, "MTerokk_OnLeaveCombat")
RegisterUnitEvent(22376, 3, "MTerokk_OnKilledTarget")
RegisterUnitEvent(22376, 4, "MTerokk_OnDied")