function On_Gossip(unit, event, player)
unit:GossipCreateMenu(3544, player, 0)
unit:GossipMenuAddItem(2, "Walmart", 1, 0)
unit:GossipMenuAddItem(2, "Horde Cities", 3, 0)
unit:GossipMenuAddItem(2, "Alliance Cities", 4, 0)
unit:GossipMenuAddItem(2, "Global Locations", 5, 0)
unit:GossipMenuAddItem(2, "Outland Locations", 6, 0)
unit:GossipMenuAddItem(2, "Northrend Locations", 7, 0)
unit:GossipMenuAddItem(2, "War Zones", 8, 0)
unit:GossipMenuAddItem(2, "I'll Take A Little Boost, Thanks!", 9, 0)
unit:GossipMenuAddItem(2, "Cure Me", 10, 0)
unit:GossipSendMenu(player)
end

function Gossip_Submenus(unit, event, player, id, intid, code)

if(intid == 999) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(2, "Walmart", 1, 0)
unit:GossipMenuAddItem(2, "Horde Cities", 3, 0)
unit:GossipMenuAddItem(2, "Alliance Cities", 4, 0)
unit:GossipMenuAddItem(2, "Global Locations", 5, 0)
unit:GossipMenuAddItem(2, "Outland Locations", 6, 0)
unit:GossipMenuAddItem(2, "Northrend Locations", 7, 0)
unit:GossipMenuAddItem(2, "War Zones", 8, 0)
unit:GossipMenuAddItem(2, "I'll Take A Little Boost, Thanks!", 9, 0)
unit:GossipMenuAddItem(2, "Cure Me", 10, 0)
unit:GossipSendMenu(player)
end

