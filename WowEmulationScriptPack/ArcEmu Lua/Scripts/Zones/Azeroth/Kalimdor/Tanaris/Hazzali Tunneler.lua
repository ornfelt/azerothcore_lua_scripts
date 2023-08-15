--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function HazzaliTunneler_OnCombat(Unit, Event)
	Unit:RegisterEvent("HazzaliTunneler_PierceArmor", 10000, 0)
end

function HazzaliTunneler_PierceArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(6016, 	Unit:GetMainTank()) 
end

function HazzaliTunneler_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function HazzaliTunneler_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function HazzaliTunneler_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5453, 1, "HazzaliTunneler_OnCombat")
RegisterUnitEvent(5453, 2, "HazzaliTunneler_OnLeaveCombat")
RegisterUnitEvent(5453, 3, "HazzaliTunneler_OnKilledTarget")
RegisterUnitEvent(5453, 4, "HazzaliTunneler_OnDied")