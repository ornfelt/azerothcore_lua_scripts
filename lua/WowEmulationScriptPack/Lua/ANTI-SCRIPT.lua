print(">> ANTI-SCRIPT")
local jiance = {
		["jiancegailv"] = 1,                    -- 拾取物品时有百分之多少的概率被检测
		["daticishu"] = 3,                      -- 答错几次踢下线
		["timu"] = {                            -- 题库
                [1] = {("5x12=？"),60},
				[2] = {("3x11=？"),33},
				[3] = {("7x5=？"),35},
				[4] = {("5x6=？"),30}; 
				[5] = {("3x9=？"),27}; 
        };
};

local flag = { };

function SetPlayerFlag(player, val)
    local Guid = player:GetGUIDLow()
	flag[Guid] = val;
end

local cuowu = { };

function SetPlayercuowu(player, val)
    local Guid = player:GetGUIDLow()
	cuowu[Guid] = val;
end


function ChatSystem(event, player, msg, Type, lang)
	if (msg == "whoismydaddy") then
		player:RemoveAura(6537)
	end
	local Guid = player:GetGUIDLow()
	if flag[Guid] ~= 0 then
		local daan = jiance["timu"][flag[Guid]][2];
		local t = msg;
		if (t+1 == daan+1) then
			player:RemoveAura(6537)
			player:SendBroadcastMessage("[|cFFF000A0脚本检测|r]回答正确，祝你玩的愉快！")
			SetPlayerFlag(player, 0)
			SetPlayercuowu(player, 0)
		else

			cuowu[Guid] = cuowu[Guid] + 1;
			if cuowu[Guid] >= jiance["daticishu"] then
				player:SendBroadcastMessage("[|cFFF000A0脚本检测|r]你已答错"..jiance["daticishu"].."次被强制下线！");
				player:RemoveAura(6537)
				SetPlayercuowu(player, 0)
				Kick( player )
			else
				player:SendBroadcastMessage("[|cFFF000A0脚本检测|r]你答错了"..cuowu[Guid].."次，请用/s普通聊天频道回答："..jiance["timu"][flag[Guid]][1].."");
			end
		end
	end
end


function shiqu (event, player, item, count)
	local datigailv = math.random(1, 100)
	if (datigailv <= jiance["jiancegailv"])then
		local xuanzetimu = math.random(1, 5)
		local Guid = player:GetGUIDLow()
		SetPlayerFlag(player, xuanzetimu)
		SetPlayercuowu(player, 0)
		player:CastSpell(player, 6537)
		player:SendBroadcastMessage("[|cFFF000A0脚本检测|r]请用/s普通聊天频道回答："..jiance["timu"][flag[Guid]][1].."");
	end
end
function shiqu2 (event, player, amount)
	local datigailv = math.random(1, 100)
	if (datigailv <= jiance["jiancegailv"])then
		local xuanzetimu = math.random(1, 5)
		local Guid = player:GetGUIDLow()
		SetPlayerFlag(player, xuanzetimu)
		SetPlayercuowu(player, 0)
		player:CastSpell(player, 6537)
		player:SendBroadcastMessage("[|cFFF000A0脚本检测|r]请用/s普通聊天频道回答："..jiance["timu"][flag[Guid]][1].."");
	end
end

RegisterPlayerEvent(32, shiqu) -- PLAYER_EVENT_ON_LOOT_ITEM      
RegisterPlayerEvent(37, shiqu2) -- PLAYER_EVENT_ON_LOOT_MONEY                            
RegisterPlayerEvent(18, ChatSystem);