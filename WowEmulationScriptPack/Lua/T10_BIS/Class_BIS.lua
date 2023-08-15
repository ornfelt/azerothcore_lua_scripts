local npcid = 100030

local COGGO = false --can only get gear once
local OGMCU = true --Only GM can use

local BISSQL = [[ CREATE TABLE IF NOT EXISTS world.bis_list ( CharID int(10) unsigned );]]
WorldDBExecute(BISSQL)

local BISSQL2 = [[INSERT IGNORE world.creature_template (entry,difficulty_entry_1,difficulty_entry_2,difficulty_entry_3,KillCredit1,KillCredit2,modelid1,modelid2,modelid3,modelid4,name,subname,IconName,gossip_menu_id,minlevel,maxlevel,`exp`,faction,npcflag,speed_walk,speed_run,`scale`,`rank`,dmgschool,BaseAttackTime,RangeAttackTime,BaseVariance,RangeVariance,unit_class,unit_flags,unit_flags2,dynamicflags,family,`type`,type_flags,lootid,pickpocketloot,skinloot,PetSpellDataId,VehicleId,mingold,maxgold,AIName,MovementType,HoverHeight,HealthModifier,ManaModifier,ArmorModifier,DamageModifier,ExperienceModifier,RacialLeader,movementId,RegenHealth,mechanic_immune_mask,spell_school_immune_mask,flags_extra,ScriptName,VerifiedBuild) VALUES (100030,0,0,0,0,0,5233,0,0,0,'Gregory Cooper','BIS Gear',NULL,0,80,80,2,35,129,1.0,1.14286,1.0,0,0,2000,0,1.0,1.0,1,0,0,0,0,7,138936390,0,0,0,0,0,0,0,'',0,1.0,1.0,1.0,1.0,1.0,1.0,0,0,1,0,0,66,'',0);]]
WorldDBExecute(BISSQL2)




local T = {
	[0] = {},
    [1] = {51225, 51226, 51227, 51228, 51229, 54581, 50677, 54578, 50620, 50657, 52572, 50363, 54590, 49623, 50733, 50670 }, -- Warrior DPS
    [2] = {51220, 51221, 51222, 51223, 51224, 50682, 50466, 51901, 50691, 54579, 50622, 50404, 54591, 50364, 50738, 50729 }, -- Warrior Tank
    [3] = {51275, 51276, 51277, 51278, 51279, 50402, 54576, 54590, 50706, 49623, 50455, 54581, 50653, 54580, 50707, 54578 }, -- Paladin DPS
    [4] = {51270, 51271, 51272, 51273, 51274, 50724, 54583, 54582, 54587, 54586, 50664, 50400, 48724, 50616, 40705, 46051, 46017 }, -- Paladin Heal
	[5] = {51265, 51266, 51267, 51268, 51269, 50682, 50466, 51901, 50991, 54579, 50622, 50404, 54591, 50738, 50729, 50461, 50364 }, -- Paladin Tank
	[6] = {51285, 51286, 51287, 51288, 51289, 50633, 50653, 50655, 50688, 54577, 54576, 50402, 50363, 54590, 50735, 50733 }, -- Hunter DPS
	[7] = {54576, 54590, 50736, 51250, 51251, 51252, 51253, 51254, 50633, 50653, 54580, 50707, 50607, 50706, 50621, 50733, 50402  }, -- Rogue DPS
	[8] = {51255, 51256, 51257, 51258, 51259, 50724, 54583, 54582, 50613, 50699, 50664, 50398, 54588, 50348, 50734, 50719, 50631 }, -- Priest DPS
	[9] = {51260, 51261, 51262, 51263, 51264, 50724, 54583, 54582, 50613, 50699, 50644, 50636, 50366, 54589, 50734, 50719, 50631 }, -- Priest Disc Heal
	[10] = {51310, 51311, 51312, 51313, 51314, 54581, 50677, 50670, 54578, 50693, 52572, 54590, 50363, 50737, 50737, 50459, 49623 }, -- Death Knight DPS
	[11] = {51305, 51306, 51307, 51308, 51309, 50682, 50466, 51901, 50991, 54579, 50622, 50404, 54591, 50364, 49623, 50462 }, -- Death Knight Tank
	[12] = {51240, 51241, 51242, 51243, 51244, 50633, 50653, 50655, 50688, 54577, 50678, 50402, 50706, 54590, 50737, 50737, 50463 }, -- Enhancment Shaman
	[13] = {51245, 51246, 51247, 51248, 51249, 50724, 54583, 50687, 54587, 50699, 50664, 50400, 50366, 54589, 46017, 50616, 50458 }, -- Restoration Shaman
	[14] = {51235, 51236, 51237, 51238, 51239, 50724, 54583, 54582, 54587, 50699, 50664, 50398, 54588, 50365, 50734, 50616, 50458 }, -- Elemental Shaman
	[15] = {51280, 51281, 51282, 51283, 51284, 50724, 54583, 54582, 50613, 50699, 50614, 50398, 54588, 50365, 50732, 50719, 50684 }, -- Mage DPS
	[16] = {51230, 51231, 51232, 51233, 51234, 50724, 54583, 54582, 50613, 50699, 50614, 50664, 54588, 50365, 50732, 50719, 50684 }, -- Warlock
	[17] = {51290, 51291, 51292, 51293, 51294, 50724, 54583, 54582, 50613, 50699, 50398, 54588, 50365, 50734, 50719, 50714, 50457 }, -- Druid Balance
	[18] = {51300, 51301, 51302, 51303, 51304, 50609, 50668, 54584, 50705, 50665, 50400, 50636, 50366, 54589, 46017, 50635, 50454 }, -- Druid Resto
	[19] = {51295, 51296, 51297, 51298, 51299, 50682, 50466, 54580, 50707, 50607, 50622, 50404, 50364, 50356, 50735, 50456 }, -- Druid Tank Feral
	[20] = {51260, 51261, 51262, 51263, 51264, 50609, 50668, 54582, 50702, 50699, 50400, 50636, 50366, 54589, 50731, 50684 }, -- Priest Holy Heal
	[21] = {51295, 51296, 51297, 51298, 51299, 50633, 50653, 50670, 50707, 50607, 50618, 50402, 50363, 54590, 50735, 50456 }, -- Druid DPS Feral

	

};

