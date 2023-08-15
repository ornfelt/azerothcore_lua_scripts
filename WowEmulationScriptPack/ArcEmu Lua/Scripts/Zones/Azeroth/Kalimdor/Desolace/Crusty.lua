--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Crusty_OnCombat(Unit, Event)
	Unit:RegisterEvent("Crusty_Enrage", 10000, 1)
end

function Crusty_Enrage(Unit, Event) 
	Unit:CastSpell(8599) 
end

function Crusty_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Crusty_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(18241, 1, "Crusty_OnCombat")
RegisterUnitEvent(18241, 2, "Crusty_OnLeaveCombat")
RegisterUnitEvent(18241, 4, "Crusty_OnDied")