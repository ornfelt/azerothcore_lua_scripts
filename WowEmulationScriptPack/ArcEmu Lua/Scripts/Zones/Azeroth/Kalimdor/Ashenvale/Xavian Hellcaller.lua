--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function XavianHellcaller_OnCombat(Unit, Event)
	Unit:RegisterEvent("XavianHellcaller_Fireball", 8000, 0)
	Unit:RegisterEvent("XavianHellcaller_GiftoftheXavian", 13000, 0)
end

function XavianHellcaller_Fireball(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9053, 	pUnit:GetMainTank()) 
end

function XavianHellcaller_GiftoftheXavian(pUnit, Event) 
	pUnit:CastSpell(6925) 
end

function XavianHellcaller_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function XavianHellcaller_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3757, 1, "XavianHellcaller_OnCombat")
RegisterUnitEvent(3757, 2, "XavianHellcaller_OnLeaveCombat")
RegisterUnitEvent(3757, 4, "XavianHellcaller_OnDied")