--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Deathclasp_OnCombat(Unit, Event)
	Unit:RegisterEvent("Deathclasp_KnockAway", 6000, 0)
	Unit:RegisterEvent("Deathclasp_ParalyzingPoison", 12000, 0)
end

function Deathclasp_KnockAway(Unit, Event) 
	Unit:FullCastSpellOnTarget(18670, 	Unit:GetMainTank()) 
end

function Deathclasp_ParalyzingPoison(Unit, Event) 
	Unit:FullCastSpellOnTarget(3609, 	Unit:GetRandomPlayer(0)) 
end

function Deathclasp_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Deathclasp_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Deathclasp_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15196, 1, "Deathclasp_OnCombat")
RegisterUnitEvent(15196, 2, "Deathclasp_OnLeaveCombat")
RegisterUnitEvent(15196, 3, "Deathclasp_OnKilledTarget")
RegisterUnitEvent(15196, 4, "Deathclasp_OnDied")