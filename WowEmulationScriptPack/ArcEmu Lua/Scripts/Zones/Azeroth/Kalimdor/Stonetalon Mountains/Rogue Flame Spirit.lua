--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RogueFlameSpirit_OnCombat(Unit, Event)
	UnitRegisterEvent("RogueFlameSpirit_Inmolate", 10000, 0)
end

function RogueFlameSpirit_Inmolate(Unit, Event) 
	UnitFullCastSpellOnTarget(1094, 	UnitGetMainTank()) 
end

function RogueFlameSpirit_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function RogueFlameSpirit_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function RogueFlameSpirit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4036, 1, "RogueFlameSpirit_OnCombat")
RegisterUnitEvent(4036, 2, "RogueFlameSpirit_OnLeaveCombat")
RegisterUnitEvent(4036, 3, "RogueFlameSpirit_OnKilledTarget")
RegisterUnitEvent(4036, 4, "RogueFlameSpirit_OnDied")