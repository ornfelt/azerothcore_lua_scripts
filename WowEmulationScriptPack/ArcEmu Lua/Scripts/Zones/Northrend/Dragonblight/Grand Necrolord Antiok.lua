--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GrandNecrolordAntiok_OnCombat(Unit, Event)
Unit:RegisterEvent("GrandNecrolordAntiok_ScreamofChaos", 15000, 1)
Unit:RegisterEvent("GrandNecrolordAntiok_ShadowBolt", 8000, 0)
Unit:RegisterEvent("GrandNecrolordAntiok_ShroudofLightning", 28000, 1)
end

function GrandNecrolordAntiok_ScreamofChaos(Unit, Event) 
Unit:CastSpell(50497) 
end

function GrandNecrolordAntiok_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(55984, Unit:GetMainTank()) 
end

function GrandNecrolordAntiok_ShroudofLightning(Unit, Event) 
Unit:CastSpell(50494) 
end

function GrandNecrolordAntiok_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function GrandNecrolordAntiok_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function GrandNecrolordAntiok_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(28006, 1, "GrandNecrolordAntiok_OnCombat")
RegisterUnitEvent(28006, 2, "GrandNecrolordAntiok_OnLeaveCombat")
RegisterUnitEvent(28006, 3, "GrandNecrolordAntiok_OnKilledTarget")
RegisterUnitEvent(28006, 4, "GrandNecrolordAntiok_OnDied")