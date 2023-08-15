--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SpitelashEnchantress_OnCombat(Unit, Event)
	Unit:RegisterEvent("SpitelashEnchantress_EnchantedQuickness", 10000, 0)
	Unit:RegisterEvent("SpitelashEnchantress_FrostShock", 6000, 0)
end

function SpitelashEnchantress_EnchantedQuickness(pUnit, Event) 
	pUnit:CastSpell(3443) 
end

function SpitelashEnchantress_FrostShock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(12548, 	pUnit:GetMainTank()) 
end

function SpitelashEnchantress_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SpitelashEnchantress_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(7186, 1, "SpitelashEnchantress_OnCombat")
RegisterUnitEvent(7186, 2, "SpitelashEnchantress_OnLeaveCombat")
RegisterUnitEvent(7186, 4, "SpitelashEnchantress_OnDied")