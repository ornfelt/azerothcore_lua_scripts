--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function StormscaleWaveRider_OnCombat(Unit, Event)
	Unit:RegisterEvent("StormscaleWaveRider_AquaJet", 8000, 0)
end

function StormscaleWaveRider_AquaJet(pUnit, Event) 
	pUnit:CastSpell(13586) 
end

function StormscaleWaveRider_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function StormscaleWaveRider_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2179, 1, "StormscaleWaveRider_OnCombat")
RegisterUnitEvent(2179, 2, "StormscaleWaveRider_OnLeaveCombat")
RegisterUnitEvent(2179, 4, "StormscaleWaveRider_OnDied")