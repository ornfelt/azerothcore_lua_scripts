--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function Gazzuz_OnCombat(Unit, Event)
	Unit:RegisterEvent("Gazzuz_SummonVoidwalker", 1000, 1)
	Unit:RegisterEvent("Gazzuz_DemonSkin", 2000, 1)
	Unit:RegisterEvent("Gazzuz_Corruption", 4000, 1)
	Unit:RegisterEvent("Gazzuz_ShadowBolt", 8000, 0)
end

function Gazzuz_SummonVoidwalker(Unit, Event) 
	Unit:CastSpell(12746) 
end

function Gazzuz_DemonSkin(Unit, Event) 
	Unit:CastSpell(20798) 
end

function Gazzuz_Corruption(Unit, Event) 
	Unit:FullCastSpellOnTarget(172, 	Unit:GetMainTank()) 
end

function Gazzuz_ShadowBolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(20791, 	Unit:GetMainTank()) 
end

function Gazzuz_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function Gazzuz_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function Gazzuz_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(3204, 1, "Gazzuz_OnCombat")
RegisterUnitEvent(3204, 2, "Gazzuz_OnLeaveCombat")
RegisterUnitEvent(3204, 3, "Gazzuz_OnKilledTarget")
RegisterUnitEvent(3204, 4, "Gazzuz_OnDied")