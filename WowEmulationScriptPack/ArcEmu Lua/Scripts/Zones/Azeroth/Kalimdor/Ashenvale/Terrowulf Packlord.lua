--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TerrowulfPacklord_OnCombat(Unit, Event)
	Unit:RegisterEvent("TerrowulfPacklord_BattleRoar", 2000, 2)
end

function TerrowulfPacklord_BattleRoar(pUnit, Event) 
	pUnit:CastSpell(6507) 
end

function TerrowulfPacklord_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TerrowulfPacklord_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3792, 1, "TerrowulfPacklord_OnCombat")
RegisterUnitEvent(3792, 2, "TerrowulfPacklord_OnLeaveCombat")
RegisterUnitEvent(3792, 4, "TerrowulfPacklord_OnDied")