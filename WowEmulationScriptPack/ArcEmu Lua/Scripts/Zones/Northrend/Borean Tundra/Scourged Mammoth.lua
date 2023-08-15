--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ScourgedMammoth_OnCombat(Unit, Event)
Unit:RegisterEvent("ScourgedMammoth_Trample", 6000, 0)
end

function ScourgedMammoth_Trample(Unit, Event) 
Unit:CastSpell(15550)
end

function ScourgedMammoth_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ScourgedMammoth_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ScourgedMammoth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25452, 1, "ScourgedMammoth_OnCombat")
RegisterUnitEvent(25452, 2, "ScourgedMammoth_OnLeaveCombat")
RegisterUnitEvent(25452, 3, "ScourgedMammoth_OnKilledTarget")
RegisterUnitEvent(25452, 4, "ScourgedMammoth_OnDied")