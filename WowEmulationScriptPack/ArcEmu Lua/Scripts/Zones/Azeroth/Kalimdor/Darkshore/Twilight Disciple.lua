--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TwilightDisciple_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightDisciple_Heal", 13000, 0)
	Unit:RegisterEvent("TwilightDisciple_Renew", 8000, 0)
end

function TwilightDisciple_Heal(pUnit, Event) 
	pUnit:CastSpell(2054) 
end

function TwilightDisciple_Renew(pUnit, Event) 
	pUnit:CastSpell(6074) 
end

function TwilightDisciple_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightDisciple_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

RegisterUnitEvent(2338, 1, "TwilightDisciple_OnCombat")
RegisterUnitEvent(2338, 2, "TwilightDisciple_OnLeaveCombat")
RegisterUnitEvent(2338, 4, "TwilightDisciple_OnDied")