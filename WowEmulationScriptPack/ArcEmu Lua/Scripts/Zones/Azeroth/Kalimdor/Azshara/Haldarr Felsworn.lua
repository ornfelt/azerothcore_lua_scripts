--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HaldarrFelsworn_OnCombat(Unit, Event)
	Unit:RegisterEvent("HaldarrFelsworn_ShadowBolt", 8000, 0)
end

function HaldarrFelsworn_ShadowBolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20825, 	pUnit:GetMainTank()) 
end

function HaldarrFelsworn_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HaldarrFelsworn_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6127, 1, "HaldarrFelsworn_OnCombat")
RegisterUnitEvent(6127, 2, "HaldarrFelsworn_OnLeaveCombat")
RegisterUnitEvent(6127, 4, "HaldarrFelsworn_OnDied")