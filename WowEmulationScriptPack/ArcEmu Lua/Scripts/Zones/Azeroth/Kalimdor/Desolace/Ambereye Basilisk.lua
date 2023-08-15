--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function AmbereyeBasilisk_OnCombat(Unit, Event)
	Unit:RegisterEvent("AmbereyeBasilisk_Petrify", 15000, 0)
end

function AmbereyeBasilisk_Petrify(Unit, Event) 
	Unit:FullCastSpellOnTarget(11020, 	Unit:GetMainTank()) 
end

function AmbereyeBasilisk_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function AmbereyeBasilisk_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(11785, 1, "AmbereyeBasilisk_OnCombat")
RegisterUnitEvent(11785, 2, "AmbereyeBasilisk_OnLeaveCombat")
RegisterUnitEvent(11785, 4, "AmbereyeBasilisk_OnDied")