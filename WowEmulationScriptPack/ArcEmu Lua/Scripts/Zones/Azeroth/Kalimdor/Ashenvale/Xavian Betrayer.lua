--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function XavianBetrayer_OnCombat(Unit, Event)
	Unit:RegisterEvent("XavianBetrayer_BattleShout", 2000, 1)
	Unit:RegisterEvent("XavianBetrayer_GiftoftheXavian", 13000, 0)
end

function XavianBetrayer_BattleShout(pUnit, Event) 
	pUnit:CastSpell(5242) 
end

function XavianBetrayer_GiftoftheXavian(pUnit, Event) 
	pUnit:CastSpell(6925) 
end

function XavianBetrayer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function XavianBetrayer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3754, 1, "XavianBetrayer_OnCombat")
RegisterUnitEvent(3754, 2, "XavianBetrayer_OnLeaveCombat")
RegisterUnitEvent(3754, 4, "XavianBetrayer_OnDied")