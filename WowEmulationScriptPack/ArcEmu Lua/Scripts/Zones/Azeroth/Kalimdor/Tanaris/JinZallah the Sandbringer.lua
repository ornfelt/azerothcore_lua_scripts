--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function JinZallahtheSandbringer_OnCombat(Unit, Event)
	Unit:RegisterEvent("JinZallahtheSandbringer_DustCloud", 15000, 0)
	Unit:RegisterEvent("JinZallahtheSandbringer_LightningBolt", 8000, 0)
	Unit:RegisterEvent("JinZallahtheSandbringer_SandStorms", 10000, 1)
end

function JinZallahtheSandbringer_DustCloud(Unit, Event) 
	Unit:CastSpell(7272) 
end

function JinZallahtheSandbringer_LightningBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(20824, 	Unit:GetMainTank()) 
end

function JinZallahtheSandbringer_SandStorms(Unit, Event) 
	Unit:CastSpell(10132) 
end

function JinZallahtheSandbringer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function JinZallahtheSandbringer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function JinZallahtheSandbringer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8200, 1, "JinZallahtheSandbringer_OnCombat")
RegisterUnitEvent(8200, 2, "JinZallahtheSandbringer_OnLeaveCombat")
RegisterUnitEvent(8200, 3, "JinZallahtheSandbringer_OnKilledTarget")
RegisterUnitEvent(8200, 4, "JinZallahtheSandbringer_OnDied")