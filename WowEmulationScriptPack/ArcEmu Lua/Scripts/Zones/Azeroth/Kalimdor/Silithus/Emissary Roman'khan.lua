--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EmissaryRomankhan_OnCombat(Unit, Event)
	Unit:RegisterEvent("EmissaryRomankhan_Wilt", 15000, 0)
end

function EmissaryRomankhan_Wilt(Unit, Event) 
	Unit:CastSpell(23772) 
end

function EmissaryRomankhan_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function EmissaryRomankhan_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function EmissaryRomankhan_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14862, 1, "EmissaryRomankhan_OnCombat")
RegisterUnitEvent(14862, 2, "EmissaryRomankhan_OnLeaveCombat")
RegisterUnitEvent(14862, 3, "EmissaryRomankhan_OnKilledTarget")
RegisterUnitEvent(14862, 4, "EmissaryRomankhan_OnDied")