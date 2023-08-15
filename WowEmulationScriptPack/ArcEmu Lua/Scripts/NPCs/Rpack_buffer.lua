local npcid = 990070
function Mega_Buff_NPC_Gossip(unit, event, player)
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Morph Options", 77, 0)
unit:GossipMenuAddItem(6, "Heal Options", 88, 0)
unit:GossipMenuAddItem(5, "Buff Options", 99, 0)
unit:GossipMenuAddItem(5, "Remove Sickness's Options ", 100, 0)
unit:GossipSendMenu(player)
end

function Mega_Buff_NPC_Submenus(unit, event, player, id, intid, code)
if(intid == 75) then
unit:GossipCreateMenu(78, player, 0)
unit:GossipMenuAddItem(6, "Morph Options", 77, 0)
unit:GossipMenuAddItem(6, "Heal Options", 88, 0)
unit:GossipMenuAddItem(5, "Buff Options", 99, 0)
unit:GossipMenuAddItem(5, "Remove Sickness's Options", 100, 0)
unit:GossipSendMenu(player)
end

if(intid == 4) then
unit:GossipCreateMenu(62, player, 0)
player:LearnSpell(15007)
player:UnlearnSpell(15007)
unit:GossipMenuAddItem(6, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 5) then
unit:GossipCreateMenu(63, player, 0)
player:LearnSpell(26013)
player:UnlearnSpell(26013)
unit:GossipMenuAddItem(6, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 77) then
unit:GossipCreateMenu(65, player, 0)
unit:GossipMenuAddItem(3,"Scuba-Goblin", 6, 0)
unit:GossipMenuAddItem(3,"Wrapped Sentry", 7, 0)
unit:GossipMenuAddItem(3,"Warp Guard", 8, 0)
unit:GossipMenuAddItem(3,"Ghost Wolf", 9, 0)
unit:GossipMenuAddItem(3,"Black Flower", 10, 0)
unit:GossipMenuAddItem(3,"Blue Flower", 11, 0)
unit:GossipMenuAddItem(3,"Thrall", 12, 0)
unit:GossipMenuAddItem(3,"Sneeds Shreader", 13, 0)
unit:GossipMenuAddItem(3,"Mage in Pimp Hat", 14, 0)
unit:GossipMenuAddItem(3,"Shark", 15, 0)
unit:GossipMenuAddItem(3,"Hammerhead Shark", 16, 0)
unit:GossipMenuAddItem(3,"Ironforge Guard", 17, 0)
unit:GossipMenuAddItem(3,"Ironfroge Mage", 18, 0)
unit:GossipMenuAddItem(3,"Horde Sentry Warrior", 19, 0)
unit:GossipMenuAddItem(3,"Horde Sentry Shaman", 20, 0)
unit:GossipSendMenu(player)
end

if(intid == 88) then
unit:GossipCreateMenu(69, player, 0)
unit:GossipMenuAddItem(4, "Renew +1200 Heal over Time", 1, 0)
unit:GossipMenuAddItem(4, "Holy Light +47500 HP", 2, 0)
unit:GossipMenuAddItem(4, "Cleanse Spirit", 3, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 99) then
unit:GossipCreateMenu(61, player, 0)
unit:FullCastSpellOnTarget(33077, player)
unit:FullCastSpellOnTarget(33078, player)
unit:FullCastSpellOnTarget(33079, player)
unit:FullCastSpellOnTarget(33080, player)
unit:FullCastSpellOnTarget(33081, player)
unit:FullCastSpellOnTarget(33082, player)
unit:FullCastSpellOnTarget(42995, player)
unit:FullCastSpellOnTarget(48161, player)
unit:FullCastSpellOnTarget(25898, player)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 100) then
unit:GossipCreateMenu(71, player, 0)
unit:GossipMenuAddItem(4, "Remove Ressurection Sickness", 4, 0)
unit:GossipMenuAddItem(4, "Remove Deserter Sickness", 5, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 1) then
unit:FullCastSpellOnTarget(57777, player)
end
if(intid == 2) then
unit:FullCastSpellOnTarget(58053, player)
end
if(intid == 3) then
unit:FullCastSpellOnTarget(51886, player)
end
if(intid == 6) then
player:SetModel(19076)
end
if(intid == 7) then
player:SetModel(19072)
end
if(intid == 8) then
player:SetModel(19061)
end
if(intid == 9) then
player:SetModel(19042)
end
if(intid == 10) then
player:SetModel(19034)
end
if(intid == 11) then
player:SetModel(19031)
end
if(intid == 12) then
player:SetModel(19015)
end
if(intid == 13) then
player:SetModel(19013)
end
if(intid == 14) then
player:SetModel(19005)
end
if(intid == 15) then
player:SetModel(12200)
end
if(intid == 16) then
player:SetModel(12204)
end
if(intid == 17) then
player:SetModel(21816)
end
if(intid == 18) then
player:SetModel(21835)
end
if(intid == 19) then
player:SetModel(23121)
end
if(intid == 20) then
player:SetModel(23183)
end
end

RegisterUnitGossipEvent(990070, 1, "Mega_Buff_NPC_Gossip")
RegisterUnitGossipEvent(990070, 2, "Mega_Buff_NPC_Submenus")