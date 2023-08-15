--[[	

This is created by zdroid9770  :D	

© Copyright 2012

--]]

local npcid = 400002

function spellst_on_gossip(unit, Event, player)
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(7, "Alliance", 5002, 0)
unit:GossipMenuAddItem(7, "Horde", 1001, 0)
unit:GossipMenuAddItem(7, "Netural", 1002, 0)
unit:GossipMenuAddItem(7, "Quests/Class", 1100, 0)
unit:GossipMenuAddItem(7, "Unknown", 5001, 0)
unit:GossipMenuAddItem(7, "Learn All", 5300, 0)
unit:GossipSendMenu(player)
end

function spellst_submenus(unit, event, player, id, intid, code, pMisc)
if(intid == 1003) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(7, "Alliance", 5002, 0)
unit:GossipMenuAddItem(7, "Horde", 1001, 0)
unit:GossipMenuAddItem(7, "Netural", 1002, 0)
unit:GossipMenuAddItem(7, "Quests/Class", 1100, 0)
unit:GossipMenuAddItem(7, "Unknown", 5001, 0)
unit:GossipMenuAddItem(7, "Learn All", 5300, 0)
unit:GossipSendMenu(player)
end

if(intid == 1100) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Cat Form", 527, 0)
unit:GossipMenuAddItem(6, "Cat Form Prowl", 528, 0)
unit:GossipMenuAddItem(6, "Bear Form", 529, 0)
unit:GossipMenuAddItem(6, "Aquatic Form", 530, 0)
unit:GossipMenuAddItem(6, "Travel Form", 531, 0)
unit:GossipMenuAddItem(6, "Flight Form", 532, 0)
unit:GossipMenuAddItem(6, "Swift Flight Form", 533, 0)
unit:GossipMenuAddItem(6, "Moonkin Form", 534, 0)
unit:GossipMenuAddItem(6, "Tree of Life", 535, 0)
unit:GossipMenuAddItem(6, "Ghost Wolf", 536, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 5002) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Striped Frostsaber", 1, 0)
unit:GossipMenuAddItem(6, "Striped Nightsaber", 2, 0)
unit:GossipMenuAddItem(6, "Striped Dawnsaber", 3, 0)
unit:GossipMenuAddItem(6, "Spotted Frostsaber", 4, 0)
unit:GossipMenuAddItem(6, "Swift Frostsaber", 5, 0)
unit:GossipMenuAddItem(6, "Swift Mistsaber", 6, 0)
unit:GossipMenuAddItem(6, "Swift Stormsaber", 7, 0)
unit:GossipMenuAddItem(6, "Blue Mechanostrider", 8, 0)
unit:GossipMenuAddItem(6, "Red Mechanostrider", 9, 0)
unit:GossipMenuAddItem(6, "Green Mechanostrider", 10, 0)
unit:GossipMenuAddItem(6, "Unpainted Mechanostrider", 11, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 999, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 999) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Swift White Mechanostrider", 13, 0)
unit:GossipMenuAddItem(6, "Swift Yellow Mechanostrider", 14, 0)
unit:GossipMenuAddItem(6, "Swift Brown Ram", 15, 0)
unit:GossipMenuAddItem(6, "Swift Gray Ram", 16, 0)
unit:GossipMenuAddItem(6, "Swift White Ram", 17, 0)
unit:GossipMenuAddItem(6, "Brown Ram", 18, 0)
unit:GossipMenuAddItem(6, "Gray Ram", 19, 0)
unit:GossipMenuAddItem(6, "White Ram", 20, 0)
unit:GossipMenuAddItem(6, "Brown Elekk", 21, 0)
unit:GossipMenuAddItem(6, "Gray Elekk", 22, 0)
unit:GossipMenuAddItem(6, "Purple Elekk", 23, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 998, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 5002, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 998) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Great Blue Elekk", 25, 0)
unit:GossipMenuAddItem(6, "Great Green Elekk", 26, 0)
unit:GossipMenuAddItem(6, "Pinto Bridle", 27, 0)
unit:GossipMenuAddItem(6, "Chestnut Mare Bridle", 28, 0)
unit:GossipMenuAddItem(6, "Brown Horse Bridle", 29, 0)
unit:GossipMenuAddItem(6, "Black Stallion Bridle", 30, 0)
unit:GossipMenuAddItem(6, "Swift Brown Steed", 31, 0)
unit:GossipMenuAddItem(6, "Swift Palomino", 32, 0)
unit:GossipMenuAddItem(6, "Swift White Steed", 33, 0)
unit:GossipMenuAddItem(6, "Ebon Gryphon", 34, 0)
unit:GossipMenuAddItem(6, "Golden Gryphon", 35, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 997, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 999, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 997) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Swift Blue Gryphon", 37, 0)
unit:GossipMenuAddItem(6, "Swift Green Gryphon", 38, 0)
unit:GossipMenuAddItem(6, "Swift Purple Gryphon", 39, 0)
unit:GossipMenuAddItem(6, "Swift Red Gryphon", 40, 0)
unit:GossipMenuAddItem(6, "Armored Brown Bear", 41, 0)
unit:GossipMenuAddItem(6, "Wooly Mammoth", 42, 0)
unit:GossipMenuAddItem(6, "Traveler's Tundra Mammoth", 43, 0)
unit:GossipMenuAddItem(6, "Armored Snowy Gryphon 20:TC", 44, 0)
unit:GossipMenuAddItem(6, "Cobalt War Talbuk", 45, 0)
unit:GossipMenuAddItem(6, "Silver War Talbuk", 46, 0)
unit:GossipMenuAddItem(6, "Tan War Talbuk", 47, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 996, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 998, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 996) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Cobalt Riding Talbuk", 49, 0)
unit:GossipMenuAddItem(6, "Silver Riding Talbuk", 50, 0)
unit:GossipMenuAddItem(6, "Tan Riding Talbuk", 51, 0)
unit:GossipMenuAddItem(6, "White Riding Talbuk", 52, 0)
unit:GossipMenuAddItem(6, "Winterspring Frostsaber", 53, 0)
unit:GossipMenuAddItem(6, "Quel'dorei Steed", 54, 0)
unit:GossipMenuAddItem(6, "Silver Covenant Hippogryph", 55, 0)
unit:GossipMenuAddItem(6, "Ice Mammoth", 56, 0)
unit:GossipMenuAddItem(6, "Grand Ice Mammoth", 57, 0)
unit:GossipMenuAddItem(6, "Crusader's White Warhorse", 58, 0)
unit:GossipMenuAddItem(6, "Grand Black War Mammoth", 59, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 995, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 997, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 995) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Black Battlestrider", 61, 0)
unit:GossipMenuAddItem(6, "Black War Ram", 62, 0)
unit:GossipMenuAddItem(6, "Black War Steed Bridle", 63, 0)
unit:GossipMenuAddItem(6, "Black War Elekk", 64, 0)
unit:GossipMenuAddItem(6, "Black War Tiger", 65, 0)
unit:GossipMenuAddItem(6, "Stormpike Battle Charger", 66, 0)
unit:GossipMenuAddItem(6, "Black War Mammoth", 67, 0)
unit:GossipMenuAddItem(6, "Mekgineer's Chopper", 68, 0)
unit:GossipMenuAddItem(6, "Darnassian Nightsaber", 69, 0)
unit:GossipMenuAddItem(6, "Exodar Elekk", 70, 0)
unit:GossipMenuAddItem(6, "Gnomeregan Mechanostrider", 71, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 994, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 996, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 994) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Stormwind Steed", 73, 0)
unit:GossipMenuAddItem(6, "Great Red Elekk", 74, 0)
unit:GossipMenuAddItem(6, "Swift Gray Steed", 75, 0)
unit:GossipMenuAddItem(6, "Swift Moonsaber", 76, 0)
unit:GossipMenuAddItem(6, "Swift Violet Ram", 77, 0)
unit:GossipMenuAddItem(6, "Turbostrider", 78, 0)
unit:GossipMenuAddItem(6, "Black War Bear", 79, 0)
unit:GossipMenuAddItem(6, "Blue Dragonhawk", 80, 0)
unit:GossipMenuAddItem(6, "Swift Green Mechanostrider", 12, 0)
unit:GossipMenuAddItem(6, "Great Purple Elekk", 24, 0)
unit:GossipMenuAddItem(6, "Snowy Gryphon", 36, 0)
unit:GossipMenuAddItem(7, "Next >>--->", 2002, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 995, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 2002) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "White War Talbuk", 48, 0)
unit:GossipMenuAddItem(6, "Swift Alliance Steed", 60, 0)
unit:GossipMenuAddItem(6, "Ironforge Ram", 72, 0)
unit:GossipMenuAddItem(6, "Ancient Frostsaber", 500, 0)
unit:GossipMenuAddItem(6, "Palomino", 501, 0)
unit:GossipMenuAddItem(6, "White Stallion", 502, 0)
unit:GossipMenuAddItem(6, "Black Ram", 506, 0)
unit:GossipMenuAddItem(6, "Frost Ram", 508, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 994, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 1001) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Swift Brown Wolf", 81, 0)
unit:GossipMenuAddItem(6, "Swift Gray Wolf", 82, 0)
unit:GossipMenuAddItem(6, "Swift Timber Wolf", 83, 0)
unit:GossipMenuAddItem(6, "Black Wolf", 84, 0)
unit:GossipMenuAddItem(6, "Brown Wolf", 85, 0)
unit:GossipMenuAddItem(6, "Dire Wolf", 86, 0)
unit:GossipMenuAddItem(6, "Timber Wolf", 87, 0)
unit:GossipMenuAddItem(6, "Black Hawkstrider", 88, 0)
unit:GossipMenuAddItem(6, "Blue Hawkstrider", 89, 0)
unit:GossipMenuAddItem(6, "Red Hawkstrider", 90, 0)
unit:GossipMenuAddItem(6, "Purple Hawkstrider", 91, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 990, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 990) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Swift Green Hawkstrider", 93, 0)
unit:GossipMenuAddItem(6, "Swift Pink Hawkstrider", 94, 0)
unit:GossipMenuAddItem(6, "Emerald Raptor", 95, 0)
unit:GossipMenuAddItem(6, "Turquoise Raptor", 96, 0)
unit:GossipMenuAddItem(6, "Violet Raptor", 97, 0)
unit:GossipMenuAddItem(6, "Swift Blue Raptor", 98, 0)
unit:GossipMenuAddItem(6, "Swift Olive Raptor", 99, 0)
unit:GossipMenuAddItem(6, "Swift Orange Raptor", 100, 0)
unit:GossipMenuAddItem(6, "Brown Kodo", 101, 0)
unit:GossipMenuAddItem(6, "Gray Kodo", 102, 0)
unit:GossipMenuAddItem(6, "White Kodo", 103, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 989, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 1001, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 989) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Great Brown Kodo", 105, 0)
unit:GossipMenuAddItem(6, "Great Gray Kodo", 106, 0)
unit:GossipMenuAddItem(6, "Red Skeletal Horse", 107, 0)
unit:GossipMenuAddItem(6, "Brown Skeletal Horse", 108, 0)
unit:GossipMenuAddItem(6, "Blue Skeletal Horse", 109, 0)
unit:GossipMenuAddItem(6, "Black Skeletal Horse", 110, 0)
unit:GossipMenuAddItem(6, "Green Skeletal Warhorse", 111, 0)
unit:GossipMenuAddItem(6, "Ochre Skeletal Warhorse", 112, 0)
unit:GossipMenuAddItem(6, "Purple Skeletal Warhorse", 113, 0)
unit:GossipMenuAddItem(6, "Blue Wind Rider", 114, 0)
unit:GossipMenuAddItem(6, "Green Wind Rider", 115, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 988, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 990, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 988) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Swift Yellow Wind Rider", 117, 0)
unit:GossipMenuAddItem(6, "Swift Red Wind Rider", 118, 0)
unit:GossipMenuAddItem(6, "Swift Purple Wind Rider", 119, 0)
unit:GossipMenuAddItem(6, "Swift Green Wind Rider", 120, 0)
unit:GossipMenuAddItem(6, "Armored Brown Bear", 121, 0)
unit:GossipMenuAddItem(6, "Wooly Mammoth", 122, 0)
unit:GossipMenuAddItem(6, "Traveler's Tundra Mammoth", 123, 0)
unit:GossipMenuAddItem(6, "Armored Blue Wind Rider", 124, 0)
unit:GossipMenuAddItem(6, "Cobalt War Talbuk", 125, 0)
unit:GossipMenuAddItem(6, "Silver War Talbuk", 126, 0)
unit:GossipMenuAddItem(6, "Tan War Talbuk", 127, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 987, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 989, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 987) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Cobalt Riding Talbuk", 129, 0)
unit:GossipMenuAddItem(6, "Silver Riding Talbuk", 130, 0)
unit:GossipMenuAddItem(6, "Tan Riding Talbuk", 131, 0)
unit:GossipMenuAddItem(6, "White Riding Talbuk", 132, 0)
unit:GossipMenuAddItem(6, "Venomhide Ravasaur", 133, 0)
unit:GossipMenuAddItem(6, "Sunreaver Hawkstrider", 134, 0)
unit:GossipMenuAddItem(6, "Sunreaver DragonHawk", 135, 0)
unit:GossipMenuAddItem(6, "Ice Mammoth", 136, 0)
unit:GossipMenuAddItem(6, "Grand Ice Mammoth", 137, 0)
unit:GossipMenuAddItem(6, "Crusader's Black Warhorse", 138, 0)
unit:GossipMenuAddItem(6, "Grand Black War Mammoth", 139, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 986, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 988, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 986) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Black War Kodo", 141, 0)
unit:GossipMenuAddItem(6, "Black War Wolf", 142, 0)
unit:GossipMenuAddItem(6, "Red Skeletal Warhorse", 143, 0)
unit:GossipMenuAddItem(6, "Swift Warstrider", 144, 0)
unit:GossipMenuAddItem(6, "Black War Raptor", 145, 0)
unit:GossipMenuAddItem(6, "Frostwolf Howler", 146, 0)
unit:GossipMenuAddItem(6, "Black War Mammoth", 147, 0)
unit:GossipMenuAddItem(6, "Mechano-Hog", 148, 0)
unit:GossipMenuAddItem(6, "Darkspear Raptor", 149, 0)
unit:GossipMenuAddItem(6, "Forsaken Warhorse", 150, 0)
unit:GossipMenuAddItem(6, "Orgrimmar Wolf", 151, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 985, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 987, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 985) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Thunder Bluff Kodo", 153, 0)
unit:GossipMenuAddItem(6, "Great Golden Kodo", 154, 0)
unit:GossipMenuAddItem(6, "Swift Burgundy Wolf", 155, 0)
unit:GossipMenuAddItem(6, "Swift Purple Raptor", 156, 0)
unit:GossipMenuAddItem(6, "Swift Red Hawkstrider", 157, 0)
unit:GossipMenuAddItem(6, "White Skeletal Warhorse", 158, 0)
unit:GossipMenuAddItem(6, "Black War Bear", 159, 0)
unit:GossipMenuAddItem(6, "Red Dragonhawk", 160, 0)
unit:GossipMenuAddItem(6, "Swift Purple Hawkstrider", 92, 0)
unit:GossipMenuAddItem(6, "Great White Kodo", 104, 0)
unit:GossipMenuAddItem(6, "Tawny Wind Rider", 116, 0)
unit:GossipMenuAddItem(7, "Next >>--->", 2001, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 986, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 2001) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "White War Talbuk", 128, 0)
unit:GossipMenuAddItem(6, "Swift Horde Wolf", 140, 0)
unit:GossipMenuAddItem(6, "Silvermoon Hawkstrider", 152, 0)
unit:GossipMenuAddItem(6, "Green Kodo", 509, 0)
unit:GossipMenuAddItem(6, "Teal Kodo", 510, 0)
unit:GossipMenuAddItem(6, "Red Wolf", 512, 0)
unit:GossipMenuAddItem(6, "Mottled Red Raptor", 513, 0)
unit:GossipMenuAddItem(6, "Winter Wolf", 514, 0)
unit:GossipMenuAddItem(6, "Winter Wolf", 515, 0)
unit:GossipMenuAddItem(6, "Ivory Raptor", 518, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 985, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 1002) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Azure Netherwing Drake", 161, 0)
unit:GossipMenuAddItem(6, "Cobalt Netherwing Drake", 162, 0)
unit:GossipMenuAddItem(6, "Onyx Netherwing Drake", 163, 0)
unit:GossipMenuAddItem(6, "Purple Netherwing Drake", 164, 0)
unit:GossipMenuAddItem(6, "Veridan Netherwing Drake", 165, 0)
unit:GossipMenuAddItem(6, "Violet Netherwing Drake", 166, 0)
unit:GossipMenuAddItem(6, "Blue Riding Nether Ray", 167, 0)
unit:GossipMenuAddItem(6, "Green Riding Nether Ray", 168, 0)
unit:GossipMenuAddItem(6, "Red Riding Nether Ray", 169, 0)
unit:GossipMenuAddItem(6, "Purple Riding Nether Ray", 170, 0)
unit:GossipMenuAddItem(6, "Silver Riding Nether Ray", 171, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 950, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 950) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Red Drake", 173, 0)
unit:GossipMenuAddItem(6, "Green Proto-Drake", 174, 0)
unit:GossipMenuAddItem(6, "Swift Nether Drake", 175, 0)
unit:GossipMenuAddItem(6, "Merciless Nether Drake", 176, 0)
unit:GossipMenuAddItem(6, "Vengeful Nether Drake", 177, 0)
unit:GossipMenuAddItem(6, "Brutal Nether Drake", 178, 0)
unit:GossipMenuAddItem(6, "Furious Gladiator's Frost Wyrm", 179, 0)
unit:GossipMenuAddItem(6, "Dark Riding Talbuk", 180, 0)
unit:GossipMenuAddItem(6, "Dark War Talbuk", 181, 0)
unit:GossipMenuAddItem(6, "Amani War Bear", 182, 0)
unit:GossipMenuAddItem(6, "Ashes of Al'ar", 183, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 951, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 1002, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 951) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Fiery Warhorse Reins", 185, 0)
unit:GossipMenuAddItem(6, "Invincible's Reins", 186, 0)
unit:GossipMenuAddItem(6, "Mimiron's Head", 187, 0)
unit:GossipMenuAddItem(6, "Black Drake", 188, 0)
unit:GossipMenuAddItem(6, "Twilight Drake", 189, 0)
unit:GossipMenuAddItem(6, "Blue Drake", 190, 0)
unit:GossipMenuAddItem(6, "Azure Drake", 191, 0)
unit:GossipMenuAddItem(6, "Blue Proto-Drake", 192, 0)
unit:GossipMenuAddItem(6, "Bronze Drake", 193, 0)
unit:GossipMenuAddItem(6, "Crimson Deathcharger", 194, 0)
unit:GossipMenuAddItem(6, "Raven Lord", 195, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 952, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 950, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 952) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Swift Razzashi Raptor", 197, 0)
unit:GossipMenuAddItem(6, "Swift Zulian Tiger", 198, 0)
unit:GossipMenuAddItem(6, "Black Proto-Drake", 199, 0)
unit:GossipMenuAddItem(6, "Ironbound Proto-Drake", 200, 0)
unit:GossipMenuAddItem(6, "Plagued Proto-Drake", 201, 0)
unit:GossipMenuAddItem(6, "Red Proto-Drake", 202, 0)
unit:GossipMenuAddItem(6, "Rusted Proto-Drake", 203, 0)
unit:GossipMenuAddItem(6, "Violet Proto-Drake", 204, 0)
unit:GossipMenuAddItem(6, "Time-Lost Proto-Drake", 205, 0)
unit:GossipMenuAddItem(6, "Sea Turtle", 206, 0)
unit:GossipMenuAddItem(6, "Blue Qiraji Resonating Cyrstal", 207, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 953, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 951, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 953) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Red Qiraji Resonating Crystal", 209, 0)
unit:GossipMenuAddItem(6, "Yellow Qiraji Resonating Crystal", 210, 0)
unit:GossipMenuAddItem(6, "Black Qiraji Resonating Crystal", 211, 0)
unit:GossipMenuAddItem(6, "White Polar Bear", 212, 0)
unit:GossipMenuAddItem(6, "Frosty Flying Carpet", 213, 0)
unit:GossipMenuAddItem(6, "Magnificent Flying Carpet", 214, 0)
unit:GossipMenuAddItem(6, "Turbo-Charged Flying Machine", 215, 0)
unit:GossipMenuAddItem(6, "Flying Machine", 216, 0)
unit:GossipMenuAddItem(6, "Flying Carpet", 217, 0)
unit:GossipMenuAddItem(6, "Big Blizzard Bear", 218, 0)
unit:GossipMenuAddItem(6, "Swift Zhevra", 219, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 954, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 952, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 954) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Wooly White Rhino", 221, 0)
unit:GossipMenuAddItem(6, "Big Battle Bear", 222, 0)
unit:GossipMenuAddItem(6, "Magic Rooster Egg", 223, 0)
unit:GossipMenuAddItem(6, "Swift Spectral Tiger", 224, 0)
unit:GossipMenuAddItem(6, "Riding Turtle", 225, 0)
unit:GossipMenuAddItem(6, "X-51 Nether Rocket X-TREME", 226, 0)
unit:GossipMenuAddItem(6, "Spectral Tiger", 227, 0)
unit:GossipMenuAddItem(6, "X-51 Nether Rocket", 228, 0)
unit:GossipMenuAddItem(6, "Argent Charger", 229, 0)
unit:GossipMenuAddItem(6, "Argent Warhorse", 230, 0)
unit:GossipMenuAddItem(6, "Argent Hippogrpyh", 231, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 955, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 953, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 955) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Great Brewfest Kodo", 233, 0)
unit:GossipMenuAddItem(6, "Swift Brewfest Ram", 234, 0)
unit:GossipMenuAddItem(6, "Brewfest Ram", 235, 0)
unit:GossipMenuAddItem(6, "Headless Horseman's Mount", 236, 0)
unit:GossipMenuAddItem(6, "Magic Broom", 237, 0)
unit:GossipMenuAddItem(6, "Blazing Hippogrpyh", 238, 0)
unit:GossipMenuAddItem(6, "Celestial Steed", 239, 0)
unit:GossipMenuAddItem(6, "Acherus DeathCharger", 240, 0)
unit:GossipMenuAddItem(6, "Red and Blue Mechanostrider", 241, 0)
unit:GossipMenuAddItem(6, "Icy Blue Mechanstrider Mod A", 242, 0)
unit:GossipMenuAddItem(6, "White Mechanostrider Mod B", 250, 0)
unit:GossipMenuAddItem(7, "Next Page >>--->", 956, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 954, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 956) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Deadly Gladiator's Frost Wyrm", 245, 0)
unit:GossipMenuAddItem(6, "Icebound Frostbrood Vanquisher", 246, 0)
unit:GossipMenuAddItem(6, "Onyxian Drake", 247, 0)
unit:GossipMenuAddItem(6, "Relentless Gladiator's Frost Wyrm", 248, 0)
unit:GossipMenuAddItem(6, "Black Nightsaber", 243, 0)
unit:GossipMenuAddItem(6, "Fluorescent Green Mechanostrider", 251, 0)
unit:GossipMenuAddItem(6, "Charger", 252, 0)
unit:GossipMenuAddItem(6, "Felsteed", 253, 0)
unit:GossipMenuAddItem(6, "Dreadsteed", 254, 0)
unit:GossipMenuAddItem(6, "Bloodbathed Frostbrood Vanquisher", 244, 0)
unit:GossipMenuAddItem(6, "Big Love Rocket", 232, 0)
unit:GossipMenuAddItem(7, "Next >>--->", 2000, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 955, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 2000) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Cenarion War Hippogryph", 172, 0)
unit:GossipMenuAddItem(6, "Deathcharger's Reins", 184, 0)
unit:GossipMenuAddItem(6, "Swift White Hawkstrider", 196, 0)
unit:GossipMenuAddItem(6, "Green Qiraji Resonating Crystal", 208, 0)
unit:GossipMenuAddItem(6, "X-53 touring Rocket", 220, 0)
unit:GossipMenuAddItem(6, "Winged Steed of the Ebon Blade", 519, 0)
unit:GossipMenuAddItem(6, "Swift Magic Broom", 520, 0)
unit:GossipMenuAddItem(6, "Swift Magic Broom", 521, 0)
unit:GossipMenuAddItem(6, "Flying Broom", 522, 0)
unit:GossipMenuAddItem(6, "Swift Flying Broom", 525, 0)
unit:GossipMenuAddItem(6, "Albino Drake", 526, 0)
unit:GossipMenuAddItem(7, "<---<< Back Page", 956, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 5001) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Dan's Test Mount", 300, 0)
unit:GossipMenuAddItem(6, "Grand Caravan Mammoth", 301, 0)
unit:GossipMenuAddItem(6, "Flying Reindeer", 302, 0)
unit:GossipMenuAddItem(6, "Frost Wyrm", 303, 0)
unit:GossipMenuAddItem(6, "Frost Wyrm Mount", 304, 0)
unit:GossipMenuAddItem(6, "Chromatic Mount", 249, 0)
unit:GossipMenuAddItem(6, "White Stallion", 503, 0)
unit:GossipMenuAddItem(6, "Little White Stallion", 504, 0)
unit:GossipMenuAddItem(6, "Black Ram", 505, 0)
unit:GossipMenuAddItem(6, "Swift Zhevra", 507, 0)
unit:GossipMenuAddItem(6, "Red Wolf", 511, 0)
unit:GossipMenuAddItem(7, "Next >>--->", 5000, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 5000) then
unit:GossipCreateMenu(100, player, 0)
unit:GossipMenuAddItem(6, "Ivory", 516, 0)
unit:GossipMenuAddItem(6, "Little Ivory Raptor", 517, 0)
unit:GossipMenuAddItem(6, "Winged Steed of the Ebon Blade", 523, 0)
unit:GossipMenuAddItem(6, "Winged Steed of the Ebon Blade", 524, 0)
unit:GossipMenuAddItem(7, "Back <---<<", 1004, 0)
unit:GossipMenuAddItem(7, "[Main Menu]", 1003, 0)
unit:GossipSendMenu(player)
end

