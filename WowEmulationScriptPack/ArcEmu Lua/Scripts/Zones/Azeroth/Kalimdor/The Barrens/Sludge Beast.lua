--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SludgeBeast_OnCombat(Unit, Event)
	Unit:RegisterEvent("SludgeBeast_BlackSludge", 6000, 0)
end

function SludgeBeast_BlackSludge(Unit, Event) 
	Unit:CastSpell(7279) 
end

function SludgeBeast_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SludgeBeast_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SludgeBeast_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3295, 1, "SludgeBeast_OnCombat")
RegisterUnitEvent(3295, 2, "SludgeBeast_OnLeaveCombat")
RegisterUnitEvent(3295, 3, "SludgeBeast_OnKilledTarget")
RegisterUnitEvent(3295, 4, "SludgeBeast_OnDied")