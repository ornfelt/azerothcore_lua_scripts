--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function Stormhide_OnCombat(Unit, Event)
	Unit:RegisterEvent("Stormhide_LizardBolt", 6000, 0)
end

function Stormhide_LizardBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(5401, 	Unit:GetMainTank()) 
end

function Stormhide_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Stormhide_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Stormhide_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3238, 1, "Stormhide_OnCombat")
RegisterUnitEvent(3238, 2, "Stormhide_OnLeaveCombat")
RegisterUnitEvent(3238, 3, "Stormhide_OnKilledTarget")
RegisterUnitEvent(3238, 4, "Stormhide_OnDied")