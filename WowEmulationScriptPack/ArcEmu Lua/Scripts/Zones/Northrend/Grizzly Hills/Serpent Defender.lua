--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SerpentDefender_OnCombat(Unit, Event)
Unit:RegisterEvent("SerpentDefender_TailLash", 8000, 0)
end

function SerpentDefender_TailLash(Unit, Event) 
Unit:FullCastSpellOnTarget(34811, Unit:GetMainTank()) 
end

function SerpentDefender_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SerpentDefender_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SerpentDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(29693, 1, "SerpentDefender_OnCombat")
RegisterUnitEvent(29693, 2, "SerpentDefender_OnLeaveCombat")
RegisterUnitEvent(29693, 3, "SerpentDefender_OnKilledTarget")
RegisterUnitEvent(29693, 4, "SerpentDefender_OnDied")