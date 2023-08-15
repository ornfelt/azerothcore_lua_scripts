--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SaltstoneBasilisk_OnCombat(Unit, Event)
	UnitRegisterEvent("SaltstoneBasilisk_CrystallineSlumber", 12000, 0)
end

function SaltstoneBasilisk_CrystallineSlumber(Unit, Event) 
	UnitFullCastSpellOnTarget(3636, 	UnitGetMainTank()) 
end

function SaltstoneBasilisk_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function SaltstoneBasilisk_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function SaltstoneBasilisk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4147, 1, "SaltstoneBasilisk_OnCombat")
RegisterUnitEvent(4147, 2, "SaltstoneBasilisk_OnLeaveCombat")
RegisterUnitEvent(4147, 3, "SaltstoneBasilisk_OnKilledTarget")
RegisterUnitEvent(4147, 4, "SaltstoneBasilisk_OnDied")