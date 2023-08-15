--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SeveredKeeper_OnCombat(Unit, Event)
	Unit:RegisterEvent("SeveredKeeper_ManaBurn", 7000, 0)
end

function SeveredKeeper_ManaBurn(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(2691, 	pUnit:GetRandomPlayer(4)) 
end

function SeveredKeeper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SeveredKeeper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3803, 1, "SeveredKeeper_OnCombat")
RegisterUnitEvent(3803, 2, "SeveredKeeper_OnLeaveCombat")
RegisterUnitEvent(3803, 4, "SeveredKeeper_OnDied")