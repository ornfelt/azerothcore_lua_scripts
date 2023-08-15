--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BerylTreasureHunter_OnCombat(Unit, Event)
	Unit:RegisterEvent("BerylTreasureHunter_FocusBeam", 8000, 0)
end

function BerylTreasureHunter_FocusBeam(Unit, Event) 
	Unit:FullCastSpellOnTarget(50658, 	Unit:GetMainTank()) 
end

function BerylTreasureHunter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BerylTreasureHunter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BerylTreasureHunter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25353, 1, "BerylTreasureHunter_OnCombat")
RegisterUnitEvent(25353, 2, "BerylTreasureHunter_OnLeaveCombat")
RegisterUnitEvent(25353, 3, "BerylTreasureHunter_OnKilledTarget")
RegisterUnitEvent(25353, 4, "BerylTreasureHunter_OnDied")