if(intid == 1) then
player:LearnSpell(8394)
player:GossipComplete()
end

if(intid == 2) then
player:LearnSpell(10793)
player:GossipComplete()
end

if(intid == 3) then
player:LearnSpell(66847)
player:GossipComplete()
end

if(intid == 4) then
player:LearnSpell(10789)
player:GossipComplete()
end

if(intid == 5) then
player:LearnSpell(23221)
player:GossipComplete()
end

if(intid == 6) then
player:LearnSpell(23219)
player:GossipComplete()
end

if(intid == 7) then
player:LearnSpell(23338)
player:GossipComplete()
end

if(intid == 8) then
player:LearnSpell(10969)
player:GossipComplete()
end

if(intid == 9) then
player:LearnSpell(10873)
player:GossipComplete()
end

if(intid == 10) then
player:LearnSpell(17453)
player:GossipComplete()
end

if(intid == 11) then
player:LearnSpell(17454)
player:GossipComplete()
end

if(intid == 12) then
player:LearnSpell(23225)
player:GossipComplete()
end

if(intid == 13) then
player:LearnSpell(23223)
player:GossipComplete()
end

if(intid == 14) then
player:LearnSpell(23222)
player:GossipComplete()
end

if(intid == 15) then
player:LearnSpell(23238)
player:GossipComplete()
end

