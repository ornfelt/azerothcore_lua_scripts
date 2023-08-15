--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BloodpawShaman_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodpawShaman_Bloodlust", 4000, 1)
Unit:RegisterEvent("BloodpawShaman_EarthShock", 6000, 0)
Unit:RegisterEvent("BloodpawShaman_Stormstrike", 8000, 0)
end

function BloodpawShaman_Bloodlust(Unit, Event) 
Unit:CastSpell(6742) 
end

function BloodpawShaman_EarthShock(Unit, Event) 
Unit:FullCastSpellOnTarget(13281, Unit:GetMainTank()) 
end

function BloodpawShaman_Stormstrike(Unit, Event) 
Unit:FullCastSpellOnTarget(51876, Unit:GetMainTank()) 
end

function BloodpawShaman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodpawShaman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodpawShaman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27343, 1, "BloodpawShaman_OnCombat")
RegisterUnitEvent(27343, 2, "BloodpawShaman_OnLeaveCombat")
RegisterUnitEvent(27343, 3, "BloodpawShaman_OnKilledTarget")
RegisterUnitEvent(27343, 4, "BloodpawShaman_OnDied")