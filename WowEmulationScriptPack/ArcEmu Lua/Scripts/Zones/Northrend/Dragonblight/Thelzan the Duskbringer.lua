--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function ThelzantheDuskbringer_OnCombat(Unit, Event)
Unit:RegisterEvent("ThelzantheDuskbringer_ChainsofIce", 16000, 0)
Unit:RegisterEvent("ThelzantheDuskbringer_FrostArmor", 11000, 0)
Unit:RegisterEvent("ThelzantheDuskbringer_Frostbolt", 7000, 0)
Unit:RegisterEvent("ThelzantheDuskbringer_FrostboltVolley", 12000, 0)
Unit:RegisterEvent("ThelzantheDuskbringer_ScreamofChaos", 20000, 0)
end

function ThelzantheDuskbringer_ChainsofIce(Unit, Event) 
Unit:FullCastSpellOnTarget(39268, Unit:GetRandomPlayer(0)) 
end

function ThelzantheDuskbringer_FrostArmor(Unit, Event) 
Unit:CastSpell(31256) 
end

function ThelzantheDuskbringer_Frostbolt(Unit, Event) 
Unit:FullCastSpellOnTarget(42719, Unit:GetMainTank()) 
end

function ThelzantheDuskbringer_FrostboltVolley(Unit, Event) 
Unit:CastSpell(22643) 
end

function ThelzantheDuskbringer_ScreamofChaos(Unit, Event) 
Unit:CastSpell(50497) 
end

function ThelzantheDuskbringer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function ThelzantheDuskbringer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function ThelzantheDuskbringer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27383, 1, "ThelzantheDuskbringer_OnCombat")
RegisterUnitEvent(27383, 2, "ThelzantheDuskbringer_OnLeaveCombat")
RegisterUnitEvent(27383, 3, "ThelzantheDuskbringer_OnKilledTarget")
RegisterUnitEvent(27383, 4, "ThelzantheDuskbringer_OnDied")