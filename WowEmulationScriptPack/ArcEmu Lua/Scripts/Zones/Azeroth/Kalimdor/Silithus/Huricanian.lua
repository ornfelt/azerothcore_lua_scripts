--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Huricanian_OnCombat(Unit, Event)
	Unit:RegisterEvent("Huricanian_ChainLightning", 8000, 0)
end

function Huricanian_ChainLightning(Unit, Event) 
	Unit:FullCastSpellOnTarget(15659, 	Unit:GetRandomPlayer(0)) 
end

function Huricanian_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Huricanian_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Huricanian_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14478, 1, "Huricanian_OnCombat")
RegisterUnitEvent(14478, 2, "Huricanian_OnLeaveCombat")
RegisterUnitEvent(14478, 3, "Huricanian_OnKilledTarget")
RegisterUnitEvent(14478, 4, "Huricanian_OnDied")