--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Hauteur_OnCombat(Unit, Event)
	Unit:RegisterEvent("Hauteur_FireShield", 2000, 1)
	Unit:RegisterEvent("Hauteur_FlameShock", 6000, 0)
end

function Hauteur_FireShield(pUnit, Event) 
	pUnit:CastSpell(134) 
end

function Hauteur_FlameShock(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(8050, 	pUnit:GetMainTank()) 
end

function Hauteur_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Hauteur_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(17206, 1, "Hauteur_OnCombat")
RegisterUnitEvent(17206, 2, "Hauteur_OnLeaveCombat")
RegisterUnitEvent(17206, 4, "Hauteur_OnDied")