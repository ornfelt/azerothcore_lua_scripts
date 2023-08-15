function On_Gossip(unit, event, player)
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Neutral Cities", 1, 0)
unit:GossipMenuAddItem(2, "Alliance Cities", 2, 0)
unit:GossipMenuAddItem(2, "Horde Cities", 3, 0)
unit:GossipMenuAddItem(2, "Azheroth Locations", 4, 0)
unit:GossipMenuAddItem(2, "Outland Locations", 5, 0)
unit:GossipMenuAddItem(2, "Northrend Locations", 6, 0)
unit:GossipMenuAddItem(6, "PvP Arenas", 7, 0)
unit:GossipMenuAddItem(2, "Fun/Level Areas", 8, 0)
unit:GossipMenuAddItem(4, "Remove Ressurection sickness", 998, 0)
unit:GossipSendMenu(player)
end

function Gossip_Submenus(unit, event, player, id, intid, code)

if(intid == 999) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Neutral Cities", 1, 0)
unit:GossipMenuAddItem(2, "Alliance Cities", 2, 0)
unit:GossipMenuAddItem(2, "Horde Cities", 3, 0)
unit:GossipMenuAddItem(2, "Azheroth Locations", 4, 0)
unit:GossipMenuAddItem(2, "Outland Locations", 5, 0)
unit:GossipMenuAddItem(2, "Northrend Locations", 6, 0)
unit:GossipMenuAddItem(6, "PvP Arenas", 7, 0)
unit:GossipMenuAddItem(2, "Custom Instances/Areas", 8, 0)
unit:GossipMenuAddItem(4, "Remove Ressurection sickness", 998, 0)
unit:GossipSendMenu(player)
end

