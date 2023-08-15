
 
multiClassUtils = {}
 
--                                      Config:
multiClassUtils.npcEntryID = 999099 -- the entryid of the npc.
multiClassUtils.TABLE_NAME = "items_for_sale" -- table name: encase in double quotation marks e.g. "..."
multiClassUtils.npcIsVendor = true -- True: The npc will sell stuff. False: The npc wont sell stuff and wont show the sale menus.
                                -- CONFIG END --
                               
--                              NOTE: The class's numbers are below.
--------------------------------------||  ||---------------------------
----------------------------||  ||-----------------
-----------------------------|| ||------------------
multiClassUtils.anyClass        = 1535
multiClassUtils.warrior         = 1
multiClassUtils.paladin         = 2
multiClassUtils.hunter          = 4
multiClassUtils.rogue           = 8
multiClassUtils.priest          = 16
multiClassUtils.deathKnight     = 32
multiClassUtils.shaman          = 64
multiClassUtils.mage            = 128
multiClassUtils.warlock         = 256
multiClassUtils.druid           = 1024
 
multiClassUtils.allSpells       = {}
multiClassUtils.allSpells["Warrior"] =
{      
        6673,5242,6192,11549,11550,11551,25289,2048,47436,18499,2458,2687,1161,100,6178,11578,845,
        7369,11608,11609,20569,25231,47519,47520,469,47439,47440,71,1160,6190,11554,11555,11556,
        25202,25203,47437,676,55694,5308,20658,20660,20661,20662,25234,25236,47470,47471,1715,284,
        1608,11564,11565,11566,11567,25286,29707,30324,47449,47450,57755,20252,3411,5246,694,7384,
        6552,1719,772,6546,6547,6548,11572,11573,11574,25208,46845,47471,20230,6572,6574,7379,11600,
        11601,25288,25269,30357,57823,64382,72,2565,23922,23923,23924,23925,25258,30356,47487,47488,
        871,1464,8820,11604,11605,25241,25242,47474,47475,23920,12678,7386,355,6343,8198,8204,8205,
        11580,11581,25264,47501,47502,34428,1680                                                                                                               
}
multiClassUtils.allSpells["Paladin"] =
{
        31884,20217,19740,19834,19835,19836,10937,19838,25291,27140,48931,48932,19742,19850,19852,
        19853,19854,25290,48935,48936,4987,19746,26573,20116,20922,20923,20924,27173,48818,48810,
        32223,48942,19752,54428,498,642,879,5614,5615,10312,10313,10314,27138,48800,48801,48947,
        19750,19939,19940,19941,19942,19943,27137,48784,48785,48945,25898,25782,25916,27141,48933,
        48934,25899,25894,25918,27143,48937,48938,853,5588,5589,10308,24275,24274,24239,27180,48805,
        48806,1044,1022,5599,10278,62124,6940,1038,639,647,1026,1042,3472,10328,10329,25292,27135,
        27136,48781,48782,2812,10318,27139,48816,48817,53407,20271,53408,633,2800,10310,27154,48788,
        1152,7328,10322,10324,20772,20773,48949,48950,54043,31789,25780,53601,20164,20165,21084,
        20166,48943,5502,53600,61411,10326                                                                                                                             
}
multiClassUtils.allSpells["Hunter"] =
{
        3044,14281,14281,14282,14283,14284,14285,14286,14287,27019,49044,49045,13161,5118,61846,
        61847,13165,14318,14319,14320,14321,14322,25296,27044,13163,13159,34074,20043,20190,27045,
        49071,1462,883,62757,5116,19263,781,2641,20736,6197,13813,14316,14317,27025,49066,49067,
        1002,6991,5384,1543,60192,1499,14310,14311,13809,1130,14323,14324,14325,53338,13795,14302,
        14303,14304,14305,27023,49055,49056,34026,53351,61005,61006,53271,136,3111,3661,3662,13542,
        13543,13544,27046,48989,48990,34477,1495,14269,14270,14271,36916,53339,2643,14288,14289,
        14290,25204,27021,49047,49048,3045,14260,14261,14262,14263,14264,14265,14266,27014,48995,
        48996,982,1513,14326,14327,3043,1978,13549,13550,13551,13552,13553,13554,13555,25295,27016,
        49000,49001,34600,56641,34120,49051,49052,1515,1494,19878,19879,19880,19882,19885,19883,
        19884,19801,3034,1510,14294,14295,27022,58431,58434,2974
}
multiClassUtils.allSpells["Rogue"] =
{
        8676,8724,8725,11267,11268,11269,27441,48689,48690,48691,53,2589,2590,2591,8721,11279,11280,
        11281,25300,26863,48656,48657,2094,1833,31224,26679,48673,48674,2836,1842,51722,1725,32645,
        32684,57992,57993,5277,26669,6760,6761,6762,8623,8624,11299,11300,31016,26865,48667,48668,
        8647,51723,1966,6768,8637,11303,25302,27448,48658,48659,703,8631,8632,8633,11289,11290,
        26839,26884,48675,48676,1776,1766,408,8643,1804,921,1943,8639,8640,11273,11274,11275,26867,
        48671,48672,1860,6770,2070,11297,51724,5938,1757,1758,1759,1760,8621,11293,11294,26861,
        26862,48637,48638,5171,6774,2983,8696,11305,1787,57934,1856,1857,26889
}
multiClassUtils.allSpells["Priest"] =
{
        552,32546,48119,48120,528,2944,19276,19277,19278,19279,19280,25467,48299,48300,527,988,
        64843,14752,14818,14819,27841,25312,48073,586,6346,2061,9472,9473,9474,10915,10916,10917,
        25233,25235,48070,48071,2060,10963,10964,10965,25314,25210,25213,48062,48063,2054,2055,
        6063,6064,14914,15262,15263,15264,15265,15266,15267,15261,25384,48134,48135,15237,15430,
        15431,27799,27800,27801,25331,48077,48078,64901,588,7128,602,1006,10951,10952,25431,48040,
        48168,2052,2053,1706,8129,32375,8092,8102,8103,8104,8105,8106,10945,10946,10947,25372,25375,
        48126,48127,605,48045,53023,453,2096,10909,1243,1244,1245,2791,10937,10938,25389,48161,17,
        592,600,3747,6065,6066,10898,10899,10900,10901,25217,25218,48065,48066,21562,21564,25392,
        48162,596,996,10960,10961,25316,25308,48072,33076,48112,48113,27683,39374,48170,27681,32999,
        48074,8122,8124,10888,10890,139,6074,6075,6076,6077,6078,10927,10928,10929,25315,25221,
        25222,48067,48068,2006,2010,10880,10881,20770,25435,48171,9484,9485,10955,976,10957,10958,
        25433,48169,32379,32996,48157,48158,589,594,970,992,2767,10892,10893,10894,25367,25368,
        48124,48125,34433,591,598,984,1004,6060,10933,10934,25363,25364,48122,48123
}
multiClassUtils.allSpells["Death Knight"] =
{
        48778,48707,42650,48721,49939,49940,49941,49926,49927,49928,49929,49930,45529,45524,56222,
        43265,49963,49937,49938,49892,49893,62903,62904,50977,48743,49998,49999,45463,49923,49924,
        43265,49936,49937,49938,47568,48263,57330,57623,48792,49896,49903,49904,49909,47528,49020,
        51423,51424,51425,3714,50842,49917,49918,49919,49920,49221,61999,46584,56815,53428,47476,
        48265
}
multiClassUtils.allSpells["Shaman"] =
{
        2008,20609,20610,20776,20777,25590,49277,556,66843,66842,66844,1064,10622,10623,25422,
        25423,55458,55459,421,930,2860,10605,25439,25442,49270,49271,8170,526,2062,8042,8044,8045,8046,
        10412,10413,10414,25454,49230,49231,2484,51730,51988,51991,51992,51993,51994,6196,2894,
        1535,8498,8499,11314,11315,25546,25547,61649,61657,8184,10537,10538,25563,58737,58739,8050,8052,
        8053,10447,10448,29228,25457,49232,49233,8227,8249,10526,16387,25557,58649,58652,58656,
        8024,8027,8030,16339,16341,16342,25489,58785,58789,58790,8181,10478,10479,25560,58741,58745,
        8056,8058,10472,10473,25464,49235,49236,8033,8038,10456,16355,16356,25500,58794,58795,58796,
        2645,8177,5394,6375,6377,10462,10463,25567,58755,58756,58757,332,547,913,939,959,8005,10395,
        10396,25357,25391,25396,49272,49273,51514,51505,60043,8004,8008,8010,10466,10467,10468,25420,
        49275,49276,529,548,915,943,6041,10391,10392,15207,15208,25448,25449,49237,49238,324,325,
        905,945,8134,10431,10432,25469,25472,49280,49281,8190,10585,10586,10587,25552,58731,58734,5675,
        10495,10496,10497,25570,58771,58773,58774,10595,10600,10601,25574,58746,58749,370,8012,
        20608,8017,8018,8019,10399,3599,6363,6364,6365,10437,10438,25533,58699,58703,58704,6495,
        5730,6390,6391,6392,10427,10428,25525,58580,58581,58582,8071,8154,8155,10406,10407,10408,
        25508,25509,58751,58753,8075,8160,8161,10442,25361,25528,57622,58643,36936,8143,131,52127,
        52129,52131,52134,52136,52138,24398,33736,57960,546,57994,8512,8232,8235,10486,16362,25505,
        58801,58803,58804
}
multiClassUtils.allSpells["Mage"] =
{
        1008,8455,10169,10170,27130,33946,43017,30451,42894,42896,42897,23028,27127,43002,1449,8437,
        8438,8439,10201,10202,27080,27082,42920,42921,1459,1460,1461,10156,10157,27126,42995,5143,
        5144,5145,8416,8417,10211,10212,25345,27075,38699,38704,42842,42846,1953,10,6141,8427,10185,
        10186,10187,27085,42939,42940,120,8492,10159,10160,10161,27087,42930,42931,587,597,990,6129,
        10144,10145,28612,33717,759,3552,10053,10054,27101,42985,42955,42956,5504,5505,5506,6127,
        10138,10139,10140,37420,27090,2139,61316,61024,604,8450,8451,10173,10174,33944,43015,12051,
        2136,2137,2138,8412,8413,10197,10199,27078,27079,42872,42873,543,8457,8458,10223,10225,
        27128,43010,143,145,3140,8400,8401,8402,10148,10149,10150,10151,25306,27070,38692,42832,
        42833,2120,2121,8422,8423,10215,10216,27086,42925,42926,7300,7301,122,865,6131,10230,27088,
        42917,6143,8461,8462,10177,28609,32796,43012,116,205,837,7322,8406,8407,8408,10179,10180,
        10181,25304,27071,27072,38697,42841,42842,44614,47610,7302,7320,10219,10220,27124,43008,
        45438,30455,42913,42914,66,6117,22782,22783,27125,43023,43024,1463,8494,8495,10191,10192,
        10193,27131,43019,43020,55342,30482,43045,43046,118,12824,12825,12826,61305,28272,61721,
        61780,28271,53142,475,43987,58659,2948,8444,8445,8446,10205,10206,10207,27073,27074,42858,
        42859,130,30449,53140
}
multiClassUtils.allSpells["Warlock"] =
{
        6366,17951,17952,17953,27250,60219,60220,693,20752,20755,20756,20757,27238,47884,2362,17727,
        17728,28172,47886,47888,710,18647,172,6222,6223,7648,11671,11672,25311,27216,47812,47813,
        6201,6202,5699,11729,11730,27230,47871,47878,980,1014,6217,11711,11712,11713,27218,47863,
        47864,603,30910,47867,1714,11719,702,1108,6205,7646,11707,11708,27224,30909,50511,1490,
        11721,11722,27228,47865,6789,17925,17926,27223,47859,47860,706,1086,11733,11734,11735,27260,
        47793,47889,687,696,48018,48020,132,689,699,709,7651,11699,11700,27219,27220,47857,5138,1120,
        8288,8289,11675,27217,47855,23161,1098,11725,11726,61191,126,5782,6213,6215,28176,28189,
        47892,47893,5784,755,3698,3699,3700,11693,11694,11695,27259,47856,1949,11683,11684,27213,
        47823,5484,17928,348,707,1094,2941,11665,11667,11668,25309,27215,47810,47811,29722,32231,
        47837,47838,1454,1455,1456,11687,11688,11689,27222,57946,5740,6219,11677,11678,27212,47819,
        47820,18540,29893,58887,698,5676,17919,17920,17921,17922,17923,27210,30459,47814,47815,
        27243,47835,47836,5500,695,705,1088,1106,7641,11659,11660,11661,25307,27209,47808,47809,
        6229,11739,11740,28610,47890,47891,47897,61290,6353,17924,27211,30545,47824,47825,29858,691,
        688,712,697,5697
}
multiClassUtils.allSpells["Druid"] =
{
        2893,1066,22812,5211,6798,8983,768,5209,1082,3029,5201,9849,9850,27000,48569,48570,8998,9000,
        9892,31709,27004,48575,8946,33786,1850,9821,33357,99,1735,9490,9747,9898,26998,48559,48560,
        9634,5229,339,1062,5195,5196,9852,9853,26989,53308,770,16857,20719,16979,49376,22568,22827,
        22828,22829,31018,24248,48576,48577,33943,22842,21849,21850,26991,48470,6795,5186,5187,5188,
        5189,6778,8903,9758,9888,9889,25297,26978,26979,48377,48378,2637,18657,18658,16914,17401,
        17402,27012,48467,29166,33745,48567,48568,33763,48450,48451,22570,49802,33878,33986,33987,
        48563,48564,33876,33982,33983,48565,48566,1126,5232,6756,5234,8907,9884,9885,26990,48469,
        6807,6808,6809,8972,9745,9880,9881,26996,48479,48480,8921,8924,8925,8926,8927,8928,8929,9833,
        9834,9835,26987,26988,48462,48463,16689,16810,16811,16812,16813,17329,27009,53312,50464,
        9005,9823,9827,27006,49803,5215,6783,9913,1822,1823,1824,9904,27003,48573,48574,6785,6787,
        9866,9867,27005,48578,48579,20484,20739,20742,20747,20748,26994,48477,8936,8938,8939,8940,
        8941,9750,9856,9857,9858,26980,48442,48443,774,1058,1430,2090,2091,3627,8910,9839,9840,9841,
        25299,26981,26982,48440,48441,2782,50769,50768,50767,50766,50765,50764,50763,1079,9492,9493,
        9752,9894,9896,27008,49799,49800,62600,52610,5221,6800,8992,9829,9830,27001,27002,48571,
        48572,2908,8955,9901,26995,2912,8949,8950,8951,9875,9876,25298,26986,48464,48465,40120,779,
        780,769,9754,9908,26997,48561,48562,62078,18960,467,782,1075,8914,9756,9910,26992,53307,5217,
        6793,9845,9846,50212,50213,5225,740,8918,9862,9863,26983,48446,48447,783,5177,5178,5179,5180,
        6780,8905,9912,26984,26985,48459,48461
}
 
