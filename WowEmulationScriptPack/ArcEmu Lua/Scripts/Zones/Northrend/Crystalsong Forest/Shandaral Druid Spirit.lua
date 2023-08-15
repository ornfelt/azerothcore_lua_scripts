--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ShandaralDruidSpirit_OnCombat(Unit, Event)
Unit:RegisterEvent("ShandaralDruidSpirit_Moonfire", 6000, 0)
Unit:RegisterEvent("ShandaralDruidSpirit_Regrowth", 13000, 0)
end

function ShandaralDruidSpirit_Moonfire(Unit, Event) 
Unit:FullCastSpellOnTarget(15798, Unit:GetMainTank()) 
end

function ShandaralDruidSpirit_Regrowth(Unit, Event) 
Unit:CastSpell(16561) 
end

function ShandaralDruidSpirit_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ShandaralDruidSpirit_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ShandaralDruidSpirit_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(30863, 1, "ShandaralDruidSpirit_OnCombat")
RegisterUnitEvent(30863, 2, "ShandaralDruidSpirit_OnLeaveCombat")
RegisterUnitEvent(30863, 3, "ShandaralDruidSpirit_OnKilledTarget")
RegisterUnitEvent(30863, 4, "ShandaralDruidSpirit_OnDied")