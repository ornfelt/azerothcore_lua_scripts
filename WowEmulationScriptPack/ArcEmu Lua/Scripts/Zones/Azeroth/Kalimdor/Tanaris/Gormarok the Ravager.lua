--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function GormaroktheRavager_OnCombat(Unit, Event)
	Unit:RegisterEvent("GormaroktheRavager_Cleave", 4000, 0)
	Unit:RegisterEvent("GormaroktheRavager_Enrage", 120000, 0)
	Unit:RegisterEvent("GormaroktheRavager_MortalStrike", 6000, 0)
end

function GormaroktheRavager_Cleave(Unit, Event) 
	Unit:CastSpell(15496) 
end

function GormaroktheRavager_MortalStrike(Unit, Event) 
	Unit:FullCastSpellOnTarget(16856, 	Unit:GetMainTank()) 
end

function GormaroktheRavager_Enrage(Unit, Event) 
if 	Unit:GetHealthPct() < 25 then
	Unit:CastSpell(8599) 
end
end

function GormaroktheRavager_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GormaroktheRavager_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GormaroktheRavager_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(12046, 1, "GormaroktheRavager_OnCombat")
RegisterUnitEvent(12046, 2, "GormaroktheRavager_OnLeaveCombat")
RegisterUnitEvent(12046, 3, "GormaroktheRavager_OnKilledTarget")
RegisterUnitEvent(12046, 4, "GormaroktheRavager_OnDied")