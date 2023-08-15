--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ArcanistNozzlespring_OnCombat(Unit, Event)
	Unit:RegisterEvent("ArcanistNozzlespring_ArcaneMissiles", 8000, 0)
	Unit:RegisterEvent("ArcanistNozzlespring_Fireball", 12000, 0)
end

function ArcanistNozzlespring_ArcaneMissiles(Unit, Event) 
	Unit:FullCastSpellOnTarget(15791, 	Unit:GetRandomPlayer(0)) 
end

function ArcanistNozzlespring_Fireball(Unit, Event) 
	Unit:FullCastSpellOnTarget(13375, 	Unit:GetMainTank()) 
end

function ArcanistNozzlespring_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ArcanistNozzlespring_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ArcanistNozzlespring_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15444, 1, "ArcanistNozzlespring_OnCombat")
RegisterUnitEvent(15444, 2, "ArcanistNozzlespring_OnLeaveCombat")
RegisterUnitEvent(15444, 3, "ArcanistNozzlespring_OnKilledTarget")
RegisterUnitEvent(15444, 4, "ArcanistNozzlespring_OnDied")