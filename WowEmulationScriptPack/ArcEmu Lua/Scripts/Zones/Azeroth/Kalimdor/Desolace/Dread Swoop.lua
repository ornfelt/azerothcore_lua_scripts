--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DreadSwoop_OnCombat(Unit, Event)
	Unit:RegisterEvent("DreadSwoop_Swoop", 8000, 0)
end

function DreadSwoop_Swoop(Unit, Event) 
	Unit:CastSpell(5708) 
end

function DreadSwoop_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DreadSwoop_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4692, 1, "DreadSwoop_OnCombat")
RegisterUnitEvent(4692, 2, "DreadSwoop_OnLeaveCombat")
RegisterUnitEvent(4692, 4, "DreadSwoop_OnDied")