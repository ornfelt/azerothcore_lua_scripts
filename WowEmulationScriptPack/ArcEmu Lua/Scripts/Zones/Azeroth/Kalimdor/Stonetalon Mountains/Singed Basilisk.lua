--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SingedBasilisk_OnCombat(Unit, Event)
	UnitRegisterEvent("SingedBasilisk_CrystallineSlumber", 15000, 1)
end

function SingedBasilisk_CrystallineSlumber(Unit, Event) 
	UnitFullCastSpellOnTarget(3636, 	UnitGetMainTank()) 
end

function SingedBasilisk_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SingedBasilisk_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SingedBasilisk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4042, 1, "SingedBasilisk_OnCombat")
RegisterUnitEvent(4042, 2, "SingedBasilisk_OnLeaveCombat")
RegisterUnitEvent(4042, 3, "SingedBasilisk_OnKilledTarget")
RegisterUnitEvent(4042, 4, "SingedBasilisk_OnDied")