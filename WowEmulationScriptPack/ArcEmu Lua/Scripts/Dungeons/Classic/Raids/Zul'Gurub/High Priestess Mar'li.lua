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
-- SPIDER DISPLAY 15226
-- NORMAL DISPLAY 15220



function HPMarli_OnCombat(Unit,event)
	Unit:RegisterEvent("HPMarli_SummonSpiders", 200, 4)
	Unit:RegisterEvent("HPMarli_Normal",1000, 1)
end
function HPMarli_Normal(Unit,event)
	Unit:SetModel(15220)
	Unit:RemoveEvents()
	Unit:RegisterEvent("HPMarli_SummonSpiders",27000, 0)
	Unit:RegisterEvent("HPMarli_PoisonVolley", 22000, 0)
	Unit:RegisterEvent("HPMarli_DrainLife", 24000, 0)
	Unit:RegisterEvent("HPMarli_SpiderForm", 60000, 1)
end
function HPMarli_PoisonVolley(Unit,event)
	Unit:FullCastSpell(24099)
end

function HPMarli_DrainLife(Unit,event)
	local plr = Unit:GetRandomPlayer(0)
	if plr ~= nil then
		Unit:StopMovement(7000)
		Unit:FullCastSpellOnTarget(24300, plr)
        end
end

function HPMarli_SummonSpiders(Unit,event)
	Unit:SpawnCreature(14880,Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO(),Unit:GetFaction(),0)
end

function HPMarli_OnWipe(Unit,event)
	if Unit:IsAlive() == true then
        Unit:RemoveEvents()
        Unit:SetModel(15220)
        else
        Unit:RemoveEvents()
        end
end
function HPMarli_OnDied(Unit,event)
	Unit:RemoveEvents()
end
function HPMarli_SpiderForm(Unit,event)
	Unit:RemoveEvents()
	Unit:SetModel(15226)-- Change display to Spiderform.
	Unit:RegisterEvent("HPMarli_AOESilence", 100, 1)
	Unit:RegisterEvent("HPMarli_Web",18000, 0)
	Unit:RegisterEvent("HPMarli_SummonSpiders",27000, 0)
	Unit:RegisterEvent("HPMarli_ChargeCheck", 18100, 0)
	Unit:RegisterEvent("HPMarli_Normal", 60000, 1)
end

function HPMarli_MovingCheck(Unit, event)
     Unit:WipeThreatList()
     Unit:SetCombatTargetingCapable(0)
     Unit:ModifyRunSpeed(8)
     Unit:ChangeTarget(Unit:GetClosestPlayer())
end

function HPMarli_ChargeCheck(Unit,event)
	local tbl=Unit:GetInRangePlayers()
        for k,v in pairs(tbl) do
                if Unit:GetDistance(v) >= 8 then
                players={}
                table.insert(players, v)
                local player=math.random(1, table.getn(players))
		        Unit:FullCastSpellOnTarget(22911, players[player])-- Charge if main tank is too far away.
                Unit:SetCombatTargetingCapable(1)
                Unit:ModifyRunSpeed(200)
                Unit:MoveTo(v:GetX(), v:GetY(), v:GetZ(), v:GetO())
                Unit:RegisterEvent("HPMarli_MovingCheck", 500, 1)
                end
        end
end


function HPMarli_Web(Unit,event)
	local tbl = Unit:GetInRangePlayers()
	for k,v in pairs(tbl) do
		if Unit:GetDistance(v) <= 8 then
			Unit:FullCastSpellOnTarget(24110,v)-- Enveloping Web
		end
	end
end
function HPMarli_AOESilence(Unit,event)
	local tbl = Unit:GetInRangePlayers()
	for k,v in pairs(tbl) do
		Unit:FullCastSpellOnTarget(15487, v) -- Iteration for Silence to cast on inrange players.
	end
end

RegisterUnitEvent(14510,1,"HPMarli_OnCombat")
RegisterUnitEvent(14510,2,"HPMarli_OnWipe")
RegisterUnitEvent(14510,4,"HPMarli_OnDied")

--[[
	SPIDERs AI
	]]


function Spider_OnWipe(Unit, event)
     Unit:RemoveEvents()
     Unit:Despawn(100, 0)
end

function HPMarli_SpiderGrow(Unit,event)
        Unit:DisableRespawn(1)
	local tbl = Unit:GetInRangeFriends()
	for k,v in pairs(tbl) do
		if v:GetEntry() == 14510 then
			if Unit:GetDistance(v) <= 1 then
				Unit:RegisterEvent("HPMarli_SpiderEnlarge", 2000, 0)
			end
		end
	end
end
function HPMarli_SpiderEnlarge(Unit,event)
	Unit:SetUInt32Value(UNIT_FIELD_MINDAMAGE,(Unit:GetUInt32Value(UNIT_FIELD_MINDAMAGE))+50)
	Unit:SetUInt32Value(UNIT_FIELD_MAXDAMAGE,(Unit:GetUInt32Value(UNIT_FIELD_MAXDAMAGE))+50)
	Unit:SetFloatValue(OBJECT_FIELD_SCALE_X,(Unit:GetFloatValue(OBJECT_FIELD_SCALE_X))+0.1)
end

RegisterUnitEvent(14880, 1, "HPMarli_SpiderGrow")
RegisterUnitEvent(14880, 2, "Spider_OnWipe")
