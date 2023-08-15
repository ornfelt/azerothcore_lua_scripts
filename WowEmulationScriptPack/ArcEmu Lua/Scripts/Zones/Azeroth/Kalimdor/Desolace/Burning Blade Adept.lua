--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BurningBladeAdept_OnCombat(Unit, Event)
	Unit:RegisterEvent("BurningBladeAdept_Bloodlust", 5000, 1)
	Unit:RegisterEvent("BurningBladeAdept_Fireball", 8000, 0)
end

function BurningBladeAdept_Bloodlust(Unit, Event) 
	Unit:CastSpell(6742) 
end

function BurningBladeAdept_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(19816, 	Unit:GetMainTank()) 
end

function BurningBladeAdept_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BurningBladeAdept_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4665, 1, "BurningBladeAdept_OnCombat")
RegisterUnitEvent(4665, 2, "BurningBladeAdept_OnLeaveCombat")
RegisterUnitEvent(4665, 4, "BurningBladeAdept_OnDied")