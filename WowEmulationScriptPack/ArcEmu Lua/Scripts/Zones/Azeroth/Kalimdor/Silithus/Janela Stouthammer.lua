--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function JanelaStouthammer_OnCombat(Unit, Event)
	Unit:RegisterEvent("JanelaStouthammer_CrusaderStrike", 8000, 0)
	Unit:RegisterEvent("JanelaStouthammer_HolyLight", 12000, 0)
end

function JanelaStouthammer_CrusaderStrike(Unit, Event) 
	Unit:FullCastSpellOnTarget(14518, 	Unit:GetMainTank()) 
end

function JanelaStouthammer_HolyLight(Unit, Event) 
	Unit:CastSpell(25263) 
end

function JanelaStouthammer_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function JanelaStouthammer_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function JanelaStouthammer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(15443, 1, "JanelaStouthammer_OnCombat")
RegisterUnitEvent(15443, 2, "JanelaStouthammer_OnLeaveCombat")
RegisterUnitEvent(15443, 3, "JanelaStouthammer_OnKilledTarget")
RegisterUnitEvent(15443, 4, "JanelaStouthammer_OnDied")