if(intid == 16) then
player:LearnSpell(23239)
player:GossipComplete()
end

if(intid == 17) then
player:LearnSpell(23240)
player:GossipComplete()
end

if(intid == 18) then
player:LearnSpell(6899)
player:GossipComplete()
end

if(intid == 19) then
player:LearnSpell(6777)
player:GossipComplete()
end

if(intid == 20) then
player:LearnSpell(6898)
player:GossipComplete()
end

if(intid == 21) then
player:LearnSpell(34406)
player:GossipComplete()
end

if(intid == 22) then
player:LearnSpell(35710)
player:GossipComplete()
end

if(intid == 23) then
player:LearnSpell(35711)
player:GossipComplete()
end

if(intid == 24) then
player:LearnSpell(35714)
player:GossipComplete()
end

if(intid == 25) then
player:LearnSpell(35713)
player:GossipComplete()
end

if(intid == 26) then
player:LearnSpell(35712)
player:GossipComplete()
end

if(intid == 27) then
player:LearnSpell(472)
player:GossipComplete()
end

if(intid == 28) then
player:LearnSpell(6648)
player:GossipComplete()
end

if(intid == 29) then
player:LearnSpell(458)
player:GossipComplete()
end

if(intid == 30) then
player:LearnSpell(470)
player:GossipComplete()
end

