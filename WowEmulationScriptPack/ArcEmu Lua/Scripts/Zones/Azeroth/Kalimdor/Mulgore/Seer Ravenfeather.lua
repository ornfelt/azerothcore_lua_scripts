--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SeerRavenfeather_OnCombat(Unit, Event)
Unit:RegisterEvent("SeerRavenfeather_RockSkin", 10000, 0)
end

function SeerRavenfeather_RockSkin(pUnit, Event) 
pUnit:CastSpell(8314) 
end

function SeerRavenfeather_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SeerRavenfeather_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SeerRavenfeather_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5888, 1, "SeerRavenfeather_OnCombat")
RegisterUnitEvent(5888, 2, "SeerRavenfeather_OnLeaveCombat")
RegisterUnitEvent(5888, 3, "SeerRavenfeather_OnKilledTarget")
RegisterUnitEvent(5888, 4, "SeerRavenfeather_OnDied")