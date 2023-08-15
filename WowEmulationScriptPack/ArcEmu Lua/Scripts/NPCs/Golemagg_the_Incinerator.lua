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
	GOLEMAGGs AI
	]]

function Golemagg_OnCombat(Unit,event)
	setvars(Unit,{Golemagg = Unit, Ragers= {}})
	Unit:RegisterEvent("Golemagg_Trust", 30000, 0)
	Unit:RegisterEvent("Golemagg_PyroBlast", 15000, 0)
	Unit:RegisterEvent("Golemagg_EarthQuake", 1000, 1)
	Unit:RegisterEvent("Golemagg_AttractRager", 1000, 1)
end
function Golemagg_Trust(Unit,event)
	local args = getvars(Unit)
	for k,v in pairs(args.Ragers) do
		if v ~= nil then
			v:FullCastSpell(20553)
		end
	end
end
function Golemagg_PyroBlast(Unit,event)
	local plr = Unit:GetRandomPlayer(0)
	if plr ~= nil then
		Unit:FullCastSpellOnTarget(20228,plr)
	end
end
function Golemagg_EarthQuake(Unit,event)
	if Unit:GetHealthPct() <= 10 then
		Unit:CastSpell(19798)
	else
		Unit:RegisterEvent("Golemagg_EarthQuake", 500, 1)
	end
end
function Golemagg_AttractRager(Unit,event)
	if Unit:GetHealthPct() <= 10 then
		local args = getvars(Unit)
		local tbl = { Unit:GetInRangePlayers() }
		for k,v in pairs(tbl) do
			if v:GetDistance(args.Ragers.Unit) <= 20 then
				args.Ragers.Unit:ModThreat(v,5000)
			end
		end
	end
end
function Golemagg_OnDied(Unit,event)
	Unit:RemoveEvents()
	local args = getvars(Unit)
	if args.Ragers ~= nil then
		for k,v in pairs(args.Ragers) do
			v:Kill(v)
		end
	end
end
function Golemagg_OnWipe(Unit,event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(11988,1,"Golemagg_OnCombat")
RegisterUnitEvent(11988,2,"Golemagg_OnWipe")
RegisterUnitEvent(11988,4,"Golemagg_OnDied")
--[[
	RAGERS AI
	]]

function CoreRager_OnCombat(Unit,event)
	local args = getvars(Unit)
	table.insert(args.Ragers,Unit)
	Unit:RegisterEvent("CoreRager_Mangle", 10000, 0)
	Unit:RegisterEvent("CoreRager_RefuseDeath", 5000, 1)
	setvars(Unit, args); -- still need to write the changes back
end
function CoreRager_OnWipe(Unit,event)
	Unit:RemoveEvents()
end
function CoreRager_OnDied(Unit,event)
	Unit:RemoveEvents()
end
function CoreRager_Mangle(Unit,event)
	local tank = Unit:GetMainTank()
	if tank ~= nil then
		Unit:CastSpellOnTarget(19820,tank)
	end
end
function CoreRager_RefuseDeath(Unit,event)
	if (Unit:GetHealthPct() <= 50) then
		local args = getvars(Unit)
		if (args.Golemagg:IsAlive() == true) then
			Unit:Heal(Unit,0,Unit:GetUInt32Value(UNIT_FIELD_MAXHEALTH))
			Unit:SendChatMessage(16, 0, Unit:GetName().."refuses to die while it's master is in trouble")
		end
	else
		Unit:RegisterEvent("CoreRager_RefuseDeath", 5000, 1)
	end
end

RegisterUnitEvent(11672,1,"CoreRager_OnCombat")
RegisterUnitEvent(11672,2,"CoreRager_OnWipe")
RegisterUnitEvent(11672,4,"CoreRager_OnDied")
