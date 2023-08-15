--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Felslayer_OnCombat(Unit, Event)
	Unit:RegisterEvent("Felslayer_ManaBurn", 8000, 0)
end

function Felslayer_ManaBurn(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(2691, 	pUnit:GetRandomPlayer(4)) 
end

function Felslayer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Felslayer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3774, 1, "Felslayer_OnCombat")
RegisterUnitEvent(3774, 2, "Felslayer_OnLeaveCombat")
RegisterUnitEvent(3774, 4, "Felslayer_OnDied")