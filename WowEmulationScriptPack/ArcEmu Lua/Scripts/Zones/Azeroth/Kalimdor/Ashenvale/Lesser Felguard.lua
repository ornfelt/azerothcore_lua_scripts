--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LesserFelguard_OnCombat(Unit, Event)
	Unit:RegisterEvent("LesserFelguard_FireShieldII", 1000, 1)
	Unit:RegisterEvent("LesserFelguard_Knockdown", 7000, 0)
end

function LesserFelguard_FireShieldII(pUnit, Event) 
	pUnit:CastSpell(184) 
end

function LesserFelguard_Knockdown(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(18812, 	pUnit:GetMainTank()) 
end

function LesserFelguard_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LesserFelguard_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3772, 1, "LesserFelguard_OnCombat")
RegisterUnitEvent(3772, 2, "LesserFelguard_OnLeaveCombat")
RegisterUnitEvent(3772, 4, "LesserFelguard_OnDied")