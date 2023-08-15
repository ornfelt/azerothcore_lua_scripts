--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function EnkilahNecromancer_OnCombat(Unit, Event)
Unit:RegisterEvent("EnkilahNecromancer_Corruption", 10000, 0)
Unit:RegisterEvent("EnkilahNecromancer_ShadowBolt", 7000, 0)
end

function EnkilahNecromancer_Corruption(Unit, Event) 
Unit:FullCastSpellOnTarget(32063, Unit:GetMainTank()) 
end

function EnkilahNecromancer_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function EnkilahNecromancer_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function EnkilahNecromancer_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function EnkilahNecromancer_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25378, 1, "EnkilahNecromancer_OnCombat")
RegisterUnitEvent(25378, 2, "EnkilahNecromancer_OnLeaveCombat")
RegisterUnitEvent(25378, 3, "EnkilahNecromancer_OnKilledTarget")
RegisterUnitEvent(25378, 4, "EnkilahNecromancer_OnDied")