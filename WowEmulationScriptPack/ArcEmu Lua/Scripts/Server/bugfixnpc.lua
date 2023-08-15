function WelcomeNPC_OnGossipTalk(pUnit, event, player, pMisc)
if (player:IsInCombat() == true) then
player:SendAreaTriggerMessage("You Can't Claim Your Items While In Combat!")
else
pUnit:GossipCreateMenu(3544, player, 0)
pUnit:GossipMenuAddItem(2, "Weapons", 1, 0)
pUnit:GossipMenuAddItem(2, "Armor", 2, 0)
pUnit:GossipMenuAddItem(2, "Learn Plate Mail", 42, 0)
pUnit:GossipMenuAddItem(2, "Learn Mail", 43, 0)
pUnit:GossipMenuAddItem(2, "Learn Languages", 44, 0)
pUnit:GossipSendMenu(player)
end
end

function WelcomeNPC_OnGossipSelect(pUnit, event, player, id, intid, code)
if(intid == 2) then
pUnit:GossipCreateMenu(51, player, 0)
pUnit:GossipMenuAddItem(2, "Warlock Armor", 4, 0)
pUnit:GossipMenuAddItem(2, "Mage Armor", 5, 0)
pUnit:GossipMenuAddItem(2, "Warrior Armor", 6, 0)
pUnit:GossipMenuAddItem(2, "Paladin Armor", 7, 0)
pUnit:GossipMenuAddItem(2, "Shaman Armor", 8, 0)
pUnit:GossipMenuAddItem(2, "Hunter Armor", 9, 0)
pUnit:GossipMenuAddItem(2, "Druid Armor", 10, 0)
pUnit:GossipMenuAddItem(2, "Rouge Armor", 11, 0)
pUnit:GossipMenuAddItem(2, "Priest Armor", 12, 0)
pUnit:GossipSendMenu(player)
end

if(intid == 1) then
pUnit:GossipCreateMenu(52, player, 0)
pUnit:GossipMenuAddItem(2, "1H Sword", 14, 0)
pUnit:GossipMenuAddItem(2, "2H Sword", 15, 0)
pUnit:GossipMenuAddItem(2, "Bow", 16, 0)
pUnit:GossipMenuAddItem(2, "Dagger", 17, 0)
pUnit:GossipMenuAddItem(2, "2H Axe", 18, 0)
pUnit:GossipMenuAddItem(2, "1H Mace", 19, 0)
pUnit:GossipMenuAddItem(2, "2H Mace", 20, 0)
pUnit:GossipMenuAddItem(2, "Staff", 21, 0)
pUnit:GossipMenuAddItem(2, "Gun", 22, 0)
pUnit:GossipMenuAddItem(2, "Arrows", 23, 0)
pUnit:GossipMenuAddItem(2, "Bullets", 24, 0)
pUnit:GossipMenuAddItem(2, "Bags", 25, 0)
pUnit:GossipMenuAddItem(2, "Ammo Pouch", 26, 0)
pUnit:GossipMenuAddItem(2, "Shields", 28, 0)
pUnit:GossipMenuAddItem(2, "Quiver", 27, 0)
pUnit:GossipSendMenu(player)
end

if(intid == 4) then
player:AddItem(22504, 1)
player:AddItem(22505, 1)
player:AddItem(22506, 1)
player:AddItem(22507, 1)
player:AddItem(22508, 1)
player:AddItem(22509, 1)
player:AddItem(22510, 1)
player:AddItem(22511, 1)
end

if(intid == 5) then
player:AddItem(22496, 1)
player:AddItem(22497, 1)
player:AddItem(22498, 1)
player:AddItem(22499, 1)
player:AddItem(22500, 1)
player:AddItem(22501, 1)
player:AddItem(22502, 1)
player:AddItem(22503, 1)
end

if(intid == 6) then
player:AddItem(22416, 1)
player:AddItem(22417, 1)
player:AddItem(22418, 1)
player:AddItem(22419, 1)
player:AddItem(22420, 1)
player:AddItem(22421, 1)
player:AddItem(22422, 1)
player:AddItem(22423, 1)
end

if(intid == 7) then
player:AddItem(22424, 1)
player:AddItem(22425, 1)
player:AddItem(22426, 1)
player:AddItem(22427, 1)
player:AddItem(22428, 1)
player:AddItem(22429, 1)
player:AddItem(22430, 1)
player:AddItem(22431, 1)
end

if(intid == 8) then
player:AddItem(22464, 1)
player:AddItem(22465, 1)
player:AddItem(22466, 1)
player:AddItem(22467, 1)
player:AddItem(22468, 1)
player:AddItem(22469, 1)
player:AddItem(22470, 1)
player:AddItem(22471, 1)
end

if(intid == 9) then
player:AddItem(22436, 1)
player:AddItem(22437, 1)
player:AddItem(22438, 1)
player:AddItem(22439, 1)
player:AddItem(22440, 1)
player:AddItem(22441, 1)
player:AddItem(22442, 1)
player:AddItem(22243, 1)
end

if(intid == 10) then
player:AddItem(22488, 1)
player:AddItem(22489, 1)
player:AddItem(22490, 1)
player:AddItem(22491, 1)
player:AddItem(22492, 1)
player:AddItem(22493, 1)
player:AddItem(22494, 1)
player:AddItem(22495, 1)
end

if(intid == 11) then
player:AddItem(22476, 1)
player:AddItem(22477, 1)
player:AddItem(22478, 1)
player:AddItem(22479, 1)
player:AddItem(22480, 1)
player:AddItem(22481, 1)
player:AddItem(22482, 1)
player:AddItem(22483, 1)
end

if(intid == 12) then
player:AddItem(22512, 1)
player:AddItem(22513, 1)
player:AddItem(22514, 1)
player:AddItem(22515, 1)
player:AddItem(22516, 1)
player:AddItem(22517, 1)
player:AddItem(22518, 1)
player:AddItem(22519, 1)
end

if(intid == 14) then
player:AddItem(42945, 1)
end

if(intid == 15) then
player:AddItem(44092, 1)
end

if(intid == 16) then
player:AddItem(42946, 1)
end

if(intid == 17) then
player:AddItem(42944, 1)
end

if(intid == 18) then
player:AddItem(42943, 1)
end

if(intid == 19) then
player:AddItem(48716, 1)
player:AddItem(42948, 1)
end

if(intid == 20) then
player:AddItem(48718, 1)
end

if(intid == 21) then
player:AddItem(42947, 1)
end

if(intid == 22) then
player:AddItem(44093, 1)
end

if(intid == 23) then
player:AddItem(3464, 1000)
end

if(intid == 24) then
player:AddItem(3465, 1000)
end

if(intid == 25) then
player:AddItem(21841, 4)
end

if(intid == 26) then
player:AddItem(3604, 1)
end

if(intid == 27) then
player:AddItem(3605, 1)
end

if(intid == 28) then
player:AddItem(23043, 1)
player:AddItem(22819, 1)
end

if(intid == 42) then
player:LearnSpell(750)
end

if(intid == 43) then
player:LearnSpell(8737)
end

if(intid == 44) then
player:LearnSpell(669)
player:LearnSpell(668)
end
end

RegisterUnitGossipEvent(900025, 1, "WelcomeNPC_OnGossipTalk")
RegisterUnitGossipEvent(900025, 2, "WelcomeNPC_OnGossipSelect")