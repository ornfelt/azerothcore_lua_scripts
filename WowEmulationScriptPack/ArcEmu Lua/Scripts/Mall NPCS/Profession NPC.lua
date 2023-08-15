--[[

	This is released by zdroid9770  :D

	© Copyright 2012

  Creator - LunarSCR
]]

function LunarSCR_Gossip(unit, event, player)
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(3, "Professions", 154, 0)
unit:GossipSendMenu(player)
end

function LunarSCR_Submenus(unit, event, player, id, intid, code)

if(intid == 154) then 
unit:GossipCreateMenu(50, player, 0)
unit:GossipMenuAddItem(0, "Alchemy", 400, 0)
unit:GossipMenuAddItem(0, "Blacksmithing", 401, 0)
unit:GossipMenuAddItem(0, "Enchanting", 402, 0)
unit:GossipMenuAddItem(0, "Engineering", 403, 0)
unit:GossipMenuAddItem(0, "Herbalism", 404, 0)
unit:GossipMenuAddItem(0, "Inscription", 405, 0)
unit:GossipMenuAddItem(0, "Jewelcrafting", 406, 0)
unit:GossipMenuAddItem(0, "Leatherworking", 407, 0)
unit:GossipMenuAddItem(0, "Mining", 408, 0)
unit:GossipMenuAddItem(0, "Skinning", 409, 0)
unit:GossipMenuAddItem(0, "Cooking", 410, 0)
unit:GossipMenuAddItem(0, "First Aid", 411, 0)
unit:GossipMenuAddItem(0, "Fishing", 412, 0)
unit:GossipMenuAddItem(0, "Tailoring", 413, 0)
unit:GossipSendMenu(player)
end

if(intid == 400) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Alchemy", 415, 0)
unit:GossipMenuAddItem(3, "Grand Master Alchemy", 416, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 401) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Blacksmithing", 417, 0)
unit:GossipMenuAddItem(3, "Grand Master Blacksmithing", 418, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 402) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "UnlearnGrand Master Enchanting", 419, 0)
unit:GossipMenuAddItem(3, "Grand Master Enchanting", 420, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 403) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Engineering", 421, 0)
unit:GossipMenuAddItem(3, "Grand Master Engineering", 422, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 404) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Herbalism", 423, 0)
unit:GossipMenuAddItem(3, "Grand Master Herbalism", 424, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 405) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Inscription", 425, 0)
unit:GossipMenuAddItem(3, "Grand Master Inscription", 426, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 406) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Jewelcrafting", 427, 0)
unit:GossipMenuAddItem(3, "Grand Master Jewelcrafting", 428, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 407) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Leatherworking", 429, 0)
unit:GossipMenuAddItem(3, "Grand Master Leatherworking", 430, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 408) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Mining", 431, 0)
unit:GossipMenuAddItem(3, "Grand Master Mining", 432, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 409) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Skinning", 433, 0)
unit:GossipMenuAddItem(3, "Grand Master Skinning", 434, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 410) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Cooking", 435, 0)
unit:GossipMenuAddItem(3, "Grand Master Cooking", 436, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 411) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master First Aid", 437, 0)
unit:GossipMenuAddItem(3, "Grand Master First Aid", 438, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 412) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Fishing", 439, 0)
unit:GossipMenuAddItem(3, "Grand Master Fishing", 440, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 413) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(3, "Unlearn Grand Master Tailor", 441, 0)
unit:GossipMenuAddItem(3, "Grand Master Tailor", 442, 0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end


if(intid == 415) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(51303)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 416) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(51303, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 417) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(51298)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 418) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(51298, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 419) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(51312)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 420) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(51312, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 421) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(51305)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 422) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(51305, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 423) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(50301)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 424) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(50301, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 425) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(45380)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 426) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(45380, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 427) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(51310)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 428) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(51310, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 429) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(51301)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 430) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(51301, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 431) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(50309)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 432) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(50309, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 433) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(50307)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 434) then
unit:GossipCreateMenu(3544, player, 0) 
unit:FullCastSpellOnTarget(50307, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 435) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(51295)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 436) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(51295, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 437) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(50299)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 438) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(50299, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 439) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(51293)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 440) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(51293, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 441) then
unit:GossipCreateMenu(3544, player, 0)
player:UnlearnSpell(51308)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 442) then
unit:GossipCreateMenu(3544, player, 0)
unit:FullCastSpellOnTarget(51308, player)
unit:GossipMenuAddItem(0, "|cffff0000Back", 154, 0)
unit:GossipSendMenu(player)
end

if(intid == 210) then 
unit:GossipCreateMenu(3599, player, 0)
unit:GossipMenuAddItem(0, "Alchemy", 400, 0)
unit:GossipMenuAddItem(0, "Blacksmithing", 401, 0)
unit:GossipMenuAddItem(0, "Enchanting", 402, 0)
unit:GossipMenuAddItem(0, "Engineering", 403, 0)
unit:GossipMenuAddItem(0, "Herbalism", 404, 0)
unit:GossipMenuAddItem(0, "Inscription", 405, 0)
unit:GossipMenuAddItem(0, "Jewelcrafting", 406, 0)
unit:GossipMenuAddItem(0, "Leatherworking", 407, 0)
unit:GossipMenuAddItem(0, "Mining", 408, 0)
unit:GossipMenuAddItem(0, "Skinning", 409, 0)
unit:GossipMenuAddItem(0, "Cooking", 410, 0)
unit:GossipMenuAddItem(0, "First Aid", 411, 0)
unit:GossipMenuAddItem(0, "Fishing", 412, 0)
unit:GossipMenuAddItem(0, "Tailoring", 413, 0)
unit:GossipMenuAddItem(5, "Set my profession skills to 450", 450,0)
unit:GossipMenuAddItem(0, "|cffff0000Back", 200, 0)
unit:GossipSendMenu(player)
end
end


RegisterUnitGossipEvent(7000003, 1,"LunarSCR_Gossip")
RegisterUnitGossipEvent(7000003, 2,"LunarSCR_Submenus")