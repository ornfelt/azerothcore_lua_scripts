--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]

function WitherbarkHeadhunter_OnEnterCombat(Unit,Event)
local plr = Unit:GetMainTank()
local choice = math.random(1,2)
	if (choice == 1) then
		Unit:FullCastSpellOnTarget(4974,plr)
		Unit:RegisterEvent("Execute", 1000, 1)
		Unit:RegisterEvent("Net", 8000, 0)
	elseif (choice == 2) then
		Unit:RegisterEvent("Execute", 1000, 1)
		Unit:RegisterEvent("Net", 8000, 0)
	end
end

function Execute(Unit,Event)
	if plr:GetHealthPct() == 20 then
		Unit:FullCastSpellOnTarget(7160,plr)
	end
end

function Net(Unit,Event)
	Unit:FullCastSpellOnTarget(6533,plr)
end

function WitherbarkHeadhunter_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end
function WitherbarkHeadhunter_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(2605,1,"WitherbarkHeadhunter_OnEnterCombat")
RegisterUnitEvent(2605,2,"WitherbarkHeadhunter_OnLeaveCombat")
RegisterUnitEvent(2605,4,"WitherbarkHeadhunter_OnDied")