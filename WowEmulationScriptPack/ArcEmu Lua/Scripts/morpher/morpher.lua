--[[   
	
    Hungarian Half Scripting team (HHScripts).
    Copyright (C) 2009  Twl

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

--]]

function Morpher_Gossip(unit, event, player)
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, " >--> Morph <--<    ", 77, 0)
local race=player:GetPlayerRace()
end
function Morpher_Submenus(unit, event, player, id, intid, code)
if(intid == 75) then
unit:GossipCreateMenu(78, player, 0)
unit:GossipMenuAddItem(6, " >--> Morph <--<", 77, 0)
unit:GossipSendMenu(player)
end

if(intid == 77) then
unit:GossipCreateMenu(65, player, 0)
unit:GossipMenuAddItem(3,"Buvar golbin", 6, 0)
unit:GossipMenuAddItem(3,"Arthas", 7, 0)
unit:GossipMenuAddItem(3,"Lich Arthas", 8, 0)
unit:GossipMenuAddItem(3,"Sw Guard", 9, 0)
unit:GossipMenuAddItem(3,"Og Guard", 10, 0)
unit:GossipMenuAddItem(3,"Murlock", 11, 0)
unit:GossipMenuAddItem(3,"Murlock costume", 12, 0)
unit:GossipMenuAddItem(3,"Torp", 13, 0)
unit:GossipMenuAddItem(3,"Kalapos Mage", 14, 0)
unit:GossipMenuAddItem(3,"Capa", 15, 0)
unit:GossipMenuAddItem(3,"Hammerhead Shark", 16, 0)
unit:GossipMenuAddItem(3,"If Guard", 17, 0)
unit:GossipMenuAddItem(3,"If Mage", 18, 0)
unit:GossipMenuAddItem(3,"Horda Warrior", 19, 0)
unit:GossipMenuAddItem(3,"Horda Shaman", 20, 0)
unit:GossipSendMenu(player)
end

if(intid == 6) then
player:SetModel(19076)
end
if(intid == 7) then
player:SetModel(24949)
end
if(intid == 8) then
player:SetModel(24191)
end
if(intid == 9) then
player:SetModel(5567)
end
if(intid == 10) then
player:SetModel(23007)
end
if(intid == 11) then
player:SetModel(617)
end
if(intid == 12) then
player:SetModel(21723)
end
if(intid == 13) then
player:SetModel(27540)
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
if(intid == 40) then
player:SetModel(49)
end
if(intid == 41) then
player:SetModel(51)
if(intid == 42) then
end
player:SetModel(53)
end
if(intid == 43) then
end
player:SetModel(55)
if(intid == 44) then
end
player:SetModel(57)
end
if(intid == 45) then
end
player:SetModel(59)
if(intid == 46) then
end
player:SetModel(1563)
end
if(intid == 47) then
end
player:SetModel(1478)
if(intid == 48) then
end
player:SetModel(15746)
end
if(intid == 49) then
end
player:SetModel(16125)
if(intid == 50) then
end
player:SetModel()
end
end

RegisterUnitGossipEvent(91000, 1, "Morpher_Gossip")
RegisterUnitGossipEvent(91000, 2, "Morpher_Submenus")
