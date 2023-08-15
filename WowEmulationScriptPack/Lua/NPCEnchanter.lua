print(">>Script: NPC Enchanter.")

local npcid = 623

local T = {
	["Menu"] = {
		{"头盔附魔", 0},
		{"肩膀附魔", 2},
		{"胸甲附魔", 4},
		{"腿甲附魔", 6},
		{"脚部附魔", 7},
		{"手部附魔", 8},
		{"腕部附魔", 9},
		{"披风附魔", 14},
		{"主手武器附魔", 15},
		{"双手武器附魔", 151},
		{"副手武器附魔", 16},
		{"盾牌附魔", 161};
	},
	
	[0] = { -- Headpiece
		{"+30法伤，+20暴击等级", 3820, false},
		{"+30法伤，每秒回复法力+10", 3819, false},
		{"+37耐力，+20防御等级", 3818, false},
		{"+50攻击强度，+20暴击等级", 3817, false},
		{"+30耐力，+25韧性等级", 3842, false},
		{"+50攻击强度，+20韧性等级", 3795, false},
		{"+29法伤，+20韧性等级", 3797, false};
	},

	[2] = { -- Shoulders
		{"+40攻击强度，+15韧性等级", 3793, false},
		{"+23法术强度，+15韧性等级", 3794, false},
		{"+30耐力，+15韧性等级", 3852, false},
		{"+40攻击强度，+15暴击等级", 3808, false},
		{"+24法术强度，每5秒法力回复+8", 3809, false},
		{"+20躲闪等级，+15防御等级", 3811, false},
		{"+24法术强度，+15爆击等级", 3810, false};
	},

	[4] = { -- Chest
		{"+10所有属性", 3832, false},
		{"+275生命值", 3297, false},
		{"每5秒法力回复+8", 2381, false},
		{"+20韧性等级", 3245, false},
		{"+22防御等级", 1953, false};
	},

	[6] = { -- Legs
		{"+40韧性等级，+28耐力", 3853, false},
		{"+55耐力，+22敏捷", 3822, false},
		{"+75攻击强度，+22爆击等级", 3823, false},
		{"+50法术强度，+20精神", 3719, false},
		{"+50法术强度，+30耐力", 3721, false};
	},	

	[7] = { -- Boots
		{"+32攻击强度", 1597, false},
		{"+15耐力，速度略微提高", 3232, false},
		{"+16敏捷", 983, false},
		{"+18精神", 1147, false},
		{"+7生命值，每5秒回复法力值+7", 3244, false},
		{"+12命中等级，+12爆击等级", 3826, false},
		{"+22耐力", 1075, false};
	},

	[8] = { -- Bracers
		{"+40耐力", 3850, false},
		{"+30法术强度", 2332, false},
		{"+50攻击强度", 3845, false},
		{"+18精神", 1147, false},
		{"+15精准等级", 3231, false},
		{"+6所有属性", 2661, false},
		{"+16智力", 1119, false};
	},

	[9] = { -- Gloves
		{"+16暴击等级", 3249, false},
		{"+2%威胁，+10招架等级", 3253, false},
		{"+44攻击强度", 1603, false},
		{"+20敏捷", 3222, false},
		{"+20命中等级", 3234, false},
		{"+15精准等级", 3231, false},
		{"+28法术强度", 3246, false};
	},

	[14] = { -- Cloak
		{"强化潜行，+10敏捷", 3256, false},
		{"+10精神，威胁降低2%", 3296, false},
		{"+16防御等级", 1951, false},
		{"+23急速等级", 3831, false},
		{"+225护甲值", 3294, false},
		{"+22敏捷", 1099, false},
		{"+20奥术抗性", 1262, false};
	},

	[15] = {
		-- Main Hand
		{"+50耐力", 3851, false},
		{"25命中等级，+25爆击等级", 3788, false},
		{"狂暴（攻击有几率提高400攻强）", 3789, false},
		{"黑魔法", 3790, false},
		{"+63法术强度", 3834, false},
		{"+65攻击强度", 3833, false},
		{"破冰武器", 3239, false},
		{"生命护卫", 3241, false},
		{"吸血", 3870, false},
		{"利刃防护", 3869, false},
		{"+26敏捷", 1103, false},
		{"+45精神", 3844, false},
		{"斩杀", 3225, false},
		{"猫鼬", 2673, false},
		
		-- Two-Handed
		{"+110攻击强度", 3827, true},
		{"+140对亡灵攻击强度", 3247, true},
		{"巨人杀手", 3251, true},
		{"+81法术强度", 3854, true};
	},
	
	[16] = {
		-- Offhand
		{"+50耐力", 3851, false},
		{"+25命中和暴击等级 - Accuracy", 3788, false},
		{"狂暴（有几率提高400攻强）", 3789, false},
		{"黑魔法", 3790, false},
		{"+63法伤", 3834, false},
		{"+65攻强", 3833, false},
		{"破冰武器", 3239, false},
		{"生命护卫", 3241, false},
		{"吸血", 3870, false},
		{"利刃防护", 3869, false},
		{"+26敏捷", 1103, false},
		{"+45精神", 3844, false},
		{"斩杀", 3225, false},
		{"猫鼬", 2673, false},
		
		-- Shields
		{"+20防御等级", 1952, true},
		{"+25智力", 1128, true},
		{"+15盾牌格挡等级", 2655, true},
		{"+12韧性等级", 3229, true},
		{"+18耐力", 1071, true},
		{"+36格挡值", 2653, true};
	},
};
local pVar = {};

