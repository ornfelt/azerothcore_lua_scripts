--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Grummbles_Curse(Unit, event, miscunit, misc)
	print "Grummbles Curse"
	Unit:FullCastSpell(29214)
end

function Grummbles(unit, event, miscunit, misc)
	print "Grummbles"
	unit:RegisterEvent("Grummbles_Curse",15000,0)
end

function Grummbles_Death(Unit)
	Unit:RemoveEvents()
end

function Grummbles_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end


RegisterUnitEvent(70005, 2, "Grummbles_OnLeaveCombat")
RegisterUnitEvent(70005, 4, "Grummbles_Death")
RegisterUnitEvent(70005, 1, "Grummbles")