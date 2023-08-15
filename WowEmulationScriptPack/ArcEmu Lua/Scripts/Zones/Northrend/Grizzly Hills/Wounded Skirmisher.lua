--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WoundedSkirmisher_OnCombat(Unit, Event)
Unit:RegisterEvent("WoundedSkirmisher_Cleave", 9000, 0)
Unit:RegisterEvent("WoundedSkirmisher_Hamstring", 10000, 0)
Unit:RegisterEvent("WoundedSkirmisher_MortalStrike", 7000, 0)
end

function WoundedSkirmisher_Cleave(Unit, Event) 
Unit:CastSpell(15496) 
end

function WoundedSkirmisher_Hamstring(Unit, Event) 
Unit:FullCastSpellOnTarget(9080, Unit:GetMainTank()) 
end

function WoundedSkirmisher_MortalStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(32736, Unit:GetMainTank()) 
end

function WoundedSkirmisher_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WoundedSkirmisher_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WoundedSkirmisher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27463, 1, "WoundedSkirmisher_OnCombat")
RegisterUnitEvent(27463, 2, "WoundedSkirmisher_OnLeaveCombat")
RegisterUnitEvent(27463, 3, "WoundedSkirmisher_OnKilledTarget")
RegisterUnitEvent(27463, 4, "WoundedSkirmisher_OnDied")