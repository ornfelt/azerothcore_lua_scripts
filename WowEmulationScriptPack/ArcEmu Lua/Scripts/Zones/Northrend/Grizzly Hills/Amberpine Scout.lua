--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AmberpineScout_OnCombat(Unit, Event)
Unit:RegisterEvent("AmberpineScout_Deterrence", 10000, 0)
Unit:RegisterEvent("AmberpineScout_PunctureArmor", 2000, 1)
Unit:RegisterEvent("AmberpineScout_Shoot", 6000, 0)
end

function AmberpineScout_Deterrence(Unit, Event) 
Unit:CastSpell(31567) 
end

function AmberpineScout_PunctureArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(35918, Unit:GetMainTank()) 
end

function AmberpineScout_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(15547, Unit:GetMainTank()) 
end

function AmberpineScout_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AmberpineScout_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AmberpineScout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27117, 1, "AmberpineScout_OnCombat")
RegisterUnitEvent(27117, 2, "AmberpineScout_OnLeaveCombat")
RegisterUnitEvent(27117, 3, "AmberpineScout_OnKilledTarget")
RegisterUnitEvent(27117, 4, "AmberpineScout_OnDied")