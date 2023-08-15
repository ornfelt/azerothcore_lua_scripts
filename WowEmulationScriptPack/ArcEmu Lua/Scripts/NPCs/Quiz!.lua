logcol(12)
print("Alliance Quiz succesfully loaded!")
logcol(7)

local NPCID = 55552

function npc_OnTalk(pUnit, event, player)
if player:HasItem(51936) or
player:HasItem(49888) or
player:HasItem(47519) or
player:HasItem(46980) or
player:HasItem(50731) or
player:HasItem(48711) or
player:HasItem(47521) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "You have already done this quiz!")
elseif
(player:IsGm() == true) then
pUnit:GossipCreateMenu(701, player, 0)
pUnit:GossipMenuAddItem(5, "|cFF00008B>>>>>[-Server-]<<<<<", 1, 0)
pUnit:GossipMenuAddItem(5, "|cFFFF0000---------------------------", 2, 0)
pUnit:GossipMenuAddItem(0, "Question 1: Who Created Wow?", 3, 0)
pUnit:GossipMenuAddItem(5, "Ubisoft", 4, 0)
pUnit:GossipMenuAddItem(5, "Blizzard", 5, 0)
pUnit:GossipMenuAddItem(5, "Activsion", 6, 0)
pUnit:GossipMenuAddItem(5, "Rockstar Games", 7, 0)
pUnit:GossipMenuAddItem(0, "Skip this Quiz", 38, 0)
pUnit:GossipSendMenu(player)
else
pUnit:GossipCreateMenu(700, player, 0)
pUnit:GossipMenuAddItem(5, "|cFF00008B>>>>>[-Server-]<<<<<", 1, 0)
pUnit:GossipMenuAddItem(5, "|cFFFF0000---------------------------", 2, 0)
pUnit:GossipMenuAddItem(0, "Question 1: Who Created Wow?", 3, 0)
pUnit:GossipMenuAddItem(5, "Ubisoft", 4, 0)
pUnit:GossipMenuAddItem(5, "Blizzard", 5, 0)
pUnit:GossipMenuAddItem(5, "Activsion", 6, 0)
pUnit:GossipMenuAddItem(5, "Rockstar Games", 7, 0)
pUnit:GossipSendMenu(player)
end
end


function npc_OnSubMenus(pUnit, event, player, code, intid, id)
if (intid == 4) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Nope...")
end

if (intid == 6) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Incorrect.")
end

if (intid == 7) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Wrong!")
end

if (intid == 5) then
pUnit:GossipCreateMenu(701, player, 0)
pUnit:GossipMenuAddItem(0, "Question 2: How Much Copyies Did Wow Sell?", 8, 0)
pUnit:GossipMenuAddItem(5, "8.4 Million", 9, 0)
pUnit:GossipMenuAddItem(5, "5.5 Million", 10, 0)
pUnit:GossipMenuAddItem(5, "Over 9 Million", 11, 0)
pUnit:GossipMenuAddItem(5, "Over 4 Million", 12, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 10) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Noo...")
end

if (intid == 11) then
player:GossipComplete()
pUnit:SendChatMesage(12, 0, "Wrong answer!")
end

if (intid == 12) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Uh-uh...")
end

if (intid == 9) then
pUnit:GossipCreateMenu(702, player, 0)
pUnit:GossipMenuAddItem(0, "Question 3: When Was Wow out in Stores?", 13, 0)
pUnit:GossipMenuAddItem(5, "2006", 14, 0)
pUnit:GossipMenuAddItem(5, "2005", 15, 0)
pUnit:GossipMenuAddItem(5, "2007", 16, 0)
pUnit:GossipMenuAddItem(5, "2004", 17, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 14) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "That's not the right answer!")
end

if (intid == 15) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Sadly, that's wrong.")
end

if (intid == 16) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Incorrect answer.")
end

if (intid == 17) then
pUnit:GossipCreateMenu(703, player, 0)
pUnit:GossipMenuAddItem(0, "Question 4: Where is Party Zone Located?", 18, 0)
pUnit:GossipMenuAddItem(5, "Quel'Thalas", 19, 0)
pUnit:GossipMenuAddItem(5, "Wetlands", 20, 0)
pUnit:GossipMenuAddItem(5, "Terenas", 21, 0)
pUnit:GossipMenuAddItem(5, "Moonglade", 22, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 20) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Umm, nope.")
end

if (intid == 21) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Incorrect answer!")
end

