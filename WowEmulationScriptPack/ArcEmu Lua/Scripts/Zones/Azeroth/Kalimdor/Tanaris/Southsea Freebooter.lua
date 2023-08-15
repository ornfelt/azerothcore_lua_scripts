--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function SouthseaFreebooter_OnCombat(Unit, Event)
	Unit:RegisterEvent("SouthseaFreebooter_Shot", 6000, 0)
end

function SouthseaFreebooter_Shot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function SouthseaFreebooter_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SouthseaFreebooter_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SouthseaFreebooter_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7856, 1, "SouthseaFreebooter_OnCombat")
RegisterUnitEvent(7856, 2, "SouthseaFreebooter_OnLeaveCombat")
RegisterUnitEvent(7856, 3, "SouthseaFreebooter_OnKilledTarget")
RegisterUnitEvent(7856, 4, "SouthseaFreebooter_OnDied")