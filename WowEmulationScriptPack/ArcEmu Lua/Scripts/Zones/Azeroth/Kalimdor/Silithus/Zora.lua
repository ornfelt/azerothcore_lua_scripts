--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Zora_OnCombat(Unit, Event)
	Unit:RegisterEvent("Zora_PoisonBolt", 8000, 0)
end

function Zora_PoisonBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(21067, 	Unit:GetMainTank()) 
end

function Zora_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Zora_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Zora_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14474, 1, "Zora_OnCombat")
RegisterUnitEvent(14474, 2, "Zora_OnLeaveCombat")
RegisterUnitEvent(14474, 3, "Zora_OnKilledTarget")
RegisterUnitEvent(14474, 4, "Zora_OnDied")