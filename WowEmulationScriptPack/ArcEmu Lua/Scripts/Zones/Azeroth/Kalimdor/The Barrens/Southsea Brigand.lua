--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SouthseaBrigand_OnCombat(Unit, Event)
	Unit:RegisterEvent("SouthseaBrigand_Backhand", 8000, 0)
end

function SouthseaBrigand_Backhand(Unit, Event) 
	Unit:FullCastSpellOnTarget(6253, 	Unit:GetMainTank()) 
end

function SouthseaBrigand_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SouthseaBrigand_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SouthseaBrigand_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3381, 1, "SouthseaBrigand_OnCombat")
RegisterUnitEvent(3381, 2, "SouthseaBrigand_OnLeaveCombat")
RegisterUnitEvent(3381, 3, "SouthseaBrigand_OnKilledTarget")
RegisterUnitEvent(3381, 4, "SouthseaBrigand_OnDied")