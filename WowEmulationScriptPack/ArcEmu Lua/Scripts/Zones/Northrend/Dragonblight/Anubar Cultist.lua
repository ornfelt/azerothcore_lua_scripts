--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function AnubarCultist_OnCombat(Unit, Event)
Unit:RegisterEvent("AnubarCultist_Empower", 2000, 1)
Unit:RegisterEvent("AnubarCultist_ShadowBolt", 8000, 0)
Unit:RegisterEvent("AnubarCultist_Zeal", 3000, 1)
end

function AnubarCultist_Empower(Unit, Event) 
Unit:CastSpell(47257) 
end

function AnubarCultist_ShadowBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(9613, Unit:GetMainTank()) 
end

function AnubarCultist_Zeal(Unit, Event) 
Unit:CastSpell(51605) 
end

function AnubarCultist_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function AnubarCultist_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function AnubarCultist_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26319, 1, "AnubarCultist_OnCombat")
RegisterUnitEvent(26319, 2, "AnubarCultist_OnLeaveCombat")
RegisterUnitEvent(26319, 3, "AnubarCultist_OnKilledTarget")
RegisterUnitEvent(26319, 4, "AnubarCultist_OnDied")