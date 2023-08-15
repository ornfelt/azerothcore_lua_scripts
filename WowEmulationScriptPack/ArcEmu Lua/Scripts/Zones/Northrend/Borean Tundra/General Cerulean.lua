--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GeneralCerulean_OnCombat(Unit, Event)
Unit:RegisterEvent("GeneralCerulean_FrostShock", 7000, 0)
end

function GeneralCerulean_FrostShock(Unit, Event) 
Unit:FullCastSpellOnTarget(15499, Unit:GetMainTank()) 
end

function GeneralCerulean_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GeneralCerulean_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GeneralCerulean_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25716, 1, "GeneralCerulean_OnCombat")
RegisterUnitEvent(25716, 2, "GeneralCerulean_OnLeaveCombat")
RegisterUnitEvent(25716, 3, "GeneralCerulean_OnKilledTarget")
RegisterUnitEvent(25716, 4, "GeneralCerulean_OnDied")