if(intid == 31) then
player:LearnSpell(23229)
player:GossipComplete()
end

if(intid == 32) then
player:LearnSpell(23227)
player:GossipComplete()
end

if(intid == 33) then
player:LearnSpell(23228)
player:GossipComplete()
end

if(intid == 34) then
player:LearnSpell(32239)
player:GossipComplete()
end

if(intid == 35) then
player:LearnSpell(32235)
player:GossipComplete()
end

if(intid == 36) then
player:LearnSpell(32240)
player:GossipComplete()
end

if(intid == 37) then
player:LearnSpell(32242)
player:GossipComplete()
end

if(intid == 38) then
player:LearnSpell(32290)
player:GossipComplete()
end

if(intid == 39) then
player:LearnSpell(32292)
player:GossipComplete()
end

if(intid == 40) then
player:LearnSpell(32289)
player:GossipComplete()
end

if(intid == 41) then
player:LearnSpell(60114)
player:GossipComplete()
end

if(intid == 42) then
player:LearnSpell(59791)
player:GossipComplete()
end

if(intid == 43) then
player:LearnSpell(61425)
player:GossipComplete()
end

if(intid == 44) then
player:LearnSpell(61229)
player:GossipComplete()
end

if(intid == 45) then
player:LearnSpell(34896)
player:GossipComplete()
end

if(intid == 46) then
player:LearnSpell(34898)
player:GossipComplete()
end

if(intid == 47) then
player:LearnSpell(34899)
player:GossipComplete()
end

if(intid == 48) then
player:LearnSpell(34897)
player:GossipComplete()
end

if(intid == 49) then
player:LearnSpell(39315)
player:GossipComplete()
end

if(intid == 50) then
player:LearnSpell(39317)
player:GossipComplete()
end

if(intid == 51) then
player:LearnSpell(39318)
player:GossipComplete()
end

if(intid == 52) then
player:LearnSpell(39319)
player:GossipComplete()
end

if(intid == 53) then
player:LearnSpell(17229)
player:GossipComplete()
end

if(intid == 54) then
player:LearnSpell(66090)
player:GossipComplete()
end

if(intid == 55) then
player:LearnSpell(66087)
player:GossipComplete()
end

if(intid == 56) then
player:LearnSpell(59799)
player:GossipComplete()
end

if(intid == 57) then
player:LearnSpell(61470)
player:GossipComplete()
end

