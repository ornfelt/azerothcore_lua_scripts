--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BjornHalgurdsson_OnCombat(Unit, Event)
Unit:RegisterEvent("BjornHalgurdsson_CrushArmor", 5000, 0)
Unit:RegisterEvent("BjornHalgurdsson_MortalStrike", 7000, 0)
end

function BjornHalgurdsson_CrushArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(33661, Unit:GetMainTank()) 
end

function BjornHalgurdsson_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(32736, Unit:GetMainTank()) 
end

function BjornHalgurdsson_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BjornHalgurdsson_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BjornHalgurdsson_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24238, 1, "BjornHalgurdsson_OnCombat")
RegisterUnitEvent(24238, 2, "BjornHalgurdsson_OnLeaveCombat")
RegisterUnitEvent(24238, 3, "BjornHalgurdsson_OnKilledTarget")
RegisterUnitEvent(24238, 4, "BjornHalgurdsson_OnDied")