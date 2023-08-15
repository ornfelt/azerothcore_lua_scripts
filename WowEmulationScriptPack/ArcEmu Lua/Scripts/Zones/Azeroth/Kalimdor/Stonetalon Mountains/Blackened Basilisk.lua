--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BlackenedBasilisk_OnCombat(Unit, Event)
	UnitRegisterEvent("BlackenedBasilisk_CrystallineSlumber", 15000, 1)
end

function BlackenedBasilisk_CrystallineSlumber(Unit, Event) 
	UnitFullCastSpellOnTarget(3636, 	UnitGetMainTank()) 
end

function BlackenedBasilisk_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function BlackenedBasilisk_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function BlackenedBasilisk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4044, 1, "BlackenedBasilisk_OnCombat")
RegisterUnitEvent(4044, 2, "BlackenedBasilisk_OnLeaveCombat")
RegisterUnitEvent(4044, 3, "BlackenedBasilisk_OnKilledTarget")
RegisterUnitEvent(4044, 4, "BlackenedBasilisk_OnDied")