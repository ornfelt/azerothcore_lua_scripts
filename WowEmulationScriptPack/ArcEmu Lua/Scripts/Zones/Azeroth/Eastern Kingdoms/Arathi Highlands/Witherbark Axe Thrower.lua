--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WitherbarkAxeThrower_OnEnterCombat(Unit,Event)
local choice = math.random(1,2)
local plr = Unit:GetMainTank()
	if (choice == 1) then
		Unit:FullCastSpellOnTarget(4974,plr)
		Unit:FullCastSpellOnTarget(10277,plr)
	elseif (choice == 2) then
		Unit:FullCastSpellOnTarget(10277,plr)
	end
end

RegisterUnitEvent(2554,1,"WitherbarkAxeThrower_OnEnterCombat")