if(intid == 1) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Horde Mall", 300, 0)
unit:GossipMenuAddItem(1, "Alliance Mall", 301, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 3) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Orgrimmar", 15, 0)
unit:GossipMenuAddItem(1, "Undercity", 16, 0)
unit:GossipMenuAddItem(1, "Thunder Bluff", 17, 0)
unit:GossipMenuAddItem(1, "Silvermoon City", 18, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 4) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Stormwind", 19, 0)
unit:GossipMenuAddItem(1, "Ironforge", 20, 0)
unit:GossipMenuAddItem(1, "Darnassus", 21, 0)
unit:GossipMenuAddItem(1, "Exodar", 22, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 5) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(0, "Eastern Kingdoms", 500, 0)
unit:GossipMenuAddItem(0, "Kalimdor", 501, 0)
unit:GossipMenuAddItem(0, "Old School Raids", 502, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 500) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Alterac Mountains", 23, 0)
unit:GossipMenuAddItem(1, "Arathi Highlands", 24, 0)
unit:GossipMenuAddItem(1, "Badlands", 25, 0)
unit:GossipMenuAddItem(1, "Blasted Lands", 26, 0)
unit:GossipMenuAddItem(1, "Burning Steppes", 27, 0)
unit:GossipMenuAddItem(1, "Deadwind Pass", 28, 0)
unit:GossipMenuAddItem(1, "Dun Morogh", 29, 0)
unit:GossipMenuAddItem(1, "Duskwood", 30, 0)
unit:GossipMenuAddItem(1, "Eastern Plaguelands", 31, 0)
unit:GossipMenuAddItem(1, "Elwynn Forest", 32, 0)
unit:GossipMenuAddItem(1, "Eversong Woods", 33, 0)
unit:GossipMenuAddItem(1, "Ghostlands", 34, 0)
unit:GossipMenuAddItem(1, "Hillsbrad Foothills", 35, 0)
unit:GossipMenuAddItem(0, "--->Second Page--->", 36, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 36) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Loch Modan",37, 0)
unit:GossipMenuAddItem(1, "Redridge Mountains", 38, 0)
unit:GossipMenuAddItem(1, "Searing Gorge", 39, 0)
unit:GossipMenuAddItem(1, "Silverpine Forest", 40, 0)
unit:GossipMenuAddItem(1, "Stranglethorn Vale", 41, 0)
unit:GossipMenuAddItem(1, "Swamp Of Sorrows", 42, 0)
unit:GossipMenuAddItem(1, "The Hinterlands", 43, 0)
unit:GossipMenuAddItem(1, "Tirisfal Glades", 44, 0)
unit:GossipMenuAddItem(1, "Western Plaguelands",45, 0)
unit:GossipMenuAddItem(1, "Westfall",46, 0)
unit:GossipMenuAddItem(1, "Wetlands", 47, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 501) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Ashenvale", 48, 0)
unit:GossipMenuAddItem(1, "Azshara", 49, 0)
unit:GossipMenuAddItem(1, "Azuremyst Isle", 50, 0)
unit:GossipMenuAddItem(1, "Bloodmyst Isle", 51, 0)
unit:GossipMenuAddItem(1, "Darkshore", 52, 0)
unit:GossipMenuAddItem(1, "Desolace", 53, 0)
unit:GossipMenuAddItem(1, "Durotar", 54, 0)
unit:GossipMenuAddItem(1, "Dustwallow Marsh", 55, 0)
unit:GossipMenuAddItem(1, "Felwood", 56, 0)
unit:GossipMenuAddItem(1, "Feralas", 57, 0)
unit:GossipMenuAddItem(1, "Moonglade", 58, 0)
unit:GossipMenuAddItem(1, "Mulgore", 59, 0)
unit:GossipMenuAddItem(1, "Silithus", 60, 0)
unit:GossipMenuAddItem(0, "--->Second Page--->", 61, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 61) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Stonetalon Mountains", 62, 0)
unit:GossipMenuAddItem(1, "Tanaris", 63, 0)
unit:GossipMenuAddItem(1, "Teldrassil", 64, 0)
unit:GossipMenuAddItem(1, "The Barrens", 65, 0)
unit:GossipMenuAddItem(1, "Thousand Needles", 66, 0)
unit:GossipMenuAddItem(1, "Un'Goro Crater", 67, 0)
unit:GossipMenuAddItem(1, "Winterspring", 68, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 502) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Ahn'Qiraj", 69, 0)
unit:GossipMenuAddItem(1, "Blackwing Lair", 70, 0)
unit:GossipMenuAddItem(1, "Molten Core", 71, 0)
unit:GossipMenuAddItem(1, "Onyxia's Lair", 72, 0)
unit:GossipMenuAddItem(1, "Zul'Gurub", 73, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 6) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Blade's Edge Mountains", 74, 0)
unit:GossipMenuAddItem(1, "Hellfire Peninsula", 75, 0)
unit:GossipMenuAddItem(1, "Nagrand", 76, 0)
unit:GossipMenuAddItem(1, "Netherstorm", 77, 0)
unit:GossipMenuAddItem(1, "Shadowmoon Valley", 78, 0)
unit:GossipMenuAddItem(1, "Terokkar Forest", 79, 0)
unit:GossipMenuAddItem(1, "Zangarmarsh", 80, 0)
unit:GossipMenuAddItem(1, "Shattrath", 81, 0)
unit:GossipMenuAddItem(0, "Outland Raids", 82, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 82) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Black Temple", 83, 0)
unit:GossipMenuAddItem(1, "Gruul's Lair", 84, 0)
unit:GossipMenuAddItem(1, "Karazhan", 85, 0)
unit:GossipMenuAddItem(1, "Magtheridon's Lair", 86, 0)
unit:GossipMenuAddItem(1, "Mount Hyjal", 87, 0)
unit:GossipMenuAddItem(1, "Serpentshrine Cavern", 88, 0)
unit:GossipMenuAddItem(1, "Sunwell", 89, 0)
unit:GossipMenuAddItem(1, "The Eye", 90, 0)
unit:GossipMenuAddItem(1, "Zul'Aman", 91, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 7) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Borean Tundra", 92, 0)
unit:GossipMenuAddItem(1, "Crystalsong Forest", 93, 0)
unit:GossipMenuAddItem(1, "Dragonblight", 94, 0)
unit:GossipMenuAddItem(1, "Grizzly Hills", 95, 0)
unit:GossipMenuAddItem(1, "Howling Fjords", 96, 0)
unit:GossipMenuAddItem(1, "Icecrown Glaicer", 97, 0)
unit:GossipMenuAddItem(1, "Sholazar Basin", 98, 0)
unit:GossipMenuAddItem(1, "Storm Peaks", 99, 0)
unit:GossipMenuAddItem(1, "Wintergrasp", 100, 0)
unit:GossipMenuAddItem(1, "Zul'Drak", 101, 0)
unit:GossipMenuAddItem(1, "Dalaran", 102, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 8) then
unit:GossipCreateMenu(3543, player, 0)
unit:GossipMenuAddItem(1, "Blade's Edge Arena", 103, 0)
unit:GossipMenuAddItem(1, "Gurubashi Arena", 104, 0)
unit:GossipMenuAddItem(1, "Nagrand Arena", 105, 0)
unit:GossipMenuAddItem(1, "Ring Of Valor (Alliance vs Horde)", 106, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 300) then
player:Teleport(560, 2536.162354, 2456.324951, 61.985809)
unit:GossipComplete(player)
end

