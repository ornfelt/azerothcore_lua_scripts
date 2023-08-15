--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RuneReaver_OnCombat(Unit, Event)
Unit:RegisterEvent("RuneReaver_RuneofRetribution", 3000, 1)
end

function RuneReaver_RuneofRetribution(Unit, Event) 
Unit:CastSpell(52628) 
end

function RuneReaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RuneReaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RuneReaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26268, 1, "RuneReaver_OnCombat")
RegisterUnitEvent(26268, 2, "RuneReaver_OnLeaveCombat")
RegisterUnitEvent(26268, 3, "RuneReaver_OnKilledTarget")
RegisterUnitEvent(26268, 4, "RuneReaver_OnDied")