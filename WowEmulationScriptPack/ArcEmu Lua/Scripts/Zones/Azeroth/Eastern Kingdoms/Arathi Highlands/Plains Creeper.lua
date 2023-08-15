--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function PlainsCreeper_OnEnterCombat(Unit,Event)
local plr = Unit:GetMainTank()
	Unit:RegisterEvent("EncasingWebs", 18000, 0)
	Unit:RegisterEvent("Poison", 5000, 1)
end

function EncasingWebs(Unit,Event)
	Unit:FullCastSpellOnTarget(4962,plr)
end

function Poison(Unit,Event)
	Unit:FullCastSpellOnTarget(744,plr)
end

function PlainsCreeper_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function PlainsCreeper_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2563,1,"PlainsCreeper_OnEnterCombat")
RegisterUnitEvent(2563,2,"PlainsCreeper_OnLeaveCombat")
RegisterUnitEvent(2563,4,"PlainsCreeper_OnDied")