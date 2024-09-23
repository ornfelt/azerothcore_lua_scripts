local hcNPC = 90000
local fragileWarriorSpellId = 80089
local pacifistModeItemId = 800051
local dietModeItemId = 800084
local nomadModeItemId = 800085
local taxationWithoutRepresentationItemId = 800086

local function PlayerDeath(event, killer, killed)
    if killed:HasItem(90000,1) then
        local message = killed:GetName() .. " was killed by " .. killer:GetName() .. " and has failed the Hardcore Mode challenge!"
        print(message)
        SendWorldMessage(message)
		killed:PlayDirectSound(183253)
        killed:RemoveItem(90000, 1) 
        killed:CastSpell(killed, 80115, true) 
    end
end

function OnFirstTalk(event, player, unit)
	    if player:IsInGroup() then
        player:SendBroadcastMessage("You must leave your group before selecting challenge modes.")
        return
    end
    if player:GetLevel() == 1 then
		player:PlayDirectSound(183254)
        player:GossipMenuAddItem(0, "Click here to try Hardcore Mode!", 0, 1)
        player:GossipMenuAddItem(0, "Click here to try Slow and Steady Mode!", 0, 9)
        player:GossipMenuAddItem(0, "Click here to try Fragile Warrior Mode!", 0, 11)
		player:GossipMenuAddItem(0, "Click here to try Ironman Mode!", 0, 14) 
		player:GossipMenuAddItem(0, "Click here to try Randomly Attacked Mode!", 0, 19) 
		player:GossipMenuAddItem(0, "Click here to try Pacifist Mode!", 0, 22)
		player:GossipMenuAddItem(0, "Click here to try Diet Mode!", 0, 25)
		player:GossipMenuAddItem(0, "Click here to try Nomad Mode!", 0, 27)
		player:GossipMenuAddItem(0, "Click here to try Taxation Without Representation Mode!", 0, 30)
		if not player:HasItem(800048, 1) and not player:HasItem(90000, 1) and not player:HasItem(800085, 1) and not player:HasItem(65000, 1) then
            player:GossipMenuAddItem(0, "Give me another Dinklestone.", 0, 18)
		end
    end
    if player:HasItem(90000, 1) then
        player:GossipMenuAddItem(0, "Remove hardcore mode from your character.", 0, 8)
    end
	if player:HasItem(800048, 1) then
     player:GossipMenuAddItem(0, "Remove Slow and Steady mode from your character.", 0, 17) 
    end
	local playerLevel = player:GetLevel()
    if player:HasAura(fragileWarriorSpellId) and (playerLevel == 1 or playerLevel == 10 or playerLevel == 20 or playerLevel == 30 or playerLevel == 40 or playerLevel == 50 or playerLevel == 60 or playerLevel == 70 or playerLevel == 80) then
        player:GossipMenuAddItem(0, "Remove Fragile Warrior mode from your character.", 0, 13)
    end
	if player:HasItem(800049, 1) then
     player:GossipMenuAddItem(0, "Remove Ironman mode from your character.", 0, 16) 
    end
	if player:HasItem(800050, 1) then
        player:GossipMenuAddItem(0, "Remove Randomly Attacked mode from your character.", 0, 21)
    end
	if player:HasItem(pacifistModeItemId, 1) then
        player:GossipMenuAddItem(0, "Remove Pacifist Mode from your character.", 0, 23)
	end
	if player:HasItem(dietModeItemId, 1) then
    player:GossipMenuAddItem(0, "Remove Diet Mode from your character.", 0, 26)
	end
if player:HasItem(nomadModeItemId, 1) then
    player:GossipMenuAddItem(0, "Remove Nomad Mode from your character.", 0, 28)
	end
	if player:HasItem(taxationWithoutRepresentationItemId, 1) then
    player:GossipMenuAddItem(0, "Remove Taxation Without Representation Mode from your character.", 0, 31)
	end
    player:GossipSendMenu(1, unit)
end

