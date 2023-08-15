--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EntropicOoze_OnCombat(Unit, Event)
Unit:RegisterEvent("EntropicOoze_CrudeOoze", 7000, 0)
end

function EntropicOoze_CrudeOoze(Unit, Event) 
Unit:FullCastSpellOnTarget(52334, Unit:GetMainTank()) 
end

function EntropicOoze_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EntropicOoze_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EntropicOoze_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26366, 1, "EntropicOoze_OnCombat")
RegisterUnitEvent(26366, 2, "EntropicOoze_OnLeaveCombat")
RegisterUnitEvent(26366, 3, "EntropicOoze_OnKilledTarget")
RegisterUnitEvent(26366, 4, "EntropicOoze_OnDied")