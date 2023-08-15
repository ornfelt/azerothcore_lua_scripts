--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SouthseaPrivateer_OnCombat(Unit, Event)
	Unit:RegisterEvent("SouthseaPrivateer_FireShot", 9000, 0)
	Unit:RegisterEvent("SouthseaPrivateer_Shoot", 6000, 0)
end

function SouthseaPrivateer_FireShot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6979, 	Unit:GetMainTank()) 
end

function SouthseaPrivateer_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function SouthseaPrivateer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SouthseaPrivateer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SouthseaPrivateer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3384, 1, "SouthseaPrivateer_OnCombat")
RegisterUnitEvent(3384, 2, "SouthseaPrivateer_OnLeaveCombat")
RegisterUnitEvent(3384, 3, "SouthseaPrivateer_OnKilledTarget")
RegisterUnitEvent(3384, 4, "SouthseaPrivateer_OnDied")