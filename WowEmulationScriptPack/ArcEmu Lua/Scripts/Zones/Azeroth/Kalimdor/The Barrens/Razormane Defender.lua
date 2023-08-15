--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function RazormaneDefender_OnCombat(Unit, Event)
	Unit:RegisterEvent("RazormaneDefender_BattleStance", 1000, 1)
	Unit:RegisterEvent("RazormaneDefender_DemoralizingShout", 4000, 1)
	Unit:RegisterEvent("RazormaneDefender_HeroicStrike", 6000, 0)
end

function RazormaneDefender_BattleStance(Unit, Event) 
	Unit:CastSpell(7165) 
end

function RazormaneDefender_DemoralizingShout(Unit, Event) 
	Unit:CastSpell(13730) 
end

function RazormaneDefender_HeroicStrike(Unit, Event) 
	Unit:FullCastSpellOnTarget(25710, 	Unit:GetMainTank()) 
end

function RazormaneDefender_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function RazormaneDefender_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function RazormaneDefender_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3266, 1, "RazormaneDefender_OnCombat")
RegisterUnitEvent(3266, 2, "RazormaneDefender_OnLeaveCombat")
RegisterUnitEvent(3266, 3, "RazormaneDefender_OnKilledTarget")
RegisterUnitEvent(3266, 4, "RazormaneDefender_OnDied")