--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HatefuryRogue_OnCombat(Unit, Event)
	Unit:RegisterEvent("HatefuryRogue_Enrage", 10000, 1)
end

function HatefuryRogue_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function HatefuryRogue_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HatefuryRogue_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HatefuryRogue_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4670, 1, "HatefuryRogue_OnCombat")
RegisterUnitEvent(4670, 2, "HatefuryRogue_OnLeaveCombat")
RegisterUnitEvent(4670, 3, "HatefuryRogue_OnKilledTarget")
RegisterUnitEvent(4670, 4, "HatefuryRogue_OnDied")