if(intid == 1) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Dalaran", 300, 0)
unit:GossipMenuAddItem(2, "Shattrath", 309, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 2) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Stormwind", 301, 0)
unit:GossipMenuAddItem(2, "Ironforge", 302, 0)
unit:GossipMenuAddItem(2, "Darnassus", 303, 0)
unit:GossipMenuAddItem(2, "Exodar", 304, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 3) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Orgrimmar", 305, 0)
unit:GossipMenuAddItem(2, "Undercity", 306, 0)
unit:GossipMenuAddItem(2, "Thunder Bluff", 307, 0)
unit:GossipMenuAddItem(2, "Silvermoon", 308, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 4) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(3, "Eastern Kingdoms", 500, 0)
unit:GossipMenuAddItem(3, "Kalimdor", 501, 0)
unit:GossipMenuAddItem(2, "Instances", 502, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 5) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(3, "Raids", 503, 0)
unit:GossipMenuAddItem(3, "Instances", 504, 0)
unit:GossipMenuAddItem(2, "Locations", 505, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 6) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(3, "Locations", 506, 0)
unit:GossipMenuAddItem(2, "Instances", 507, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 7) then --PvP Arenas
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(0, "Gurubashi Arena", 900, 0)
unit:GossipMenuAddItem(0, "Dire Maul Arena", 901, 0)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 500) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Alterac Mountains", 400, 0)
unit:GossipMenuAddItem(2, "Badlands", 401, 0)
unit:GossipMenuAddItem(2, "Blasted Lands", 402, 0)
unit:GossipMenuAddItem(2, "Burning Steppes", 403, 0)
unit:GossipMenuAddItem(2, "Deadwind Pass", 404, 0)
unit:GossipMenuAddItem(2, "Dun Morogh", 405, 0)
unit:GossipMenuAddItem(2, "Duskwood", 406, 0)
unit:GossipMenuAddItem(2, "Eastern Plaguelands", 407, 0)
unit:GossipMenuAddItem(2, "Elwynn Forest", 408, 0)
unit:GossipMenuAddItem(2, "Eversong Woods", 409, 0)
unit:GossipMenuAddItem(2, "Ghostlands", 410, 0)
unit:GossipMenuAddItem(0, "Next Page", 411, 0)
unit:GossipMenuAddItem(0, "Back", 4, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 411) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Hillsbrad Foothills", 412, 0)
unit:GossipMenuAddItem(2, "Loch Modan", 413, 0)
unit:GossipMenuAddItem(2, "Redridge Mountains", 414, 0)
unit:GossipMenuAddItem(2, "Searing Gorge", 415, 0)
unit:GossipMenuAddItem(2, "Silverpine Forest", 416, 0)
unit:GossipMenuAddItem(2, "Strangethorn Vale", 417, 0)
unit:GossipMenuAddItem(2, "Swamp Of Sorrows", 418, 0)
unit:GossipMenuAddItem(2, "The Hinterlands", 419, 0)
unit:GossipMenuAddItem(2, "Trisfal Glades", 420, 0)
unit:GossipMenuAddItem(2, "Westfall", 421, 0)
unit:GossipMenuAddItem(2, "Western Plaguelands", 422, 0)
unit:GossipMenuAddItem(2, "Wetlands", 423, 0)
unit:GossipMenuAddItem(0, "Back", 500, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 501) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Ashenvale", 430, 0)
unit:GossipMenuAddItem(2, "Azuremyst Isle", 431, 0)
unit:GossipMenuAddItem(2, "Bloodmyst Isle", 432, 0)
unit:GossipMenuAddItem(2, "Darkshore", 433, 0)
unit:GossipMenuAddItem(2, "Desolace", 434, 0)
unit:GossipMenuAddItem(2, "Durotar", 435, 0)
unit:GossipMenuAddItem(2, "Dustwallow Marsh", 436, 0)
unit:GossipMenuAddItem(2, "Felwood", 437, 0)
unit:GossipMenuAddItem(2, "Moonglade", 438, 0)
unit:GossipMenuAddItem(2, "Mulgore", 439, 0)
unit:GossipMenuAddItem(2, "Silithus", 440, 0)
unit:GossipMenuAddItem(0, "Next Page", 441, 0)
unit:GossipMenuAddItem(0, "Back", 4, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 441) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Tanaris", 442, 0)
unit:GossipMenuAddItem(2, "Teldrassil", 443, 0)
unit:GossipMenuAddItem(2, "The Barrens", 444, 0)
unit:GossipMenuAddItem(2, "Thousand Needles", 445, 0)
unit:GossipMenuAddItem(2, "Un'Goro Crater", 446, 0)
unit:GossipMenuAddItem(2, "Winterspring", 447, 0)
unit:GossipMenuAddItem(2, "Azshara", 448, 0)
unit:GossipMenuAddItem(0, "Back", 501, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 502) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Shadowfang Keep", 450, 0)
unit:GossipMenuAddItem(2, "Zul'Gurub", 451, 0)
unit:GossipMenuAddItem(2, "Scarlet Monastery", 452, 0)
unit:GossipMenuAddItem(2, "Stratholme", 453, 0)
unit:GossipMenuAddItem(2, "Scholomance", 454, 0)
unit:GossipMenuAddItem(2, "Blackrock", 455, 0)
unit:GossipMenuAddItem(2, "Onyxia's Lair", 456, 0)
unit:GossipMenuAddItem(2, "Molten Core", 457, 0)
unit:GossipMenuAddItem(2, "Karazhan", 458, 0)
unit:GossipMenuAddItem(2, "Caverns Of Time", 459, 0)
unit:GossipMenuAddItem(0, "Back", 4, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 503) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Gruul's Lair", 460, 0)
unit:GossipMenuAddItem(2, "Magtheridon's Laid", 461, 0)
unit:GossipMenuAddItem(2, "Zul'Aman", 462, 0)
unit:GossipMenuAddItem(2, "Serpentshrine Cavern", 463, 0)
unit:GossipMenuAddItem(2, "The Eye", 464, 0)
unit:GossipMenuAddItem(2, "Black Temple", 465, 0)
unit:GossipMenuAddItem(2, "Sunwell Plateau", 466, 0)
unit:GossipMenuAddItem(0, "Back", 5, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 504) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Hellfire Ramparts", 467, 0)
unit:GossipMenuAddItem(2, "The BloodFurnace", 468, 0)
unit:GossipMenuAddItem(2, "Shattered Halls", 469, 0)
unit:GossipMenuAddItem(2, "Mana-Tombs", 470, 0)
unit:GossipMenuAddItem(2, "Sethekk Halls", 471, 0)
unit:GossipMenuAddItem(2, "Auchenai Crypts", 472, 0)
unit:GossipMenuAddItem(2, "Shadow Labyrinth", 473, 0)
unit:GossipMenuAddItem(2, "Magisters Terrace", 474, 0)
unit:GossipMenuAddItem(2, "Tempest Keep", 475, 0)
unit:GossipMenuAddItem(2, "Slave Pens", 476, 0)
unit:GossipMenuAddItem(2, "The Underbog", 477, 0)
unit:GossipMenuAddItem(0, "Back", 5, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 505) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Hellfire Peninsula", 478, 0)
unit:GossipMenuAddItem(2, "Zangarmarsh", 479, 0)
unit:GossipMenuAddItem(2, "Nagarad", 480, 0)
unit:GossipMenuAddItem(2, "Blades Edge Mountains", 481, 0)
unit:GossipMenuAddItem(2, "Netherstorm", 482, 0)
unit:GossipMenuAddItem(2, "Terokkar Forest", 483, 0)
unit:GossipMenuAddItem(2, "Shadowmoon Valley", 484, 0)
unit:GossipMenuAddItem(0, "Back", 5, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 506) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Borean Tundra", 485, 0)
unit:GossipMenuAddItem(2, "Crystalsong Forest", 486, 0)
unit:GossipMenuAddItem(2, "Dragonblight", 487, 0)
unit:GossipMenuAddItem(2, "Grizzly Hills", 488, 0)
unit:GossipMenuAddItem(2, "Howling Fjord", 489, 0)
unit:GossipMenuAddItem(2, "Icecrown", 490, 0)
unit:GossipMenuAddItem(2, "Sholazar Basin", 491, 0)
unit:GossipMenuAddItem(2, "The Storm Peaks", 492, 0)
unit:GossipMenuAddItem(2, "Zul'Drak", 493, 0)
unit:GossipMenuAddItem(0, "Back", 6, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 507) then
unit:GossipCreateMenu(3000, player, 0)
unit:GossipMenuAddItem(2, "Naxxramas", 494, 0)
unit:GossipMenuAddItem(2, "Halls Of Lightning", 495, 0)
unit:GossipMenuAddItem(2, "Halls Of Stone", 496, 0)
unit:GossipMenuAddItem(2, "The Obsidian Sanctum", 497, 0)
unit:GossipMenuAddItem(2, "Vault Of Archavon", 498, 0)
unit:GossipMenuAddItem(2, "Voilet Hold", 499, 0)
unit:GossipMenuAddItem(2, "Utgarde Pinnacle", 600, 0)
unit:GossipMenuAddItem(2, "The Nexus/Occulus/Eye Of Eternity", 601, 0)
unit:GossipMenuAddItem(2, "Uldar", 602, 0)
unit:GossipMenuAddItem(0, "Back", 6, 0)
unit:GossipMenuAddItem(0, "Main Menu", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 900) then
unit:GossipCreateMenu(62, player, 0)
player:LearnSpell(15007)
player:UnlearnSpell(15007)
unit:GossipMenuAddItem(0, "[Back]", 999, 0)
unit:GossipSendMenu(player)
end

