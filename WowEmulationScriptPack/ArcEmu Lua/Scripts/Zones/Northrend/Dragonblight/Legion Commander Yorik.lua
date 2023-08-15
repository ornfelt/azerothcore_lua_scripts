--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LegionCommanderYorik_OnCombat(Unit, Event)
Unit:RegisterEvent("LegionCommanderYorik_Shoot", 5000, 0)
end

function LegionCommanderYorik_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(15620, Unit:GetMainTank()) 
end

function LegionCommanderYorik_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LegionCommanderYorik_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LegionCommanderYorik_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27857, 1, "LegionCommanderYorik_OnCombat")
RegisterUnitEvent(27857, 2, "LegionCommanderYorik_OnLeaveCombat")
RegisterUnitEvent(27857, 3, "LegionCommanderYorik_OnKilledTarget")
RegisterUnitEvent(27857, 4, "LegionCommanderYorik_OnDied")