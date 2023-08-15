--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Scavengebot004A8_OnCombat(Unit, Event)
Unit:RegisterEvent("Scavengebot004A8_CuttingLaser", 7000, 0)
end

function Scavengebot004A8_CuttingLaser(Unit, Event) 
Unit:FullCastSpellOnTarget(49945, Unit:GetMainTank()) 
end

function Scavengebot004A8_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Scavengebot004A8_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Scavengebot004A8_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25752, 1, "Scavengebot004A8_OnCombat")
RegisterUnitEvent(25752, 2, "Scavengebot004A8_OnLeaveCombat")
RegisterUnitEvent(25752, 3, "Scavengebot004A8_OnKilledTarget")
RegisterUnitEvent(25752, 4, "Scavengebot004A8_OnDied")