if(intid == 300) then
player:Teleport(571, 5798.553711, 645.019287, 647.477783)
unit:GossipComplete(player)
end

if(intid == 301) then
player:Teleport(0, -8913.230469, 554.632996, 93.794830)
unit:GossipComplete(player)
end

if(intid == 302) then
player:Teleport(0, -4982.447266, -880.969604, 501.659882)
unit:GossipComplete(player)
end

if(intid == 303) then
player:Teleport(1, 9946.639648, 2610.149414, 1316.256348)
unit:GossipComplete(player)
end

if(intid == 304) then
player:Teleport(530, -4008.085205, -11885.257813, -1.419589)
unit:GossipComplete(player)
end

if(intid == 305) then
player:Teleport(1, 1505.377319, -4414.602539, 20.598469)
unit:GossipComplete(player)
end

if(intid == 306) then
player:Teleport(0, 1831.750854, 238.543503, 60.478447)
unit:GossipComplete(player)
end

if(intid == 307) then
player:Teleport(1, -1282.347534, 133.302917, 131.218323)
unit:GossipComplete(player)
end

if(intid == 308) then
player:Teleport(530, 9381.675781, -7277.671387, 14.241373)
unit:GossipComplete(player)
end

if(intid == 309) then
player:Teleport(530, -1704.053589, 5376.160156, 3.416441)
unit:GossipComplete(player)
end