if(intid == 58) then
player:LearnSpell(68187)
player:GossipComplete()
end

if(intid == 59) then
player:LearnSpell(61467)
player:GossipComplete()
end

if(intid == 60) then
player:LearnSpell(68057)
player:GossipComplete()
end

if(intid == 61) then
player:LearnSpell(22719)
player:GossipComplete()
end

if(intid == 62) then
player:LearnSpell(22720)
player:GossipComplete()
end

if(intid == 63) then
player:LearnSpell(22717)
player:GossipComplete()
end

if(intid == 64) then
player:LearnSpell(48027)
player:GossipComplete()
end

if(intid == 65) then
player:LearnSpell(22723)
player:GossipComplete()
end

if(intid == 66) then
player:LearnSpell(23510)
player:GossipComplete()
end

if(intid == 67) then
player:LearnSpell(59788)
player:GossipComplete()
end

if(intid == 68) then
player:LearnSpell(60424)
player:GossipComplete()
end

if(intid == 69) then
player:LearnSpell(63637)
player:GossipComplete()
end

if(intid == 70) then
player:LearnSpell(63639)
player:GossipComplete()
end

if(intid == 71) then
player:LearnSpell(63638)
player:GossipComplete()
end

if(intid == 72) then
player:LearnSpell(63636)
player:GossipComplete()
end

if(intid == 73) then
player:LearnSpell(63232)
player:GossipComplete()
end

if(intid == 74) then
player:LearnSpell(65637)
player:GossipComplete()
end

if(intid == 75) then
player:LearnSpell(65640)
player:GossipComplete()
end

if(intid == 76) then
player:LearnSpell(65638)
player:GossipComplete()
end

if(intid == 77) then
player:LearnSpell(65643)
player:GossipComplete()
end

if(intid == 78) then
player:LearnSpell(65642)
player:GossipComplete()
end

if(intid == 79) then
player:LearnSpell(60118)
player:GossipComplete()
end

if(intid == 80) then
player:LearnSpell(61996)
player:GossipComplete()
end

if(intid == 81) then
player:LearnSpell(23250)
player:GossipComplete()
end

if(intid == 82) then
player:LearnSpell(23252)
player:GossipComplete()
end

if(intid == 83) then
player:LearnSpell(23251)
player:GossipComplete()
end

if(intid == 84) then
player:LearnSpell(64658)
player:GossipComplete()
end

if(intid == 85) then
player:LearnSpell(6654)
player:GossipComplete()
end

if(intid == 86) then
player:LearnSpell(6653)
player:GossipComplete()
end

if(intid == 87) then
player:LearnSpell(580)
player:GossipComplete()
end

if(intid == 88) then
player:LearnSpell(35022)
player:GossipComplete()
end

if(intid == 89) then
player:LearnSpell(35020)
player:GossipComplete()
end

if(intid == 90) then
player:LearnSpell(34795)
player:GossipComplete()
end

if(intid == 91) then
player:LearnSpell(35018)
player:GossipComplete()
end

if(intid == 92) then
player:LearnSpell(35027)
player:GossipComplete()
end

if(intid == 93) then
player:LearnSpell(35025)
player:GossipComplete()
end

if(intid == 94) then
player:LearnSpell(33660)
player:GossipComplete()
end

if(intid == 95) then
player:LearnSpell(8395)
player:GossipComplete()
end

if(intid == 96) then
player:LearnSpell(10796)
player:GossipComplete()
end

if(intid == 97) then
player:LearnSpell(10799)
player:GossipComplete()
end

if(intid == 98) then
player:LearnSpell(23241)
player:GossipComplete()
end

if(intid == 99) then
player:LearnSpell(23242)
player:GossipComplete()
end

if(intid == 100) then
player:LearnSpell(23243)
player:GossipComplete()
end

if(intid == 101) then
player:LearnSpell(18990)
player:GossipComplete()
end

if(intid == 102) then
player:LearnSpell(18989)
player:GossipComplete()
end

if(intid == 103) then
player:LearnSpell(64657)
player:GossipComplete()
end

if(intid == 104) then
player:LearnSpell(23247)
player:GossipComplete()
end

if(intid == 105) then
player:LearnSpell(23249)
player:GossipComplete()
end

if(intid == 106) then
player:LearnSpell(23248)
player:GossipComplete()
end

if(intid == 107) then
player:LearnSpell(17462)
player:GossipComplete()
end

if(intid == 108) then
player:LearnSpell(17464)
player:GossipComplete()
end

if(intid == 109) then
player:LearnSpell(17463)
player:GossipComplete()
end

if(intid == 110) then
player:LearnSpell(64977)
player:GossipComplete()
end

if(intid == 111) then
player:LearnSpell(17465)
player:GossipComplete()
end

if(intid == 112) then
player:LearnSpell(66846)
player:GossipComplete()
end

if(intid == 113) then
player:LearnSpell(23246)
player:GossipComplete()
end

if(intid == 114) then
player:LearnSpell(32244)
player:GossipComplete()
end

if(intid == 115) then
player:LearnSpell(32245)
player:GossipComplete()
end

if(intid == 116) then
player:LearnSpell(32243)
player:GossipComplete()
end

if(intid == 117) then
player:LearnSpell(32296)
player:GossipComplete()
end

if(intid == 118) then
player:LearnSpell(32246)
player:GossipComplete()
end

if(intid == 119) then
player:LearnSpell(32297)
player:GossipComplete()
end

if(intid == 120) then
player:LearnSpell(32295)
player:GossipComplete()
end

if(intid == 121) then
player:LearnSpell(60116)
player:GossipComplete()
end

if(intid == 122) then
player:LearnSpell(59793)
player:GossipComplete()
end

if(intid == 123) then
player:LearnSpell(61447)
player:GossipComplete()
end

if(intid == 124) then
player:LearnSpell(61230)
player:GossipComplete()
end

if(intid == 125) then
player:LearnSpell(34896)
player:GossipComplete()
end

if(intid == 126) then
player:LearnSpell(34898)
player:GossipComplete()
end

if(intid == 127) then
player:LearnSpell(34899)
player:GossipComplete()
end

if(intid == 128) then
player:LearnSpell(34897)
player:GossipComplete()
end

if(intid == 129) then
player:LearnSpell(39315)
player:GossipComplete()
end

if(intid == 130) then
player:LearnSpell(39317)
player:GossipComplete()
end

if(intid == 131) then
player:LearnSpell(39318)
player:GossipComplete()
end

if(intid == 132) then
player:LearnSpell(39319)
player:GossipComplete()
end

if(intid == 133) then
player:LearnSpell(64659)
player:GossipComplete()
end

if(intid == 134) then
player:LearnSpell(66091)
player:GossipComplete()
end

if(intid == 135) then
player:LearnSpell(66088)
player:GossipComplete()
end

if(intid == 136) then
player:LearnSpell(59797)
player:GossipComplete()
end

if(intid == 137) then
player:LearnSpell(61469)
player:GossipComplete()
end

if(intid == 138) then
player:LearnSpell(68188)
player:GossipComplete()
end

if(intid == 139) then
player:LearnSpell(61467)
player:GossipComplete()
end

if(intid == 140) then
player:LearnSpell(68056)
player:GossipComplete()
end

if(intid == 141) then
player:LearnSpell(22718)
player:GossipComplete()
end

if(intid == 142) then
player:LearnSpell(22724)
player:GossipComplete()
end

if(intid == 143) then
player:LearnSpell(22722)
player:GossipComplete()
end

if(intid == 144) then
player:LearnSpell(35028)
player:GossipComplete()
end

if(intid == 145) then
player:LearnSpell(22721)
player:GossipComplete()
end

if(intid == 146) then
player:LearnSpell(23509)
player:GossipComplete()
end

if(intid == 147) then
player:LearnSpell(59788)
player:GossipComplete()
end

if(intid == 148) then
player:LearnSpell(55531)
player:GossipComplete()
end

