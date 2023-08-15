--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function XavianRogue_OnCombat(Unit, Event)
	Unit:RegisterEvent("XavianRogue_GiftoftheXavian", 13000, 0)
end

function XavianRogue_GiftoftheXavian(pUnit, Event) 
	pUnit:CastSpell(6925) 
end

function XavianRogue_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function XavianRogue_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3752, 1, "XavianRogue_OnCombat")
RegisterUnitEvent(3752, 2, "XavianRogue_OnLeaveCombat")
RegisterUnitEvent(3752, 4, "XavianRogue_OnDied")