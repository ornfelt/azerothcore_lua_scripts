--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Drakaguul_OnCombat(Unit, Event)
Unit:RegisterEvent("Drakaguul_BerserkerCharge", 10000, 0)
Unit:RegisterEvent("Drakaguul_DrakaguulsSoldiers", 12000, 0)
end

function Drakaguul_BerserkerCharge(Unit, Event) 
Unit:FullCastSpellOnTarget(52460, Unit:GetMainTank()) 
end

function Drakaguul_DrakaguulsSoldiers(Unit, Event) 
Unit:CastSpell(52457) 
end

function Drakaguul_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Drakaguul_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Drakaguul_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26919, 1, "Drakaguul_OnCombat")
RegisterUnitEvent(26919, 2, "Drakaguul_OnLeaveCombat")
RegisterUnitEvent(26919, 3, "Drakaguul_OnKilledTarget")
RegisterUnitEvent(26919, 4, "Drakaguul_OnDied")