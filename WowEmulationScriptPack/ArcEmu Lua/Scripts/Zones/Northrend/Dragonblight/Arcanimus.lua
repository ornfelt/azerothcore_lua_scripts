--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Arcanimus_OnCombat(Unit, Event)
Unit:RegisterEvent("Arcanimus_ArcaneExplosion", 6000, 0)
end

function Arcanimus_ArcaneExplosion(Unit, Event) 
Unit:CastSpell(51820) 
end

function Arcanimus_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Arcanimus_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Arcanimus_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26370, 1, "Arcanimus_OnCombat")
RegisterUnitEvent(26370, 2, "Arcanimus_OnLeaveCombat")
RegisterUnitEvent(26370, 3, "Arcanimus_OnKilledTarget")
RegisterUnitEvent(26370, 4, "Arcanimus_OnDied")