--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function IronRuneSmith_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneSmith_LightningCharged", 4000, 1)
Unit:RegisterEvent("IronRuneSmith_SmeltRune", 10000, 0)
end

function IronRuneSmith_LightningCharged(Unit, Event) 
Unit:CastSpell(52701) 
end

function IronRuneSmith_SmeltRune(Unit, Event) 
Unit:FullCastSpellOnTarget(52699, Unit:GetMainTank()) 
end

function IronRuneSmith_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneSmith_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneSmith_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26408, 1, "IronRuneSmith_OnCombat")
RegisterUnitEvent(26408, 2, "IronRuneSmith_OnLeaveCombat")
RegisterUnitEvent(26408, 3, "IronRuneSmith_OnKilledTarget")
RegisterUnitEvent(26408, 4, "IronRuneSmith_OnDied")