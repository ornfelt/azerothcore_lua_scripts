--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HatefuryShadowstalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("HatefuryShadowstalker_Enrage", 10000, 1)
	Unit:RegisterEvent("HatefuryShadowstalker_ExploitWeakness", 11000, 0)
	Unit:RegisterEvent("HatefuryShadowstalker_Gouge", 8000, 0)
end

function HatefuryShadowstalker_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function HatefuryShadowstalker_ExploitWeakness(Unit, Event) 
	Unit:FullCastSpellOnTarget(6595, 	Unit:GetMainTank()) 
end

function HatefuryShadowstalker_Gouge(Unit, Event) 
	Unit:FullCastSpellOnTarget(8629, 	Unit:GetMainTank()) 
end

function HatefuryShadowstalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HatefuryShadowstalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HatefuryShadowstalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4674, 1, "HatefuryShadowstalker_OnCombat")
RegisterUnitEvent(4674, 2, "HatefuryShadowstalker_OnLeaveCombat")
RegisterUnitEvent(4674, 3, "HatefuryShadowstalker_OnKilledTarget")
RegisterUnitEvent(4674, 4, "HatefuryShadowstalker_OnDied")