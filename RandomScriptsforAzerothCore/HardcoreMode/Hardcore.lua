--NPC id
local hcNPC = 90000
--This is how long the character is locked for - default is 32 years.
local banTimer = 999999999

--on death function - checks if player has token and bans character if it does.
local function PlayerDeath(event, killer, killed)
  if killed:HasItem(90000,1) and killed:GetLevel() == 1 then
    print(killed:GetName() .. " was killed by " .. killer:GetName())
    SendWorldMessage(killed:GetName() .. " was killed by " .. killer:GetName())
    Ban(1,killed:GetName(),banTimer)
  end
end

--First Gossip Screen for NPC
function OnFirstTalk(event, player, unit)
  if player:GetLevel() == 1 then
    player:PlayDistanceSound(20431)
    player:GossipMenuAddItem(0, "Looking for a challenge? Click here to try hardcore mode!", 0, 1)
    player:GossipMenuAddItem(0, "What's with the wings?", 0, 4)
    player:GossipSendMenu(1, unit)
  else
    player:SendBroadcastMessage("You must be level 1 to access hardcore mode.")
    player:PlayDistanceSound(20432)
    player:GossipComplete()
  end
end

--Selection for NPC gossip
function OnSelect(event, player, unit, sender, intid, code)
  if intid == 1 then
    player:PlayDistanceSound(20433)
    player:GossipMenuAddItem(0, "Just double checking to make sure that you want to turn on hardcore mode. This will lock the character after death to be no longer playable, remove all your current gold, remove bonus starter items and Murky will no longer be with you! I will likely be adding rewards for reaching certain stages of the game later...", 0, 2)
    player:GossipMenuAddItem(0, "NO TAKE ME BACK!", 0, 3)
    player:GossipSendMenu(2, unit)
  elseif intid == 4 then
	player:PlayDistanceSound(172899)
    player:GossipMenuAddItem(0, "Wings are a major feature of this world and provide a number of unique benefits aside from simply looking great. If you open your spellbook, you'll notice a few new spells and can probably guess at what some of those benefits might be.", 0, 5)
    player:GossipSendMenu(4, unit)
  elseif intid == 5 then
    player:GossipMenuAddItem(0, "Where can I get wings?", 0, 6)
    player:GossipSendMenu(5, unit)
  elseif intid == 6 then
		player:PlayDistanceSound(172901)
    player:GossipMenuAddItem(0, "Wings have been scattered in various places throughout Azeroth and are primarily attached to tabards. That said not every tabard will provide wings and not all wings have been released in game. As time goes on I will add more wings with different sources of acquisition and different benefits. If you choose to do hardcore mode you may get lucky enough to acquire a pair for yourself if you make it to certain levels...", 0, 7)
    player:GossipSendMenu(6, unit)
  elseif intid == 7 then
    player:GossipComplete()
  end
end

--if player chooses to do hardcore they receive the token and have custom items and Murky removed
function OnHardCore(event, player, unit, sender, intid, code)
  if intid == 2 then
    player:PlayDistanceSound(20434)
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

RegisterCreatureGossipEvent(hcNPC, 1 , OnFirstTalk)
RegisterCreatureGossipEvent(hcNPC, 2, OnSelect)
RegisterCreatureGossipEvent(hcNPC, 2, OnHardCore)
RegisterPlayerEvent(8, PlayerDeath)