--ENUM for type: 'Armor','Weapons','Gems','Enchantments','Glyphs','Misc','Custom'
function multiClassUtils.OnTalk(unit,event,player)
        local class = player:GetPlayerClass()
        unit:GossipCreateMenu(1, player,0)
        if(multiClassUtils.npcIsVendor) then
                unit:GossipMenuAddItem(0,"Buy class armor",11,0)
                unit:GossipMenuAddItem(0,"Buy class weapons",12,0)
                unit:GossipMenuAddItem(0,"Buy class glyphs",13,0)
                unit:GossipMenuAddItem(0,"Buy class enchantments",14,0)
                unit:GossipMenuAddItem(0,"Buy class gems",15,0)
                unit:GossipMenuAddItem(0,"Buy class misc. items",16,0)
                unit:GossipMenuAddItem(0,"Buy class custom items",17,0)
        end
        unit:GossipMenuAddItem(5,"Learn all weapon skills",1,0)
        unit:GossipMenuAddItem(5,"Learn riding skills",2,0)
        unit:GossipMenuAddItem(5,"Reset Talents",3,0)
        unit:GossipSendMenu(player)
end
 
function multiClassUtils.findPlayersClassBitfield(class)
        if(class == "Warrior") then
                return  multiClassUtils.warrior
        elseif(class == "Paladin") then
                return  multiClassUtils.paladin
        elseif(class == "Hunter") then
                return  multiClassUtils.hunter
        elseif(class == "Rogue") then
                return  multiClassUtils.rogue
        elseif(class == "Death Knight") then
                return  multiClassUtils.deathKnight
        elseif(class == "Priest") then
                return  multiClassUtils.priest
        elseif(class == "Druid") then
                return  multiClassUtils.druid
        elseif(class == "Mage") then
                return  multiClassUtils.mage
        elseif(class == "Warlock") then
                return  multiClassUtils.warlock
        elseif(class == "Shaman") then
                return  multiClassUtils.shaman
        end
        return 0
