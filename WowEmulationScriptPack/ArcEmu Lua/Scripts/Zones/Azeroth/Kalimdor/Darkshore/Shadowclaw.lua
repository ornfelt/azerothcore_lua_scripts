--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Shadowclaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("Shadowclaw_CurseofWeakness", 4000, 1)
end

function Shadowclaw_CurseofWeakness(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(17227, 	pUnit:GetMainTank()) 
end

function Shadowclaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Shadowclaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2175, 1, "Shadowclaw_OnCombat")
RegisterUnitEvent(2175, 2, "Shadowclaw_OnLeaveCombat")
RegisterUnitEvent(2175, 4, "Shadowclaw_OnDied")