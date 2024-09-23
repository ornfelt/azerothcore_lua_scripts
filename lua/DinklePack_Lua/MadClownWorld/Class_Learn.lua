--[[For learning custom class spells]]

--[[
		{46917 , "Titan's Grip"},
		{49152 , "Titan's Grip"},
		{50483 , "Titan's Grip for Shield"},
]]

local Spells = {
	[1] = {-- Warrior
		{23920, 60, "Spell Reflection"},
		{3411, 45, "Intervene"},	
		{30262, 1, "NPC Bot: Sendto Smoke Flare"},
		{202, 1, "2h Swords"},
		{200, 1, "Polearms"},
	},
	[2] = {-- Paladin
		{32223, 60, "Crusader Aura"},
		{100108, 1, "Holy leap"},
		{35395, 1, "Crusader Strike"},
		{54428, 50, "Divine Plea"},
		{202, 1, "2h Swords"},
		{30262, 1, "NPC Bot: Sendto Smoke Flare"},
	},
    [3] = {-- Hunter
		{34026, 45, "Kill Command"},
		{53271, 55, "Master's Call"},
		{34477, 35, "Misdirection"},
		{30262, 1, "NPC Bot: Sendto Smoke Flare"},
	},
	[4] = {-- Rogue
		{51723, 25, "Fan of Knives"},
		{31224, 60, "Cloak of Shadows"},
		{5938, 60, "Shiv"},
		{32645, 60, "Envenom"},
		{57934, 45, "Tricks of the Trade"},
		{30262, 1, "NPC Bot: Sendto Smoke Flare"},
		{674, 1, "Dual Wield"},
		{100192, 1, "Grappling Hook"},
	},
	[5] = {-- Priest
		{64901, 60, "Hymn of Hope"},
		{32375, 60, "Mass Dispel"},
		{30262, 1, "NPC Bot: Sendto Smoke Flare"},
	},
	[6] = {-- Death Knights
		{48265, 55, "Unholy Presence"},
		{50977, 55, "Death Gate"},
		{53428, 55, "Runeforging"},
		{48778, 55, "Acherus Deathcharger"},
		{53428, 55, "Runeforging"},
		{48707, 55, "Anti-Magic Shell"},		
		{48707, 60, "Blood Tap"},	
		{56222, 57, "Dark Command"},
		{3714, 58, "Path of Frost"},	
		{47568, 60, "Empower Rune Weapon"},
		{56815, 58, "Rune Strike"},		
		{30262, 55, "NPC Bot: Sendto Smoke Flare"},
		{80104, 55, "Grim Advance"},
	},
	[7] = {-- Shaman
		{51514, 30, "Hex"},
		{3738, 60, "Wrath of Air Totem"},
		{30262, 1, "NPC Bot: Sendto Smoke Flare"},
	},
	[8] = {-- Mage
	--	{44614, 60, "Frostfire Bolt"},
	--	{30455, 60, "Ice Lance"},
		{30262, 1, "NPC Bot: Sendto Smoke Flare"},
	},
	[9] = {-- Warlock
		{29858, 45, "Soulshatter"},
		{48018, 55, "Demonic Circle: Summon"},
		{48020, 55, "Demonic Circle: Teleport"},
		{30262, 1, "NPC Bot: Sendto Smoke Flare"},
	},
	[11] = {-- Druid
		{52610, 55, "Savage Roar"},
		{33786, 45, "Cyclone"},
		{62078, 57, "Swipe"},
		{50334, 60, "Berserk"},
		{30262, 1, "NPC Bot: Sendto Smoke Flare"},
	},
}

local Races = {
    [10] = {-- (Blood Elf)
        {137, 1, "Thalassian", 300},
    },
    [14] = {--  (High Elf)
        {137, 1, "Thalassian", 300},
    },
}

function CheckRaceSkill(player)
    local Player_Race = player:GetRace()
    if Races[Player_Race] then
        for event, v in ipairs(Races[Player_Race]) do
            local currSkillValue = player:GetSkillValue(v[1])
            if currSkillValue < v[4] then
                player:SetSkill(v[1], v[2], v[4], v[4])
              --  player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFYour skill = |cff00cc00"..v[3].. " has been increased to " .. v[4])
            end
        end
    end
end

function CheckSpell(player)
	local Player_Class = player:GetClass()
	local Player_LeveL = player:GetLevel()
	if Spells[Player_Class] then
		for event, v in ipairs(Spells[Player_Class]) do
			local hasSpell = player:HasSpell(v[1])
			if not hasSpell and Player_LeveL >= v[2] then
				player:LearnSpell(v[1])
				player:SendBroadcastMessage("|cffff3347Notice: |cff3399FFLearned Spell = |cff00cc00"..v[3])
			end
		end
	end
end


local UnlearnSpells = {24939, 24969, 100116, 100117, 100118}
local TriggerItems = {800048, 90000, 800085}

local function CheckUnlearnSpells(player)
    for _, itemId in ipairs(TriggerItems) do
        if player:HasItem(itemId, 1) then
            for _, spellId in ipairs(UnlearnSpells) do
                if player:HasSpell(spellId) then
                    player:RemoveSpell(spellId)
                    player:SendBroadcastMessage("A challenge mode item in your inventory has caused you to forget a spell.")
                end
            end
        end
    end
end

local function SendPatreonMessage(eventid, delay, repeats, player)
    player:SendBroadcastMessage("|cff00ff00Thank you to all my wonderful supporters! Your patreon pledges go a long way in ensuring we continue to get cool stuff for the repack. If you'd like to donate, you can visit our page here: |cffffffffpatreon.com/Dinklepack5")
end

local function Delay(eventid, delay, repeats, player)
    CheckSpell(player)
    CheckRaceSkill(player)
    CheckUnlearnSpells(player) 
end

local function Delay(eventid, delay, repeats, player)
	CheckSpell(player)
	CheckRaceSkill(player)
	CheckUnlearnSpells(player) 
end

local function RunCheck_Login(event, player)
	player:RegisterEvent(Delay, 4500, 1, player)
	player:RegisterEvent(SendPatreonMessage, 13000, 1, player)

end
local function RunCheck_LevelUP(event, player)
	player:RegisterEvent(Delay, 3000, 1, player)
end

RegisterPlayerEvent(30, RunCheck_Login)
RegisterPlayerEvent(3, RunCheck_Login)
RegisterPlayerEvent(13, RunCheck_LevelUP)

