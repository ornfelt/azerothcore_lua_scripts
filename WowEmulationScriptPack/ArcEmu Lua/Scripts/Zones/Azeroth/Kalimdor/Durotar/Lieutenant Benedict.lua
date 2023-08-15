--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function LieutenantBenedict_OnCombat(Unit, Event)
	Unit:RegisterEvent("LieutenantBenedict_DefensiveStance", 1000, 1)
	Unit:RegisterEvent("LieutenantBenedict_ImprovedBlocking", 6000, 0)
	Unit:RegisterEvent("LieutenantBenedict_ShieldBash", 8000, 0)
end

function LieutenantBenedict_DefensiveStance(Unit, Event) 
	Unit:CastSpell(7164) 
end

function LieutenantBenedict_ImprovedBlocking(Unit, Event) 
	Unit:CastSpell(3248) 
end

function LieutenantBenedict_ShieldBash(Unit, Event) 
	Unit:FullCastSpellOnTarget(72, 	Unit:GetMainTank()) 
end

function LieutenantBenedict_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function LieutenantBenedict_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function LieutenantBenedict_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3192, 1, "LieutenantBenedict_OnCombat")
RegisterUnitEvent(3192, 2, "LieutenantBenedict_OnLeaveCombat")
RegisterUnitEvent(3192, 3, "LieutenantBenedict_OnKilledTarget")
RegisterUnitEvent(3192, 4, "LieutenantBenedict_OnDied")