if(intid == 301) then
player:Teleport(560, 3604.475586, 2287.418213, 59.282700)
unit:GossipComplete(player)
end

if(intid == 15) then
player:Teleport(1, 1502.709961, -4415.419922, 21.552706)
unit:GossipComplete(player)
end

if(intid == 16) then
player:Teleport(0, 1560.453857, 244.334030, -43.102592)
unit:GossipComplete(player)
end

if(intid == 17) then
player:Teleport(1, -1195.436523, 34.784081, 132.40137)
unit:GossipComplete(player)
end

if(intid == 18) then
player:Teleport(530, 9496.041016, -7282.289551, 14.318037)
unit:GossipComplete(player)
end

if(intid == 19) then
player:Teleport(0, -8832.935547, 625.797485, 93.914894)
unit:GossipComplete(player)
end

if(intid == 20) then
player:Teleport(0, -4924.375488, -950.865112, 501.547333)
unit:GossipComplete(player)
end

if(intid == 21) then
player:Teleport(1, 9945.676758, 2482.677979, 1316.198853)
unit:GossipComplete(player)
end

if(intid == 22) then
player:Teleport(530, -3946.064941, -11727.777344, -138.922562)
unit:GossipComplete(player)
end

if(intid == 23) then
player:Teleport(0, 58.714684, -570.825317, 145.711151)
unit:GossipComplete(player)
end

if(intid == 24) then
player:Teleport(0, -1550.519409, -2496.936791, 54.452209)
unit:GossipComplete(player)
end

if(intid == 25) then
player:Teleport(0, -6819.416992, -3422.346680, 242.543167)
unit:GossipComplete(player)
end

if(intid == 26) then
player:Teleport(0, -11270.514648, -3061.004395, -0.152069)
unit:GossipComplete(player)
end

if(intid == 27) then
player:Teleport(0, -8057.234375, -1997.046143, 133.364822)
unit:GossipComplete(player)
end

if(intid == 28) then
player:Teleport(0, -10437.863281, -1866.211182, 104.634972)
unit:GossipComplete(player)
end

if(intid == 29) then
player:Teleport(0, -5271.595703, 43.802460, 386.111420)
unit:GossipComplete(player)
end

if(intid == 30) then
player:Teleport(0, -10893.999023, -349.645538, 39.141331)
unit:GossipComplete(player)
end

if(intid == 31) then
player:Teleport(0, 2263.505859, -4627.462891, 73.623268)
unit:GossipComplete(player)
end

if(intid == 32) then
player:Teleport(0, -9547.107422, 82.203911, 59.357063)
unit:GossipComplete(player)
end

if(intid == 33) then
player:Teleport(530, 8822.261719, -7098.651855, 35.365276)
unit:GossipComplete(player)
end

if(intid == 34) then
player:Teleport(530, 7230.481934, -6586.369629, 25.941483)
unit:GossipComplete(player)
end

if(intid == 35) then
player:Teleport(0, -414.885590, -662.270203, 54.499748)
unit:GossipComplete(player)
end

if(intid == 37) then
player:Teleport(0, -5544.246582, -2851.535645, 361.768768)
unit:GossipComplete(player)
end

if(intid == 38) then
player:Teleport(0, -9472.294922, -2266.869873, 74.356583)
unit:GossipComplete(player)
end

if(intid == 39) then
player:Teleport(0, -6667.144043, -1194.482300, 242.106873)
unit:GossipComplete(player)
end

if(intid == 40) then
player:Teleport(0, 581.543396, 1249.138062, 86.588158)
unit:GossipComplete(player)
end

if(intid == 41) then
player:Teleport(0, -12323.756836, -584.573059, 24.864433)
unit:GossipComplete(player)
end

if(intid == 42) then
player:Teleport(0, -10371.346680, -2723.086426, 21.678825)
unit:GossipComplete(player)
end

if(intid == 43) then
player:Teleport(0, 118.710144, -1948.693237, 148.925842)
unit:GossipComplete(player)
end

if(intid == 44) then
player:Teleport(0, 2024.515137, 168.655807, 33.867512)
unit:GossipComplete(player)
end