end
       
function multiClassUtils.vendorSQLs(unit,player,itemType)
        unit:VendorRemoveAllItems()
        local qres = WorldDBQuery("SELECT * FROM "..multiClassUtils.TABLE_NAME.." WHERE type = '"..itemType.."'",0)
        local i=0
        if(qres ~= nil) then
                while(i<qres:GetRowCount()) do
                        if(qres:GetColumn(4):GetLong()>-1) then
                                if(player:HasItem(qres:GetColumn(4):GetLong())) then
                                        if(bit_and(qres:GetColumn(2):GetUShort(),multiClassUtils.findPlayersClassBitfield(player:GetPlayerClass()))) then
                                                unit:VendorAddItem(qres:GetColumn(0):GetULong(),1,qres:GetColumn(1):GetUShort())
                                        end
                                end
                        else   
                                if(bit_and(qres:GetColumn(2):GetUShort(),multiClassUtils.findPlayersClassBitfield(player:GetPlayerClass()))) then
                                        unit:VendorAddItem(qres:GetColumn(0):GetULong(),1,qres:GetColumn(1):GetUShort())
                                end
                        end
                        qres:NextRow()
                        i=i+1
                end
                player:SendVendorWindow(unit)
        else
                unit:SendChatMessage(13, 0, "There are no items available for you to buy under this submenu. Please try again later. Thank You")
        end    
