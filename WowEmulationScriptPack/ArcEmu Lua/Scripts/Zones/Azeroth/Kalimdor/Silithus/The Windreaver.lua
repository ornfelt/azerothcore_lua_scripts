--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function TheWindreaver_OnCombat(Unit, Event)
	Unit:RegisterEvent("TheWindreaver_ChainLightning", 8000, 0)
	Unit:RegisterEvent("TheWindreaver_EnvelopingWinds", 12000, 0)
	Unit:RegisterEvent("TheWindreaver_LightningCloud", 6000, 0)
	Unit:RegisterEvent("TheWindreaver_Shock", 4000, 0)
end

function TheWindreaver_ChainLightning(Unit, Event) 
	Unit:FullCastSpellOnTarget(23106, 	Unit:GetMainTank()) 
end

function TheWindreaver_EnvelopingWinds(Unit, Event) 
	Unit:FullCastSpellOnTarget(23103, 	Unit:GetRandomPlayer(0)) 
end

function TheWindreaver_LightningCloud(Unit, Event) 
	Unit:CastSpell(23105) 
end

function TheWindreaver_Shock(Unit, Event) 
	Unit:FullCastSpellOnTarget(23104, 	Unit:GetMainTank()) 
end

function TheWindreaver_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TheWindreaver_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TheWindreaver_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(14454, 1, "TheWindreaver_OnCombat")
RegisterUnitEvent(14454, 2, "TheWindreaver_OnLeaveCombat")
RegisterUnitEvent(14454, 3, "TheWindreaver_OnKilledTarget")
RegisterUnitEvent(14454, 4, "TheWindreaver_OnDied")