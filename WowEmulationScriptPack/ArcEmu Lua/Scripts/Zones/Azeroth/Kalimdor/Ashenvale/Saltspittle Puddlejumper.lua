--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function SaltspittlePuddlejumper_OnCombat(Unit, Event)
	Unit:RegisterEvent("SaltspittlePuddlejumper_BattleStance", 1000, 1)
	Unit:RegisterEvent("SaltspittlePuddlejumper_RushingCharge", 8000, 0)
end

function SaltspittlePuddlejumper_BattleStance(pUnit, Event) 
	pUnit:CastSpell(7165) 
end

function SaltspittlePuddlejumper_RushingCharge(pUnit, Event) 
	pUnit:CastSpell(6268) 
end

function SaltspittlePuddlejumper_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SaltspittlePuddlejumper_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(3737, 1, "SaltspittlePuddlejumper_OnCombat")
RegisterUnitEvent(3737, 2, "SaltspittlePuddlejumper_OnLeaveCombat")
RegisterUnitEvent(3737, 4, "SaltspittlePuddlejumper_OnDied")