if(intid == 149) then
player:LearnSpell(63635)
player:GossipComplete()
end

if(intid == 150) then
player:LearnSpell(63643)
player:GossipComplete()
end

if(intid == 151) then
player:LearnSpell(63640)
player:GossipComplete()
end

if(intid == 152) then
player:LearnSpell(63642)
player:GossipComplete()
end

if(intid == 153) then
player:LearnSpell(63641)
player:GossipComplete()
end

if(intid == 154) then
player:LearnSpell(65641)
player:GossipComplete()
end

if(intid == 155) then
player:LearnSpell(65646)
player:GossipComplete()
end

if(intid == 156) then
player:LearnSpell(65644)
player:GossipComplete()
end

if(intid == 157) then
player:LearnSpell(65639)
player:GossipComplete()
end

if(intid == 158) then
player:LearnSpell(65645)
player:GossipComplete()
end

if(intid == 159) then
player:LearnSpell(60119)
player:GossipComplete()
end

if(intid == 160) then
player:LearnSpell(61997)
player:GossipComplete()
end

if(intid == 161) then
player:LearnSpell(41514)
player:GossipComplete()
end

if(intid == 162) then
player:LearnSpell(41515)
player:GossipComplete()
end

if(intid == 163) then
player:LearnSpell(41513)
player:GossipComplete()
end

if(intid == 164) then
player:LearnSpell(41516)
player:GossipComplete()
end

if(intid == 165) then
player:LearnSpell(41517)
player:GossipComplete()
end

if(intid == 166) then
player:LearnSpell(41518)
player:GossipComplete()
end

if(intid == 167) then
player:LearnSpell(39803)
player:GossipComplete()
end

if(intid == 168) then
player:LearnSpell(39798)
player:GossipComplete()
end

if(intid == 169) then
player:LearnSpell(39800)
player:GossipComplete()
end

if(intid == 170) then
player:LearnSpell(39801)
player:GossipComplete()
end

if(intid == 171) then
player:LearnSpell(39802)
player:GossipComplete()
end

if(intid == 172) then
player:LearnSpell(43927)
player:GossipComplete()
end

if(intid == 173) then
player:LearnSpell(59570)
player:GossipComplete()
end

if(intid == 174) then
player:LearnSpell(61294)
player:GossipComplete()
end

if(intid == 175) then
player:LearnSpell(37015)
player:GossipComplete()
end

if(intid == 176) then
player:LearnSpell(44317)
player:GossipComplete()
end

if(intid == 177) then
player:LearnSpell(49193)
player:GossipComplete()
end

if(intid == 178) then
player:LearnSpell(58615)
player:GossipComplete()
end

if(intid == 179) then
player:LearnSpell(65439)
player:GossipComplete()
end

if(intid == 180) then
player:LearnSpell(39316)
player:GossipComplete()
end

if(intid == 181) then
player:LearnSpell(34790)
player:GossipComplete()
end

if(intid == 182) then
player:LearnSpell(43688)
player:GossipComplete()
end

if(intid == 183) then
player:LearnSpell(40192)
player:GossipComplete()
end

if(intid == 184) then
player:LearnSpell(17481)
player:GossipComplete()
end

if(intid == 185) then
player:LearnSpell(30480)
player:GossipComplete()
end

if(intid == 186) then
player:LearnSpell(72286)
player:GossipComplete()
end

if(intid == 187) then
player:LearnSpell(63796)
player:GossipComplete()
end

if(intid == 188) then
player:LearnSpell(59650)
player:GossipComplete()
end

if(intid == 189) then
player:LearnSpell(59571)
player:GossipComplete()
end

if(intid == 190) then
player:LearnSpell(59568)
player:GossipComplete()
end

if(intid == 191) then
player:LearnSpell(59567)
player:GossipComplete()
end

if(intid == 192) then
player:LearnSpell(59996)
player:GossipComplete()
end

if(intid == 193) then
player:LearnSpell(59569)
player:GossipComplete()
end

if(intid == 194) then
player:LearnSpell(73313)
player:GossipComplete()
end

if(intid == 195) then
player:LearnSpell(41252)
player:GossipComplete()
end

if(intid == 196) then
player:LearnSpell(46628)
player:GossipComplete()
end

if(intid == 197) then
player:LearnSpell(24242)
player:GossipComplete()
end

if(intid == 198) then
player:LearnSpell(24252)
player:GossipComplete()
end

if(intid == 199) then
player:LearnSpell(59976)
player:GossipComplete()
end

if(intid == 200) then
player:LearnSpell(63956)
player:GossipComplete()
end

if(intid == 201) then
player:LearnSpell(60021)
player:GossipComplete()
end

if(intid == 202) then
player:LearnSpell(59961)
player:GossipComplete()
end

if(intid == 203) then
player:LearnSpell(63963)
player:GossipComplete()
end

if(intid == 204) then
player:LearnSpell(60024)
player:GossipComplete()
end

if(intid == 205) then
player:LearnSpell(60002)
player:GossipComplete()
end

if(intid == 206) then
player:LearnSpell(64731)
player:GossipComplete()
end

if(intid == 207) then
player:LearnSpell(25953)
player:GossipComplete()
end

if(intid == 208) then
player:LearnSpell(26056)
player:GossipComplete()
end

if(intid == 209) then
player:LearnSpell(26054)
player:GossipComplete()
end

if(intid == 210) then
player:LearnSpell(26055)
player:GossipComplete()
end

if(intid == 211) then
player:LearnSpell(26656)
player:GossipComplete()
end

if(intid == 212) then
player:LearnSpell(54753)
player:GossipComplete()
end

if(intid == 213) then
player:LearnSpell(75596)
player:GossipComplete()
end

if(intid == 214) then
player:LearnSpell(61309)
player:GossipComplete()
end

if(intid == 215) then
player:LearnSpell(44151)
player:GossipComplete()
end

if(intid == 216) then
player:LearnSpell(44153)
player:GossipComplete()
end

if(intid == 217) then
player:LearnSpell(61451)
player:GossipComplete()
end

if(intid == 218) then
player:LearnSpell(58983)
player:GossipComplete()
end

if(intid == 219) then
player:LearnSpell(48954)
player:GossipComplete()
end

if(intid == 220) then
player:LearnSpell(75973)
player:GossipComplete()
end

if(intid == 221) then
player:LearnSpell(74918)
player:GossipComplete()
end

if(intid == 222) then
player:LearnSpell(51412)
player:GossipComplete()
end

if(intid == 223) then
player:LearnSpell(65917)
player:GossipComplete()
end

if(intid == 224) then
player:LearnSpell(42777)
player:GossipComplete()
end

if(intid == 225) then
player:LearnSpell(30174)
player:GossipComplete()
end

if(intid == 226) then
player:LearnSpell(46199)
player:GossipComplete()
end

if(intid == 227) then
player:LearnSpell(42776)
player:GossipComplete()
end

if(intid == 228) then
player:LearnSpell(46197)
player:GossipComplete()
end

if(intid == 229) then
player:LearnSpell(66906)
player:GossipComplete()
end

if(intid == 230) then
player:LearnSpell(67466)
player:GossipComplete()
end

if(intid == 231) then
player:LearnSpell(63844)
player:GossipComplete()
end

if(intid == 232) then
player:LearnSpell(71342)
player:GossipComplete()
end

if(intid == 233) then
player:LearnSpell(49379)
player:GossipComplete()
end

if(intid == 234) then
player:LearnSpell(43900)
player:GossipComplete()
end

if(intid == 235) then
player:LearnSpell(43899)
player:GossipComplete()
end

if(intid == 236) then
player:LearnSpell(48025)
player:GossipComplete()
end

if(intid == 237) then
player:LearnSpell(47977)
player:GossipComplete()
end

if(intid == 238) then
player:LearnSpell(74856)
player:GossipComplete()
end

if(intid == 239) then
player:LearnSpell(75614)
player:GossipComplete()
end

