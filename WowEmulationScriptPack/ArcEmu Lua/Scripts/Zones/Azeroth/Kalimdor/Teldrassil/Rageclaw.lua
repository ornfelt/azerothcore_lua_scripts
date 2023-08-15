--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


function Rageclaw_OnCombat(Unit, Event)
	Unit:RegisterEvent("Rageclaw_BearForm", 1000, 1)
	Unit:RegisterEvent("Rageclaw_Maul", 4000, 0)
end

function Rageclaw_BearForm(Unit, Event) 
	Unit:CastSpell(7090) 
end

function Rageclaw_Maul(Unit, Event) 
	Unit:FullCastSpellOnTarget(12161, 	Unit:GetMainTank()) 
end

function Rageclaw_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Rageclaw_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Rageclaw_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(7318, 1, "Rageclaw_OnCombat")
RegisterUnitEvent(7318, 2, "Rageclaw_OnLeaveCombat")
RegisterUnitEvent(7318, 3, "Rageclaw_OnKilledTarget")
RegisterUnitEvent(7318, 4, "Rageclaw_OnDied")