if(intid == 310) then
player:Teleport(1, -11836.854492, -4754.102051, 6.230094)
unit:GossipComplete(player)
end

if(intid == 311) then
player:Teleport(1, -10714.201172, 2414.157227, 7.605680)
unit:GossipComplete(player)
end

if(intid == 312) then
player:Teleport(36, -1478.834351, 521.719360, -0.000186)
unit:GossipComplete(player)
end

if(intid == 313) then
player:Teleport(36, -760.039124, 438.745941, 727.394104)
unit:GossipComplete(player)
end

if(intid == 314) then
player:Teleport(169, -1111.939941, -1941.119995, 92.007500)
unit:GossipComplete(player)
end

if(intid == 315) then
player:Teleport(0, -11208.176758, 1674.476196, 24.608866)
unit:GossipComplete(player)
end

if(intid == 320) then
player:Teleport(1, 4612.354004, -3862.625000, 944.182495)
unit:GossipComplete(player)
end

if(intid == 322) then
player:Teleport(0, -13226.803711, 229.691193, 33.161755)
unit:GossipComplete(player)
end

if(intid == 323) then
player:Teleport(0, -4147.456055, -1114.092529, 170.117996)
unit:GossipComplete(player)
end

if(intid == 324) then
player:Teleport(1, 7420.457031, -1580.407349, 179.838913)
unit:GossipComplete(player)
end

if(intid == 326) then
player:Teleport(0, -8075.481445, -317.063660, 271.870087)
unit:GossipComplete(player)
end

if(intid == 400) then
player:Teleport(0, 263.982361, -673.894104, 127.404716)
unit:GossipComplete(player)
end

if(intid == 401) then
player:Teleport(0, -6047.203125, -3313.854980, 258.708557)
unit:GossipComplete(player)
end

if(intid == 402) then
player:Teleport(0, -10906.685547, -2927.268066, 12.964416)
unit:GossipComplete(player)
end

if(intid == 403) then
player:Teleport(0, -7889.491699, -1135.223267, 2.924039)
unit:GossipComplete(player)
end

if(intid == 404) then
player:Teleport(0, -10448.166016, -1856.763916, 105.005913)
unit:GossipComplete(player)
end

if(intid == 405) then
player:Teleport(0, -5433.301270, -224.541077, 407.520925)
unit:GossipComplete(player)
end

if(intid == 406) then
player:Teleport(0, -11279.900391, -361.012268, 62.467072)
unit:GossipComplete(player)
end

if(intid == 407) then
player:Teleport(0, 1964.197754, -4337.873047, 74.472122)
unit:GossipComplete(player)
end

if(intid == 408) then
player:Teleport(0, -9548.906250, -52.026482, 56.932626)
unit:GossipComplete(player)
end

if(intid == 409) then
player:Teleport(530, 9445.799805, -6780.160645, 16.617193)
unit:GossipComplete(player)
end

if(intid == 410) then
player:Teleport(530, 7560.582520, -6810.677246, 87.206497)
unit:GossipComplete(player)
end

if(intid == 412) then
player:Teleport(0, -843.708008, -545.247009, 11.397400)
unit:GossipComplete(player)
end

