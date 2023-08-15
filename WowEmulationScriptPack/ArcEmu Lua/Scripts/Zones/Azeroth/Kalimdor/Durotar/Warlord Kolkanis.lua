--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function WarlordKolkanis_OnCombat(Unit, Event)
	Unit:RegisterEvent("WarlordKolkanis_Pummel", 5000, 0)
	Unit:RegisterEvent("WarlordKolkanis_Thunderclap", 7000, 0)
end

function WarlordKolkanis_Pummel(Unit, Event) 
	Unit:FullCastSpellOnTarget(12555, 	Unit:GetMainTank()) 
end

function WarlordKolkanis_Thunderclap(Unit, Event) 
	Unit:FullCastSpellOnTarget(8078, 	Unit:GetMainTank()) 
end

function WarlordKolkanis_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WarlordKolkanis_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WarlordKolkanis_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5808, 1, "WarlordKolkanis_OnCombat")
RegisterUnitEvent(5808, 2, "WarlordKolkanis_OnLeaveCombat")
RegisterUnitEvent(5808, 3, "WarlordKolkanis_OnKilledTarget")
RegisterUnitEvent(5808, 4, "WarlordKolkanis_OnDied")