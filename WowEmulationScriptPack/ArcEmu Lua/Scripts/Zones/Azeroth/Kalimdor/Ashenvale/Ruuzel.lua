--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Ruuzel_OnCombat(Unit, Event)
	Unit:RegisterEvent("Ruuzel_HeroicStrike", 6000, 0)
end

function Ruuzel_HeroicStrike(pUnit, Event) 
	pUnit:FullCastSpellOnTarget(25712, 	pUnit:GetMainTank()) 
end

function Ruuzel_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Ruuzel_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3943, 1, "Ruuzel_OnCombat")
RegisterUnitEvent(3943, 2, "Ruuzel_OnLeaveCombat")
RegisterUnitEvent(3943, 4, "Ruuzel_OnDied")