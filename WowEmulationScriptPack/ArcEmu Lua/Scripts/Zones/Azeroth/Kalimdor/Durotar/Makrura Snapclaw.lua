--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MakruraSnapclaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("MarkuraSnapclaw_Claw",8000,0)
end

function MarkuraSnapclaw_Claw(Unit,Event)
	Unit:FullCastSpellOnTarget(5424,	Unit:GetMainTank())
end

function MakruraSnapclaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MakruraSnapclaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function MakruraSnapclaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3105, 1, "MakruraSnapclaw_OnCombat")
RegisterUnitEvent(3105, 2, "MakruraSnapclaw_OnLeaveCombat")
RegisterUnitEvent(3105, 3, "MakruraSnapclaw_OnKilledTarget")
RegisterUnitEvent(3105, 4, "MakruraSnapclaw_OnDied")