if(intid == 240) then
player:LearnSpell(48778)
player:GossipComplete()
end

if(intid == 241) then
player:LearnSpell(17456)
player:GossipComplete()
end

if(intid == 242) then
player:LearnSpell(17459)
player:GossipComplete()
end

if(intid == 243) then
player:LearnSpell(16055)
player:GossipComplete()
end

if(intid == 244) then
player:LearnSpell(72808)
player:GossipComplete()
end

if(intid == 245) then
player:LearnSpell(64927)
player:GossipComplete()
end

if(intid == 246) then
player:LearnSpell(72807)
player:GossipComplete()
end

if(intid == 247) then
player:LearnSpell(69395)
player:GossipComplete()
end

if(intid == 248) then
player:LearnSpell(67336)
player:GossipComplete()
end

if(intid == 249) then
player:LearnSpell(24576)
player:GossipComplete()
end

if(intid == 250) then
player:LearnSpell(15779)
player:GossipComplete()
end

if(intid == 251) then
player:LearnSpell(17458)
player:GossipComplete()
end

if(intid == 252) then
player:LearnSpell(23214)
player:GossipComplete()
end

if(intid == 253) then
player:LearnSpell(5784)
player:GossipComplete()
end

if(intid == 254) then
player:LearnSpell(23161)
player:GossipComplete()
end

if(intid == 300) then
player:LearnSpell(61983)
player:GossipComplete()
end

if(intid == 301) then
player:LearnSpell(60136)
player:GossipComplete()
end

if(intid == 302) then
player:LearnSpell(44655)
player:GossipComplete()
end

if(intid == 303) then
player:LearnSpell(43810)
player:GossipComplete()
end

if(intid == 304) then
player:LearnSpell(51960)
player:GossipComplete()
end

if(intid == 500) then
player:LearnSpell(16056)
player:GossipComplete()
end

if(intid == 501) then
player:LearnSpell(16082)
player:GossipComplete()
end

if(intid == 502) then
player:LearnSpell(468)
player:GossipComplete()
end

if(intid == 503) then
player:LearnSpell(16083)
player:GossipComplete()
end

if(intid == 504) then
player:LearnSpell(68768)
player:GossipComplete()
end

if(intid == 505) then
player:LearnSpell(17461)
player:GossipComplete()
end

if(intid == 506) then
player:LearnSpell(6896)
player:GossipComplete()
end

if(intid == 507) then
player:LearnSpell(48954)
player:GossipComplete()
end

if(intid == 508) then
player:LearnSpell(17460)
player:GossipComplete()
end

if(intid == 509) then
player:LearnSpell(18991)
player:GossipComplete()
end

if(intid == 510) then
player:LearnSpell(18992)
player:GossipComplete()
end

if(intid == 511) then
player:LearnSpell(16080)
player:GossipComplete()
end

if(intid == 512) then
player:LearnSpell(579)
player:GossipComplete()
end

if(intid == 513) then
player:LearnSpell(16084)
player:GossipComplete()
end

if(intid == 514) then
player:LearnSpell(581)
player:GossipComplete()
end

if(intid == 515) then
player:LearnSpell(16081)
player:GossipComplete()
end

if(intid == 516) then
player:LearnSpell(17450)
player:GossipComplete()
end

if(intid == 517) then
player:LearnSpell(68769)
player:GossipComplete()
end

if(intid == 518) then
player:LearnSpell(10795)
player:GossipComplete()
end

if(intid == 519) then
player:LearnSpell(54726)
player:GossipComplete()
end

if(intid == 520) then
player:LearnSpell(42683)
player:GossipComplete()
end

if(intid == 521) then
player:LearnSpell(42684)
player:GossipComplete()
end

if(intid == 522) then
player:LearnSpell(42667)
player:GossipComplete()
end

if(intid == 523) then
player:LearnSpell(54727)
player:GossipComplete()
end

if(intid == 524) then
player:LearnSpell(54729)
player:GossipComplete()
end

if(intid == 525) then
player:LearnSpell(42668)
player:GossipComplete()
end

if(intid == 526) then
player:LearnSpell(60025)
player:GossipComplete()
end

if(intid == 527) then
player:LearnSpell(768)
player:GossipComplete()
end

if(intid == 528) then
player:LearnSpell(5215)
player:GossipComplete()
end

if(intid == 529) then
player:LearnSpell(5487)
player:GossipComplete()
end

if(intid == 530) then
player:LearnSpell(1066)
player:GossipComplete()
end

if(intid == 531) then
player:LearnSpell(783)
player:GossipComplete()
end

if(intid == 532) then
player:LearnSpell(33943)
player:GossipComplete()
end

if(intid == 533) then
player:LearnSpell(40120)
player:GossipComplete()
end

if(intid == 534) then
player:LearnSpell(24858)
player:GossipComplete()
end

if(intid == 535) then
player:LearnSpell(33891)
player:GossipComplete()
end

if(intid == 536) then
player:LearnSpell(67116)
player:GossipComplete()
end

