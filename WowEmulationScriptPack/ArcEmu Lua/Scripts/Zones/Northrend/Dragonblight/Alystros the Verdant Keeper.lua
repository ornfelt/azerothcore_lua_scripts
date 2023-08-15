--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AlystrostheVerdantKeeper_OnCombat(Unit, Event)
Unit:RegisterEvent("AlystrostheVerdantKeeper_LapsingDream", 1000, 1)
Unit:RegisterEvent("AlystrostheVerdantKeeper_TalonStrike", 5000, 0)
Unit:RegisterEvent("AlystrostheVerdantKeeper_WingBeat", 8000, 0)
end

function AlystrostheVerdantKeeper_LapsingDream(Unit, Event) 
Unit:FullCastSpellOnTarget(51922, Unit:GetMainTank()) 
end

function AlystrostheVerdantKeeper_TalonStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(51937, Unit:GetMainTank()) 
end

function AlystrostheVerdantKeeper_WingBeat(Unit, Event) 
Unit:CastSpell(51938) 
end

function AlystrostheVerdantKeeper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AlystrostheVerdantKeeper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AlystrostheVerdantKeeper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27249, 1, "AlystrostheVerdantKeeper_OnCombat")
RegisterUnitEvent(27249, 2, "AlystrostheVerdantKeeper_OnLeaveCombat")
RegisterUnitEvent(27249, 3, "AlystrostheVerdantKeeper_OnKilledTarget")
RegisterUnitEvent(27249, 4, "AlystrostheVerdantKeeper_OnDied")