if (intid == 22) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "No, no, no!")
end

if (intid == 19) then
pUnit:GossipCreateMenu(704, player, 0)
pUnit:GossipMenuAddItem(0, "Question 5: Who is Owner of VigilanceWoW", 23, 0)
pUnit:GossipMenuAddItem(5, "Tom", 24, 0)
pUnit:GossipMenuAddItem(5, "Kuku", 25, 0)
pUnit:GossipMenuAddItem(5, "Kumi", 26, 0)
pUnit:GossipMenuAddItem(5, "Donald", 27, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 24) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Haha, wrong!")
end

if (intid == 25) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Nah, incorrect...")
end

if (intid == 27) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Nope, not the right answer.")
end

if (intid == 26) then
pUnit:GossipCreateMenu(705, player, 0)
pUnit:GossipMenuAddItem(0, "Question 6: What is vigilancewow Site?", 28, 0)
pUnit:GossipMenuAddItem(5, "vigilancewow.servegame.org", 29, 0)
pUnit:GossipMenuAddItem(5, "vigilancewow.servegame.cc", 30, 0)
pUnit:GossipMenuAddItem(5, "vigilancewow.game-server.co", 31, 0)
pUnit:GossipMenuAddItem(5, "vigilance-wow.servgame.com", 32, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 30) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Incorrect!")
end

if (intid == 31) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Sorry, that's wrong.")
end

if (intid == 32) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Nooo, wrong answer!!")
end

if (intid == 29) then
pUnit:GossipCreateMenu(706, player, 0)
pUnit:GossipMenuAddItem(0, "Question 7: This was Made Using?  ", 32, 0)
pUnit:GossipMenuAddItem(5, "C++", 33, 0)
pUnit:GossipMenuAddItem(5, "Lua", 34, 0)
pUnit:GossipMenuAddItem(5, "C+ and lua", 35, 0)
pUnit:GossipMenuAddItem(5, "C+++", 36, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 33) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "Definately not!")
end

if (intid == 35) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "That answer isn't right.")
end

if (intid == 36) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "NO! Wrong...")
end

if (intid == 34) then
pUnit:GossipCreateMenu(707, player, 0)
pUnit:GossipMenuAddItem(0, "Question 8: ok..Last Question.. How Many Classes are in Wow?", 37, 0)
pUnit:GossipMenuAddItem(5, "Nine", 38, 0)
pUnit:GossipMenuAddItem(5, "Seven", 39, 0)
pUnit:GossipSendMenu(player)
end

if (intid == 39) then
player:GossipComplete()
pUnit:SendChatMessage(12, 0, "WRONG!")
end

if (intid == 38) then
if (player:GetPlayerClass() == "Warrior") then
player:AddItem(51936, 1) -- 2H Sword
end
if (player:GetPlayerClass() == "Death Knight") then
player:AddItem(49888, 1) -- 2H Axe
end
if (player:GetPlayerClass() == "Paladin") then
player:AddItem(47519, 1) -- 2H Mace
end
if (player:GetPlayerClass() == "Rogue") then
player:AddItem(46980, 1) -- MainHand Dagger
player:AddItem(51880, 1) -- Thrown
end
if (player:GetPlayerClass() == "Mage") then
player:AddItem(50731, 1) -- Staff
player:AddItem(50684, 1) -- Wand
end
if (player:GetPlayerClass() == "Warlock") then
player:AddItem(50731, 1) -- Staff
player:AddItem(50684, 1) -- Wand
end
if (player:GetPlayerClass() == "Druid") then
player:AddItem(50731, 1) -- Staff
end
if (player:GetPlayerClass() == "Priest") then
player:AddItem(50731, 1) -- Staff
player:AddItem(50684, 1) -- Wand
end
if (player:GetPlayerClass() == "Shaman") then
player:AddItem(47519, 1) -- 2H Mace
end
if (player:GetPlayerClass() == "Hunter") then
player:AddItem(48711, 1) -- Bow
player:AddItem(47521, 1) -- Gun
end
pUnit:FullCastSpellOnTarget(15366, player)
player:SendAreaTriggerMessage("Congratulations, you won!")
player:SendBroadcastMessage("Congratulations, you won!")
pUnit:SendChatMessage(12, 0, "Well done! Enjoy your reward...")
player:GossipComplete()
end
end

RegisterUnitGossipEvent(55552, 1, "npc_OnTalk")
RegisterUnitGossipEvent(55552, 2, "npc_OnSubMenus")