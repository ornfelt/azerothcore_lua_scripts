--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ScorchedBasilisk_OnCombat(Unit, Event)
	UnitRegisterEvent("ScorchedBasilisk_CrystallineSlumber", 15000, 1)
end

function ScorchedBasilisk_CrystallineSlumber(Unit, Event) 
	UnitFullCastSpellOnTarget(3636, 	UnitGetMainTank()) 
end

function ScorchedBasilisk_OnLeaveCombat(Unit, Event) 
	UnitRemoveEvents() 
end

function ScorchedBasilisk_OnDied(Unit, Event) 
	UnitRemoveEvents()
end

function ScorchedBasilisk_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(4041, 1, "ScorchedBasilisk_OnCombat")
RegisterUnitEvent(4041, 2, "ScorchedBasilisk_OnLeaveCombat")
RegisterUnitEvent(4041, 3, "ScorchedBasilisk_OnKilledTarget")
RegisterUnitEvent(4041, 4, "ScorchedBasilisk_OnDied")