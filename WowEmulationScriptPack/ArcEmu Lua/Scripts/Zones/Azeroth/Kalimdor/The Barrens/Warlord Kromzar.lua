--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WarlordKromzar_OnCombat(Unit, Event)
	Unit:RegisterEvent("WarlordKromzar_CreateKromzarsBanner", 2000, 1)
	Unit:RegisterEvent("WarlordKromzar_Strike", 5000, 0)
end

function WarlordKromzar_CreateKromzarsBanner(Unit, Event) 
	Unit:CastSpell(13965) 
end

function WarlordKromzar_Strike(Unit, Event) 
	Unit:FullCastSpellOnTarget(11976, 	Unit:GetMainTank()) 
end

function WarlordKromzar_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WarlordKromzar_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WarlordKromzar_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(9456, 1, "WarlordKromzar_OnCombat")
RegisterUnitEvent(9456, 2, "WarlordKromzar_OnLeaveCombat")
RegisterUnitEvent(9456, 3, "WarlordKromzar_OnKilledTarget")
RegisterUnitEvent(9456, 4, "WarlordKromzar_OnDied")