function OnSelect(event, player, unit, sender, intid, code)
    if player:IsInGroup() then
        player:SendBroadcastMessage("You must leave your group before engaging in challenge modes.")
        return
    end
    if intid == 1 then
        player:GossipMenuAddItem(0, "This challenge will lock the character after death to be no longer playable. Additionally it will remove all your current gold, remove bonus starter items and Murky will no longer be with you! This challenge mode offers various rewards at certain milestones.", 0, 2)
        player:GossipMenuAddItem(0, "NO TAKE ME BACK!", 0, 3)
        player:GossipSendMenu(2, unit)
    elseif intid == 8 then
        player:RemoveItem(90000, 1)
        player:SendBroadcastMessage("Hardcore mode has been removed from your character.")
        player:GossipComplete()
    elseif intid == 9 then
        player:GossipMenuAddItem(0, "Slow and Steady is a choice for adventurers seeking to savor their journey by halving the pace of their experience gains and removing the ability to train mounts. Along this measured path, enticing rewards await those who embrace the challenge. Dinklestone and other beneficial items will be removed during this challenge.", 0, 10)
        player:GossipMenuAddItem(0, "NO TAKE ME BACK!", 0, 3)
        player:GossipSendMenu(2, unit)
    elseif intid == 10 then
		player:SendBroadcastMessage("You have embraced the Slow and Steady Mode. Brace yourself for a sluggish adventure!")
        player:AddItem(800048, 1)
        local charId = player:GetGUIDLow()
        WorldDBExecute("UPDATE custom_xp SET Rate = 0.5 WHERE CharID = "..charId)
		CharDBExecute("UPDATE custom_gather_rates SET GatherRate = 1 WHERE CharID = "..charId)
		CharDBExecute("UPDATE custom_rep_rates SET RepRate = 1 WHERE CharID = "..charId)
		CharDBExecute("UPDATE custom_craft_rates SET CraftRate = 1 WHERE CharID = "..charId)
		player:SetCoinage(0)
        player:RemoveItem(60002, player:GetItemCount(60002))
        player:RemoveItem(10594, player:GetItemCount(10594))
        player:RemoveItem(65000, player:GetItemCount(65000))
        player:RemoveSpell(24939)
        player:RemoveSpell(100117)
        player:RemoveSpell(100118)
        player:RemoveSpell(100105)
		player:RemoveItem(65000, 1)
		player:SendBroadcastMessage("Your experience gains have been set to half!")
        player:GossipComplete()
    elseif intid == 11 then
        player:GossipMenuAddItem(0, "Fragile Warrior Mode is for those seeking to test their skills under precarious conditions. In this mode, your damage done is decreased by 15% and damage taken is tripled. Brave the challenges and seek the path of the fragile warrior. Do you dare to take on this trial? You will only be able to remove this mode at 10 level intervals and currently only level 60 rewards are available for this mode.", 0, 12)
        player:GossipMenuAddItem(0, "NO TAKE ME BACK!", 0, 3)
        player:GossipSendMenu(2, unit)
    elseif intid == 12 then
        player:CastSpell(player, fragileWarriorSpellId, true)
		unit:PerformEmote(1)
        unit:SendUnitSay("You have embraced the Fragile Warrior Mode. May your battles be fierce and your victories hard-earned.", 0) -- Changed this line
        player:GossipComplete()
    elseif intid == 13 then
        player:RemoveAura(fragileWarriorSpellId)
        player:SendBroadcastMessage("Fragile Warrior Mode has been removed from your character.")
        player:GossipComplete()
    elseif intid == 14 then 
        player:GossipMenuAddItem(0, "Ironman Mode is for those seeking a true challenge. In this mode, you can only equip common or poor quality items. Brace yourself for a test of skill and perseverance. Are you up to the task?", 0, 15)
        player:GossipMenuAddItem(0, "NO TAKE ME BACK!", 0, 3)
        player:GossipSendMenu(2, unit)
    elseif intid == 15 then
        player:AddItem(800049, 1) 
        unit:SendUnitSay("You have embraced the Ironman Mode. May your journey be treacherous and your rewards well-deserved.", 0)
        player:GossipComplete()
    elseif intid == 16 then
        player:RemoveItem(800049, 1) 
        player:SendBroadcastMessage("Ironman mode has been removed from your character.")
        player:GossipComplete()
    elseif intid == 17 then
        player:RemoveItem(800048, 1) 
        player:SendBroadcastMessage("Slow and Steady mode has been removed from your character.")
        player:GossipComplete()
    elseif intid == 18 then
        player:AddItem(65000, 1)
        player:GossipComplete()
    elseif intid == 19 then 
        player:GossipMenuAddItem(0, "In Randomly Attacked Mode, you will be randomly attacked by enemies along your journey. Be vigilant and stay on your guard! Are you ready for the challenge?", 0, 20)
        player:GossipMenuAddItem(0, "NO TAKE ME BACK!", 0, 3)
        player:GossipSendMenu(2, unit)
    elseif intid == 20 then 
        player:AddItem(800050, 1) 
        player:SendBroadcastMessage("You have embraced the Randomly Attacked Mode. Be vigilant and stay on your guard as enemies may attack you at any moment!")
        player:GossipComplete()
    elseif intid == 21 then 
        player:RemoveItem(800050, 1)
        player:SendBroadcastMessage("Randomly Attacked mode has been removed from your character.")
        player:GossipComplete()
    elseif intid == 22 then 
        player:GossipMenuAddItem(0, "Pacifist Mode calls to those who wish to traverse the vast expanses of Azeroth, not as conquerors, but as harmonious explorers. Embrace this path, and no creature shall fall by your hand. Are you prepared to embody tranquility and tread a path of peace?", 0, 24)
        player:GossipMenuAddItem(0, "NO TAKE ME BACK!", 0, 3)
        player:GossipSendMenu(2, unit)
    elseif intid == 24 then 
        player:AddItem(pacifistModeItemId, 1) 
        player:SendBroadcastMessage("You have embraced the Pacifist Mode. In this mode, you will not be able to kill any creature. Failing the challenge will leave you with a 7 day debuff. Joining a group in this mode will fail your challenge.")
        player:GossipComplete()
    elseif intid == 23 then 
        player:RemoveItem(pacifistModeItemId, 1)
        player:SendBroadcastMessage("Pacifist Mode has been removed from your character.")
        player:GossipComplete()
    elseif intid == 25 then 
        player:GossipMenuAddItem(0, "Embrace the Diet Mode, perfect for those looking to shed some pixels. Eating and drinking? Overrated! Prepare for an adventure that's as lean as it gets. Ready to experience the 'hangry' side of Azeroth?", 0, 29)
        player:GossipMenuAddItem(0, "NO TAKE ME BACK!", 0, 3)
        player:GossipSendMenu(2, unit)
	elseif intid == 26 then 
        player:RemoveItem(dietModeItemId, 1)
        player:SendBroadcastMessage("Diet Mode has been removed from your character.")
        player:GossipComplete()
		    elseif intid == 28 then 
        player:RemoveItem(nomadModeItemId, 1)
        player:SendBroadcastMessage("Nomad Mode has been removed from your character.")
        player:GossipComplete()
    elseif intid == 29 then 
        player:AddItem(dietModeItemId, 1)
        player:SendBroadcastMessage("You have embraced the Diet Mode. Brace yourself for a lean and challenging adventure!")
        player:GossipComplete()
    elseif intid == 27 then 
        player:GossipMenuAddItem(0, "Nomad Mode - because who needs a cozy inn or teleportation spells when the whole world is your home? Say goodbye to your Dinkletone and Hearthstone and say hello to a life of wandering. Ready to give up your creature comforts?", 0, 33)
        player:GossipMenuAddItem(0, "NO TAKE ME BACK!", 0, 3)
        player:GossipSendMenu(2, unit)
    elseif intid == 33 then 
        player:AddItem(nomadModeItemId, 1)
        player:RemoveItem(65000, player:GetItemCount(65000))
        player:SendBroadcastMessage("You have embraced the Nomad Mode. Get ready for a life of wandering!")
        player:GossipComplete()
    elseif intid == 30 then 
        player:GossipMenuAddItem(0, "Think you're brave? Try Taxation Without Representation Mode! With a 90% gold tax, your wealth will disappear faster than a murloc's dignity at a fish market! Note: Being in a guild with guild funds module active will make earnings 90% of whatever you earned for guild funds. Highy reccomended to not do this challenge while in a guild, unless you want to be extra hardcore.", 0, 34)
        player:GossipMenuAddItem(0, "Wait, I changed my mind... I like my gold!", 0, 3)
        player:GossipSendMenu(2, unit)
    elseif intid == 34 then 
        player:AddItem(taxationWithoutRepresentationItemId, 1) 
		player:SetCoinage(0)
        player:SendBroadcastMessage("You've chosen the Taxation Without Representation Mode. Hope you're not too attached to your gold!")
        player:GossipComplete()
    elseif intid == 31 then 
        player:RemoveItem(taxationWithoutRepresentationItemId, 1)
        player:SendBroadcastMessage("Whew, you're free from the Taxation Without Representation Mode. Your coin purse breathes a sigh of relief.")
        player:GossipComplete()
    end
