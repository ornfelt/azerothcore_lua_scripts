local Content = {
	Area = {
		-- 3.1
		[5379] = {
			isRaid = true,
			[0] = {"Ulduar 10 Normal", 576}, -- Ulduar enterance, Naxx world first
			[1] = {"Ulduar 25 Normal", 577},
			[2] = {"Ulduar 10 Normal", 576}, -- Ulduar enterance, Naxx world first
			[3] = {"Ulduar 25 Normal", 577},
		},
		
		-- 3.2
		[5505] = {
			isRaid = false,
			[0] = {"Trial of the Champion Normal", 1289}, -- TotC enterance, Ulduar world first
			[1] = {"Trial of the Champion Heroic", 4296, 3778}, -- TotC enterance, Ulduar world first
		},
		[5503] = {
			isRaid = true,
			[0] = {"Trial of the Crusader 10 Normal", 2894}, -- TotC enterance, Ulduar world first
			[1] = {"Trial of the Crusader 25 Normal", 2895}, -- TotC enterance, Ulduar world first
			[2] = {"Trial of the Crusader 10 Heroic", 3917}, -- TotC enterance, Ulduar world first
			[3] = {"Trial of the Crusader 25 Heroic", 3916}, -- TotC enterance, Ulduar world first
		},
		[2848] = {
			isRaid = true,
			[0] = {"Onyxia's Lair 10 Normal", 2894}, -- Onyxia's Lair enterance, Ulduar world first
			[1] = {"Onyxia's Lair 25 Normal", 2895}, -- Onyxia's Lair enterance, Ulduar world first
			[2] = {"Onyxia's Lair 10 Normal", 2894}, -- Onyxia's Lair enterance, Ulduar world first
			[3] = {"Onyxia's Lair 25 Normal", 2895}, -- Onyxia's Lair enterance, Ulduar world first
		},
		
		-- 3.3
		[5635] = {
			isRaid = false,
			[0] = {"Forge of Souls Normal", 2894}, -- FoS enterance, ToTC world first
			[1] = {"Forge of Souls Heroic", 3917}, -- FoS enterance, ToTC world first
		},
		[5636] = {
			isRaid = false,
			[0] = {"Halls of Reflection Normal", 4517}, -- HoR enterance, ToTC world first
			[1] = {"Halls of Reflection Heroic", 4520}, -- HoR enterance, ToTC world first
		},
		[5637] = {
			isRaid = false,
			[0] = {"Pit of Saron Normal", 4516}, -- PoS enterance, ToTC world first
			[1] = {"Pit of Saron Heroic", 4519}, -- PoS enterance, ToTC world first
		},
		[5670] = {
			isRaid = true,
			[0] = {"Icecrown Citadel 10 Normal", 3918}, -- ICC enterance, ToTC world first
			[1] = {"Icecrown Citadel 25 Normal", 3812}, -- ICC enterance, ToTC world first
			[2] = {"Icecrown Citadel 10 Heroic", 4532}, -- ICC enterance, ToTC world first
			[3] = {"Icecrown Citadel 25 Heroic", 4608}, -- ICC enterance, ToTC world first
		},
		[5869] = {
			isRaid = true,
			[0] = {"The Ruby Sanctum 10 Normal", 4636}, -- RS enterance, ToTC world first
			[1] = {"The Ruby Sanctum 25 Normal", 4637}, -- RS enterance, ToTC world first
			[2] = {"The Ruby Sanctum 10 Heroic", 4817}, -- RS enterance, ToTC world first
			[3] = {"The Ruby Sanctum 25 Heroic", 4815}, -- RS enterance, ToTC world first
		},
	},
	Map = {
	}
}

function Content.TriggerCheck(event, player, triggerId)
    if(Content["Area"][triggerId] and not player:IsGM()) then
        local cT = Content["Area"][triggerId][player:GetDifficulty(Content["Area"][triggerId]["isRaid"])]
		if(triggerId == 5505) then -- Special case for Trial of the Crusader
			if ((not(player:HasAchieved(cT[2]))) and (not(player:HasAchieved(cT[3])))) then
				player:SendAreaTriggerMessage("You have not yet unlocked "..cT[1].." mode!")
				player:SendBroadcastMessage("|cffffffffYou do not have the |cffffff00|Hachievement:"..cT[2]..":"..string.format('%x', player:GetGUIDLow())..":0:0:0:0:0:0:0:0|h[Required Achievement]|h|r |cffffffffto enter this dungeon.")
				return true;
			end
		else
			if not(player:HasAchieved(cT[2])) then
				player:SendAreaTriggerMessage("You have not yet unlocked "..cT[1].." mode!")
				player:SendBroadcastMessage("|cffffffffYou do not have the |cffffff00|Hachievement:"..cT[2]..":"..string.format('%x', player:GetGUIDLow())..":0:0:0:0:0:0:0:0|h[Required Achievement]|h|r |cffffffffto enter this dungeon.")
				return true;
			end
		end
    end
    return false;
end

RegisterServerEvent(24, Content.TriggerCheck)