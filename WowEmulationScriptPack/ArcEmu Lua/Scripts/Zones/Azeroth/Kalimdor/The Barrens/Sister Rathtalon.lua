--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function SisterRathtalon_OnCombat(Unit, Event)
	Unit:RegisterEvent("SisterRathtalon_EnvelopingWinds", 10000, 0)
	Unit:RegisterEvent("SisterRathtalon_GustofWind", 14000, 0)
	Unit:RegisterEvent("SisterRathtalon_LightningCloud", 3000, 1)
end

function SisterRathtalon_EnvelopingWinds(Unit, Event) 
	Unit:FullCastSpellOnTarget(6728, 	Unit:GetMainTank()) 
end

function SisterRathtalon_GustofWind(Unit, Event) 
	Unit:CastSpell(6982) 
end

function SisterRathtalon_LightningCloud(Unit, Event) 
	Unit:CastSpell(6535) 
end

function SisterRathtalon_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function SisterRathtalon_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function SisterRathtalon_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5830, 1, "SisterRathtalon_OnCombat")
RegisterUnitEvent(5830, 2, "SisterRathtalon_OnLeaveCombat")
RegisterUnitEvent(5830, 3, "SisterRathtalon_OnKilledTarget")
RegisterUnitEvent(5830, 4, "SisterRathtalon_OnDied")