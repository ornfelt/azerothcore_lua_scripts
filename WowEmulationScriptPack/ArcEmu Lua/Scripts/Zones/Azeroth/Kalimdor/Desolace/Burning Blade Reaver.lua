--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BurningBladeReaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("BurningBladeReaver_ArcingSmash", 8000, 0)
end

function BurningBladeReaver_ArcingSmash(Unit, Event) 
	Unit:CastSpell(8374) 
end

function BurningBladeReaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BurningBladeReaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4664, 1, "BurningBladeReaver_OnCombat")
RegisterUnitEvent(4664, 2, "BurningBladeReaver_OnLeaveCombat")
RegisterUnitEvent(4664, 4, "BurningBladeReaver_OnDied")