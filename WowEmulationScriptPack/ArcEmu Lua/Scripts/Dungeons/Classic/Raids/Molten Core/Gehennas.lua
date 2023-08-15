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
	GEHENNAS AI
	]]
math.randomseed(os.time())


function Gehennas_OnCombat(Unit,event)
	Unit:RegisterEvent("GehennasSpells", 13000, 0)
	local tbl = Unit:GetInRangeFriends()
	local mt = Unit:GetClosestPlayer()
	for k,v in pairs(tbl) do
		if (v:GetEntry() == 11664) then
			v:ModifyWalkSpeed(8)
			v:MoveTo(mt:GetX(), mt:GetY(), mt:GetZ(), mt:GetO())
		end
	end
end

function Gehennas_OnDied(Unit,event)
	Unit:RemoveEvents()
end

function Gehennas_OnWipe(Unit,event)
	if (Unit:IsAlive() == true) then
		Unit:SpawnCreature(11664, 905.372314, -542.778442, -202.930298, 3.989631)
		Unit:SpawnCreature(11664, 890.958008, -539.140015, -203.050995, 5.445430)
		Unit:RemoveEvents()
	else
		Unit:RemoveEvents()
	end
end
	
function GehennasSpells(Unit,event)
	local rand = math.random(1,3)
	local plr = Unit:GetRandomPlayer(0)
	if (rand == 1) and (Unit:GetInRangePlayersCount() > 1) then
		if (Unit:GetRandomPlayer(0) ~= Unit:GetMainTank()) then
			Unit:FullCastSpellOnTarget(19729, Unit:GetRandomPlayer(0))
		else
			repeat
			until Unit:GetRandomPlayer(0) ~= Unit:GetMainTank()
			Unit:FullCastSpellOnTarget(19729, Unit:GetRandomPlayer(0))
		end
	elseif (rand == 2) and (plr ~= nil) then
		Unit:CastSpellAoF(plr:GetX(),plr:GetY(),plr:GetZ(),19717)
	elseif (rand == 3) then
		Unit:CastSpell(19716)
	end
end

RegisterUnitEvent(12259,1,"Gehennas_OnCombat")
RegisterUnitEvent(12259,2,"Gehennas_OnWipe")
RegisterUnitEvent(12259,4,"Gehennas_OnDied")

--[[
	FLAMEWALKER's AI
	]]

function GehennasElites_OnCombat(Unit,event)
		Unit:RegisterEvent("GehennasElitesSpells", math.random(12000, 18000), 0)
		local tbl = Unit:GetInRangeFriends()
		local mt = Unit:GetClosestPlayer()
		for k,v in pairs(tbl) do
			if (v:GetEntry() == 11664) then
				if (v:IsCreatureMoving() == false) then
					v:ModifyWalkSpeed(8)
					v:MoveTo(mt:GetX(), mt:GetY(), mt:GetZ(), mt:GetO())
				end
			end
		end
		for k,v in pairs(tbl) do
			if (v:GetEntry() == 12259) then
				if (v:IsCreatureMoving() == false) then
					v:ModifyWalkSpeed(8)
					v:MoveTo(mt:GetX(), mt:GetY(), mt:GetZ(), mt:GetO())
				end
			end
		end
	Unit:RegisterEvent("GehennasElitesSpells", math.random(12000, 18000), 0)
end

function GehennasElites_OnWipe(Unit,event)
	Unit:RemoveEvents()
	Unit:Despawn(1000, 0)
end

function GehennasElites_OnDied(Unit,event)
	Unit:RemoveEvents()
end

function GehennasElitesSpells(Unit,event)
	local rand = math.random(1,3)
	local tank = Unit:GetMainTank()
	if (rand == 1) then
		Unit:CastSpell(20277)
	elseif (rand == 2) and (tank ~= nil) then
		Unit:FullCastSpellOnTarget(24317, tank)
	elseif (rand == 3) and (tank ~= nil) then
		Unit:FullCastSpellOnTarget(19730, tank)
	end
end
	
RegisterUnitEvent(11664, 1, "GehennasElites_OnCombat")
RegisterUnitEvent(11664, 2, "GehennasElites_OnWipe")
RegisterUnitEvent(11664, 4, "GehennasElites_OnDied")