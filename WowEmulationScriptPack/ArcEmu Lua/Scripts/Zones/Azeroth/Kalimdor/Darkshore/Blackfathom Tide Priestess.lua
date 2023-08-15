--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlackfathomTidePriestess_OnCombat(Unit, Event)
	Unit:RegisterEvent("BlackfathomTidePriestess_Frostbolt", 8000, 0)
	Unit:RegisterEvent("BlackfathomTidePriestess_Heal", 13000, 0)
end

function BlackfathomTidePriestess_Frostbolt(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(9672, 	pUnit:GetMainTank()) 
end

function BlackfathomTidePriestess_Heal(pUnit, Event) 
	pUnit:CastSpell(11642) 
end

function BlackfathomTidePriestess_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BlackfathomTidePriestess_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4802, 1, "BlackfathomTidePriestess_OnCombat")
RegisterUnitEvent(4802, 2, "BlackfathomTidePriestess_OnLeaveCombat")
RegisterUnitEvent(4802, 4, "BlackfathomTidePriestess_OnDied")