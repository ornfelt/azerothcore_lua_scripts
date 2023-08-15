--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WatchCommanderZalaphil_OnCombat(Unit, Event)
	Unit:RegisterEvent("WatchCommanderZalaphil_DefensiveStance", 1000, 1)
	Unit:RegisterEvent("WatchCommanderZalaphil_ShieldBash", 8000, 0)
end

function WatchCommanderZalaphil_DefensiveStance(Unit, Event) 
	Unit:CastSpell(7164) 
end

function WatchCommanderZalaphil_ShieldBash(Unit, Event) 
	Unit:FullCastSpellOnTarget(72, 	Unit:GetMainTank()) 
end

function WatchCommanderZalaphil_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WatchCommanderZalaphil_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WatchCommanderZalaphil_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3192, 1, "WatchCommanderZalaphil_OnCombat")
RegisterUnitEvent(3192, 2, "WatchCommanderZalaphil_OnLeaveCombat")
RegisterUnitEvent(3192, 3, "WatchCommanderZalaphil_OnKilledTarget")
RegisterUnitEvent(3192, 4, "WatchCommanderZalaphil_OnDied")