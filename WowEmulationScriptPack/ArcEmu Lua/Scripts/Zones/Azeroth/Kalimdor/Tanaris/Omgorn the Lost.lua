--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]
function OmgorntheLost_OnCombat(Unit, Event)
	Unit:RegisterEvent("OmgorntheLost_MortalStrike", 6000, 0)
	Unit:RegisterEvent("OmgorntheLost_Enrage", 12000, 0)
end

function OmgorntheLost_MortalStrike(Unit, Event) 
	Unit:FullCastSpellOnTarget(16856, 	Unit:GetMainTank()) 
end

function OmgorntheLost_Enrage(Unit, Event)
if 	Unit:GetHealthPct() < 25 then
	Unit:CastSpell(8599) 
end
end

function OmgorntheLost_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function OmgorntheLost_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function OmgorntheLost_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(8201, 1, "OmgorntheLost_OnCombat")
RegisterUnitEvent(8201, 2, "OmgorntheLost_OnLeaveCombat")
RegisterUnitEvent(8201, 3, "OmgorntheLost_OnKilledTarget")
RegisterUnitEvent(8201, 4, "OmgorntheLost_OnDied")