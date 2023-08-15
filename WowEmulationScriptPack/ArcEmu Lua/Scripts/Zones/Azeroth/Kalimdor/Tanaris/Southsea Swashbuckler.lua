--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SouthseaSwashbuckler_OnCombat(Unit, Event)
	Unit:RegisterEvent("SouthseaSwashbuckler_Disarm", 10000, 0)
end

function SouthseaSwashbuckler_Disarm(Unit, Event) 
	Unit:FullCastSpellOnTarget(6713, 	Unit:GetMainTank()) 
end

function SouthseaSwashbuckler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SouthseaSwashbuckler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SouthseaSwashbuckler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7858, 1, "SouthseaSwashbuckler_OnCombat")
RegisterUnitEvent(7858, 2, "SouthseaSwashbuckler_OnLeaveCombat")
RegisterUnitEvent(7858, 3, "SouthseaSwashbuckler_OnKilledTarget")
RegisterUnitEvent(7858, 4, "SouthseaSwashbuckler_OnDied")