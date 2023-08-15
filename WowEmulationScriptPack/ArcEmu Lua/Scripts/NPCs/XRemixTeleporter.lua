local npcid = 990090
function On_Gossip(unit, event, player)
unit:GossipCreateMenu(50, player, 0)
unit:GossipMenuAddItem(5, "Remixed Locations", 666, 0)
unit:GossipMenuAddItem(5, "Horde Cities", 1, 0)
unit:GossipMenuAddItem(0, "Alliance Cities", 2, 0)
unit:GossipMenuAddItem(7, "Azeroth Locations", 3, 0)
unit:GossipMenuAddItem(5, "Azeroth Instances", 5, 0)
unit:GossipMenuAddItem(9, "Outland Locations", 6, 0)
unit:GossipMenuAddItem(9, "Outland Instances", 7, 0)
unit:GossipMenuAddItem(0, "Northrend Locations", 97, 0)
unit:GossipMenuAddItem(1, "Gurubashi Arena", 45,  0)
unit:GossipMenuAddItem(1, "Isle of Quel' Danas", 46,  0)
unit:GossipMenuAddItem(5, "Quick Buff", 99, 0)
unit:GossipMenuAddItem(5, "Quick Heal", 98, 0)
unit:GossipMenuAddItem(5, "Quick Removal of Resurrection Sickness", 900, 0)
unit:GossipSendMenu(player)
end

function Gossip_Submenus(Unit, event, player, id, intid, code, pMisc)
if(intid == 75) then
unit:GossipCreateMenu(50, player, 0)
unit:GossipMenuAddItem(5, "Remixed Locations", 666, 0)
unit:GossipMenuAddItem(5, "Horde Cities", 1, 0)
unit:GossipMenuAddItem(0, "Alliance Cities", 2, 0)
unit:GossipMenuAddItem(7, "Azeroth Locations", 3, 0)
unit:GossipMenuAddItem(5, "Azeroth Instances", 5, 0)
unit:GossipMenuAddItem(9, "Outland Locations", 6, 0)
unit:GossipMenuAddItem(9, "Outland Instances", 7, 0)
unit:GossipMenuAddItem(0, "Northrend Locations", 97, 0)
unit:GossipMenuAddItem(1, "Gurubashi Arena", 45,  0)
unit:GossipMenuAddItem(1, "Isle of Quel' Danas", 46,  0)
unit:GossipMenuAddItem(5, "Buff me", 99, 0)
unit:GossipMenuAddItem(5, "Heal me", 98, 0)
unit:GossipMenuAddItem(5, "Remove Resurrection Sickness", 900, 0)
unit:GossipSendMenu(player)
end

