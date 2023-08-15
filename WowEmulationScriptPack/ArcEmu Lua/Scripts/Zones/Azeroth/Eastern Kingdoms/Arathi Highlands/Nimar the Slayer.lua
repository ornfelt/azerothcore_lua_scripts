--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function NimarTheSlayer_OnEnterCombat(Unit,Event)
local plr = Unit:GetMainTank()
	Unit:RegisterEvent("Cleave", 5000, 0)
	Unit:RegisterEvent("Whirlwind", 14000, 0)
end

function Cleave(Unit,Event)
	Unit:FullCastSpellOnTarget(845,plr)
end

function Whirlwind(Unit,Event)
	Unit:FullCastSpellOnTarget(15576,plr)
	Unit:CastSpellOnTarget(17207,plr)
end

function NimarTheSlayer_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function NimarTheSlayer_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2606,1,"NimarTheSlayer_OnEnterCombat")
RegisterUnitEvent(2606,2,"NimarTheSlayer_OnLeaveCombat")
RegisterUnitEvent(2606,4,"NimarTheSlayer_OnDied")