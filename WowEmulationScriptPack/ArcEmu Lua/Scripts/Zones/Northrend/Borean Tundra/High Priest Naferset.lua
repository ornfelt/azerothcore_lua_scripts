--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HighPriestNaferset_OnCombat(Unit, Event)
Unit:RegisterEvent("HighPriestNaferset_MindBlast", 6000, 0)
Unit:RegisterEvent("HighPriestNaferset_Renew", 13000, 0)
end

function HighPriestNaferset_MindBlast(Unit, Event) 
Unit:FullCastSpellOnTarget(15587, Unit:GetMainTank()) 
end

function HighPriestNaferset_Renew(Unit, Event) 
Unit:CastSpell(11640) 
end

function HighPriestNaferset_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HighPriestNaferset_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HighPriestNaferset_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26076, 1, "HighPriestNaferset_OnCombat")
RegisterUnitEvent(26076, 2, "HighPriestNaferset_OnLeaveCombat")
RegisterUnitEvent(26076, 3, "HighPriestNaferset_OnKilledTarget")
RegisterUnitEvent(26076, 4, "HighPriestNaferset_OnDied")