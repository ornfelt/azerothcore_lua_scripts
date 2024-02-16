local CHALLENGE_ITEMS = {
    [800051] = "Pacifist Mode",
    [800048] = "Slow and Steady Mode",
    [800049] = "Ironman Mode",
    [800050] = "Randomly Attacked Mode",
    [90000]  = "Hardcore Mode",
	[800084] = "Diet Mode"
}

local CHALLENGE_REWARDS = {
    [800051] = {
        [9] = {item = {id = 37711, count = 10}, spell = 100200},
        [19] = {item = {id = 37711, count = 20}, spell = 100200},
        [29] = {item = {id = 37711, count = 30}, spell = 100200},
        [39] = {item = {id = 37711, count = 40}, spell = 100200},
        [49] = {item = {id = 37711, count = 50}, spell = 100200},
        [59] = {item = {id = 37711, count = 100}, spell = 80114, title = 185}
    },
    [800048] = {
        [9] = {item = {id = 37711, count = 10}, spell = 100200},
        [19] = {item = {id = 37711, count = 20}, spell = 100200},
        [29] = {item = {id = 37711, count = 30}, spell = 100200},
        [39] = {item = {id = 37711, count = 40}, spell = 100200},
        [49] = {item = {id = 37711, count = 50}, spell = 100200},
        [59] = {item = {id = 37711, count = 100}, spell = {80110, 80108}, title = 187}
    },
    [800049] = {
        [9] = {item = {id = 37711, count = 10}, spell = 100200},
        [19] = {item = {id = 37711, count = 20}, spell = 100200},
        [29] = {item = {id = 37711, count = 30}, spell = 100200},
        [39] = {item = {id = 37711, count = 40}, spell = 100200},
        [49] = {item = {id = 37711, count = 50}, spell = 100200},
        [59] = {item = {id = 37711, count = 100}, spell = 80109, title = 186}
    },
    [800050] = {
        [9] = {item = {id = 37711, count = 10}, spell = 100200},
        [19] = {item = {id = 37711, count = 20}, spell = 100200},
        [29] = {item = {id = 37711, count = 30}, spell = 100200},
        [39] = {item = {id = 37711, count = 40}, spell = 100200},
        [49] = {item = {id = 37711, count = 50}, spell = 100200},
        [59] = {item = {id = 37711, count = 100}, spell = 80111, title = 180}
    },
    [90000] = {
        [9] = {item = {id = 37711, count = 10}, spell = 100200},
        [19] = {item = {id = 37711, count = 20}, spell = 100200},
        [29] = {item = {id = 37711, count = 30}, spell = 100200},
        [39] = {item = {id = 37711, count = 40}, spell = 100200},
        [49] = {item = {id = 37711, count = 50}, spell = 100200},
        [59] = {item = {id = 36941, count = 1}, spell = {100125, 53082, 80112}}
    },
	[800084] = {
        [9] = {item = {id = 37711, count = 10}, item2 = {id = 43490, count = 1}, item3 = {id = 44616, count = 1}, item4 = {id = 44838, count = 1}, spell = 100200},
        [19] = {item = {id = 37711, count = 20}, item2 = {id = 43490, count = 2}, item3 = {id = 46887, count = 2}, item4 = {id = 44839, count = 2}, spell = 100200},
        [29] = {item = {id = 37711, count = 30}, item2 = {id = 38466, count = 3}, item3 = {id = 44791, count = 3}, item4 = {id = 16169, count = 3}, spell = 100200},
        [39] = {item = {id = 37711, count = 40}, item2 = {id = 16168, count = 4}, item3 = {id = 44616, count = 4}, item4 = {id = 44838, count = 4}, spell = 100200},
        [49] = {item = {id = 37711, count = 50}, item2 = {id = 3927, count = 5}, item3 = {id = 23160, count = 5}, item4 = {id = 11415, count = 5}, spell = 100200},
        [59] = {item = {id = 37711, count = 50}, item2 = {id = 35565, count = 10}, item3 = {id = 44616, count = 10}, item4 = {id = 33208, count = 5}, spell = 800120, title = 190} 
    },
	[800085] = {
        [9] = {item = {id = 37711, count = 5}, spell = 100200},
        [19] = {item = {id = 37711, count = 10}, spell = 100200},
        [29] = {item = {id = 37711, count = 15}, spell = 100200},
        [39] = {item = {id = 37711, count = 20}, spell = 100200},
        [49] = {item = {id = 37711, count = 25}, spell = 100200},
        [59] = {item = {id = 37711, count = 50}, spell = 80111, title = 191}
    },
	[800086] = {
        [9] = {item = {id = 37711, count = 5}, spell = 100200},
        [19] = {item = {id = 37711, count = 10}, spell = 100200},
        [29] = {item = {id = 37711, count = 15}, spell = 100200},
        [39] = {item = {id = 37711, count = 20}, spell = 100200},
        [49] = {item = {id = 37711, count = 25}, spell = 100200},
        [59] = {item = {id = 37711, count = 50}, spell = 80111, title = 192}
    }
}

