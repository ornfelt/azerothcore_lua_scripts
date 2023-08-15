--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MagicboundAncient_OnCombat(Unit, Event)
Unit:RegisterEvent("MagicboundAncient_MarkofDetonation", 6000, 0)
end

function MagicboundAncient_MarkofDetonation(Unit, Event) 
Unit:CastSpell(50506) 
end

function MagicboundAncient_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function MagicboundAncient_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function MagicboundAncient_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25707, 1, "MagicboundAncient_OnCombat")
RegisterUnitEvent(25707, 2, "MagicboundAncient_OnLeaveCombat")
RegisterUnitEvent(25707, 3, "MagicboundAncient_OnKilledTarget")
RegisterUnitEvent(25707, 4, "MagicboundAncient_OnDied")