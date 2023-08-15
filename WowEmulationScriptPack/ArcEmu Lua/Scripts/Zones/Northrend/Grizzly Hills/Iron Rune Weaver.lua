--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function IronRuneWeaver_OnCombat(Unit, Event)
Unit:RegisterEvent("IronRuneWeaver_RuneWeaving", 9000, 0)
end

function IronRuneWeaver_RuneWeaving(Unit, Event) 
Unit:FullCastSpellOnTarget(52713, Unit:GetMainTank()) 
end

function IronRuneWeaver_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function IronRuneWeaver_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function IronRuneWeaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26820, 1, "IronRuneWeaver_OnCombat")
RegisterUnitEvent(26820, 2, "IronRuneWeaver_OnLeaveCombat")
RegisterUnitEvent(26820, 3, "IronRuneWeaver_OnKilledTarget")
RegisterUnitEvent(26820, 4, "IronRuneWeaver_OnDied")