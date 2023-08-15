--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Naltaszar_OnCombat(Unit, Event)
	UnitRegisterEvent("Naltaszar_ChainBurn", 10000, 0)
	UnitRegisterEvent("Naltaszar_ChainLightning", 6000, 0)
end

function Naltaszar_ChainBurn(Unit, Event) 
	UnitFullCastSpellOnTarget(8211, 	UnitGetRandomPlayer(4)) 
end

function Naltaszar_ChainLightning(Unit, Event) 
	UnitFullCastSpellOnTarget(15305, 	UnitGetMainTank()) 
end

function Naltaszar_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function Naltaszar_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function Naltaszar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4066, 1, "Naltaszar_OnCombat")
RegisterUnitEvent(4066, 2, "Naltaszar_OnLeaveCombat")
RegisterUnitEvent(4066, 3, "Naltaszar_OnKilledTarget")
RegisterUnitEvent(4066, 4, "Naltaszar_OnDied")