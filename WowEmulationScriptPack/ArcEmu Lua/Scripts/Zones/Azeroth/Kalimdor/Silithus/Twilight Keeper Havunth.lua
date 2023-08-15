--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function TwilightKeeperHavunth_OnCombat(Unit, Event)
	Unit:RegisterEvent("TwilightKeeperHavunth_FireBlast", 6000, 0)
	Unit:RegisterEvent("TwilightKeeperHavunth_FireNova", 8000, 0)
end

function TwilightKeeperHavunth_FireBlast(Unit, Event) 
	Unit:FullCastSpellOnTarget(13339, 	Unit:GetMainTank()) 
end

function TwilightKeeperHavunth_FireNova(Unit, Event) 
	Unit:CastSpell(17366) 
end

function TwilightKeeperHavunth_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function TwilightKeeperHavunth_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function TwilightKeeperHavunth_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(11804, 1, "TwilightKeeperHavunth_OnCombat")
RegisterUnitEvent(11804, 2, "TwilightKeeperHavunth_OnLeaveCombat")
RegisterUnitEvent(11804, 3, "TwilightKeeperHavunth_OnKilledTarget")
RegisterUnitEvent(11804, 4, "TwilightKeeperHavunth_OnDied")