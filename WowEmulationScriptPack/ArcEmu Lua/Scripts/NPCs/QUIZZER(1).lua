-- Random Quiz NPC
-- Scripted by Alvanaar for AC-Web
--
-- Edit what is needed to be edited.
--
-- Feel free to modify and redistribute, however, please leave the original credits!

function Quiz_OnGossip(unit, event, player)
unit:GossipCreateMenu(700, player, 0)
unit:GossipMenuAddItem(5, "|cFF00008B>>>>>[-Server-]<<<<<", 1, 0)
unit:GossipMenuAddItem(5, "|cFFFF0000---------------------------", 2, 0)
unit:GossipMenuAddItem(0, "Question 1: Who Created Wow?", 3, 0)
unit:GossipMenuAddItem(5, "Ubisoft", 4, 0)
unit:GossipMenuAddItem(5, "Blizzard", 5, 0)
unit:GossipMenuAddItem(5, "Activsion", 6, 0)
unit:GossipMenuAddItem(5, "Rockstar Games", 7, 0)
unit:GossipSendMenu(player)
end

function Quiz_Questions(unit, event, player, code, intid, id)
if (intid == 4) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Nope...")
end

if (intid == 6) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Incorrect.")
end

if (intid == 7) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Wrong!")
end

if (intid == 5) then
unit:GossipCreateMenu(701, player, 0)
unit:GossipMenuAddItem(0, "Question 2: How Much Copys Did Wow Sell?", 8, 0)
unit:GossipMenuAddItem(5, "8.4 Million", 9, 0)
unit:GossipMenuAddItem(5, "5.5 Million", 10, 0)
unit:GossipMenuAddItem(5, "Over 9 Million", 11, 0)
unit:GossipMenuAddItem(5, "Over 4 Million", 12, 0)
unit:GossipSendMenu(player)
end

if (intid == 10) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Noo...")
end

if (intid == 11) then
player:GossipComplete()
unit:SendChatMesage(12, 0, "Wrong answer!")
end

if (intid == 12) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Uh-uh...")
end

if (intid == 9) then
unit:GossipCreateMenu(702, player, 0)
unit:GossipMenuAddItem(0, "Question 3: When Was Wow out in Stores?", 13, 0)
unit:GossipMenuAddItem(5, "2006", 14, 0)
unit:GossipMenuAddItem(5, "2005", 15, 0)
unit:GossipMenuAddItem(5, "2007", 16, 0)
unit:GossipMenuAddItem(5, "2004", 17, 0)
unit:GossipSendMenu(player)
end

if (intid == 14) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "That's not the right answer!")
end

if (intid == 15) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Sadly, that's wrong.")
end

if (intid == 16) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Incorrect answer.")
end

if (intid == 17) then
unit:GossipCreateMenu(703, player, 0)
unit:GossipMenuAddItem(0, "Question 4: Where is Party Zone Located?", 18, 0)
unit:GossipMenuAddItem(5, "Quel'Thalas", 19, 0)
unit:GossipMenuAddItem(5, "Wetlands", 20, 0)
unit:GossipMenuAddItem(5, "Terenas", 21, 0)
unit:GossipMenuAddItem(5, "Moonglade", 22, 0)
unit:GossipSendMenu(player)
end

if (intid == 20) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Umm, nope.")
end

if (intid == 21) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Incorrect answer!")
end

if (intid == 22) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "No, no, no!")
end

if (intid == 19) then
unit:GossipCreateMenu(704, player, 0)
unit:GossipMenuAddItem(0, "Question 5: Who is Owner of VigilanceWoW", 23, 0)
unit:GossipMenuAddItem(5, "Tom", 24, 0)
unit:GossipMenuAddItem(5, "Kuku", 25, 0)
unit:GossipMenuAddItem(5, "Kumi", 26, 0)
unit:GossipMenuAddItem(5, "Donald", 27, 0)
unit:GossipSendMenu(player)
end

if (intid == 24) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Haha, wrong!")
end

if (intid == 25) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Nah, incorrect...")
end

if (intid == 27) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Nope, not the right answer.")
end

if (intid == 26) then
unit:GossipCreateMenu(705, player, 0)
unit:GossipMenuAddItem(0, "Question 6: What is vigilancewow Site?", 28, 0)
unit:GossipMenuAddItem(5, "vigilancewow.servegame.org", 29, 0)
unit:GossipMenuAddItem(5, "vigilancewow.servegame.cc", 30, 0)
unit:GossipMenuAddItem(5, "vigilancewow.game-server.co", 31, 0)
unit:GossipMenuAddItem(5, "vigilance-wow.servgame.com", 32, 0)
unit:GossipSendMenu(player)
end

if (intid == 30) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Incorrect!")
end

if (intid == 31) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Sorry, that's wrong.")
end

if (intid == 32) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Nooo, wrong answer!!")
end

if (intid == 29) then
unit:GossipCreateMenu(706, player, 0)
unit:GossipMenuAddItem(0, "Question 7: This was Made Using?  ", 32, 0)
unit:GossipMenuAddItem(5, "C++", 33, 0)
unit:GossipMenuAddItem(5, "Lua", 34, 0)
unit:GossipMenuAddItem(5, "C+ and lua", 35, 0)
unit:GossipMenuAddItem(5, "C+++", 36, 0)
unit:GossipSendMenu(player)
end

if (intid == 33) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "Definately not!")
end

if (intid == 35) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "That answer isn't right.")
end

if (intid == 36) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "NO! Wrong...")
end

if (intid == 34) then
unit:GossipCreateMenu(707, player, 0)
unit:GossipMenuAddItem(0, "Question 8: ok..Last Question.. How Many Classes are in Wow?", 37, 0)
unit:GossipMenuAddItem(5, "Nine", 38, 0)
unit:GossipMenuAddItem(5, "Seven", 39, 0)
unit:GossipSendMenu(player)
end

if (intid == 39) then
player:GossipComplete()
unit:SendChatMessage(12, 0, "WRONG!")
end

if (intid == 38) then
if player:GetItemCount(40000) < 1 then
player:AddItem(40000, 1)
end
unit:FullCastSpellOnTarget(15366, player)
player:SendAreaTriggerMessage("Congratulations, you won!")
player:SendBroadcastMessage("Congratulations, you won!")
unit:SendChatMessage(12, 0, "Well done! Enjoy your reward...")
player:GossipComplete()
end
end


RegisterUnitGossipEvent(55552, 1, "Quiz_OnGossip")
RegisterUnitGossipEvent(55552, 2, "Quiz_Questions")