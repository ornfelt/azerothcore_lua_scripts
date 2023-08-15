--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WrathtailSeaWitch_OnCombat(Unit, Event)
	Unit:RegisterEvent("WrathtailSeaWitch_LightningBlast", 8000, 0)
end

function WrathtailSeaWitch_LightningBlast(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(8598, 	pUnit:GetMainTank()) 
end

function WrathtailSeaWitch_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WrathtailSeaWitch_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3715, 1, "WrathtailSeaWitch_OnCombat")
RegisterUnitEvent(3715, 2, "WrathtailSeaWitch_OnLeaveCombat")
RegisterUnitEvent(3715, 4, "WrathtailSeaWitch_OnDied")