if(intid == 45) then
player:Teleport(0, 1678.447876, -1364.333862, 69.890274)
unit:GossipComplete(player)
end

if(intid == 46) then
player:Teleport(0, -10726.467773, 1030.061523, 33.054764)
unit:GossipComplete(player)
end

if(intid == 47) then
player:Teleport(0, -3192.923340, -2452.208496, 9.292380)
unit:GossipComplete(player)
end

if(intid == 48) then
player:Teleport(1, 2461.417725, -504.268280, 114.812622)
unit:GossipComplete(player)
end

if(intid == 49) then
player:Teleport(1, 3383.945313, -4665.848145, 94.969765)
unit:GossipComplete(player)
end

if(intid == 50) then
player:Teleport(530, -4251.174316, -12869.387695, 13.412463)
unit:GossipComplete(player)
end

if(intid == 51) then
player:Teleport(530, -2244.586670, -11910.894531, 24.423874)
unit:GossipComplete(player)
end

if(intid == 52) then
player:Teleport(1, 6145.536133, 282.024109, 23.928629)
unit:GossipComplete(player)
end

if(intid == 53) then
player:Teleport(1, -1127.806885, 1793.706909, 62.220467)
unit:GossipComplete(player)
end

if(intid == 54) then
player:Teleport(1, 601.661621, -4733.739258, -8.558049)
unit:GossipComplete(player)
end

if(intid == 55) then
player:Teleport(1, -3647.304199, -2721.955566, 33.222332)
unit:GossipComplete(player)
end

if(intid == 56) then
player:Teleport(1, 5378.582031, -752.227243, 344.328766)
unit:GossipComplete(player)
end

if(intid == 57) then
player:Teleport(1, -4805.526855, 1038.506226, 104.156227)
unit:GossipComplete(player)
end

if(intid == 58) then
player:Teleport(1, 8001.228027, -2672.624268, 512.099792)
unit:GossipComplete(player)
end

if(intid == 59) then
player:Teleport(1, -2362.893311, -826.267517, -9.369063)
unit:GossipComplete(player)
end

if(intid == 60) then
player:Teleport(1, -7015.238770, 968.619934, 5.474441)
unit:GossipComplete(player)
end

if(intid == 62) then
player:Teleport(1, 1299.952491, 728.316223, 177.870941)
unit:GossipComplete(player)
end

if(intid == 63) then
player:Teleport(1, -7184.853027, -3983.132324, 10.982137)
unit:GossipComplete(player)
end

if(intid == 64) then
player:Teleport(1, 10119.146484, 1549.032837, 1321.552002)
unit:GossipComplete(player)
end

if(intid == 65) then
player:Teleport(1, -642.360962, -2654.214844, 95.787682)
unit:GossipComplete(player)
end

if(intid == 66) then
player:Teleport(1, -5375.651367, -2509.229736, -40.432945)
unit:GossipComplete(player)
end

if(intid == 67) then
player:Teleport(1, -6178.627441, -1100.540283, -214.140274)
unit:GossipComplete(player)
end

if(intid == 68) then
player:Teleport(1, 6661.349121, -4560.519043, 717.435547)
unit:GossipComplete(player)
end

if(intid == 69) then
player:Teleport(1, -8189.559570, 1532.920898, 4.194667)
unit:GossipComplete(player)
end

if(intid == 70) then
player:Teleport(0, -7660.572266, -1221.226318, 287.787964)
unit:GossipComplete(player)
end

if(intid == 71) then
player:Teleport(230, 1120.799927, -467.276886, -104.741043)
unit:GossipComplete(player)
end

if(intid == 72) then
player:Teleport(1, -4693.167969, -3719.408936, 49.774086)
unit:GossipComplete(player)
end

if(intid == 73) then
player:Teleport(0, -11913.967773, -1115.898560, 77.279816)
unit:GossipComplete(player)
end

if(intid == 74) then
player:Teleport(530, 3034.863281, 5952.613281, 130.774368)
unit:GossipComplete(player)
end

if(intid == 75) then
player:Teleport(530, -215.563675, 2153.101074, 79.554207)
unit:GossipComplete(player)
end

if(intid == 76) then
player:Teleport(530, -1648.201416, 7686.244141, -14.353410)
unit:GossipComplete(player)
end

if(intid == 77) then
player:Teleport(530, 3037.424561, 3576.538818, 143.218384)
unit:GossipComplete(player)
end

