--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MagusRimtori_OnCombat(Unit, Event)
	Unit:RegisterEvent("MagusRimtori_Fireball", 8000, 0)
	Unit:RegisterEvent("MagusRimtori_FrostNova", 10000, 0)
end

function MagusRimtori_Fireball(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(20823, 	pUnit:GetMainTank()) 
end

function MagusRimtori_FrostNova(pUnit, Event) 
	pUnit:CastSpell(11831) 
end

function MagusRimtori_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MagusRimtori_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(8578, 1, "MagusRimtori_OnCombat")
RegisterUnitEvent(8578, 2, "MagusRimtori_OnLeaveCombat")
RegisterUnitEvent(8578, 4, "MagusRimtori_OnDied")