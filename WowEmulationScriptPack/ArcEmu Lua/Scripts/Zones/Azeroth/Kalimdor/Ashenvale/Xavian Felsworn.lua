--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function XavianFelsworn_OnCombat(Unit, Event)
	Unit:RegisterEvent("XavianFelsworn_Corruption", 8000, 0)
	Unit:RegisterEvent("XavianFelsworn_GiftoftheXavian", 13000, 0)
end

function XavianFelsworn_Corruption(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(6223, 	pUnit:GetMainTank()) 
end

function XavianFelsworn_GiftoftheXavian(pUnit, Event) 
	pUnit:CastSpell(6925) 
end

function XavianFelsworn_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function XavianFelsworn_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3755, 1, "XavianFelsworn_OnCombat")
RegisterUnitEvent(3755, 2, "XavianFelsworn_OnLeaveCombat")
RegisterUnitEvent(3755, 4, "XavianFelsworn_OnDied")