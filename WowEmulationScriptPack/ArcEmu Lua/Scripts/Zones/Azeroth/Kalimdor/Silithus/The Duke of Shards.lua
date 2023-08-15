--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TheDukeofShards_OnCombat(Unit, Event)
	Unit:RegisterEvent("TheDukeofShards_GroundTremor", 8000, 0)
	Unit:RegisterEvent("TheDukeofShards_Strike", 5000, 0)
	Unit:RegisterEvent("TheDukeofShards_Thunderclap", 11000, 0)
end

function TheDukeofShards_GroundTremor(Unit, Event) 
	Unit:CastSpell(6524) 
end

function TheDukeofShards_Strike(Unit, Event) 
	Unit:FullCastSpellOnTarget(13446, 	Unit:GetMainTank()) 
end

function TheDukeofShards_Thunderclap(Unit, Event) 
	Unit:CastSpell(8078) 
end

function TheDukeofShards_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TheDukeofShards_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TheDukeofShards_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15208, 1, "TheDukeofShards_OnCombat")
RegisterUnitEvent(15208, 2, "TheDukeofShards_OnLeaveCombat")
RegisterUnitEvent(15208, 3, "TheDukeofShards_OnKilledTarget")
RegisterUnitEvent(15208, 4, "TheDukeofShards_OnDied")