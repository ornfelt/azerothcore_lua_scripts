--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function GlacialLieutenant_OnCombat(Unit, Event)
	Unit:RegisterEvent("GlacialLieutenant_FrostNova", 8000, 0)
	Unit:RegisterEvent("GlacialLieutenant_FrostShock", 6000, 0)
end

function GlacialLieutenant_FrostNova(Unit, Event) 
	Unit:CastSpell(14907) 
end

function GlacialLieutenant_FrostShock(Unit, Event) 
	Unit:FullCastSpellOnTarget(12548, 	Unit:GetMainTank()) 
end

function GlacialLieutenant_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function GlacialLieutenant_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function GlacialLieutenant_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(26215, 1, "GlacialLieutenant_OnCombat")
RegisterUnitEvent(26215, 2, "GlacialLieutenant_OnLeaveCombat")
RegisterUnitEvent(26215, 3, "GlacialLieutenant_OnKilledTarget")
RegisterUnitEvent(26215, 4, "GlacialLieutenant_OnDied")