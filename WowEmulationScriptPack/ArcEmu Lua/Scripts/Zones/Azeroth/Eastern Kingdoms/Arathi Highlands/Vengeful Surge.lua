--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function VengefulSurge_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("FrostNova", 14000, 1)
end

function FrostNova(Unit,Event)
local plr = Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(14907,plr)
end

function VengefulSurge_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function VengefulSurge_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2776,1,"VengefulSurge_OnEnterCombat")
RegisterUnitEvent(2776,2,"VengefulSurge_OnLeaveCombat")
RegisterUnitEvent(2776,4,"VengefulSurge_OnDied")