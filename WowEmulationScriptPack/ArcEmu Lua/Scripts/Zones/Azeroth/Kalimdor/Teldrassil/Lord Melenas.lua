--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LordMelenas_OnCombat(Unit, Event)
	Unit:RegisterEvent("LordMelenas_CatForm", 1000, 1)
	Unit:RegisterEvent("LordMelenas_Rake", 6000, 0)
	Unit:RegisterEvent("LordMelenas_Rejuvenation", 12000, 0)
end

function LordMelenas_CatForm(Unit, Event) 
	Unit:CastSpell(5759) 
end

function LordMelenas_Rake(Unit, Event) 
	Unit:FullCastSpellOnTarget(1822, 	Unit:GetMainTank()) 
end

function LordMelenas_Rejuvenation(Unit, Event) 
	Unit:CastSpell(774) 
end

function LordMelenas_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LordMelenas_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function LordMelenas_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(2038, 1, "LordMelenas_OnCombat")
RegisterUnitEvent(2038, 2, "LordMelenas_OnLeaveCombat")
RegisterUnitEvent(2038, 3, "LordMelenas_OnKilledTarget")
RegisterUnitEvent(2038, 4, "LordMelenas_OnDied")