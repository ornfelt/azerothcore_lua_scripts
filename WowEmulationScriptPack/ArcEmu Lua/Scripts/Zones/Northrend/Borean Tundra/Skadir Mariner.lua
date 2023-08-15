--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SkadirMariner_OnCombat(Unit, Event)
Unit:RegisterEvent("SkadirMariner_DemoralizingShout", 2000, 2)
Unit:RegisterEvent("SkadirMariner_Uppercut", 8000, 0)
end

function SkadirMariner_DemoralizingShout(Unit, Event) 
Unit:CastSpell(13730) 
end

function SkadirMariner_Uppercut(Unit, Event)
Unit:FullCastSpellOnTarget(10966, Unit:GetMainTank())
end

function SkadirMariner_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function SkadirMariner_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function SkadirMariner_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25523, 1, "SkadirMariner_OnCombat")
RegisterUnitEvent(25523, 2, "SkadirMariner_OnLeaveCombat")
RegisterUnitEvent(25523, 3, "SkadirMariner_OnKilledTarget")
RegisterUnitEvent(25523, 4, "SkadirMariner_OnDied")