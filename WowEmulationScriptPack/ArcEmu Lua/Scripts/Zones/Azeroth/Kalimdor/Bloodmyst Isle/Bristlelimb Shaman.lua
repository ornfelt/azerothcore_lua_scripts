--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BristlelimbShaman_OnCombat(Unit, Event)
	Unit:RegisterEvent("BristlelimbShaman_FlameShock", 10000, 0)
	Unit:RegisterEvent("BristlelimbShaman_ScorchingTotem", 2000, 1)
end

function BristlelimbShaman_FlameShock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(32967, 	pUnit:GetMainTank()) 
end

function BristlelimbShaman_ScorchingTotem(pUnit, Event) 
	pUnit:CastSpell(32968) 
end

function BristlelimbShaman_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BristlelimbShaman_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17320, 1, "BristlelimbShaman_OnCombat")
RegisterUnitEvent(17320, 2, "BristlelimbShaman_OnLeaveCombat")
RegisterUnitEvent(17320, 4, "BristlelimbShaman_OnDied")