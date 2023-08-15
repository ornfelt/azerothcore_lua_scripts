--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WastewanderShadowMage_OnCombat(Unit, Event)
	Unit:RegisterEvent("WastewanderShadowMage_Shadowbolt", 8000, 0)
	Unit:RegisterEvent("WastewanderShadowMage_Immolate", 10000, 2)
end

function WastewanderShadowMage_Shadowbolt(Unit, Event) 
	Unit:FullCastSpellOnTarget(20825, 	Unit:GetMainTank()) 
end

function WastewanderShadowMage_Immolate(Unit, Event) 
	Unit:FullCastSpellOnTarget(20826, 	Unit:GetMainTank()) 
end

function WastewanderShadowMage_OnLeaveCombat(Unit, Event) 
	Unit:RemoveEvents() 
end

function WastewanderShadowMage_OnDied(Unit, Event) 
	Unit:RemoveEvents()
end

function WastewanderShadowMage_OnKilledTarget(Unit, Event) 
end

RegisterUnitEvent(5617, 1, "WastewanderShadowMage_OnCombat")
RegisterUnitEvent(5617, 2, "WastewanderShadowMage_OnLeaveCombat")
RegisterUnitEvent(5617, 3, "WastewanderShadowMage_OnKilledTarget")
RegisterUnitEvent(5617, 4, "WastewanderShadowMage_OnDied")