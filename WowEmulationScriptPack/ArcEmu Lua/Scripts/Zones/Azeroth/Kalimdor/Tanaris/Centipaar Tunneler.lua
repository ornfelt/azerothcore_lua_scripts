--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function CentipaarTunneler_OnCombat(Unit, Event)
	Unit:RegisterEvent("CentipaarTunneler_PierceArmor", 15000, 0)
	Unit:RegisterEvent("CentipaarTunneler_Thrash", 6000, 0)
end

function CentipaarTunneler_PierceArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(6016, 	Unit:GetMainTank()) 
end

function CentipaarTunneler_Thrash(Unit, Event) 
	Unit:FullCastSpellOnTarget(3391, 	Unit:GetMainTank()) 
end

function CentipaarTunneler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function CentipaarTunneler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function CentipaarTunneler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5459, 1, "CentipaarTunneler_OnCombat")
RegisterUnitEvent(5459, 2, "CentipaarTunneler_OnLeaveCombat")
RegisterUnitEvent(5459, 3, "CentipaarTunneler_OnKilledTarget")
RegisterUnitEvent(5459, 4, "CentipaarTunneler_OnDied")