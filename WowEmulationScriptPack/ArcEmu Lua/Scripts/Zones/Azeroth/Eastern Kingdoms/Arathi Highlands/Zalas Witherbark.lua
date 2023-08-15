--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function ZalasWitherbark_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("ShadowboltVolley", 3000, 0)
end

function ShadowboltVolley(Unit,Event)
local plr = Unit:GetClosestPlayer()
	if (plr ~= nil) then
		return
	else
		Unit:FullCastSpellOnTarget(9081,plr)
	end
end

function ZalasWitherbark_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function ZalasWitherbark_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2605,1,"ZalasWitherbark_OnEnterCombat")
RegisterUnitEvent(2605,2,"ZalasWitherbark_OnLeaveCombat")
RegisterUnitEvent(2605,4,"ZalasWitherbark_OnDied")