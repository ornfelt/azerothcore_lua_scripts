--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SwinegartSpearhide_OnCombat(Unit, Event)
	Unit:RegisterEvent("SwinegartSpearhide_PierceArmor", 10000, 0)
end

function SwinegartSpearhide_PierceArmor(Unit, Event) 
	Unit:FullCastSpellOnTarget(6016, 	Unit:GetMainTank()) 
end

function SwinegartSpearhide_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SwinegartSpearhide_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SwinegartSpearhide_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5864, 1, "SwinegartSpearhide_OnCombat")
RegisterUnitEvent(5864, 2, "SwinegartSpearhide_OnLeaveCombat")
RegisterUnitEvent(5864, 3, "SwinegartSpearhide_OnKilledTarget")
RegisterUnitEvent(5864, 4, "SwinegartSpearhide_OnDied")