--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function LostShandaralSpirit_OnCombat(Unit, Event)
Unit:RegisterEvent("LostShandaralSpirit_Moonfire", 6000, 0)
Unit:RegisterEvent("LostShandaralSpirit_Regrowth", 13000, 0)
end

function LostShandaralSpirit_Moonfire(Unit, Event) 
Unit:FullCastSpellOnTarget(15798, Unit:GetMainTank()) 
end

function LostShandaralSpirit_Regrowth(Unit, Event) 
Unit:CastSpell(16561) 
end

function LostShandaralSpirit_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function LostShandaralSpirit_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function LostShandaralSpirit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31231, 1, "LostShandaralSpirit_OnCombat")
RegisterUnitEvent(31231, 2, "LostShandaralSpirit_OnLeaveCombat")
RegisterUnitEvent(31231, 3, "LostShandaralSpirit_OnKilledTarget")
RegisterUnitEvent(31231, 4, "LostShandaralSpirit_OnDied")