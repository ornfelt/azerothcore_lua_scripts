

print "LevelUpAward Loading"

AWARD = {{60037,10,1,"不朽智慧药剂"},{60037,20,1,"不朽智慧药剂"},{60037,30,1,"不朽智慧药剂"},{60037,40,1,"不朽智慧药剂"},{60037,50,1,"不朽智慧药剂"},{60037,60,1,"不朽智慧药剂"},{60037,70,1,"不朽智慧药剂"},{60037,80,1,"不朽智慧药剂"}
};

local function LevelUpAward (event, player, oldLevel)
	local nowLevel		= player:GetLevel()--得到当前等级
	for _,v in pairs (AWARD) do
		if (nowLevel == v[2]) then
			player:AddItem(v[1], v[3]);
			local ItemName = v[4];
			player:SendBroadcastMessage("恭喜你提升到"..nowLevel.."级,获得系统奖励["..ItemName.."]"..v[3].."个。")
			SendWorldMessage("|cffff0000[系统公告]|r|cffcc00cc恭喜玩家|r|Hplayer:"..player:GetName().."|h|cff3333ff["..player:GetName().."]|h|r|cffcc00cc提升到"..nowLevel.."级,获得系统奖励["..ItemName.."]"..v[3].."个。|r")
		end
	end
end

RegisterPlayerEvent(13, LevelUpAward)