local SPELLS = {
--  [classId] = {item1, item2, item3m, ...},
	[0] = {},
    [1] = {47436, 47450, 11578, 47465, 47502, 34428, 1715, 2687, 71, 7386, 355, 72, 47437, 57823, 694, 2565, 676, 47520, 20230, 12678, 47471, 1161, 871, 2458, 20252, 47475, 18499, 1680, 6552, 47488, 1719, 23920, 47440, 3411, 64382, 55694, 57755, 674, 750, 5246, 3127, 5011, 266}, -- Warrior
    [2] = {750, 48942, 48782, 48932, 20271, 498, 1152, 10278, 48788, 53408, 48950, 48936, 62124, 54043, 48801, 48785, 5502, 20164, 10326, 1038, 53407, 48943, 20165, 48945, 642, 48947, 20166, 4987, 48806, 6940, 48817, 48934, 48938, 25898, 25899, 32223, 31884, 54428, 61411, 53601, 33388, 33391, 34769, 34767, 3127, 19746, 5588, 19752, 5589, 10308, 31789, 25780, 1044, 20217, 53736 }, -- Paladin
    [3] = {8737, 1494, 13163, 48996, 49001, 49045, 53338, 5116, 27044, 883, 2641, 6991, 982, 1515, 19883, 20736, 48990, 2974, 6197, 1002, 14327, 5118, 49056, 53339, 49048, 19884, 34074, 781, 14311, 1462, 19885, 19880, 13809, 13161, 5384, 1543, 19878, 49067, 3034, 13159, 19882, 58434, 49071, 49052, 19879, 19263, 19801, 34026, 34600, 34477, 61006, 61847, 53271, 60192, 62757, 3127, 674, 3043, 3045}, -- Hunter
    [4] = {674, 48668, 48638, 1784, 48657, 921, 1776, 26669, 51724, 6774, 11305, 1766, 48676, 48659, 1804, 8647, 48691, 51722, 48672, 1725, 26889, 2836, 1833, 1842, 8643, 2094, 1860, 57993, 48674, 31224, 5938, 57934, 51723, 3127}, -- Rogue
	[5] = {2053, 48161, 48123, 48125, 48066, 586, 48068, 48127, 48171, 48168, 10890, 6064, 988, 48300, 6346, 48071, 48135, 48078, 453, 9484, 10909, 8129, 48073, 605, 48072, 48169, 552, 1706, 48063, 48162, 48170, 48074, 48158, 48120, 34433, 48113, 32375, 64843, 64901, 53023, 9485, 10955, 528}, -- Priest
	[6] = {50842, 49941, 49930, 47476, 45529, 3714, 56222, 48743, 48263, 49909, 66188, 47528, 45524, 48792, 57623, 56815, 47568, 49895, 50977, 49576, 49921, 46584, 49938, 48707, 48265, 61999, 42650, 53428, 53331, 54447, 53342, 54446, 53323, 53344, 70164, 62158, 33391, 48778, 51425, 49924, 49924}, -- Deathknight
	[7] = {8737, 49273, 49238, 10399, 49231, 58753, 2484, 49281, 58582, 49233, 58790, 58704, 58643, 49277, 61657, 8012, 526, 2645, 57994, 8143, 49236, 58796, 58757, 49276, 57960, 131, 58745, 6196, 58734, 58774, 58739, 58656, 546, 556, 66842, 51994, 8177, 58749, 20608, 36936, 58804, 49271, 8512, 6495, 8170, 66843, 55459, 66844, 3738, 2894, 60043, 51514, 2062, 30798, 2825, 32182}, -- Shaman
	[8] = {42995, 42833, 27090, 42842, 33717, 42873, 42846, 12826, 28271, 61780, 61721, 28272, 61305, 42917, 43015, 130, 42921, 42926, 43017, 475, 1953, 42940, 12051, 43010, 43020, 43012, 42859, 2139, 42931, 42985, 43008, 45438, 43024, 43002, 43046, 42897, 42914, 66, 58659, 30449, 42956, 47610, 61316, 61024, 55342, 7301}, -- Mage
	[9] = {696, 47811, 47809, 688, 47813, 50511, 57946, 47864, 6215, 47878, 47855, 697, 47856, 47857, 5697, 47884, 47815, 47889, 47820, 698, 712, 126, 5138, 5500, 11719, 132, 60220, 18647, 61191, 47823, 691, 47865, 47891, 47888, 17928, 47860, 47825, 1122, 47867, 18540, 47893, 47838, 29858, 58887, 47836, 61290, 48018, 48020, 33388, 33391, 23161, 5784}, -- Warlock
	[11] = {5487, 783, 768, 48378, 48469, 48461, 48463, 48441, 53307, 53308, 48560, 6795, 48480, 53312, 18960, 48443, 50763, 8983, 8946, 48562, 770, 16857, 18658, 16979, 49376, 5215, 48477, 49800, 48465, 48572, 26995, 48574, 50213, 33357, 5209, 48575, 48447, 48577, 48579, 5225, 22842, 49803, 9634, 20719, 48467, 29166, 62600, 22812, 48470, 48564, 48566, 33891, 33943, 49802, 48451, 48568, 33786, 40120, 62078, 52610, 50464, 48570, 2637, 2912, 2908, 99, 5229, 1066, 1082, 5186, 8936, 20484, 2782, 2893}, -- Druid

};




