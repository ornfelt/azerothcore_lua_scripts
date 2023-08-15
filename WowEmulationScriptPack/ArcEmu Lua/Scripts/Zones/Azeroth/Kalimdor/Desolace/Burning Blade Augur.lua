--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BurningBladeAugur_OnCombat(Unit, Event)
	Unit:RegisterEvent("BurningBladeAugur_CurseofThorns", 5000, 1)
	Unit:RegisterEvent("BurningBladeAugur_ShadowBolt", 8000, 0)
end

function BurningBladeAugur_CurseofThorns(Unit, Event) 
	Unit:FullCastSpellOnTarget(6909, 	Unit:GetMainTank()) 
end

function BurningBladeAugur_ShadowBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(20807, 	Unit:GetMainTank()) 
end

function BurningBladeAugur_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BurningBladeAugur_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4663, 1, "BurningBladeAugur_OnCombat")
RegisterUnitEvent(4663, 2, "BurningBladeAugur_OnLeaveCombat")
RegisterUnitEvent(4663, 4, "BurningBladeAugur_OnDied")