function Enchanter(event, plr, unit)
	pVar[plr:GetName()] = nil;

	for _, v in ipairs(T["Menu"]) do
		plr:GossipMenuAddItem(3, "|cFF0000CC"..v[1].."|R", 0, v[2])
	end
	plr:GossipSendMenu(1, unit)
end

function EnchanterSelect(event, plr, unit, sender, intid, code)
	if (intid < 500) then
		local ID = intid
		local f
		if(intid == 161 or intid == 151) then
			ID = math.floor(intid/10)
			f = true
		end
		pVar[plr:GetName()] = intid;
		if(T[ID]) then
			for i, v in ipairs(T[ID]) do
				if((not f and not v[3]) or (f and v[3])) then
					plr:GossipMenuAddItem(3, "|cFF0000CC"..v[1].."|R", 0, v[2])
				end
			end
		end
		plr:GossipMenuAddItem(3, "[返回首页]", 0, 500)
		plr:GossipSendMenu(1, unit)
	elseif (intid == 500) then
		Enchanter(event, plr, unit)
	elseif (intid >= 900) then
		local ID = pVar[plr:GetName()]
		if(ID == 161 or ID == 151) then
			ID = math.floor(ID/10)
		end
		for k, v in pairs(T[ID]) do
			if v[2] == intid then
				local item = plr:GetEquippedItemBySlot(ID)
				if item then
					if v[3] then
						local WType = item:GetSubClass()
						if pVar[plr:GetName()] == 151 then
							if(WType == 1 or WType == 5 or WType == 6 or WType == 8 or WType == 10) then
								item:ClearEnchantment(0,0)
								item:SetEnchantment(intid, 0, 0)
							else
								plr:SendAreaTriggerMessage("你必须装备一把双手武器才可以进行附魔。")
							end	
						elseif pVar[plr:GetName()] == 161 then
							if(WType == 6) then
								item:ClearEnchantment(0,0)
								item:SetEnchantment(intid, 0, 0)
							else
								plr:SendAreaTriggerMessage("你必须装备一个盾牌才可以进行附魔。")
							end
						end
					else
						item:ClearEnchantment(0,0)
						item:SetEnchantment(intid, 0, 0)
						plr:CastSpell(plr, 36937)
					end
				else
					plr:SendAreaTriggerMessage("没有检测到你要进行附魔的装备，附魔失败！")
				end
			end
		end
		EnchanterSelect(event, plr, unit, sender, pVar[plr:GetName()], nil)
	end
end

RegisterCreatureGossipEvent(npcid, 1, Enchanter)
RegisterCreatureGossipEvent(npcid, 2, EnchanterSelect)