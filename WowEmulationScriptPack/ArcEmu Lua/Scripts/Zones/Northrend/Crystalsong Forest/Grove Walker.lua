--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GroveWalker_OnCombat(Unit, Event)
Unit:RegisterEvent("GroveWalker_Rejuvenation", 12000, 0)
Unit:RegisterEvent("GroveWalker_Thorns", 2000, 1)
end

function GroveWalker_Rejuvenation(Unit, Event) 
Unit:CastSpell(15981) 
end

function GroveWalker_Thorns(Unit, Event) 
Unit:CastSpell(35361) 
end

function GroveWalker_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GroveWalker_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GroveWalker_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(31228, 1, "GroveWalker_OnCombat")
RegisterUnitEvent(31228, 2, "GroveWalker_OnLeaveCombat")
RegisterUnitEvent(31228, 3, "GroveWalker_OnKilledTarget")
RegisterUnitEvent(31228, 4, "GroveWalker_OnDied")