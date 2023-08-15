--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodmoonWorgen_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodmoonWorgen_Enrage", 10000, 0)
Unit:RegisterEvent("BloodmoonWorgen_InfectedWorgenBite", 4000, 3)
Unit:RegisterEvent("BloodmoonWorgen_SinisterStrike", 6000, 0)
end

function BloodmoonWorgen_Enrage(Unit, Event) 
Unit:CastSpell(32714) 
end

function BloodmoonWorgen_InfectedWorgenBite(Unit, Event) 
Unit:FullCastSpellOnTarget(53094, Unit:GetMainTank()) 
end

function BloodmoonWorgen_SinisterStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(14873, Unit:GetMainTank()) 
end

function BloodmoonWorgen_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodmoonWorgen_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodmoonWorgen_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27020, 1, "BloodmoonWorgen_OnCombat")
RegisterUnitEvent(27020, 2, "BloodmoonWorgen_OnLeaveCombat")
RegisterUnitEvent(27020, 3, "BloodmoonWorgen_OnKilledTarget")
RegisterUnitEvent(27020, 4, "BloodmoonWorgen_OnDied")