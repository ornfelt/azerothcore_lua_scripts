--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function WestfallBrigadeMarine_OnCombat(Unit, Event)
Unit:RegisterEvent("WestfallBrigadeMarine_ConcussionBlow", 9000, 0)
Unit:RegisterEvent("WestfallBrigadeMarine_SunderArmor", 5000, 0)
end

function WestfallBrigadeMarine_ConcussionBlow(Unit, Event) 
Unit:FullCastSpellOnTarget(52719, Unit:GetMainTank()) 
end

function WestfallBrigadeMarine_SunderArmor(Unit, Event) 
Unit:FullCastSpellOnTarget(50307, Unit:GetMainTank()) 
end

function WestfallBrigadeMarine_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function WestfallBrigadeMarine_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function WestfallBrigadeMarine_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27501, 1, "WestfallBrigadeMarine_OnCombat")
RegisterUnitEvent(27501, 2, "WestfallBrigadeMarine_OnLeaveCombat")
RegisterUnitEvent(27501, 3, "WestfallBrigadeMarine_OnKilledTarget")
RegisterUnitEvent(27501, 4, "WestfallBrigadeMarine_OnDied")