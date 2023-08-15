--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BloodoftheOldGod_OnCombat(Unit, Event)
Unit:RegisterEvent("BloodoftheOldGod_CorruptionoftheOldGod", 7000, 0)
end

function BloodoftheOldGod_CorruptionoftheOldGod(Unit, Event) 
Unit:FullCastSpellOnTarget(52564, Unit:GetMainTank()) 
end

function BloodoftheOldGod_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function BloodoftheOldGod_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function BloodoftheOldGod_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(28854, 1, "BloodoftheOldGod_OnCombat")
RegisterUnitEvent(28854, 2, "BloodoftheOldGod_OnLeaveCombat")
RegisterUnitEvent(28854, 3, "BloodoftheOldGod_OnKilledTarget")
RegisterUnitEvent(28854, 4, "BloodoftheOldGod_OnDied")