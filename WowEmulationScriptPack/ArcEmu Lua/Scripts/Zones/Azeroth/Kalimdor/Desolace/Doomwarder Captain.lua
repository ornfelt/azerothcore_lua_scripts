--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function DoomwarderCaptain_OnCombat(Unit, Event)
	Unit:RegisterEvent("DoomwarderCaptain_BattleShout", 5000, 1)
	Unit:RegisterEvent("DoomwarderCaptain_Ignite", 10000, 0)
end

function DoomwarderCaptain_BattleShout(Unit, Event) 
	Unit:CastSpell(6192) 
end

function DoomwarderCaptain_Ignite(Unit, Event) 
	Unit:FullCastSpellOnTarget(3261, 	Unit:GetMainTank()) 
end

function DoomwarderCaptain_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function DoomwarderCaptain_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(4680, 1, "DoomwarderCaptain_OnCombat")
RegisterUnitEvent(4680, 2, "DoomwarderCaptain_OnLeaveCombat")
RegisterUnitEvent(4680, 4, "DoomwarderCaptain_OnDied")