local FRAGILE_WARRIOR_AURA = 80089

local function ChallengeMOnPlayerLevelUp(event, player, newLevel)
    if newLevel == 9 or newLevel == 19 or newLevel == 29 or newLevel == 39 or newLevel == 49 or newLevel == 59 then
        local activeChallenges = 0
        for itemId, challengeName in pairs(CHALLENGE_ITEMS) do
            if player:HasItem(itemId) then
                activeChallenges = activeChallenges + 1
                local rewards = CHALLENGE_REWARDS[itemId][newLevel]
                player:AddItem(rewards.item.id, rewards.item.count)
                if rewards.item2 then player:AddItem(rewards.item2.id, rewards.item2.count) end
                if rewards.item3 then player:AddItem(rewards.item3.id, rewards.item3.count) end
                if rewards.item4 then player:AddItem(rewards.item4.id, rewards.item4.count) end
                if rewards.title then
                    player:SetKnownTitle(rewards.title)
                    player:SendBroadcastMessage("|cff0000ffYou've earned a new title!|r") 
                end
                if type(rewards.spell) == "table" then
                    for _, spellId in ipairs(rewards.spell) do
                        player:LearnSpell(spellId)
                    end
                else
                    player:LearnSpell(rewards.spell)
                end
                SendWorldMessage(player:GetName() .. " has reached level " .. (newLevel + 1) .. " on " .. challengeName .. "! CONGRATULATIONS!")
            end
        end
        if player:HasAura(FRAGILE_WARRIOR_AURA) then
            activeChallenges = activeChallenges + 1
            if newLevel == 59 then
                player:LearnSpell(200179)
                player:LearnSpell(80113)
                player:SetKnownTitle(189)
                player:AddItem(37711, 100)
                SendWorldMessage(player:GetName() .. " has reached level " .. (newLevel + 1) .. " on Fragile Warrior Mode! They've learned a new spell! CONGRATULATIONS!")
            end
        end
        if newLevel == 59 then  
            if activeChallenges >= 2 then
                -- grant rewards for having 2 or more challenge modes active
                player:SetKnownTitle(188)  -- Title for 2 or more active challenges
                player:AddItem(37711, 200)
                player:LearnSpell(100218)
                SendWorldMessage(player:GetName() .. " has reached level " .. (newLevel + 1) .. " with 2 or more challenge modes active! CONGRATULATIONS!")
            end
            if activeChallenges >= 3 then
                -- grant rewards for having 3 or more challenge modes active
                player:AddItem(37711, 300)
                player:LearnSpell(80097)
                player:LearnSpell(100219)
                SendWorldMessage(player:GetName() .. " has reached level " .. (newLevel + 1) .. " with 3 or more challenge modes active! CONGRATULATIONS!")
            end
        end
    end
end

RegisterPlayerEvent(13, ChallengeMOnPlayerLevelUp)