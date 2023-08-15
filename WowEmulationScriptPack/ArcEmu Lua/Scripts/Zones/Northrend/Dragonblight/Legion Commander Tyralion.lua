--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function LegionCommanderTyralion_OnCombat(Unit, Event)
Unit:RegisterEvent("LegionCommanderTyralion_Shoot", 5000, 0)
end

function LegionCommanderTyralion_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(15620, Unit:GetMainTank()) 
end

function LegionCommanderTyralion_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LegionCommanderTyralion_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LegionCommanderTyralion_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27844, 1, "LegionCommanderTyralion_OnCombat")
RegisterUnitEvent(27844, 2, "LegionCommanderTyralion_OnLeaveCombat")
RegisterUnitEvent(27844, 3, "LegionCommanderTyralion_OnKilledTarget")
RegisterUnitEvent(27844, 4, "LegionCommanderTyralion_OnDied")