if(intid == 412) then
player:Teleport(0, -843.708008, -545.247009, 11.397400)
unit:GossipComplete(player)
end

if(intid == 414) then
player:Teleport(0, -9249.617188, -2148.591553, 63.933914)
unit:GossipComplete(player)
end

if(intid == 415) then
player:Teleport(0, -7355.223633, -1098.422485, 277.840637)
unit:GossipComplete(player)
end

if(intid == 416) then
player:Teleport(0, 513.679016, 1625.099976, 125.510002)
unit:GossipComplete(player)
end

if(intid == 417) then
player:Teleport(0, -11612.054688, -58.522003, 105.949398)
unit:GossipComplete(player)
end

if(intid == 418) then
player:Teleport(0, -10460.044922, -3261.839600, 20.178509)
unit:GossipComplete(player)
end

if(intid == 419) then
player:Teleport(0, 146.856552, -2003.116577, 126.594170)
unit:GossipComplete(player)
end

if(intid == 420) then
player:Teleport(0, 2034.480835, 292.189941, 54.163761)
unit:GossipComplete(player)
end

if(intid == 421) then
player:Teleport(0, -10518.205078, 1069.469116, 54.769070)
unit:GossipComplete(player)
end

if(intid == 422) then
player:Teleport(0, 1265.575073, -1194.470703, 59.570076)
unit:GossipComplete(player)
end

if(intid == 423) then
player:Teleport(0, -4086.566650, -2614.740479, 44.690865)
unit:GossipComplete(player)
end

if(intid == 430) then
player:Teleport(1, 3189.298584, 226.574127, 14.819330)
unit:GossipComplete(player)
end

if(intid == 431) then
player:Teleport(530, -4194.541992, -12555.260742, 39.841660)
unit:GossipComplete(player)
end

if(intid == 432) then
player:Teleport(530, -2738.501797, -12210.000977, 8.803289)
unit:GossipComplete(player)
end

if(intid == 433) then
player:Teleport(1, 6207.632813, -154.939209, 80.792686)
unit:GossipComplete(player)
end

if(intid == 434) then
player:Teleport(1, -82.607262, 1676.598145, 89.806580)
unit:GossipComplete(player)
end

if(intid == 435) then
player:Teleport(1, 340.362000, -4686.290039, 16.641100)
unit:GossipComplete(player)
end

if(intid == 436) then
player:Teleport(1, -3460.119629, -4127.141602, 17.098972)
unit:GossipComplete(player)
end

if(intid == 437) then
player:Teleport(1, 5486.022949, -764.407228, 338.605072)
unit:GossipComplete(player)
end

if(intid == 438) then
player:Teleport(1, 8013.640625, -2676.404785, 514.589722)
unit:GossipComplete(player)
end

if(intid == 439) then
player:Teleport(1, -1840.750000, -456.561005, -8.845256)
unit:GossipComplete(player)
end

if(intid == 440) then
player:Teleport(1, -6925.356934, 915.713562, 22.929478)
unit:GossipComplete(player)
end

if(intid == 442) then
player:Teleport(1, -7160.649902, 3841.387207, 8.671937)
unit:GossipComplete(player)
end

if(intid == 443) then
player:Teleport(1, 9860.146484, 589.684326, 1300.625366)
unit:GossipComplete(player)
end

if(intid == 444) then
player:Teleport(1, -1026.215698, -3672.566650, 22.966539)
unit:GossipComplete(player)
end

if(intid == 445) then
player:Teleport(1, -4687.388184, -1836.957397, -44.047394)
unit:GossipComplete(player)
end

if(intid == 446) then
player:Teleport(1, -6154.613281, -1090.232422, -203.079956)
unit:GossipComplete(player)
end

if(intid == 447) then
player:Teleport(1, 6695.457031, -4669.457031, 721.567566)
unit:GossipComplete(player)
end

if(intid == 448) then
player:Teleport(1, 2741.128418, -4411.292969, 103.803925)
unit:GossipComplete(player)
end