local spellist = {201, 196, 264, 266, 198, 204, 227, 202, 199, 197, 203, 1180, 2567, 5011, 5009, 200, 15590};


local function OnLoad()
if not COGGO then
WorldDBExecute("TRUNCATE TABLE world.bis_list")
end
end

local function AutoLearn(player)
local intid = player:GetClass()


for _,v in ipairs(SPELLS[intid]) do
            player:LearnSpell(v)
        end
		
		if intid == 8 then
	if (player:GetTeam() < 1) then -- Alliance Portals
            player:LearnSpell(32271)
            player:LearnSpell(49359)
            player:LearnSpell(3565)
            player:LearnSpell(33690)
            player:LearnSpell(3562)
            player:LearnSpell(3561)
            player:LearnSpell(11419)
            player:LearnSpell(32266)
            player:LearnSpell(11416)
            player:LearnSpell(33691)
            player:LearnSpell(10059)
            player:LearnSpell(49360)
        else -- Horde Portals
            player:LearnSpell(3567)
            player:LearnSpell(35715)
            player:LearnSpell(3566)
            player:LearnSpell(49358)
            player:LearnSpell(32272)
            player:LearnSpell(3563)
            player:LearnSpell(11417)
            player:LearnSpell(35717)
            player:LearnSpell(32267)
            player:LearnSpell(49361)
            player:LearnSpell(11420)
            player:LearnSpell(11418)
        end	
		end
		
end


local function getPlayerCharacterGUID(player)
    query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end

