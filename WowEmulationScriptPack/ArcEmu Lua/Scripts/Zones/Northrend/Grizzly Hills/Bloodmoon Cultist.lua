--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodmoonCultist_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodmoonCultist_Enrage", 10000, 0)
Unit:RegisterEvent("BloodmoonCultist_InfectedWorgenBite", 4000, 3)
Unit:RegisterEvent("BloodmoonCultist_SinisterStrike", 6000, 0)
end

function BloodmoonCultist_Enrage(Unit, Event) 
Unit:CastSpell(32714) 
end

function BloodmoonCultist_InfectedWorgenBite(Unit, Event) 
Unit:FullCastSpellOnTarget(53094, Unit:GetMainTank()) 
end

function BloodmoonCultist_SinisterStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(14873, Unit:GetMainTank()) 
end

function BloodmoonCultist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodmoonCultist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodmoonCultist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27024, 1, "BloodmoonCultist_OnCombat")
RegisterUnitEvent(27024, 2, "BloodmoonCultist_OnLeaveCombat")
RegisterUnitEvent(27024, 3, "BloodmoonCultist_OnKilledTarget")
RegisterUnitEvent(27024, 4, "BloodmoonCultist_OnDied")