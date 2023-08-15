--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MakrinniSnapclaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("MakrinniSnapclaw_TendonRip", 10000, 0)
end

function MakrinniSnapclaw_TendonRip(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(3604, 	pUnit:GetMainTank()) 
end

function MakrinniSnapclaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function MakrinniSnapclaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(6372, 1, "MakrinniSnapclaw_OnCombat")
RegisterUnitEvent(6372, 2, "MakrinniSnapclaw_OnLeaveCombat")
RegisterUnitEvent(6372, 4, "MakrinniSnapclaw_OnDied")