if(intid == 78) then
player:Teleport(530, -3072.626709, 2879.110840, 82.300873)
unit:GossipComplete(player)
end

if(intid == 79) then
player:Teleport(530, -2812.025146, 5085.235352, -13.033023)
unit:GossipComplete(player)
end

if(intid == 80) then
player:Teleport(530, -203.677704, 5513.926758, 21.679346)
unit:GossipComplete(player)
end

if(intid == 81) then
player:Teleport(530, -1721.940063, 5382.318359, 1.537373)
unit:GossipComplete(player)
end

if(intid == 83) then
player:Teleport(530, -3637.713623, 315.175232, 35.551952)
unit:GossipComplete(player)
end

if(intid == 84) then
player:Teleport(530, 3530.903320, 5117.925293, 4.349529)
unit:GossipComplete(player)
end

if(intid == 85) then
player:Teleport(0, -11121.737305, -2015.547119, 47.084202)
unit:GossipComplete(player)
end

if(intid == 86) then
player:Teleport(530, -315.928223, 3090.644775, -116.455063)
unit:GossipComplete(player)
end

if(intid == 87) then
player:Teleport(1, -8173.633789, -4176.341797, -166.151794)
unit:GossipComplete(player)
end

if(intid == 88) then
player:Teleport(530, 796.048401, 6864.074219, -64.992691)
unit:GossipComplete(player)
end

if(intid == 89) then
player:Teleport(530, 12564.260742, -6775.855469, 15.090900)
unit:GossipComplete(player)
end

if(intid == 90) then
player:Teleport(530, 3086.903564, 1406.003540, 189.548431)
unit:GossipComplete(player)
end

if(intid == 91) then
player:Teleport(530, 6849.811035, -7953.119141, 170.099884)
unit:GossipComplete(player)
end

if(intid == 92) then
player:Teleport(571, 3760.002197, 5413.608398, 40.775795)
unit:GossipComplete(player)
end

if(intid == 93) then
player:Teleport(571, 5298.182129, -724.851501, 162.903442)
unit:GossipComplete(player)
end

if(intid == 94) then
player:Teleport(571, 3539.470215, 263.158417, 45.625706)
unit:GossipComplete(player)
end

if(intid == 95) then
player:Teleport(571, 3736.716553, -3862.061035, 183.021378)
unit:GossipComplete(player)
end

if(intid == 96) then
player:Teleport(571, 2029.114624, -4520.532715, 207.844940)
unit:GossipComplete(player)
end

if(intid == 97) then
player:Teleport(571, 6330.499023, 2310.453369, 477.265106)
unit:GossipComplete(player)
end

if(intid == 98) then
player:Teleport(571, 5484.500000, 4750.392578, -196.924042)
unit:GossipComplete(player)
end

if(intid == 99) then
player:Teleport(571, 8232.848633, -1483.130615, 1072.386108)
unit:GossipComplete(player)
end

if(intid == 100) then
player:Teleport(571, 4608.031738, 2846.253418, 396.896698)
unit:GossipComplete(player)
end

if(intid == 101) then
player:Teleport(571, 5449.899902, -2629.230713, 306.253143)
unit:GossipComplete(player)
end

if(intid == 102) then
player:Teleport(571, 5809.805664, 651.377075, 647.504602)
unit:GossipComplete(player)
end

if(intid == 103) then
player:Teleport(530, 2908.942383, 5973.306152, 2.096412)
unit:GossipComplete(player)
end

if(intid == 104) then
player:Teleport(0, -13258.738281, 168.794815, 34.707809)
unit:GossipComplete(player)
end

if(intid == 105) then
player:Teleport(530, -2073.057861, 6708.157227, 11.765224)
unit:GossipComplete(player)
end

if(intid == 106) then
player:Teleport(1, 2178.247070, -4766.309570, 54.911034)
unit:GossipComplete(player)
end

if(intid == 9) then
unit:FullCastSpellOnTarget(58451, player)
unit:FullCastSpellOnTarget(48100, player)
unit:FullCastSpellOnTarget(58453, player)
unit:FullCastSpellOnTarget(48104, player)
unit:FullCastSpellOnTarget(48102, player)
unit:FullCastSpellOnTarget(58449, player)
end

if(intid == 10) then
player:LearnSpell(15007)
player:UnlearnSpell(15007)
end
end

RegisterUnitGossipEvent(333333, 1, "On_Gossip")
RegisterUnitGossipEvent(333333, 2, "Gossip_Submenus")
