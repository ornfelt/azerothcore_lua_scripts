--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]


local Range = 15

function Checker_OnSpawn(unit)
	unit:RegisterEvent(Checker_RangeCheck, 1000, 0);
end

function Checker_RangeCheck(unit)
	local plrs = unit:GetInRangePlayers()
	if plrs ~= nil then
		for _, v in pairs(plrs) do
			if v:IsMounted() and unit:GetDistance(v) <= Range then
				v:Dismount()
			end
		end
	end
end

RegisterUnitEvent(900004, 18, Checker_OnSpawn)