if(intid == 5300) then
player:LearnSpell(8394)--2
player:LearnSpell(10793)--3
player:LearnSpell(66847)--4
player:LearnSpell(10789)--5
player:LearnSpell(23221)--6
player:LearnSpell(23219)--7
player:LearnSpell(23338)--8
player:LearnSpell(10969)--9
player:LearnSpell(10873)--10
player:LearnSpell(17453)--11
player:LearnSpell(17454)--12
player:LearnSpell(23225)--13
player:LearnSpell(23223)--14
player:LearnSpell(23222)--15
player:LearnSpell(23238)--16
player:LearnSpell(23239)--17
player:LearnSpell(23240)--18
player:LearnSpell(6899)--19
player:LearnSpell(6777)--20
player:LearnSpell(6898)--21
player:LearnSpell(34406)--22
player:LearnSpell(35710)--23
player:LearnSpell(35711)--24
player:LearnSpell(35714)--25
player:LearnSpell(35713)--26
player:LearnSpell(35712)--27
player:LearnSpell(472)--28
player:LearnSpell(6648)--29
player:LearnSpell(458)--30
player:LearnSpell(470)--31
player:LearnSpell(23229)--32
player:LearnSpell(23227)--33
player:LearnSpell(23228)--34
player:LearnSpell(32239)--35
player:LearnSpell(32235)--36
player:LearnSpell(32240)--37
player:LearnSpell(32242)--38
player:LearnSpell(32290)--39
player:LearnSpell(32292)--40
player:LearnSpell(32289)--41
player:LearnSpell(60114)--42
player:LearnSpell(59791)--43
player:LearnSpell(61425)--44
player:LearnSpell(61229)--45
player:LearnSpell(34896)--46
player:LearnSpell(34898)--47
player:LearnSpell(34899)--48
player:LearnSpell(34897)--49
player:LearnSpell(39315)--50
player:LearnSpell(39317)--51
player:LearnSpell(39318)--52
player:LearnSpell(39319)--53
player:LearnSpell(17229)--54
player:LearnSpell(66090)--55
player:LearnSpell(66087)--56
player:LearnSpell(59799)--57
player:LearnSpell(61470)--58
player:LearnSpell(68187)--59
player:LearnSpell(61467)--60
player:LearnSpell(68057)--61
player:LearnSpell(22719)--62
player:LearnSpell(22720)--63
player:LearnSpell(22717)--64
player:LearnSpell(48027)--65
player:LearnSpell(22723)--66
player:LearnSpell(23510)--67
player:LearnSpell(59788)--68
player:LearnSpell(60424)--69
player:LearnSpell(63637)--70
player:LearnSpell(63639)--71
player:LearnSpell(63638)--72
player:LearnSpell(63636)--73
player:LearnSpell(63232)--74
player:LearnSpell(65637)--75
player:LearnSpell(65640)--76
player:LearnSpell(65638)--77
player:LearnSpell(65643)--78
player:LearnSpell(65642)--79
player:LearnSpell(60118)--80
player:LearnSpell(61996)--81
player:LearnSpell(23250)--82
player:LearnSpell(23252)--83
player:LearnSpell(23251)--84
player:LearnSpell(64658)--85
player:LearnSpell(6654)--86
player:LearnSpell(6653)--87
player:LearnSpell(580)--88
player:LearnSpell(35022)--89
player:LearnSpell(35020)--90
player:LearnSpell(34795)--91
player:LearnSpell(35018)--92
player:LearnSpell(35027)--93
player:LearnSpell(35025)--94
player:LearnSpell(33660)--95
player:LearnSpell(8395)--96
player:LearnSpell(10796)--97
player:LearnSpell(10799)--98
player:LearnSpell(23241)--99
player:LearnSpell(23242)--100
player:LearnSpell(23243)--101
player:LearnSpell(18990)--102
player:LearnSpell(18989)--103
player:LearnSpell(64657)--104
player:LearnSpell(23247)--105
player:LearnSpell(23249)--106
player:LearnSpell(23248)--107
player:LearnSpell(17462)--108
player:LearnSpell(17464)--109
player:LearnSpell(17463)--110
player:LearnSpell(64977)--111
player:LearnSpell(17465)--112
player:LearnSpell(66846)--113
player:LearnSpell(23246)--114
player:LearnSpell(32244)--115
player:LearnSpell(32245)--116
player:LearnSpell(32243)--117
player:LearnSpell(32296)--118
player:LearnSpell(32246)--119
player:LearnSpell(32297)--120
player:LearnSpell(32295)--121
player:LearnSpell(60116)--122
player:LearnSpell(59793)--123
player:LearnSpell(61447)--124
player:LearnSpell(61230)--125
player:LearnSpell(34896)--126
player:LearnSpell(34898)--127
player:LearnSpell(34899)--128
player:LearnSpell(34897)--129
player:LearnSpell(39315)--130
player:LearnSpell(39317)--131
player:LearnSpell(39318)--132
player:LearnSpell(39319)--133
player:LearnSpell(64659)--134
player:LearnSpell(66091)--135
player:LearnSpell(66088)--136
player:LearnSpell(59797)--137
player:LearnSpell(61469)--138
player:LearnSpell(68188)--139
player:LearnSpell(61467)--140
player:LearnSpell(68056)--141
player:LearnSpell(22718)--142
player:LearnSpell(22724)--143
player:LearnSpell(22722)--144
player:LearnSpell(35028)--145
player:LearnSpell(22721)--146
player:LearnSpell(23509)--147
player:LearnSpell(59788)--148
player:LearnSpell(55531)--149
player:LearnSpell(63635)--150
player:LearnSpell(63643)--151
player:LearnSpell(63640)--152
player:LearnSpell(63642)--153
player:LearnSpell(63641)--154
player:LearnSpell(65641)--155
player:LearnSpell(65646)--156
player:LearnSpell(65644)--157
player:LearnSpell(65639)--158
player:LearnSpell(65645)--159
player:LearnSpell(60119)--160
player:LearnSpell(61997)--161
player:LearnSpell(41514)--162
player:LearnSpell(41515)--163
player:LearnSpell(41513)--164
player:LearnSpell(41516)--165
player:LearnSpell(41517)--166
player:LearnSpell(41518)--167
player:LearnSpell(39803)--168
player:LearnSpell(39798)--169
player:LearnSpell(39800)--170
player:LearnSpell(39801)--171
player:LearnSpell(39802)--172
player:LearnSpell(43927)--173
player:LearnSpell(59570)--174
player:LearnSpell(61294)--175
player:LearnSpell(37015)--176
player:LearnSpell(44317)--177
player:LearnSpell(49193)--178
player:LearnSpell(58615)--179
player:LearnSpell(65439)--180
player:LearnSpell(39316)--181
player:LearnSpell(34790)--182
player:LearnSpell(43688)--183
player:LearnSpell(40192)--184
player:LearnSpell(17481)--185
player:LearnSpell(30480)--186
player:LearnSpell(72286)--187
player:LearnSpell(63796)--188
player:LearnSpell(59650)--189
player:LearnSpell(59571)--190
player:LearnSpell(59568)--191
player:LearnSpell(59567)--192
player:LearnSpell(59996)--193
player:LearnSpell(59569)--194
player:LearnSpell(73313)--195
player:LearnSpell(41252)--196
player:LearnSpell(46628)--197
player:LearnSpell(24242)--198
player:LearnSpell(24252)--199
player:LearnSpell(59976)--200
player:LearnSpell(63956)--201
player:LearnSpell(60021)--202
player:LearnSpell(59961)--203
player:LearnSpell(63963)--204
player:LearnSpell(60024)--205
player:LearnSpell(60002)--206
player:LearnSpell(64731)--207
player:LearnSpell(25953)--208
player:LearnSpell(26056)--209
player:LearnSpell(26054)--210
player:LearnSpell(26055)--211
player:LearnSpell(26656)--212
player:LearnSpell(54753)--213
player:LearnSpell(75596)--214
player:LearnSpell(61309)--215
player:LearnSpell(44151)--216
player:LearnSpell(44153)--217
player:LearnSpell(61451)--218
player:LearnSpell(58983)--219
player:LearnSpell(48954)--220
player:LearnSpell(75973)--221
player:LearnSpell(74918)--222
player:LearnSpell(51412)--223
player:LearnSpell(65917)--224
player:LearnSpell(42777)--225
player:LearnSpell(30174)--226
player:LearnSpell(46199)--227
player:LearnSpell(42776)--228
player:LearnSpell(46197)--229
player:LearnSpell(66906)--230
player:LearnSpell(67466)--231
player:LearnSpell(63844)--232
player:LearnSpell(71342)--233
player:LearnSpell(49379)--234
player:LearnSpell(43900)--235
player:LearnSpell(43899)--236
player:LearnSpell(48025)--237
player:LearnSpell(47977)--238
player:LearnSpell(74856)--239
player:LearnSpell(75614)--240
player:LearnSpell(48778)--241
player:LearnSpell(17456)--242
player:LearnSpell(17459)--243
player:LearnSpell(16055)--244
player:LearnSpell(72808)--245
player:LearnSpell(64927)--246
player:LearnSpell(72807)--247
player:LearnSpell(69395)--248
player:LearnSpell(67336)--249
player:LearnSpell(24576)--250
player:LearnSpell(15779)--251
player:LearnSpell(17458)--252
player:LearnSpell(23214)--253
player:LearnSpell(5784)--254
player:LearnSpell(23161)--300
player:LearnSpell(61983)--301
player:LearnSpell(60136)--302
player:LearnSpell(44655)--303
player:LearnSpell(43810)--304
player:LearnSpell(51960)--500
player:LearnSpell(16056)--501
player:LearnSpell(16082)--502
player:LearnSpell(468)--503
player:LearnSpell(16083)--504
player:LearnSpell(68768)--505
player:LearnSpell(17461)--506
player:LearnSpell(6896)--507
player:LearnSpell(48954)--508
player:LearnSpell(17460)--509
player:LearnSpell(18991)--510
player:LearnSpell(18992)--511
player:LearnSpell(16080)--512
player:LearnSpell(579)--513
player:LearnSpell(16084)--514
player:LearnSpell(581)--515
player:LearnSpell(16081)--516
player:LearnSpell(17450)--517
player:LearnSpell(68769)--518
player:LearnSpell(10795)--519
player:LearnSpell(54726)--520
player:LearnSpell(42683)--521
player:LearnSpell(42684)--522
player:LearnSpell(42667)--523
player:LearnSpell(54727)--524
player:LearnSpell(54729)--525
player:LearnSpell(42668)--526
player:LearnSpell(60025)
player:GossipComplete()
end
end

RegisterUnitGossipEvent(npcid, 1, "spellst_on_gossip")
RegisterUnitGossipEvent(npcid, 2, "spellst_submenus")