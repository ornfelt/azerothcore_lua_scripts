--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ConquestHoldBerserker_OnCombat(Unit, Event)
Unit:RegisterEvent("ConquestHoldBerserker_BattleShout", 4000, 1)
end

function ConquestHoldBerserker_BattleShout(Unit, Event) 
Unit:CastSpell(31403) 
end

function ConquestHoldBerserker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ConquestHoldBerserker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ConquestHoldBerserker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27500, 1, "ConquestHoldBerserker_OnCombat")
RegisterUnitEvent(27500, 2, "ConquestHoldBerserker_OnLeaveCombat")
RegisterUnitEvent(27500, 3, "ConquestHoldBerserker_OnKilledTarget")
RegisterUnitEvent(27500, 4, "ConquestHoldBerserker_OnDied")