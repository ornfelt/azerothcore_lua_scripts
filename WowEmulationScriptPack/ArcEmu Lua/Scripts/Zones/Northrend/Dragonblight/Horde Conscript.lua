--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HordeConscript_OnCombat(Unit, Event)
Unit:RegisterEvent("HordeConscript_HeroicStrike", 8000, 0)
Unit:RegisterEvent("HordeConscript_Shoot", 6000, 0)
end

function HordeConscript_HeroicStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(29426, Unit:GetMainTank()) 
end

function HordeConscript_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(15620, Unit:GetMainTank()) 
end

function HordeConscript_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HordeConscript_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HordeConscript_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27749, 1, "HordeConscript_OnCombat")
RegisterUnitEvent(27749, 2, "HordeConscript_OnLeaveCombat")
RegisterUnitEvent(27749, 3, "HordeConscript_OnKilledTarget")
RegisterUnitEvent(27749, 4, "HordeConscript_OnDied")