--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ThistleshrubRootshaper_OnCombat(Unit, Event)
	Unit:RegisterEvent("ThistleshrubRootshaper_EarthgrabTotem", 10000, 1)
end

function ThistleshrubRootshaper_EarthgrabTotem(Unit, Event) 
	Unit:CastSpell(8376) 
end

function ThistleshrubRootshaper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ThistleshrubRootshaper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ThistleshrubRootshaper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5485, 1, "ThistleshrubRootshaper_OnCombat")
RegisterUnitEvent(5485, 2, "ThistleshrubRootshaper_OnLeaveCombat")
RegisterUnitEvent(5485, 3, "ThistleshrubRootshaper_OnKilledTarget")
RegisterUnitEvent(5485, 4, "ThistleshrubRootshaper_OnDied")