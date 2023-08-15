--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function BaeldunRifleman_OnCombat(Unit, Event)
	Unit:RegisterEvent("BaeldunRifleman_Shoot", 6000, 0)
end

function BaeldunRifleman_Shoot(Unit, Event) 
	Unit:FullCastSpellOnTarget(6660, 	Unit:GetMainTank()) 
end

function BaeldunRifleman_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function BaeldunRifleman_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function BaeldunRifleman_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3377, 1, "BaeldunRifleman_OnCombat")
RegisterUnitEvent(3377, 2, "BaeldunRifleman_OnLeaveCombat")
RegisterUnitEvent(3377, 3, "BaeldunRifleman_OnKilledTarget")
RegisterUnitEvent(3377, 4, "BaeldunRifleman_OnDied")