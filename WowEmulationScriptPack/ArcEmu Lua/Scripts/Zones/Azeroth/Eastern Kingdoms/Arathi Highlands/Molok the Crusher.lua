--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MoloktheCrusher_OnEnterCombat(Unit,Event)
local plr = Unit:GetMainTank()
	Unit:RegisterEvent("Backhand", 16000, 0)
end

function Backhand(Unit,Event)
	Unit:FullCastSpellOnTarget(6253,plr)
end

function MoloktheCrusher_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function MoloktheCrusher_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2604,1,"MoloktheCrusher_OnEnterCombat")
RegisterUnitEvent(2604,2,"MoloktheCrusher_OnLeaveCombat")
RegisterUnitEvent(2604,4,"MoloktheCrusher_OnDied")