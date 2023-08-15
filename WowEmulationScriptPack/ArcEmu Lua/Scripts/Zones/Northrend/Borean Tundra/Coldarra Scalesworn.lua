--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ColdarraScalesworn_OnCombat(Unit, Event)
Unit:RegisterEvent("ColdarraScalesworn_FrostNova", 10000, 0)
Unit:RegisterEvent("ColdarraScalesworn_Rend", 8000, 0)
end

function ColdarraScalesworn_FrostNova(Unit, Event) 
Unit:CastSpell(12748) 
end

function ColdarraScalesworn_Rend(Unit, Event) 
Unit:FullCastSpellOnTarget(11977, Unit:GetMainTank()) 
end

function ColdarraScalesworn_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ColdarraScalesworn_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ColdarraScalesworn_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25717, 1, "ColdarraScalesworn_OnCombat")
RegisterUnitEvent(25717, 2, "ColdarraScalesworn_OnLeaveCombat")
RegisterUnitEvent(25717, 3, "ColdarraScalesworn_OnKilledTarget")
RegisterUnitEvent(25717, 4, "ColdarraScalesworn_OnDied")