--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CorruptedLothalorAncient_OnCombat(Unit, Event)
Unit:RegisterEvent("CorruptedLothalorAncient_ArcaneDischarge", 6000, 0)
Unit:RegisterEvent("CorruptedLothalorAncient_ArcaneExplosion", 5000, 0)
end

function CorruptedLothalorAncient_ArcaneDischarge(Unit, Event) 
Unit:CastSpell(51727) 
end

function CorruptedLothalorAncient_ArcaneExplosion(Unit, Event) 
Unit:CastSpell(51725) 
end

function CorruptedLothalorAncient_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CorruptedLothalorAncient_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CorruptedLothalorAncient_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26333, 1, "CorruptedLothalorAncient_OnCombat")
RegisterUnitEvent(26333, 2, "CorruptedLothalorAncient_OnLeaveCombat")
RegisterUnitEvent(26333, 3, "CorruptedLothalorAncient_OnKilledTarget")
RegisterUnitEvent(26333, 4, "CorruptedLothalorAncient_OnDied")