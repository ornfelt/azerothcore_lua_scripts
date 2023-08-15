--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Scavengebot005B6_OnCombat(Unit, Event)
Unit:RegisterEvent("Scavengebot005B6_CuttingLaser", 7000, 0)
end

function Scavengebot005B6_CuttingLaser(Unit, Event) 
Unit:FullCastSpellOnTarget(49945, Unit:GetMainTank()) 
end

function Scavengebot005B6_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Scavengebot005B6_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Scavengebot005B6_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25792, 1, "Scavengebot005B6_OnCombat")
RegisterUnitEvent(25792, 2, "Scavengebot005B6_OnLeaveCombat")
RegisterUnitEvent(25792, 3, "Scavengebot005B6_OnKilledTarget")
RegisterUnitEvent(25792, 4, "Scavengebot005B6_OnDied")