if(intid == 1) then
unit:GossipCreateMenu(51, player, 0)
unit:GossipMenuAddItem(1, "Orgrimmar", 10, 0)
unit:GossipMenuAddItem(1, "Undercity", 11, 0)
unit:GossipMenuAddItem(1, "Thunder Bluff", 12, 0)
unit:GossipMenuAddItem(1, "Silvermoon", 13, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 2) then
unit:GossipCreateMenu(52, player, 0)
unit:GossipMenuAddItem(1, "Stormwind", 14, 0)
unit:GossipMenuAddItem(2, "Ironforge", 15, 0)
unit:GossipMenuAddItem(3, "Darnassus", 16, 0)
unit:GossipMenuAddItem(4, "Exodar", 17, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 3) then
unit:GossipCreateMenu(53, player, 0)
unit:GossipMenuAddItem(0, "Eastern Kingdoms", 40, 0)
unit:GossipMenuAddItem(0, "Kalidamor", 41, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 40) then
unit:GossipCreateMenu(54, player, 0)
unit:GossipMenuAddItem(1, "Alterac Mountains", 208, 0)
unit:GossipMenuAddItem(2, "Badlands", 214, 0)
unit:GossipMenuAddItem(3, "Blasted Lands", 222, 0)
unit:GossipMenuAddItem(4, "Burning Steppes", 216, 0)
unit:GossipMenuAddItem(5, "Deadwind Pass", 221, 0)
unit:GossipMenuAddItem(6, "Dun Morogh", 212, 0)
unit:GossipMenuAddItem(7, "Duskwood", 220, 0)
unit:GossipMenuAddItem(8, "Eastern Plaguelands", 206, 0)
unit:GossipMenuAddItem(11, "Elwynn Forest", 217, 0)
unit:GossipMenuAddItem(3, "Eversong Woods", 201, 0)
unit:GossipMenuAddItem(5, "Ghostlands", 202, 0)
unit:GossipMenuAddItem(6, "-->Second Page-->", 43, 0)
unit:GossipMenuAddItem(0, "[Back]", 3, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 41) then
unit:GossipCreateMenu(55, player, 0)
unit:GossipMenuAddItem(1, "Ashenvale", 109, 0)
unit:GossipMenuAddItem(1, "Azuremyst Isle", 103, 0)
unit:GossipMenuAddItem(1, "Bloodmyst Isle", 102, 0)
unit:GossipMenuAddItem(1, "Darkshore", 105, 0)
unit:GossipMenuAddItem(1, "Desolace", 113, 0)
unit:GossipMenuAddItem(1, "Durotar", 111, 0)
unit:GossipMenuAddItem(1, "Dustwallow Marsh", 117, 0)
unit:GossipMenuAddItem(1, "Felwood", 107, 0)
unit:GossipMenuAddItem(1, "Feralas", 116, 0)
unit:GossipMenuAddItem(1, "Moonglade", 106, 0)
unit:GossipMenuAddItem(1, "Mulgore", 115, 0)
unit:GossipMenuAddItem(1, "Silithus", 120, 0)
unit:GossipMenuAddItem(0, "-->Second Page-->", 43, 0)
unit:GossipMenuAddItem(0, "[Back]", 3, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 42) then
unit:GossipCreateMenu(55, player, 0)
unit:GossipMenuAddItem(1, "Hillsbrad Foothills", 210, 0)
unit:GossipMenuAddItem(1, "Loch Modan", 213, 0)
unit:GossipMenuAddItem(1, "Redridge Mountains", 218, 0)
unit:GossipMenuAddItem(1, "Searing Gorge", 215, 0)
unit:GossipMenuAddItem(1, "Silverpine Forest", 207, 0)
unit:GossipMenuAddItem(1, "Strangethorn Vale", 223, 0)
unit:GossipMenuAddItem(1, "Swamp Of Sorrows", 219, 0)
unit:GossipMenuAddItem(1, "The Hinterlands", 209, 0)
unit:GossipMenuAddItem(1, "Trisfal Glades", 205, 0)
unit:GossipMenuAddItem(1, "Western Plaguelands", 203, 0)
unit:GossipMenuAddItem(1, "Wetlands", 211, 0)
unit:GossipMenuAddItem(0, "[Back]", 3, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 43) then
unit:GossipCreateMenu(55, player, 0)
unit:GossipMenuAddItem(1, "Stonetalon Mountains", 112, 0)
unit:GossipMenuAddItem(1, "Tanaris", 121, 0)
unit:GossipMenuAddItem(1, "Teldrassil", 100, 0)
unit:GossipMenuAddItem(1, "The Barrens", 114, 0)
unit:GossipMenuAddItem(1, "Thousand Needles", 118, 0)
unit:GossipMenuAddItem(1, "Un'Goro Crater", 119, 0)
unit:GossipMenuAddItem(1, "Winterspring", 108, 0)
unit:GossipMenuAddItem(0, "[Back]", 3, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 5) then
unit:GossipCreateMenu(56, player, 0)
unit:GossipMenuAddItem(1, "Shadowfang Keep", 19, 0)
unit:GossipMenuAddItem(1, "Zul'Gurub", 20, 0)
unit:GossipMenuAddItem(1, "Scarlet Monastery", 21, 0)
unit:GossipMenuAddItem(1, "Stratholme", 22, 0)
unit:GossipMenuAddItem(1, "Scholomance", 23, 0)
unit:GossipMenuAddItem(1, "Blackrock", 24, 0)
unit:GossipMenuAddItem(1, "Onyxia's Lair", 25, 0)
unit:GossipMenuAddItem(1, "Molten Core", 26, 0)
unit:GossipMenuAddItem(1, "Karazhan", 27, 0)
unit:GossipMenuAddItem(1, "Naxxramas", 28, 0)
unit:GossipMenuAddItem(1, "Caverns Of Time", 29, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 6) then
unit:GossipCreateMenu(57, player, 0)
unit:GossipMenuAddItem(1, "Hellfire", 30, 0)
unit:GossipMenuAddItem(1, "Zangremarsh", 31, 0)
unit:GossipMenuAddItem(1, "Nagrand", 32, 0)
unit:GossipMenuAddItem(1, "Blades Edge", 33, 0)
unit:GossipMenuAddItem(1, "Netherstorm", 34, 0)
unit:GossipMenuAddItem(1, "Terokkar Forest", 35, 0)
unit:GossipMenuAddItem(1, "Shadowmoon Valley", 36, 0)
unit:GossipMenuAddItem(1, "Shattrath", 37, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 7) then
unit:GossipCreateMenu(58, player, 0)
unit:GossipMenuAddItem(0, "Outland Raids", 41, 0)
unit:GossipMenuAddItem(1, "Hellfire Ramparts", 430, 0)
unit:GossipMenuAddItem(1, "The BloodFurnace", 431, 0)
unit:GossipMenuAddItem(1, "Shattered Halls", 441, 0)
unit:GossipMenuAddItem(1, "Mana-Tombs", 434, 0)
unit:GossipMenuAddItem(1, "Sethekk Halls", 438, 0)
unit:GossipMenuAddItem(1, "Auchenai Crypts", 435, 0)
unit:GossipMenuAddItem(1, "Shadow Labyrinth", 440, 0)
unit:GossipMenuAddItem(1, "Caverns of Time", 436, 0)
unit:GossipMenuAddItem(1, "Shadow Labyrinth", 440, 0)
unit:GossipMenuAddItem(1, "Magisters Terrace", 445, 0)
unit:GossipMenuAddItem(0, "-->Second Page-->", 47, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 47) then
unit:GossipCreateMenu(59, player, 0)
unit:GossipMenuAddItem(1, "Gruul's Lair", 446, 0)
unit:GossipMenuAddItem(1, "Magtheridon's Lair", 447, 0)
unit:GossipMenuAddItem(1, "Zul'Aman", 448, 0)
unit:GossipMenuAddItem(1, "Serpentshrine Cavern", 449, 0)
unit:GossipMenuAddItem(1, "The Eye", 450, 0)
unit:GossipMenuAddItem(1, "Black Temple", 451, 0)
unit:GossipMenuAddItem(1, "Sunwell Plateau", 452, 0)
unit:GossipMenuAddItem(0, "[Back]", 7, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 48) then
unit:GossipCreateMenu(60, player, 0)
unit:GossipMenuAddItem(1, "The Mechanar", 442, 0)
unit:GossipMenuAddItem(1, "The Botanica", 443, 0)
unit:GossipMenuAddItem(1, "The Arcatraz", 444, 0)
unit:GossipMenuAddItem(1, "The Steamvault", 439, 0)
unit:GossipMenuAddItem(1, "Slave Pens", 432, 0)
unit:GossipMenuAddItem(1, "The Underbog", 433, 0)
unit:GossipMenuAddItem(0, "[Back]", 7, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 8) then
unit:GossipCreateMenu(50, player, 0)
unit:GossipMenuAddItem(1, "Terrace of Light", 38, 0)
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
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 98) then
unit:GossipCreateMenu(63, player, 0)
unit:FullCastSpellOnTarget(26565, player)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 900) then
unit:GossipCreateMenu(62, player, 0)
player:LearnSpell(15007)
player:UnlearnSpell(15007)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 97) then
unit:GossipCreateMenu(500, player, 0)
unit:GossipMenuAddItem(1, "Borean Tundra", 501, 0)
unit:GossipMenuAddItem(1, "Crystalsong Forest", 502, 0)
unit:GossipMenuAddItem(1, "Dalaran (City)", 503, 0)
unit:GossipMenuAddItem(1, "Dragonblight", 504, 0)
unit:GossipMenuAddItem(1, "Grizzly Hills", 505, 0)
unit:GossipMenuAddItem(1, "Howling Fjord", 506, 0)
unit:GossipMenuAddItem(1, "Icecrown", 507, 0)
unit:GossipMenuAddItem(1, "Sholazar Basin", 508, 0)
unit:GossipMenuAddItem(1, "The Storm Peaks", 509, 0)
unit:GossipMenuAddItem(1, "Zul'Dark", 510, 0)
unit:GossipMenuAddItem(1, "DK Start Zone", 511, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end

if(intid == 666) then
unit:GossipCreateMenu(777, player, 0)
unit:GossipMenuAddItem(5, "Don't go, I repeat don't go to locations that are not for your faction. If you do that, you will have to face the concequences.", 600, 0)
unit:GossipMenuAddItem(4, "Horde Mall", 512, 0)
unit:GossipMenuAddItem(6, "Alliance Mall", 513, 0)
unit:GossipMenuAddItem(8, "Horde Resistance Camp", 514, 0)
unit:GossipMenuAddItem(1, "Alliance Resistance Camp", 515, 0)
unit:GossipMenuAddItem(0, "[Main Menu]", 75, 0)
unit:GossipSendMenu(player)
end


if(intid == 512) then
player:Teleport( 1, 7408.962891, -1643.316284, 189.942795)
end

if(intid == 514) then
player:Teleport(37, -136.931244, 865.885803, 298.638367)
end

if(intid == 513) then
player:Teleport(37, 1022.572937, 288.628998, 331.787537)
end

if(intid == 515) then
player:Teleport(37, -309.048706, -308.227203, 295.927979)
end

if(intid == 10) then
player:Teleport(1, 1484, -4417, 25)
end

if(intid == 11) then
player:Teleport(0, 1831, 238, 60)
end

if(intid == 12) then
player:Teleport(1, -1277, 118, 131)
end

if(intid == 13) then
player:Teleport(530, 9413, -7277, 14)
end

if(intid == 14) then
player:Teleport(0, -8913.23, 554.633, 94.7944)
end


if(intid == 15) then
player:Teleport(0, -4981.25, -881.542, 502.66)
end

if(intid == 16) then
player:Teleport(1, 9948, 2413, 1327)
end

if(intid == 17) then
player:Teleport(530, -4014.080078, -11895.799805, -1.990842)
end

if(intid == 19) then
player:Teleport(0, -234.495087, 1561.946411, 76.892143)
end

if(intid == 20) then
player:Teleport(0, -11919.073242, -1202.459374, 92.298744)
end

if(intid == 21) then
player:Teleport(0, 2870.442627, -819.985229, 160.331085)
end

if(intid == 22) then
player:Teleport(0, 3359.111572, -3380.8444238, 144.781860)
end

if(intid == 23) then
player:Teleport(0, 1267.468628, -2556.651367, 94.127983)
end

if(intid == 24) then
player:Teleport(0, -7527.129883, -1224.997437, 285.733002)
end

if(intid == 25) then
player:Teleport(1, -4708.491699, -3727.672363, 54.535076)
end

if(intid == 26) then
player:Teleport(0, -7515.409668, -1045.369629, 182.301208)
end

if(intid == 27) then
player:Teleport(0, -11122.913086, -2014.498779, 47.079350)
end

if(intid == 28) then
player:Teleport(0, 3132.915283, -3731.012939, 138.658371)
end

if(intid == 29) then
player:Teleport(1, -8519.718750, -4297.542480, -208.441376)
end

if(intid == 30) then
player:Teleport(530, -247.9672, 948.5709, 84.3798)
end

if(intid == 31) then
player:Teleport(530, -1045.0179, 5380.0288, 22.1216)
end

if (intid == 32) then
player:Teleport(530, -468, 8418, 28)
end

if(intid == 33) then
player:Teleport(530, 1552.2236, 6813.3798, 125.1364)
end

if(intid == 34) then
player:Teleport(530, 3396, 4185, 137)
end

if(intid == 35) then
player:Teleport(530, -2276.82, 5132.03, -8.62994)
end

if(intid == 36) then
player:Teleport(530, -3004.3488, 2968.4343, 81.8821)
end

if(intid == 37) then
player:Teleport(530, -1849.4200, 5401.4599, -12.4279)
end

if(intid == 38) then
player:Teleport(530, -1849.4200, 5401.4599, -12.4279)
end

if(intid == 45) then
player:Teleport(0, -13243.240234, 197.949799, 32.112690)
end

if(intid == 46) then
player:Teleport(530, 12956.072266, -6943.814453, 9.968110)
end

if(intid == 100) then
player:Teleport(1, 9874.646484, 595.742432, 1303.874023)
end

if(intid == 102) then
player:Teleport(530, -2721.68, -12208.9, 10.0882)
end

if(intid == 103) then
player:Teleport(530, -4020.48, -13783.3, 74.9001)
end

if(intid == 105) then
player:Teleport(1, 6207.5, -152.833, 80.8185)
end

if(intid == 106) then
player:Teleport(1, 7101.68, -2670.2, 512.2)
end

if(intid == 107) then
player:Teleport(1, 5483.9, -749.881, 335.621)
end

if(intid == 108) then
player:Teleport(1, 6107.62, -4181.6, 853.322)
end

if(intid == 109) then
player:Teleport(1, 2717.1, 5967.91, 107.4)  (1, 3469.43, 847.62, 6.36476)
end

if(intid == 111) then
player:Teleport(1, 341.42, -4684.7, 31.9493)
end

if(intid == 112) then
player:Teleport(1, 1145.85, 664.812, 143)
end

if(intid == 113) then
player:Teleport(1, -93.1614, 1691.15, 90.0649)
end

if(intid == 114) then
player:Teleport(1, -90.19003, -1943.44, -180.4727)
end

if(intid == 115) then
player:Teleport(1, -1840.75, 5359, -7.845)
end

if(intid == 116) then
player:Teleport(1, -4458.93, 243.415, -65.6136)
end

if(intid == 117) then
player:Teleport(1, -3463.26, -4123.13, 18.1043)
end

if(intid == 118) then
player:Teleport(1, -4932.53, -1596.05, 85.8157)
end

if(intid == 119) then
player:Teleport(1, -7932.61, -2139.61, -229.728)
end

if(intid == 120) then
player:Teleport(1, -7373.69, -2950.2, -11.7598)
end

if(intid == 121) then
player:Teleport(1, -7373.69, -2950.2, -30.7598)
end

if(intid == 201) then
player:Teleport(530, 9449.15, -6782.61, 16.6167)
end 

if(intid == 202) then
player:Teleport(530, 7880, -6193, 22)
end

if(intid == 203) then
player:Teleport(0, 1224.36, -1151.97, 61.7327)
end 

if(intid == 205) then
player:Teleport(0, 2019.35, 1904.36, 106.144)
end

if(intid == 206) then
player:Teleport(0, 1919.44, -4306.23, 77.838)
end 

if(intid == 207) then
player:Teleport(0, 511.536, 1638.63, 121.417)
end

if(intid == 208) then
player:Teleport(0, 272.704, -654.514, 129.609)
end 

if(intid == 209) then
player:Teleport(0, 139.375, -1982.79, 134.043)
end 

if(intid == 210) then
player:Teleport(0, -852.854, -576.712, 21.0293)
end 

if(intid == 211) then
player:Teleport(0, -4086.36, -2610.95, 47.0143)
end

if(intid == 212) then
player:Teleport(0, -5425.924316, -224.271957, 404.984344)
end

if(intid == 213) then
player:Teleport(0, -4939.1, -3423.74, 306.595)
end

if(intid == 214) then
player:Teleport(0, -6018.138184, -3311.517822, 261.744324)
end 

if(intid == 215) then
player:Teleport(0, -7176.63, -937.667, 171.206)
end

if(intid == 216) then
player:Teleport(0, -7907.41, -1128.66, 192.056)
end 

if(intid == 217) then
player:Teleport(0, -9621.383789, -371.068207, 57.471478)
end

if(intid == 218) then
player:Teleport(0, -9219.37, -2149.94, 71.606)
end

if(intid == 219) then
player:Teleport(0, -10264.6, -3059.9, 19.9356)
end 						

if(intid == 220) then
player:Teleport(0, -11224.254883, -378.471802, 52.764240)
end

if(intid == 221) then
player:Teleport(0, -10435.4, -1809.28, 101)
end

if(intid == 222) then
player:Teleport(0, -11204.5, -2730.61, 15.8972)
end

if(intid == 223) then
player:Teleport(0, -11634.8, -54.0697, 14.4439)
end

if(intid == 430) then
player:Teleport(530, -360.671, 3071.9, -15.0977)
end 

if(intid == 431) then
player:Teleport(542, -3.9967, 14.6363, -44.8009)
end 

if(intid == 432) then
player:Teleport(530, 721.926, 7012.24, -73.065)
end 

if(intid == 433) then
player:Teleport(530, 779.802, 6769.33, -71.4282)
end 

if(intid == 434) then
player:Teleport(530, -3101.47, 4947.11, -101.177)
end 

if(intid == 435) then
player:Teleport(530, -3357.32, 5216.77, -101.049)
end 

if(intid == 436) then
player:Teleport(1, -8195.94, -4500.13, 9.60819)
end 

if(intid == 438) then
player:Teleport(530, -3360.13, 4667.85, -101.047)
end 

if(intid == 439) then
player:Teleport(0, -11634.8, -54.0697, 14.4439)
end 

if(intid == 440) then
player:Teleport(530, -3635.76, 4931.82, -100.034)
end 

if(intid == 441) then
player:Teleport(530, -309.83, 3080.08, -3.63538)
end 

if(intid == 442) then
player:Teleport(530, 2885.2, 1564.73, 248.874)
end

if(intid == 443) then
player:Teleport(530, 3405.48, 1489.14, 183.838)
end

if(intid == 444) then
player:Teleport(530, 2872, 1555.29, 253.159)
end 

if(intid == 445) then
player:Teleport(585, 2.19347, -0.123698, -2.8025)
end

if(intid == 446) then
player:Teleport(530, 3606.85, 5260.49, 4.1724)
end 

if(intid == 447) then
player:Teleport(530, -319.635, 3102.03, -113.937)
end 

if(intid == 448) then
player:Teleport(530, 6850, -7950, 170)
end 

if(intid == 449) then
player:Teleport(530, 742.883, 6867.19, -68.8289)
end 

if(intid == 450) then
player:Teleport(530, 3087.22, 1380.7, 184.883)
end

if(intid == 451) then
player:Teleport(530, -3604.74, 328.252, 38.3077)
end

if(intid == 452) then
player:Teleport(580, 1791.17, 926.31, 15.1135)
end

if(intid == 501) then
player:Teleport(571, 2087.0109, 6508.6171, 1.4727)
end

if(intid == 502) then
player:Teleport(571, 5434.8281, -1022.4812, 175.0125)
end

if(intid == 503) then
player:Teleport(571, 5811.4067, 647.7883, 647.4152)
end

if(intid == 504) then
player:Teleport(571, 3511.6850, 2841.8454, 36.7473)
end

if(intid == 505) then
player:Teleport(571, 3346.2551, -4486.8173, 259.2319)
end

if(intid == 506) then
player:Teleport(571, 2195.3654, -4526.7729, 216.7943)
end

if(intid == 507) then
player:Teleport(571, 6729.2387, 2510.4931, 427.7868)
end

if(intid == 508) then
player:Teleport(570, 4913.3090, 5536.0737, -76.4190)
end

if(intid == 509) then
player:Teleport(571, 6196.4174, -776.7462, 402.3688)
end

if(intid == 510) then
player:Teleport(571, 5443.4326, -1259.7487, 248.7494)
end

if(intid == 511) then
player:Teleport(609, 2355.7048, -5662.7075, 426.0274)
end

if(intid == 99) then
pUnit:SendChatMessage(12, 0, "I'm Jean Clod Van Dam and I'm a mage")
player:GossipComplete(player)
end


if(intid == 98) then
pUnit:SendChatMessage(12, 0, "Je m'appele Jean Clod Van Dam et je suis le mage.")
player:GossipComplete(player)
end

if(intid == 900) then
pUnit:SendChatMessage(12, 0, "You have been healed. Use it wisely.")
player:GossipComplete(player)
end
end

RegisterUnitGossipEvent(990090, 1, "On_Gossip")
RegisterUnitGossipEvent(990090, 2, "Gossip_Submenus")