--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SouthseaCannoneer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SouthseaCannoneer_Shoot", 6000, 0)
end

function SouthseaCannoneer_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function SouthseaCannoneer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SouthseaCannoneer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SouthseaCannoneer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3382, 1, "SouthseaCannoneer_OnCombat")
RegisterUnitEvent(3382, 2, "SouthseaCannoneer_OnLeaveCombat")
RegisterUnitEvent(3382, 3, "SouthseaCannoneer_OnKilledTarget")
RegisterUnitEvent(3382, 4, "SouthseaCannoneer_OnDied")