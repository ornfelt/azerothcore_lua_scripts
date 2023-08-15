--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function MesaBuzzard_OnCombat(Unit,Event)
local plr = Unit:GetMainTank()
local choice = math.random(1,2)
	if (choice == 1) then 	
		Unit:FullCastSpellOnTarget(8139,plr)
	elseif (choice == 2) then
		return
	end
end

RegisterUnitEvent(2579,1,"MesaBuzzard_OnCombat")