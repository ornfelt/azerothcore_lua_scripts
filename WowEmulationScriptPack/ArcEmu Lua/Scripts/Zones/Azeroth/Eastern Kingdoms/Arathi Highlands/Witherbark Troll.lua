--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WitherbarkTroll_OnEnterCombat(Unit,Event)
local choice = math.random(1,2)
local tank = Unit:GetMainTank()
	if (choice == 1) then
		Unit:FullCastSpellOnTarget(4974,tank)
	elseif (choice == 2) then
		return
	end
end

RegisterUnitEvent(4974,1,"WitherbarkTroll_OnEnterCombat")