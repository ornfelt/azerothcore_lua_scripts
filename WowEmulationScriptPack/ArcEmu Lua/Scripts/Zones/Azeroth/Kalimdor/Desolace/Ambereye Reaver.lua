--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AmbereyeReaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("AmbereyeReaver_Cleave", 8000, 0)
	Unit:RegisterEvent("AmbereyeReaver_Petrify", 15000, 0)
end

function AmbereyeReaver_Cleave(Unit, Event) 
	Unit:CastSpell(40504) 
end

function AmbereyeReaver_Petrify(Unit, Event) 
	Unit:FullCastSpellOnTarget(11020, 	Unit:GetMainTank()) 
end

function AmbereyeReaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AmbereyeReaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11786, 1, "AmbereyeReaver_OnCombat")
RegisterUnitEvent(11786, 2, "AmbereyeReaver_OnLeaveCombat")
RegisterUnitEvent(11786, 4, "AmbereyeReaver_OnDied")