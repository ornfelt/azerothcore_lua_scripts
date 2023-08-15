--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function MagnataurHuntress_OnCombat(Unit, Event)
Unit:RegisterEvent("MagnataurHuntress_TuskStrike", 7000, 0)
Unit:RegisterEvent("MagnataurHuntress_WarStomp", 10000, 0)
end

function MagnataurHuntress_TuskStrike(Unit, Event) 
Unit:FullCastSpellOnTarget(50410, Unit:GetMainTank()) 
end

function MagnataurHuntress_WarStomp(Unit, Event) 
Unit:CastSpell(11876) 
end

function MagnataurHuntress_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MagnataurHuntress_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MagnataurHuntress_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(24469, 1, "MagnataurHuntress_OnCombat")
RegisterUnitEvent(24469, 2, "MagnataurHuntress_OnLeaveCombat")
RegisterUnitEvent(24469, 3, "MagnataurHuntress_OnKilledTarget")
RegisterUnitEvent(24469, 4, "MagnataurHuntress_OnDied")