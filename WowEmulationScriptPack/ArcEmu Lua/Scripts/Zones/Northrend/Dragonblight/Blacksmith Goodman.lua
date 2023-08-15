--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function BlacksmithGoodman_OnCombat(Unit, Event)
Unit:RegisterEvent("BlacksmithGoodman_CrushArmor", 6000, 0)
Unit:RegisterEvent("BlacksmithGoodman_SkullCrack", 8000, 0)
end

function BlacksmithGoodman_CrushArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(33661, Unit:GetMainTank()) 
end

function BlacksmithGoodman_SkullCrack(Unit, Event) 
Unit:FullCastSpellOnTarget(15621, Unit:GetMainTank()) 
end

function BlacksmithGoodman_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BlacksmithGoodman_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BlacksmithGoodman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27234, 1, "BlacksmithGoodman_OnCombat")
RegisterUnitEvent(27234, 2, "BlacksmithGoodman_OnLeaveCombat")
RegisterUnitEvent(27234, 3, "BlacksmithGoodman_OnKilledTarget")
RegisterUnitEvent(27234, 4, "BlacksmithGoodman_OnDied")