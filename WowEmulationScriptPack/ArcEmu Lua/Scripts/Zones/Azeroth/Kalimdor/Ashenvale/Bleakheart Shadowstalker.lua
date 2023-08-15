--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BleakheartShadowstalker_OnCombat(Unit, Event)
	Unit:RegisterEvent("BleakheartShadowstalker_ShadowstalkerSlash", 8000, 0)
end

function BleakheartShadowstalker_ShadowstalkerSlash(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6927, 	pUnit:GetMainTank()) 
end

function BleakheartShadowstalker_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BleakheartShadowstalker_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3770, 1, "BleakheartShadowstalker_OnCombat")
RegisterUnitEvent(3770, 2, "BleakheartShadowstalker_OnLeaveCombat")
RegisterUnitEvent(3770, 4, "BleakheartShadowstalker_OnDied")