local function OnGossipHello(event, player, creature)
local class = player:GetClass()


  local query = WorldDBQuery(string.format("SELECT * FROM world.bis_list WHERE CharID=%i", getPlayerCharacterGUID(player)))
  

  
  local mingmrank = 3
  
  if (OGMCU and player:GetGMRank() < mingmrank) then
  player:GossipMenuAddItem(0, "Only GM Rank 3 can access this NPC.", 0, 0)
  
  else

  
  

	if query then
	player:GossipMenuAddItem(0, "You have already claimed your T10 Gear", 0, 0)
	else
	if not query then
	if (class == 1) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Sword_27.png:20|t DPS T10", 0, 1)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Ability_Warrior_Defensivestance.png:20|t Tank T10", 0, 2)
	end
	if (class == 2) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Holy_Auraoflight.png:20|t DPS T10", 0, 3)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Holy_Flashheal.png:20|t Heal T10", 0, 4)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Ability_Warrior_Defensivestance.png:20|t Tank T10", 0, 5)
	end
	if (class == 3) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Weapon_Bow_07.png:20|t DPS T10", 0, 6)

	end
	if (class == 4) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_ThrowingKnife_04.png:20|t DPS T10", 0, 7)
	end
	if (class == 5) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Shadow_Devouringplague.png:20|t DPS T10", 0, 8)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Holy_Powerwordshield:20|t Disc Heal T10", 0, 9)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Holy_Renew.png:20|t Holy Heal T10", 0, 20)
	end
	if (class == 6) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Deathknight_Classicon.png:20|t DPS T10", 0, 10)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Ability_Warrior_Defensivestance.png:20|t Tank T10", 0, 11)
	end
	if (class == 7) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Nature_Lightningshield.png:20|t Enhancment DPS T10", 0, 12)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Nature_Healingwavegreater.png:20|t Heal T10", 0, 13)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Nature_Lightning.png:20|t Elemental DPS T10", 0, 14)
	end
	if (class == 8) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Staff_13.png:20|t DPS T10", 0, 15)
	end
	if (class == 9) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Nature_Drowsy.png:20|t DPS T10", 0, 16)
	end
	if (class == 11) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Arcane_Arcane04.png:20|t Balance T10", 0, 17)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_nature_healingtouch.png:20|t Resto T10", 0, 18)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Ability_racial_bearform.png:20|t Feral Tank T10", 0, 19)
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Ability_druid_ferociousbite.png:20|t Feral DPS T10", 0, 21)
	end
	
	
	
end


end

end
	player:GossipSendMenu(1, creature)
	
	
end




local function OnGossipSelect(event, player, creature, sender, intid, code)
local class = player:GetClass()

    
	local query = WorldDBQuery(string.format("SELECT * FROM world.bis_list WHERE CharID=%i", getPlayerCharacterGUID(player)))
	
	local bag1 = player:GetItemByPos(255, 19)
	local bag2 = player:GetItemByPos(255, 20)
	local bag3 = player:GetItemByPos(255, 21)
	local bag4 = player:GetItemByPos(255, 22)
	local mingmrank = 3
	
	if (OGMCU and player:GetGMRank() < mingmrank) then
  player:GossipMenuAddItem(0, "Only GM Rank 3 can access this NPC.", 0, 0)
  
  else
  
	if (intid ~= nil and not query) then
	
	if class == 3 or 7 then
	player:LearnSpell(8737)
	end
	
	if class == 1 or 2 then
	player:LearnSpell(750)
	end
	
	player:SetLevel( 80 )
	local level = player:GetLevel()
	if  intid == 2 then
		player:AddItem(51834)
	end
			
	if (bag1 and bag2 and bag3 and bag4) == nil then
		player:EquipItem( 41600, 19 )
		player:EquipItem( 41600, 20 )
		player:EquipItem( 41600, 21 )
		player:EquipItem( 41600, 22 )
		end
		
	if class == 10 or class == 3 or class == 11 or class == 6 or class == 2 or class == 1 and not player:HasSkill(229) then
	player:SetSkill( 229, 1, 5, 5 )
	end
	
	if class == 7 or class == 6 or class == 4 or class == 1 and not player:HasSkill(44) then
	player:SetSkill( 44, 1, 5, 5 )
	end
	
	if class == 8 or class == 9 and not player:HasSkill(43) then
	player:SetSkill( 43, 1, 5, 5 )
	end
	
	if class == 3 or class == 4 and not player:HasSkill(226) then
	player:SetSkill( 226, 1, 5, 5 )
	end
	
	if class == 1 or class == 2 and not player:HasSkill(172) then
	player:SetSkill( 172, 1, 5, 5 )
	end
	
	if (class == 3) then
	player:LearnSpell(5300)
	player:LearnSpell(1579)
	end
	
	
	
	
	
        for _,v in ipairs(T[intid]) do
			player:RemoveItem(v, 1);
            player:AddItem(v, 1)


			if COGGO then
			WorldDBExecute(string.format("INSERT INTO world.bis_list VALUES (%i)", getPlayerCharacterGUID(player)))
	end
        end
	
	AutoLearn(player)
    end
	
end
	
	local ahenbands = {50400, 50398, 50402, 50404, 52572}
	
	for k,v in pairs(ahenbands) do
	if player:HasItem(v) then
	player:SetReputation(1156, 42000)
	
	end
	end
	
	player:GossipComplete()
end






RegisterServerEvent(33, OnLoad)
RegisterCreatureGossipEvent(npcid, 1, OnGossipHello)
RegisterCreatureGossipEvent(npcid, 2, OnGossipSelect)