end


function OnHardCore(event, player, unit, sender, intid, code)
    if intid == 2 then
        player:AddItem(90000, 1)
        player:SetCoinage(0)
        player:RemoveItem(60002, player:GetItemCount(60002))
        player:RemoveItem(10594, player:GetItemCount(10594))
        player:RemoveItem(65000, player:GetItemCount(65000))
        player:RemoveSpell(24939)
        player:RemoveSpell(100117)
        player:RemoveSpell(100118)
        player:RemoveSpell(100105)
    else
        player:GossipComplete()
    end
end

function OnPlayerLevelUp(event, player, oldLevel)
    local playerLevel = player:GetLevel()
    if player:HasAura(fragileWarriorSpellId) and (playerLevel == 10 or playerLevel == 20 or playerLevel == 30 or playerLevel == 40 or playerLevel == 50 or playerLevel == 60 or playerLevel == 70 or playerLevel == 80) then
        player:SendBroadcastMessage("You've reached a milestone in Fragile Warrior Mode. You have the option to remove the challenge by visiting the NPC.")
    end
end

RegisterCreatureGossipEvent(hcNPC, 1 , OnFirstTalk)
RegisterCreatureGossipEvent(hcNPC, 2, OnSelect)
RegisterCreatureGossipEvent(hcNPC, 2, OnHardCore)
RegisterPlayerEvent(8, PlayerDeath)
RegisterPlayerEvent(13, OnPlayerLevelUp)
