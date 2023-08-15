--[[********************************
*                                                            *
* The LUA++ Scripting Project        *
*                                                            *
********************************

This software is provided as free and open source by the
staff of The LUA++ Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- LUA++ staff, March 26, 2008. ]]
--[[
	GARR's AI
	]]

function Garr_OnCombat(Unit,event)
	setvars(Unit, {Garr = Unit})
	local tbl = Unit:GetInRangeFriends()
	local mt = Unit:GetClosestPlayer()
	for k,v in pairs(tbl) do
		if (v:GetEntry() == 12099) then
			if (v:IsCreatureMoving() == false) then
			v:ModifyWalkSpeed(8)
			v:MoveTo(mt:GetX(), mt:GetY(), mt:GetZ(), mt:GetO())
			Unit:RegisterEvent("Garr_Shackles", 21000, 0)
			Unit:RegisterEvent("Garr_AntiMagicPulse", 10000, 0)
			end
		end
	end
end

function Garr_OnWipe(Unit,event)
	if (Unit:IsAlive() == true) then
		Unit:SpawnCreature(12099, 691.497, -508.682, -214.613, 4.97918, 14, 0)
		Unit:SpawnCreature(12099, 698.169, -504.932, -214.626, 5.03141, 14, 0)
		Unit:SpawnCreature(12099, 700.19, -497.552, -214.396, 5.0165, 14, 0)
		Unit:SpawnCreature(12099, 696.475, -490.809, -213.817, 4.74342, 14, 0)
		Unit:SpawnCreature(12099, 689.116, -488.824, -213.552, 4.77706, 14, 0)
		Unit:SpawnCreature(12099, 682.444, -492.575, -213.484, 4.95256, 14, 0)
		Unit:SpawnCreature(12099, 680.378, -499.944, -213.925, 4.92875, 14, 0)
		Unit:SpawnCreature(12099, 684.128, -504.616, -214.439, 5.0414, 14, 0)
		Unit:RemoveEvents()
	else
		Unit:RemoveEvents()
	end
end

function Garr_OnDied(Unit,event)
	Unit:RemoveEvents()
end

function Garr_Shackles(Unit,event)
	Unit:CastSpell(19496)
end

function Garr_AntiMagicPulse(Unit,event)
	Unit:CastSpell(19492)
end

RegisterUnitEvent(12057,1,"Garr_OnCombat")
RegisterUnitEvent(12057,2,"Garr_OnWipe")
RegisterUnitEvent(12057,4,"Garr_OnDied")

--[[
	FIRESWORM
	]]

function Firesworm_OnCombat(Unit,event)
	Unit:RegisterEvent("Separation_Anxiety", 2000, 0)
	local tbl = Unit:GetInRangeFriends()
	local mt = Unit:GetClosestPlayer()
	for k,v in pairs(tbl) do
		if (v:GetEntry() == 12099) then
			if (v:IsCreatureMoving() == false) then
			v:ModifyWalkSpeed(8)
			v:MoveTo(mt:GetX(), mt:GetY(), mt:GetZ(), mt:GetO())
			end
		end
	end
	for k,v in pairs(tbl) do
		if (v:GetEntry() == 12057) then
			if (v:IsCreatureMoving() == false) then
			v:ModifyWalkSpeed(8)
			v:MoveTo(mt:GetX(), mt:GetY(), mt:GetZ(), mt:GetO())
			end
		end
	end
end

function Firesworm_OnWipe(Unit,event)
	Unit:RemoveEvents()
	Unit:Despawn(1000, 0)
end

function Firesworm_OnDied(Unit,event)
	Unit:RemoveEvents()
	Unit:CastSpell(19497)
end

function Separation_Anxiety(Unit,event)
	local args = getvars(Unit)
	if (args.Garr ~= nil) then
		local dist = Unit:GetDistance(args.Garr)
		if (dist >= 2500) then
			Unit:CastSpell(23492)
		end
	end
end

RegisterUnitEvent(12099,1,"Firesworm_OnCombat")
RegisterUnitEvent(12099,2,"Firesworm_OnWipe")
RegisterUnitEvent(12099,4,"Firesworm_OnDied")