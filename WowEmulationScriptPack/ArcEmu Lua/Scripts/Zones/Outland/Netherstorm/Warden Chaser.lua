--[[ Netherstorm -- Warden Chaser.lua

This script was written and is protected
by the GPL v2. This script was released
by BlackHer0 of the BLUA Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BlackHer0, Oktober, 27th, 2008. ]]

function Chaser_OnCombat(Unit, Event)
Unit:RegisterEvent("Chaser_Invisible", 15000, 0)
Unit:RegisterEvent("Chaser_Bite", 4000, 0)
Unit:RegisterEvent("Chaser_Warp", 7000, 0)
Unit:RegisterEvent("Chaser_WarpCharge", 5000, 0)
end

function Chaser_Invisible(Unit, Event) 
Unit:CastSpell(32943) 
end

function Chaser_Bite(Unit, Event) 
Unit:FullCastSpellOnTarget(32739, Unit:GetMainTank()) 
end

function Chaser_Warp(Unit, Event) 
Unit:CastSpell(32920) 
end

function Chaser_WarpCharge(Unit, Event) 
Unit:FullCastSpellOnTarget(37417, Unit:GetMainTank()) 
end

function Chaser_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Chaser_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Chaser_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(18884, 1, "Chaser_OnCombat")
RegisterUnitEvent(18884, 2, "Chaser_OnLeaveCombat")
RegisterUnitEvent(18884, 3, "Chaser_OnKilledTarget")
RegisterUnitEvent(18884, 4, "Chaser_OnDied")