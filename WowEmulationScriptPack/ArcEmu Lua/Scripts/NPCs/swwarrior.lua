--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Swwarrior_Talon(Unit, event, miscunit, misc)
	print "Punk"
	Unit:FullCastSpellOnTarget(43517,Unit:GetMainTank())
end

function Swwarrior(unit, event, miscunit, misc)
	print "Fuck You"
	unit:RegisterEvent("Swwarrior_Talon",10000,0)
end

function Swwarrior_Death(Unit)
	Unit:RemoveEvents()
end

function Swwarrior_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

RegisterUnitEvent(70002, 1, "Swwarrior")
RegisterUnitEvent(70002, 2, "Swwarrior_OnLeaveCombat")
RegisterUnitEvent(70002, 4, "Swwarrior_Death")