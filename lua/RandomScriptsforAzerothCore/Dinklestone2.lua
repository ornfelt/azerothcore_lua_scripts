function OnGossipHello(event, player, item)
if player:GetLevel() < 15 then
player:SendBroadcastMessage("You need to be level 15 or higher to use this item.")
return
end
player:GossipMenuAddItem(0, "|TInterface\\icons\\achievement_boss_lichking:37:37:-23|t|cff007d45Scourge Event|r", 150, 0)
player:GossipSendMenu(1, item)
end

local function OnGossipSelect(event, player, item, sender, intid, code)
if (sender == 150) then
-- Show Scourge Event menu
player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_misc_emotionhappy:37:37:-23|t|cff007d45Start Event for Bonus Lich Runes|r", 100, 0)
player:GossipMenuAddItem(0, "|TInterface\\icons\\spell_misc_emotionsad:37:37:-23|t|cffC41F3BStop Event but Suffer|r", 101, 0)
player:GossipMenuAddItem(0, "Back", 0, 0)
player:GossipSendMenu(1, item)
return
elseif (sender == 100) then
-- Start the event
if IsGameEventActive(17) then
player:SendBroadcastMessage("The Scourge event is already active.")
else
player:AddItem(43949, 2)
StartGameEvent(17, true)
player:PlayDirectSound(14797)
end
player:GossipComplete()
elseif (sender == 101) then
-- Stop the event
if not IsGameEventActive(17) then
player:SendBroadcastMessage("The Scourge event is not currently active.")
else
StopGameEvent(17, true)
player:CastSpell(player, 15007, true)
player:RemoveItem(43949, 2)
player:SetLevel(player:GetLevel())
player:SendBroadcastMessage("2 Lich Runes have been removed, you've been given Resurrection Sickness and have lost your current level's experience progress. So sad :(")
player:PlayDirectSound(14776)
end
player:GossipComplete()
elseif (sender == 0) then
-- return to main menu
OnGossipHello(event, player, item)
return
end

player:GossipComplete()
end

RegisterItemGossipEvent(65001, 1, OnGossipHello)
RegisterItemGossipEvent(65001, 2, OnGossipSelect)