if(intid == 450) then
player:Teleport(0, -242.876968, 1542.257568, 76.892174)
unit:GossipComplete(player)
end

if(intid == 451) then
player:Teleport(0, -242.876968, 1542.257568, 76.892174)
unit:GossipComplete(player)
end

if(intid == 452) then
player:Teleport(0, 2878.302246, -816.704773, 160.332397)
unit:GossipComplete(player)
end

if(intid == 453) then
player:Teleport(0, 3351.682373, -3379.496094, 144.780228)
unit:GossipComplete(player)
end

if(intid == 454) then
player:Teleport(0, 1266.714722, -2556.920166, 94.127419)
unit:GossipComplete(player)
end

if(intid == 455) then
player:Teleport(0, -7534.680176, -1213.109985, 285.431000)
unit:GossipComplete(player)
end

if(intid == 456) then
player:Teleport(1, -4708.069336, -3727.718994, 54.573933)
unit:GossipComplete(player)
end

if(intid == 457) then
player:Teleport(230, 1125.097900, -454.822937, -101.581688)
unit:GossipComplete(player)
end

if(intid == 458) then
player:Teleport(0, -11124.409180, -2015.627930, 47.120663)
unit:GossipComplete(player)
end

if(intid == 459) then
player:Teleport(1, -8182.500000, 4696.040039, 17.523251)
unit:GossipComplete(player)
end

if(intid == 460) then
player:Teleport(530, 3524.755371, 5101.661133, 3.072796)
unit:GossipComplete(player)
end

if(intid == 461) then
player:Teleport(530, -333.516205, 3125.315918, -102.970184)
unit:GossipComplete(player)
end

if(intid == 462) then
player:Teleport(530, 6852.098145, -7953.127441, 170.098938)
unit:GossipComplete(player)
end

if(intid == 463) then
player:Teleport(530, 791.185181, 6865.699219, -65.006554)
unit:GossipComplete(player)
end

if(intid == 464) then
player:Teleport(530, 3089.215820, 1381.435059, 184.864380)
unit:GossipComplete(player)
end

if(intid == 465) then
player:Teleport(530, -3604.214600, 326.868164, 38.729469)
unit:GossipComplete(player)
end

if(intid == 466) then
player:Teleport(530, 12577.938477, -6775.112305, 15.086068)
unit:GossipComplete(player)
end

if(intid == 467) then
player:Teleport(530, -360.265076, 3068.756104, -15.114500)
unit:GossipComplete(player)
end

if(intid == 468) then
player:Teleport(530, -299.533020, 3158.082520, 31.658264)
unit:GossipComplete(player)
end

if(intid == 469) then
player:Teleport(530, -308.039093, 3069.387207, -3.330737)
unit:GossipComplete(player)
end

if(intid == 470) then
player:Teleport(530, -3095.589355, 4947.178711, -101.084450)
unit:GossipComplete(player)
end

if(intid == 471) then
player:Teleport(530, -3360.259521, 4693.305176, -101.048592)
unit:GossipComplete(player)
end

if(intid == 472) then
player:Teleport(530, -3363.312500, 5206.016602, -101.049477)
unit:GossipComplete(player)
end

if(intid == 473) then
player:Teleport(530, -3605.316406, 4942.418945, -101.048210)
unit:GossipComplete(player)
end

if(intid == 474) then
player:Teleport(530, 12886.801758, -7332.976074, 65.481247)
unit:GossipComplete(player)
end

if(intid == 475) then
player:Teleport(530, 3100.356094, 1527.632568, 190.300339)
unit:GossipComplete(player)
end

if(intid == 476) then
player:Teleport(530, 716.138062, 6991.310547, -73.074303)
unit:GossipComplete(player)
end

if(intid == 477) then
player:Teleport(530, 778.920959, 6766.257324, -71.898819)
unit:GossipComplete(player)
end

if(intid == 478) then
player:Teleport(530, -248.000000, 956.000000, 84.362801)
unit:GossipComplete(player)
end

