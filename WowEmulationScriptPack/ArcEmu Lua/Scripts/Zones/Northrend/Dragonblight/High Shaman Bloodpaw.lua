--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function HighShamanBloodpaw_OnCombat(Unit, Event)
Unit:RegisterEvent("HighShamanBloodpaw_Bloodlust", 11000, 0)
Unit:RegisterEvent("HighShamanBloodpaw_ChainLightning", 10000, 0)
Unit:RegisterEvent("HighShamanBloodpaw_FrostShock", 6000, 0)
Unit:RegisterEvent("HighShamanBloodpaw_LightningBolt", 8000, 0)
end

function HighShamanBloodpaw_Bloodlust(Unit, Event) 
Unit:CastSpell(28902) 
end

function HighShamanBloodpaw_ChainLightning(Unit, Event) 
Unit:FullCastSpellOnTarget(22355, Unit:GetMainTank()) 
end

function HighShamanBloodpaw_FrostShock(Unit, Event) 
Unit:FullCastSpellOnTarget(19133, Unit:GetMainTank()) 
end

function HighShamanBloodpaw_LightningBolt(Unit, Event) 
Unit:FullCastSpellOnTarget(22414, Unit:GetMainTank()) 
end

function HighShamanBloodpaw_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function HighShamanBloodpaw_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function HighShamanBloodpaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(27762, 1, "HighShamanBloodpaw_OnCombat")
RegisterUnitEvent(27762, 2, "HighShamanBloodpaw_OnLeaveCombat")
RegisterUnitEvent(27762, 3, "HighShamanBloodpaw_OnKilledTarget")
RegisterUnitEvent(27762, 4, "HighShamanBloodpaw_OnDied")