--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function FrostpawTrapper_OnCombat(Unit, Event)
Unit:RegisterEvent("FrostpawTrapper_AimedShot", 9000, 0)
Unit:RegisterEvent("FrostpawTrapper_Shoot", 6000, 0)
Unit:RegisterEvent("FrostpawTrapper_WingClip", 12000, 0)
end

function FrostpawTrapper_AimedShot(Unit, Event) 
Unit:FullCastSpellOnTarget(30614, Unit:GetMainTank()) 
end

function FrostpawTrapper_Shoot(Unit, Event) 
Unit:FullCastSpellOnTarget(6660, Unit:GetMainTank()) 
end

function FrostpawTrapper_WingClip(Unit, Event) 
Unit:FullCastSpellOnTarget(32908, Unit:GetMainTank()) 
end

function FrostpawTrapper_OnLeaveCombat(Unit, Event) 
Unit:RemoveEvents() 
end

function FrostpawTrapper_OnDied(Unit, Event) 
Unit:RemoveEvents()
end

function FrostpawTrapper_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26434, 1, "FrostpawTrapper_OnCombat")
RegisterUnitEvent(26434, 2, "FrostpawTrapper_OnLeaveCombat")
RegisterUnitEvent(26434, 3, "FrostpawTrapper_OnKilledTarget")
RegisterUnitEvent(26434, 4, "FrostpawTrapper_OnDied")