--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function DunemaulOgreMage_OnCombat(Unit, Event)
	Unit:RegisterEvent("DunemaulOgreMage_Bloodlust", 10000, 0)
	Unit:RegisterEvent("DunemaulOgreMage_Slow", 15000, 0)
	Unit:RegisterEvent("DunemaulOgreMage_Fireball", 5000, 0)
end

function DunemaulOgreMage_Bloodlust(Unit, Event) 
	Unit:CastSpell(6742) 
end

function DunemaulOgreMage_Slow(Unit, Event) 
	Unit:FullCastSpellOnTarget(11436, 	Unit:GetMainTank()) 
end

function DunemaulOgreMage_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(9053, 	Unit:GetMainTank()) 
end

function DunemaulOgreMage_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DunemaulOgreMage_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function DunemaulOgreMage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5473, 1, "DunemaulOgreMage_OnCombat")
RegisterUnitEvent(5473, 2, "DunemaulOgreMage_OnLeaveCombat")
RegisterUnitEvent(5473, 3, "DunemaulOgreMage_OnKilledTarget")
RegisterUnitEvent(5473, 4, "DunemaulOgreMage_OnDied")