end
 
function multiClassUtils.Submenus(unit, event, player, id, intID, code)
       
        if(intID == 1) then
                player:AdvanceSkill (43, 399)
                player:AdvanceSkill (44, 399)
                player:AdvanceSkill (45, 399)
                player:AdvanceSkill (46, 399)
                player:AdvanceSkill (54, 399)
                player:AdvanceSkill (55, 399)
                player:AdvanceSkill (95, 399)
                player:AdvanceSkill (136, 399)
                player:AdvanceSkill (160, 399)
                player:AdvanceSkill (162, 399)
                player:AdvanceSkill (172, 399)
                player:AdvanceSkill (173, 399)
                player:AdvanceSkill (176, 399)
                player:AdvanceSkill (226, 399)
                player:AdvanceSkill (228, 399)
                player:AdvanceSkill (229, 399)
                player:AdvanceSkill (473, 399)
                unit:SendChatMessage(13, 0, "You should relog to benefit from the new skills you have just learned.")
        elseif(intID == 2) then
                player:LearnSpell(33388) -- Apprentice Riding
                player:LearnSpell(33391) -- Journeyman Riding
                player:LearnSpell(34090) -- Expert Riding
                player:LearnSpell(34091) -- Artisan Riding
                player:LearnSpell(54197) -- Cold Weather Fying
                unit:SendChatMessage(13, 0, "You should relog to benefit from the new skills you have just learned.")
                player:GossipComplete()
        elseif(intID == 3) then -- Reset talents
                player:ResetTalents()
                player:GossipComplete()
        elseif(intID == 10) then -- All class Spells (and in so few lines :P)
                local class = player:GetPlayerClass()
                player:LearnSpells(multiClassUtils.allSpells[""..class..""])
                if(class == "Paladin") then
                        if race == 10 then
                                player:LearnSpell(34767) -- Summon Charger Horde
                                player:LearnSpell(34769) -- Summon Warhorse Horde
                                player:LearnSpell(2825) -- Seal of Corruption
                        elseif(race == 1 or race == 3 or race == 11)then
                                player:LearnSpell(23214) -- Summon Charger Alliance
                                player:LearnSpell(32182) -- Seal of Vengeance
                                player:LearnSpell(13819) -- Summon Warhorse Alliance
                        end
                elseif(class == "Shaman") then
                        if race == 2 or race == 6 or race == 8 then
                                player:LearnSpell(2825) -- Bloodlust
                        elseif(race == 11)then
                                player:LearnSpell(32182) -- Heroism
                        end
                elseif(class == "Mage") then
                        if race == 1 or race == 3 or race == 4 or race == 7 or race == 11 then
                                player:LearnSpell(11419) -- Portal: Darnassus
                                player:LearnSpell(32266) -- Portal: Exodar
                                player:LearnSpell(11416) -- Portal: Ironforge
                                player:LearnSpell(33691) -- Portal: Shattrath
                                player:LearnSpell(11059) -- Portal: Stormwind
                                player:LearnSpell(49360) -- Portal: Theramore
                                player:LearnSpell(3565) -- Teleport: Darnassus
                                player:LearnSpell(32271) -- Teleport: Exodar
                                player:LearnSpell(3562) -- Teleport: Ironforge
                                player:LearnSpell(33690) -- Teleport: Shattrath
                                player:LearnSpell(3561) -- Teleport: Stormwind
                                player:LearnSpell(49359) -- Teleport: Theramore
                        elseif(race == 2 or race == 5 or race == 6 or race == 8 or race == 10) then
                                player:LearnSpell(11417) -- Portal: Orgrimmar
                                player:LearnSpell(35717) -- Portal: Shattrath
                                player:LearnSpell(32267) -- Portal: Silvermoon
                                player:LearnSpell(49361) -- Portal: Stonard
                                player:LearnSpell(11420) -- Portal: Thunder Bluff
                                player:LearnSpell(11418) -- Portal: Undercity
                                player:LearnSpell(3567) -- Teleport: Orgrimmar
                                player:LearnSpell(35715) -- Teleport: Shattrath
                                player:LearnSpell(32272) -- Teleport: Silvermoon
                                player:LearnSpell(49358) -- Teleport: Stonard
                                player:LearnSpell(3566) -- Teleport: Thunder Bluff
                                player:LearnSpell(3563) -- Teleport: Undercity
                        end
                end
                unit:SendChatMessage(13,0,"You have learnt all your spells. I recommend you relog.")
                player:GossipComplete()
        elseif(intID == 11) then
                multiClassUtils.vendorSQLs(unit,player,"Armor")
        elseif(intID == 12) then
                multiClassUtils.vendorSQLs(unit,player,"Weapons")
        elseif(intID == 13) then
                multiClassUtils.vendorSQLs(unit,player,"Glyphs")
        elseif(intID == 14) then
                multiClassUtils.vendorSQLs(unit,player,"Enchantments")
        elseif(intID == 15) then
                multiClassUtils.vendorSQLs(unit,player,"Gems")
        elseif(intID == 16) then
                multiClassUtils.vendorSQLs(unit,player,"Misc")
        elseif(intID == 17) then
                multiClassUtils.vendorSQLs(unit,player,"Custom")
        elseif (intid == 18) then -- thanks to ZxOxZ for the following talents spells, even though I have changed it around a lot.
                if player:HasSpell(12294) then
                        player:LearnSpell(21551)
                        player:LearnSpell(21552)
                        player:LearnSpell(21553)
                        player:LearnSpell(25248)
                        player:LearnSpell(30330)
                        player:LearnSpell(47485)
                        player:LearnSpell(47486)
                elseif player:HasSpell(20243) then
                        player:LearnSpell(30016)
                        player:LearnSpell(30022)
                        player:LearnSpell(47497)
                        player:LearnSpell(47498)
                elseif player:HasSpell(31935) then
                        player:LearnSpell(32699)
                        player:LearnSpell(32700)
                        player:LearnSpell(48826)
                        player:LearnSpell(48827)
                elseif player:HasSpell(20925) then
                        player:LearnSpell(20927)
                        player:LearnSpell(20928)
                        player:LearnSpell(27179)
                        player:LearnSpell(48951)
                        player:LearnSpell(48952)
                elseif player:HasSpell(20473) then
                        player:LearnSpell(20929)
                        player:LearnSpell(20930)
                        player:LearnSpell(27174)
                        player:LearnSpell(33072)
                        player:LearnSpell(48824)
                        player:LearnSpell(48825)
                elseif player:HasSpell(19434) then
                        player:LearnSpell(20900)
                        player:LearnSpell(20901)
                        player:LearnSpell(20902)
                        player:LearnSpell(20903)
                        player:LearnSpell(20904)
                        player:LearnSpell(27065)
                        player:LearnSpell(49049)
                        player:LearnSpell(49050)
                elseif player:HasSpell(19306) then
                        player:LearnSpell(20909)
                        player:LearnSpell(20910)
                        player:LearnSpell(27067)
                        player:LearnSpell(48998)
                        player:LearnSpell(48999)
                elseif player:HasSpell(53301) then
                        player:LearnSpell(60051)
                        player:LearnSpell(60052)
                        player:LearnSpell(60053)
                elseif player:HasSpell(19386) then
                        player:LearnSpell(24132)
                        player:LearnSpell(24133)
                        player:LearnSpell(27068)
                        player:LearnSpell(49011)
                        player:LearnSpell(49012)
                elseif player:HasSpell(16511) then
                        player:LearnSpell(17347)
                        player:LearnSpell(17348)
                        player:LearnSpell(26864)
                        player:LearnSpell(48660)
                elseif player:HasSpell(1329) then
                        player:LearnSpell(34411)
                        player:LearnSpell(34412)
                        player:LearnSpell(34413)
                        player:LearnSpell(48663)
                        player:LearnSpell(48666)
                elseif player:HasSpell(34861) then
                        player:LearnSpell(34863)
                        player:LearnSpell(34864)
                        player:LearnSpell(34865)
                        player:LearnSpell(34866)
                        player:LearnSpell(48088)
                        player:LearnSpell(48089)
                elseif player:HasSpell(19236) then
                        player:LearnSpell(19238)
                        player:LearnSpell(19240)
                        player:LearnSpell(19241)
                        player:LearnSpell(19242)
                        player:LearnSpell(19243)
                        player:LearnSpell(25437)
                        player:LearnSpell(48172)
                        player:LearnSpell(48173)
                elseif player:HasSpell(724) then
                        player:LearnSpell(27870)
                        player:LearnSpell(27871)
                        player:LearnSpell(28275)
                        player:LearnSpell(48086)
                        player:LearnSpell(48087)
                elseif player:HasSpell(15407) then
                        player:LearnSpell(17311)
                        player:LearnSpell(17312)
                        player:LearnSpell(17313)
                        player:LearnSpell(17314)
                        player:LearnSpell(18807)
                        player:LearnSpell(25387)
                        player:LearnSpell(48155)
                        player:LearnSpell(48156)
                elseif player:HasSpell(47540) then
                        player:LearnSpell(53005)
                        player:LearnSpell(53006)
                        player:LearnSpell(53007)
                elseif player:HasSpell(34914) then
                        player:LearnSpell(34916)
                        player:LearnSpell(34917)
                        player:LearnSpell(48159)
                        player:LearnSpell(48160)
                elseif player:HasSpell(49158) then
                        player:LearnSpell(51325)
                        player:LearnSpell(51326)
                        player:LearnSpell(51327)
                        player:LearnSpell(51328)
                elseif player:HasSpell(49143) then
                        player:LearnSpell(51416)
                        player:LearnSpell(51417)
                        player:LearnSpell(51418)
                        player:LearnSpell(51419)
                        player:LearnSpell(55268)
                elseif player:HasSpell(55050) then
                        player:LearnSpell(55258)
                        player:LearnSpell(55259)
                        player:LearnSpell(55260)
                        player:LearnSpell(55261)
                        player:LearnSpell(55262)
                elseif player:HasSpell(49184) then
                        player:LearnSpell(51409)
                        player:LearnSpell(51410)
                        player:LearnSpell(51411)
                elseif player:HasSpell(55090) then
                        player:LearnSpell(55265)
                        player:LearnSpell(55270)
                        player:LearnSpell(55271)
                elseif player:HasSpell(974) then
                        player:LearnSpell(32593)
                        player:LearnSpell(32594)
                        player:LearnSpell(49283)
                        player:LearnSpell(49284)
                elseif player:HasSpell(61295) then
                        player:LearnSpell(61299)
                        player:LearnSpell(61300)
                        player:LearnSpell(61301)
                elseif player:HasSpell(51490) then
                        player:LearnSpell(59156)
                        player:LearnSpell(59158)
                        player:LearnSpell(59159)
                elseif player:HasSpell(30706) then
                        player:LearnSpell(57720)
                        player:LearnSpell(57721)
                        player:LearnSpell(57722)
                elseif player:HasSpell(44425) then
                        player:LearnSpell(44780)
                        player:LearnSpell(44781)
                elseif player:HasSpell(11113) then
                        player:LearnSpell(13018)
                        player:LearnSpell(13019)
                        player:LearnSpell(13020)
                        player:LearnSpell(13021)
                        player:LearnSpell(27133)
                        player:LearnSpell(33933)
                        player:LearnSpell(42944)
                        player:LearnSpell(42945)
                elseif player:HasSpell(31611) then
                        player:LearnSpell(33041)
                        player:LearnSpell(33042)
                        player:LearnSpell(33043)
                        player:LearnSpell(42949)
                        player:LearnSpell(42950)
                elseif player:HasSpell(11426) then
                        player:LearnSpell(13031)
                        player:LearnSpell(13032)
                        player:LearnSpell(13033)
                        player:LearnSpell(27134)
                        player:LearnSpell(33405)
                        player:LearnSpell(43038)
                        player:LearnSpell(43039)
                elseif player:HasSpell(44457) then
                        player:LearnSpell(55359)
                        player:LearnSpell(55360)
                elseif player:HasSpell(11366) then
                        player:LearnSpell(12505)
                        player:LearnSpell(12522)
                        player:LearnSpell(12523)
                        player:LearnSpell(12524)
                        player:LearnSpell(12525)
                        player:LearnSpell(12526)
                        player:LearnSpell(18809)
                        player:LearnSpell(27132)
                        player:LearnSpell(33938)
                        player:LearnSpell(42890)
                        player:LearnSpell(42891)
                elseif player:HasSpell(50796) then
                        player:LearnSpell(59170)
                        player:LearnSpell(59171)
                        player:LearnSpell(59172)
                elseif player:HasSpell(18220) then
                        player:LearnSpell(18937)
                        player:LearnSpell(18938)
                        player:LearnSpell(27265)
                        player:LearnSpell(59092)
                elseif player:HasSpell(48181) then
                        player:LearnSpell(59161)
                        player:LearnSpell(59163)
                        player:LearnSpell(59164)
                elseif player:HasSpell(17877) then
                        player:LearnSpell(18867)
                        player:LearnSpell(18868)
                        player:LearnSpell(18869)
                        player:LearnSpell(18870)
                        player:LearnSpell(18871)
                        player:LearnSpell(27263)
                        player:LearnSpell(30546)
                        player:LearnSpell(47826)
                        player:LearnSpell(27827)
                elseif player:HasSpell(30283) then
                        player:LearnSpell(30413)
                        player:LearnSpell(30414)
                        player:LearnSpell(47846)
                        player:LearnSpell(47847)
                elseif player:HasSpell(30108) then
                        player:LearnSpell(30404)
                        player:LearnSpell(30405)
                        player:LearnSpell(47841)
                        player:LearnSpell(47843)
                elseif player:HasSpell(5570) then
                        player:LearnSpell(24974)
                        player:LearnSpell(24975)
                        player:LearnSpell(24976)
                        player:LearnSpell(24977)
                        player:LearnSpell(27013)
                        player:LearnSpell(48468)
                elseif player:HasSpell(33878) then
                        player:LearnSpell(33986)
                        player:LearnSpell(33987)
                        player:LearnSpell(48563)
                        player:LearnSpell(48564)
                elseif player:HasSpell(33876) then
                        player:LearnSpell(33982)
                        player:LearnSpell(33983)
                        player:LearnSpell(48565)
                        player:LearnSpell(48566)
                elseif player:HasSpell(48505) then
                        player:LearnSpell(53199)
                        player:LearnSpell(53200)
                        player:LearnSpell(53201)
                elseif player:HasSpell(50516) then
                        player:LearnSpell(53223)
                        player:LearnSpell(53225)
                        player:LearnSpell(53226)
                        player:LearnSpell(61384)
                elseif player:HasSpell(48438) then
                        player:LearnSpell(53248)
                        player:LearnSpell(53249)
                        player:LearnSpell(53251)
                else
                        unit:SendChatMessage(13,0, "You haven't talented your character, or your talents don't require new spells.")
                end
                unit:SendChatMessage(13,0,"You have learnt all your talent spells. I recommend you relog.")
                player:GossipComplete()
        end
end
 
RegisterUnitGossipEvent(multiClassUtils.npcEntryID,1,"multiClassUtils.OnTalk")
RegisterUnitGossipEvent(multiClassUtils.npcEntryID,2,"multiClassUtils.Submenus")