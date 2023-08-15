--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HulkingGritjawBasilisk_OnCombat(Unit, Event)
	Unit:RegisterEvent("HulkingGritjawBasilisk_CrystallineSlumber", 15000, 1)
end

function HulkingGritjawBasilisk_CrystallineSlumber(Unit, Event) 
	Unit:FullCastSpellOnTarget(3636, 	Unit:GetMainTank()) 
end

function HulkingGritjawBasilisk_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HulkingGritjawBasilisk_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HulkingGritjawBasilisk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4729, 1, "HulkingGritjawBasilisk_OnCombat")
RegisterUnitEvent(4729, 2, "HulkingGritjawBasilisk_OnLeaveCombat")
RegisterUnitEvent(4729, 3, "HulkingGritjawBasilisk_OnKilledTarget")
RegisterUnitEvent(4729, 4, "HulkingGritjawBasilisk_OnDied")