--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Threggil_OnCombat(Unit, Event)
	Unit:RegisterEvent("Threggil_Strike", 6000, 0)
end

function Threggil_Strike(Unit, Event) 
	Unit:FullCastSpellOnTarget(11976, 	Unit:GetMainTank()) 
end

function Threggil_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Threggil_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Threggil_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14432, 1, "Threggil_OnCombat")
RegisterUnitEvent(14432, 2, "Threggil_OnLeaveCombat")
RegisterUnitEvent(14432, 3, "Threggil_OnKilledTarget")
RegisterUnitEvent(14432, 4, "Threggil_OnDied")