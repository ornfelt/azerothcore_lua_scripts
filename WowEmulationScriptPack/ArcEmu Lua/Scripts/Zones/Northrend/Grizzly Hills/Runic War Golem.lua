--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function RunicWarGolem_OnCombat(Unit, Event)
Unit:RegisterEvent("RunicWarGolem_RunePunch", 10000, 0)
end

function RunicWarGolem_RunePunch(Unit, Event) 
Unit:FullCastSpellOnTarget(52702, Unit:GetMainTank()) 
end

function RunicWarGolem_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function RunicWarGolem_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function RunicWarGolem_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26347, 1, "RunicWarGolem_OnCombat")
RegisterUnitEvent(26347, 2, "RunicWarGolem_OnLeaveCombat")
RegisterUnitEvent(26347, 3, "RunicWarGolem_OnKilledTarget")
RegisterUnitEvent(26347, 4, "RunicWarGolem_OnDied")