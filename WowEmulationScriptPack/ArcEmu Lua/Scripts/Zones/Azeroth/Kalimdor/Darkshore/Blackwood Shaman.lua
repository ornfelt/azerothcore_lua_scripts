--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlackwoodShaman_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlackwoodShaman_HealingWave", 13000, 0)
	Unit:RegisterEvent("BlackwoodShaman_Shock", 7000, 0)
	Unit:RegisterEvent("BlackwoodShaman_LightningBolt", 9000, 0)
end

function BlackwoodShaman_HealingWave(pUnit, Event) 
	pUnit:CastSpell(913) 
end

function BlackwoodShaman_LightningBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9532, 	pUnit:GetMainTank()) 
end

function BlackwoodShaman_Shock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(2606, 	pUnit:GetMainTank()) 
end

function BlackwoodShaman_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlackwoodShaman_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2171, 1, "BlackwoodShaman_OnCombat")
RegisterUnitEvent(2171, 2, "BlackwoodShaman_OnLeaveCombat")
RegisterUnitEvent(2171, 4, "BlackwoodShaman_OnDied")