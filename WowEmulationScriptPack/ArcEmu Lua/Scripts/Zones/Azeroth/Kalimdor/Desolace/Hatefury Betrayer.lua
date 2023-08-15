--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HatefuryBetrayer_OnCombat(Unit, Event)
	Unit:RegisterEvent("HatefuryBetrayer_Enrage", 10000, 1)
end

function HatefuryBetrayer_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function HatefuryBetrayer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HatefuryBetrayer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HatefuryBetrayer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4673, 1, "HatefuryBetrayer_OnCombat")
RegisterUnitEvent(4673, 2, "HatefuryBetrayer_OnLeaveCombat")
RegisterUnitEvent(4673, 3, "HatefuryBetrayer_OnKilledTarget")
RegisterUnitEvent(4673, 4, "HatefuryBetrayer_OnDied")