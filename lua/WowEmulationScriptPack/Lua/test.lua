local PLAYER_EVENT_ON_LOGIN = 3

local function OnLogin(event, player)
    player:SendBroadcastMessage("Hello world")
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LOGIN, OnLogin)
--
--print(">>Script: TeleportStone loading...OK")
--
----菜单所有者 --默认炉石
--local itemEntry	=6948
--local Stone={}
--function Stone.ShowGossip(event, player, item)
--	player:SendBroadcastMessage("ShowGossip")
--	return false
--end
--
--function Stone.SelectGossip(event, player, item, sender, intid, code, menu_id)
--	player:SendBroadcastMessage("SelectGossip")
--	return false
--end
--
--
--RegisterItemGossipEvent(itemEntry, 1, Stone.ShowGossip)
--RegisterItemGossipEvent(itemEntry, 2, Stone.SelectGossip)
local target
local function Chat (event, player, message, type, language)
	player:SendBroadcastMessage("Chating")
	if (message == "#sex") then --test change model
		player:SetDisplayId(1)
		player:SendBroadcastMessage("You have been sexed up!")
		return 0
	end
	--get target
	if(message == "t") then
		target=player:GetSelection()--得到玩家选中对象
		player:SendBroadcastMessage("get target:"..target:GetName().." type:"..target:GetTypeId())
	end
	-- test move 
	if(message =="a") then
		local slave = player:GetSelection()--得到玩家选中对象
		if(slave)then
			if(slave:GetTypeId()==3)then--目标是生物
				--slave:MoveFollow(target)
			end
		end
	end
	if(message == "k") then
		player:SetHealth(0)
		player:KillPlayer()
		--player:SetLuaCooldown(0, 3)
		--player:RemoveEvents()
		player:SendBroadcastMessage("player:"..player:GetName().." killed")

	end
	if(message == "aura") then
		local spellID = 16609
		player:AddAura(spellID,player)
	end
end
RegisterPlayerEvent(18, Chat)
--RegisterPlayerEvent(42,Chat)

-- 让闪金镇的马克能够对话
-- 先修改马克的 creature_template.npc_flags = 2+1(3) 才能有对话菜单
local creatureEntry = 795
local function OnGossipHello(event, player, unit)
    player:GossipMenuAddItem(0, "Test Weather", 1, 1)
    player:GossipMenuAddItem(0, "Nevermind..", 1, 2)
    player:GossipSendMenu(1, unit)
end

local function OnGossipSelect(event, plr, unit, sender, action, code)
    if (action == 1) then
        plr:GetMap():SetWeather(plr:GetZoneId(), math.random(0, 3), 1) -- random weather
        plr:GossipComplete()
	unit:MoveFollow(plr)
    elseif (action == 2) then
        plr:GossipComplete()
	plr:SendBroadcastMessage("player:"..plr:GetName().." hello?")
	--unit:MoveTo(0, plr:GetX()+50,plr:GetY(),plr:GetZ())
	unit:MoveClear()
    end
end


RegisterCreatureGossipEvent(creatureEntry, 1, OnGossipHello)
RegisterCreatureGossipEvent(creatureEntry, 2, OnGossipSelect)



--让闪金镇的布尔797有boss技能 癞皮狼525 暴风城卫兵1423 
local npcId = 525
local Therer = {}

function Therer.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Therer.ArcaneBolt, 12000, 0)
    creature:RegisterEvent(Therer.DrainLife, 7500, 0)
    creature:RegisterEvent(Therer.DigestiveAcid, 18000, 0)
    creature:RegisterEvent(Therer.ArcaneExplode, 15000, 0)

end

function Therer.OnLeaveCombat(event, creature)
    creature:SendUnitYell("Didn't even stand a chance", 0)
    creature:CastSpell(creature, 36393, true)
    creature:RemoveEvents()
end

function Therer.OnDied(event, creature, killer)
    if (killer:GetObjectType() == "Player") then
        killer:SendBroadcastMessage("You killed " .. creature:GetName() .. "!")
    end
    creature:RemoveEvents()
end

--奥数爆炸
function Therer.ArcaneExplode(event, dely, calls, creature)
    local TARGET3 = creature:GetAITarget(4, true, 0, 45)
    creature:CastSpell(TARGET3, 34656, true)
	creature:SendUnitYell("奥数爆炸！", 0)
end

--奥术箭
function Therer.ArcaneBolt(event, dely, calls, creature)
    local TARGET2 = creature:GetAITarget(4, true, 0, 45)
    creature:CastSpell(TARGET2, 58456, true)
	creature:SendUnitYell("奥术箭！", 0)
end

--吸取生命
function Therer.DrainLife(event, dely, calls, creature)
    creature:CastSpell(creature:GetVictim(), 17620, false)
	creature:SendUnitYell("吸取生命！", 0)
end

--消化酸液
function Therer.DigestiveAcid(event, dely, calls, creature)
    local TARGET1 = creature:GetAITarget(1, true, 0, 45)
    creature:CastSpell(TARGET1, 26476, true)
	creature:SendUnitYell("消化酸液！", 0)
end

RegisterCreatureEvent(npcId, 1, Therer.OnEnterCombat)
RegisterCreatureEvent(npcId, 2, Therer.OnLeaveCombat)
RegisterCreatureEvent(npcId, 4, Therer.OnDied)