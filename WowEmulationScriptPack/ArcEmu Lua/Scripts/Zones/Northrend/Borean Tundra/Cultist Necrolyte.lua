--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function CultistNecrolyte_OnCombat(Unit, Event)
Unit:RegisterEvent("CultistNecrolyte_CurseofAgony", 10000, 0)
Unit:RegisterEvent("CultistNecrolyte_ShadowBolt", 7000, 0)
end

function CultistNecrolyte_CurseofAgony(Unit, Event) 
Unit:FullCastSpellOnTarget(18266, Unit:GetMainTank()) 
end

function CultistNecrolyte_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function CultistNecrolyte_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function CultistNecrolyte_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function CultistNecrolyte_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25651, 1, "CultistNecrolyte_OnCombat")
RegisterUnitEvent(25651, 2, "CultistNecrolyte_OnLeaveCombat")
RegisterUnitEvent(25651, 3, "CultistNecrolyte_OnKilledTarget")
RegisterUnitEvent(25651, 4, "CultistNecrolyte_OnDied")