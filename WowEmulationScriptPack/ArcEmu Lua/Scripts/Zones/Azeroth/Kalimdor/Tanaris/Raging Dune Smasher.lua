--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RagingDuneSmasher_OnCombat(Unit, Event)
	Unit:RegisterEvent("RagingDuneSmasher_Enrage", 120000, 0)
end

function RagingDuneSmasher_Enrage(Unit, Event) 
if 	Unit:GetHealthPct() < 25 then
	Unit:CastSpell(8599) 
end
end

function RagingDuneSmasher_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RagingDuneSmasher_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RagingDuneSmasher_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5470, 1, "RagingDuneSmasher_OnCombat")
RegisterUnitEvent(5470, 2, "RagingDuneSmasher_OnLeaveCombat")
RegisterUnitEvent(5470, 3, "RagingDuneSmasher_OnKilledTarget")
RegisterUnitEvent(5470, 4, "RagingDuneSmasher_OnDied")