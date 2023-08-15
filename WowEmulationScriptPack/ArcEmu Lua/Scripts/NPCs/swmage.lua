--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Swmage_Shadowbolt(Unit, event, miscunit, misc)
	print "Shadowbolt"
	Unit:FullCastSpellOnTarget(31627,Unit:GetMainTank(1))
end

function Swmage_Adds(Unit, event, miscunit, misc)
	print "Adds"
	Unit:FullCastSpell(31624)
end

function Swmage(unit, event, miscunit, misc)
	print "Die"
	unit:RegisterEvent("Swmage_Shadowbolt",15000,0)
	unit:RegisterEvent("Swmage_Adds",40000,0)
end

function Swmage_Death(Unit)
	Unit:RemoveEvents()
end

function Swmage_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end


RegisterUnitEvent(70013, 2, "Swmage_OnLeaveCombat")
RegisterUnitEvent(70013, 4, "Swmage_Death")
RegisterUnitEvent(70013, 1, "Swmage")