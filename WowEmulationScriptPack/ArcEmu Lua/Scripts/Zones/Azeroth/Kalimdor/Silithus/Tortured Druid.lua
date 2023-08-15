--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TorturedDruid_OnCombat(Unit, Event)
	Unit:RegisterEvent("TorturedDruid_HealingTouch", 15000, 0)
	Unit:RegisterEvent("TorturedDruid_Moonfire", 6000, 0)
	Unit:RegisterEvent("TorturedDruid_SummonHiveAshiDrones", 2000, 1)
end

function TorturedDruid_HealingTouch(Unit, Event) 
	Unit:CastSpell(23381) 
end

function TorturedDruid_Moonfire(Unit, Event) 
	Unit:FullCastSpellOnTarget(23380, 	Unit:GetMainTank()) 
end

function TorturedDruid_SummonHiveAshiDrones(Unit, Event) 
	Unit:CastSpell(21327) 
end

function TorturedDruid_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TorturedDruid_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TorturedDruid_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(12178, 1, "TorturedDruid_OnCombat")
RegisterUnitEvent(12178, 2, "TorturedDruid_OnLeaveCombat")
RegisterUnitEvent(12178, 3, "TorturedDruid_OnKilledTarget")
RegisterUnitEvent(12178, 4, "TorturedDruid_OnDied")