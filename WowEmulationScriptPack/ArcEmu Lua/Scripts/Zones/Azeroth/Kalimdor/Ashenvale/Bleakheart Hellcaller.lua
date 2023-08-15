--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BleakheartHellcaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("BleakheartHellcaller_SummonImp", 1000, 0)
end

function BleakheartHellcaller_SummonImp(pUnit, Event) 
	pUnit:CastSpell(11939) 
end

function BleakheartHellcaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BleakheartHellcaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3771, 1, "BleakheartHellcaller_OnCombat")
RegisterUnitEvent(3771, 2, "BleakheartHellcaller_OnLeaveCombat")
RegisterUnitEvent(3771, 4, "BleakheartHellcaller_OnDied")