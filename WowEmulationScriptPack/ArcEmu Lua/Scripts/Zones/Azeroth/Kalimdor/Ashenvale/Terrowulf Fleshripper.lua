--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TerrowulfFleshripper_OnCombat(Unit, Event)
	Unit:RegisterEvent("TerrowulfFleshripper_TendonRip", 8000, 0)
end

function TerrowulfFleshripper_TendonRip(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3604, 	pUnit:GetMainTank()) 
end

function TerrowulfFleshripper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TerrowulfFleshripper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3789, 1, "TerrowulfFleshripper_OnCombat")
RegisterUnitEvent(3789, 2, "TerrowulfFleshripper_OnLeaveCombat")
RegisterUnitEvent(3789, 4, "TerrowulfFleshripper_OnDied")