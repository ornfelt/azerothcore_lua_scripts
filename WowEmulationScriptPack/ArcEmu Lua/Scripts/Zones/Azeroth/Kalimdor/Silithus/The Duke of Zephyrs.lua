--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TheDukeofZephyrs_OnCombat(Unit, Event)
	Unit:RegisterEvent("TheDukeofZephyrs_ForkedLightning", 6000, 0)
	Unit:RegisterEvent("TheDukeofZephyrs_LightningCloud", 8000, 0)
	Unit:RegisterEvent("TheDukeofZephyrs_WingFlap", 12000, 0)
end

function TheDukeofZephyrs_ForkedLightning(Unit, Event) 
	Unit:CastSpell(25034) 
end

function TheDukeofZephyrs_LightningCloud(Unit, Event) 
	Unit:CastSpell(44417) 
end

function TheDukeofZephyrs_WingFlap(Unit, Event) 
	Unit:FullCastSpellOnTarget(12882, 	Unit:GetMainTank()) 
end

function TheDukeofZephyrs_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TheDukeofZephyrs_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TheDukeofZephyrs_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15220, 1, "TheDukeofZephyrs_OnCombat")
RegisterUnitEvent(15220, 2, "TheDukeofZephyrs_OnLeaveCombat")
RegisterUnitEvent(15220, 3, "TheDukeofZephyrs_OnKilledTarget")
RegisterUnitEvent(15220, 4, "TheDukeofZephyrs_OnDied")