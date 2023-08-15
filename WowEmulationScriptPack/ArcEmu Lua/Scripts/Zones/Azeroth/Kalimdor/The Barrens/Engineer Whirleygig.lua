--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function EngineerWhirleygig_OnCombat(Unit, Event)
	Unit:RegisterEvent("EngineerWhirleygig_CompactHarvestReaper", 4000, 1)
	Unit:RegisterEvent("EngineerWhirleygig_ExplosiveSheep", 10000, 1)
end

function EngineerWhirleygig_CompactHarvestReaper(Unit, Event) 
	Unit:CastSpell(7979) 
end

function EngineerWhirleygig_ExplosiveSheep(Unit, Event) 
	Unit:CastSpell(8209) 
end

function EngineerWhirleygig_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function EngineerWhirleygig_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function EngineerWhirleygig_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5836, 1, "EngineerWhirleygig_OnCombat")
RegisterUnitEvent(5836, 2, "EngineerWhirleygig_OnLeaveCombat")
RegisterUnitEvent(5836, 3, "EngineerWhirleygig_OnKilledTarget")
RegisterUnitEvent(5836, 4, "EngineerWhirleygig_OnDied")