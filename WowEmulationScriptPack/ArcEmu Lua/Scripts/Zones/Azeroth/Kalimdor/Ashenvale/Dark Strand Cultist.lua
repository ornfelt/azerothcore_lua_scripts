--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DarkStrandCultist_OnCombat(Unit, Event)
	Unit:RegisterEvent("DarkStrandCultist_SummonImp", 1000, 1)
	Unit:RegisterEvent("DarkStrandCultist_Corruption", 2000, 2)
	Unit:RegisterEvent("DarkStrandCultist_ShadowBolt", 8000, 0)
end

function DarkStrandCultist_SummonImp(pUnit, Event) 
	pUnit:CastSpell(11939) 
end

function DarkStrandCultist_Corruption(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6222, 	pUnit:GetMainTank()) 
end

function DarkStrandCultist_ShadowBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20791, 	pUnit:GetMainTank()) 
end

function DarkStrandCultist_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DarkStrandCultist_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3725, 1, "DarkStrandCultist_OnCombat")
RegisterUnitEvent(3725, 2, "DarkStrandCultist_OnLeaveCombat")
RegisterUnitEvent(3725, 4, "DarkStrandCultist_OnDied")