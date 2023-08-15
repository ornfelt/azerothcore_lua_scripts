--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TheDukeofCynders_OnCombat(Unit, Event)
	Unit:RegisterEvent("TheDukeofCynders_BlastWave", 8000, 0)
	Unit:RegisterEvent("TheDukeofCynders_FireBlast", 6000, 0)
	Unit:RegisterEvent("TheDukeofCynders_Flamestrike", 2000, 2)
end

function TheDukeofCynders_BlastWave(Unit, Event) 
	Unit:CastSpell(22424) 
end

function TheDukeofCynders_FireBlast(Unit, Event) 
	Unit:FullCastSpellOnTarget(25028, 	Unit:GetMainTank()) 
end

function TheDukeofCynders_Flamestrike(Unit, Event) 
	Unit:CastSpell(18399) 
end

function TheDukeofCynders_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TheDukeofCynders_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TheDukeofCynders_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15206, 1, "TheDukeofCynders_OnCombat")
RegisterUnitEvent(15206, 2, "TheDukeofCynders_OnLeaveCombat")
RegisterUnitEvent(15206, 3, "TheDukeofCynders_OnKilledTarget")
RegisterUnitEvent(15206, 4, "TheDukeofCynders_OnDied")