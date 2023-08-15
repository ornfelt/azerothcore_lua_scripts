--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Kaganishu_OnCombat(Unit, Event)
Unit:RegisterEvent("Kaganishu_BlastWave", 9000, 0)
Unit:RegisterEvent("Kaganishu_FireNovaTotem", 2000, 1)
Unit:RegisterEvent("Kaganishu_Fireball", 7000, 0)
end

function Kaganishu_BlastWave(Unit, Event) 
Unit:CastSpell(15744) 
end

function Kaganishu_FireNovaTotem(Unit, Event) 
Unit:CastSpell(44257) 
end

function Kaganishu_Fireball(Unit, Event) 
Unit:FullCastSpellOnTarget(19816, Unit:GetMainTank()) 
end

function Kaganishu_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function Kaganishu_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function Kaganishu_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(25427, 1, "Kaganishu_OnCombat")
RegisterUnitEvent(25427, 2, "Kaganishu_OnLeaveCombat")
RegisterUnitEvent(25427, 3, "Kaganishu_OnKilledTarget")
RegisterUnitEvent(25427, 4, "Kaganishu_OnDied")