if(intid == 479) then
player:Teleport(530, -1040.743164, 5380.502930, 22.108717)
unit:GossipComplete(player)
end

if(intid == 480) then
player:Teleport(530, -481.318756, 8420.708984, 31.585732)
unit:GossipComplete(player)
end

if(intid == 481) then
player:Teleport(530, 1714.867432, 6047.045898, 143.767380)
unit:GossipComplete(player)
end

if(intid == 482) then
player:Teleport(530, 3382.884277, 4140.254395, 148.334152)
unit:GossipComplete(player)
end

if(intid == 483) then
player:Teleport(530, -1942.855713, 4684.942871, -2.187463)
unit:GossipComplete(player)
end

if(intid == 484) then
player:Teleport(530, -2975.471436, 2959.093750, 72.738640)
unit:GossipComplete(player)
end

if(intid == 485) then
player:Teleport(571, 2102.045166, 6529.468262, 0.573996)
unit:GossipComplete(player)
end

if(intid == 486) then
player:Teleport(571, 5711.308105, 1011.812256, 174.479507)
unit:GossipComplete(player)
end

if(intid == 487) then
player:Teleport(571, 3509.596926, 2841.850830, 36.646351)
unit:GossipComplete(player)
end

if(intid == 488) then
player:Teleport(571, 3349.896729, -5593.875000, 259.144592)
unit:GossipComplete(player)
end

if(intid == 489) then
player:Teleport(571, 2027.013550, -4510.509277, 207.624573)
unit:GossipComplete(player)
end

if(intid == 490) then
player:Teleport(571, 6711.064063, 2473.802979, 429.895142)
unit:GossipComplete(player)
end

if(intid == 491) then
player:Teleport(571, 5573.436523, 5749.734375, -74.824722)
unit:GossipComplete(player)
end

if(intid == 492) then
player:Teleport(571, 6109.867676, -1059.728882, 403.013428)
unit:GossipComplete(player)
end

if(intid == 493) then
player:Teleport(571, 5452.265137, -2608.871094, 306.910156)
unit:GossipComplete(player)
end

if(intid == 494) then
player:Teleport(571, 3672.763672, -1272.110596, 243.509659)
unit:GossipComplete(player)
end

if(intid == 495) then
player:Teleport(571, 9183.885742, -1385.423096, 1110.215698)
unit:GossipComplete(player)
end

if(intid == 496) then
player:Teleport(571, 8921.869141, -981.888062, 1039.308594)
unit:GossipComplete(player)
end

if(intid == 497) then
player:Teleport(571, 3516.448486, 268.855072, -114.035500)
unit:GossipComplete(player)
end

if(intid == 498) then
player:Teleport(571, 5467.650879, 2840.862305, 418.675415)
unit:GossipComplete(player)
end

if(intid == 499) then
player:Teleport(571, 5687.046387, 495.134888, 652.644714)
unit:GossipComplete(player)
end

if(intid == 600) then
player:Teleport(571, 1255.936279, -4852.825684, 215.602203)
unit:GossipComplete(player)
end

if(intid == 601) then
player:Teleport(571, 3773.419922, 6939.600098, 106.174004)
unit:GossipComplete(player)
end

if(intid == 602) then
player:Teleport(571, 9333.074219, -1115.338257, 1245.146851)
unit:GossipComplete(player)
end

--endCustom Instances/Area Teleports Start Here! 

if(intid == 800) then
player:Teleport(1, 4612.13, 3862.4, 944.182)
unit:GossipComplete(player)
end

--Custom Instances/Areas Teleports Stop Here!

if(intid == 900) then
player:Teleport(0, -13263.00, 160.08, 37.27)
unit:GossipComplete(player)
end

if(intid == 901) then
player:Teleport(1, -3842.24, 1097.79, 163.01)
unit:GossipComplete(player)
end

end

RegisterUnitGossipEvent(100000, 1, "On_Gossip")
RegisterUnitGossipEvent(100000, 2, "Gossip_Submenus")