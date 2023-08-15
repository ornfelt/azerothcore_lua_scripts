--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ElderMysticRazorsnout_OnCombat(Unit, Event)
	Unit:RegisterEvent("ElderMysticRazorsnout_EarthbindTotem", 4000, 1)
	Unit:RegisterEvent("ElderMysticRazorsnout_HealingWave", 12000, 0)
end

function ElderMysticRazorsnout_EarthbindTotem(Unit, Event) 
	Unit:CastSpell(2484) 
end

function ElderMysticRazorsnout_HealingWave(Unit, Event) 
	Unit:CastSpell(547) 
end

function ElderMysticRazorsnout_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function ElderMysticRazorsnout_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function ElderMysticRazorsnout_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3270, 1, "ElderMysticRazorsnout_OnCombat")
RegisterUnitEvent(3270, 2, "ElderMysticRazorsnout_OnLeaveCombat")
RegisterUnitEvent(3270, 3, "ElderMysticRazorsnout_OnKilledTarget")
RegisterUnitEvent(3270, 4, "ElderMysticRazorsnout_OnDied")