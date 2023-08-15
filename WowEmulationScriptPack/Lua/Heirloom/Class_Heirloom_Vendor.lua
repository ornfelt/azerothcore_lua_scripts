local npcid = 100029

local COGGO = false --can only get gear once
local OGMCU = false --Only GM can use

local LOOMSQL = [[ CREATE TABLE IF NOT EXISTS world.heirloom_list ( CharID int(10) unsigned );]]
WorldDBExecute(LOOMSQL)

local LOOMSQL2 = [[ INSERT IGNORE world.creature_template (entry,difficulty_entry_1,difficulty_entry_2,difficulty_entry_3,KillCredit1,KillCredit2,modelid1,modelid2,modelid3,modelid4,name,subname,IconName,gossip_menu_id,minlevel,maxlevel,`exp`,faction,npcflag,speed_walk,speed_run,`scale`,`rank`,dmgschool,BaseAttackTime,RangeAttackTime,BaseVariance,RangeVariance,unit_class,unit_flags,unit_flags2,dynamicflags,family,`type`,type_flags,lootid,pickpocketloot,skinloot,PetSpellDataId,VehicleId,mingold,maxgold,AIName,MovementType,HoverHeight,HealthModifier,ManaModifier,ArmorModifier,DamageModifier,ExperienceModifier,RacialLeader,movementId,RegenHealth,mechanic_immune_mask,spell_school_immune_mask,flags_extra,ScriptName,VerifiedBuild) VALUES 	(100029,0,0,0,0,0,19646,0,0,0,'Armstrong','Heirloom items',NULL,0,80,80,2,35,129,1.0,1.14286,1.0,0,0,2000,0,1.0,1.0,1,0,0,0,0,7,138936390,0,0,0,0,0,0,0,'',0,1.0,1.0,1.0,1.0,1.0,1.0,0,0,1,0,0,66,'',0);]]
WorldDBExecute(LOOMSQL2)

local T = {
--  [classId] = {item1, item2, item3m, ...},
	[0] = {},
    [1] = {42943, 48718, 42991, 42991, 48716, 42949, 48685, 50255, 6948, 50250}, -- Warrior
    [2] = {44100, 48685, 44092, 42992, 42992, 50255, 48716, 6948, 50250}, -- Paladin
    [3] = {42946, 50255, 48677, 42991, 42991, 42950, 42944, 6948, 50250}, -- Hunter
    [4] = {42944, 48689, 42952, 42991, 42991, 50255, 6948, 50250}, -- Rogue
    [5] = {42947, 48691, 44107, 42992, 42992, 50255, 6948, 50250}, -- Priest
    [6] = {42943, 48685, 42949, 42991, 42991, 50255, 50250}, -- Death Knight
    [7] = {48716, 48716, 42992, 42992, 48677, 42950, 42951, 48683, 50255, 6948, 50250}, -- Shaman
    [8] = {42947, 48691, 44107, 42992, 42992, 50255, 6948, 50250}, -- Mage
    [9] = {42947, 48691, 44107, 42992, 42992, 50255, 6948, 50250}, -- Warlock
    [11] = {42947, 48718, 42952, 42991, 42991, 44107, 48691, 48689, 50255, 6948, 50250}, -- Druid

};

local function OnLoad()
if not COGGO then
WorldDBExecute("TRUNCATE TABLE world.heirloom_list")
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

local query = WorldDBQuery(string.format("SELECT * FROM world.heirloom_list WHERE CharID=%i", getPlayerCharacterGUID(player)))

local mingmrank = 3
  
    if (OGMCU and player:GetGMRank() < mingmrank) then
  player:GossipMenuAddItem(0, "Only GM Rank 3 can access this NPC.", 0, 0)
  
  else

local hunterbot =  math.random(70101, 70139)



if query then
player:GossipMenuAddItem(0, "You have already claimed your Free gear and bags.", 0, 0)
else
	if (class == 1) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Sword_27.png:20|t Gear PVE - Warrior", 0, 1)
	end
	if (class == 2) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Holy_DivineIntervention.png:20|t Gear PVE - Paladin", 0, 2)
	end
	if (class == 3) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Weapon_Bow_07.png:20|t Gear PVE - Hunter", 0, 3)

	end
	if (class == 4) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_ThrowingKnife_04.png:20|t Gear PVE - Rogue", 0, 4)
	end
	if (class == 5) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Staff_30.png:20|t Gear PVE - Priest", 0, 5)
	end
	if (class == 6) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Deathknight_ClassIcon.png:20|t Gear PVE - Death Knight", 0, 6)
	end
	if (class == 7) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Nature_BloodLust.png:20|t Gear PVE - Shaman", 0, 7)
	end
	if (class == 8) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Staff_13.png:20|t Gear PVE - Mage", 0, 8)
	end
	if (class == 9) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/Spell_Nature_Drowsy.png:20|t Gear PVE - Warlock", 0, 9)
	end
	if (class == 11) then
	player:GossipMenuAddItem(0, "|TInterface/ICONS/INV_Misc_MonsterClaw_04.png:20|t Gear PVE - Druid", 0, 11)
	end
	if class == 10 or class == 3 or class == 11 or class == 6 or class == 2 or class == 1 and not player:HasSkill(229) then
	player:SetSkill( 229, 1, 5, 5 )
	end
	end
end
	player:GossipSendMenu(1, creature)
	
	
end



local function OnGossipSelect(event, player, creature, sender, intid, code)
local class = player:GetClass()
local query = WorldDBQuery(string.format("SELECT * FROM world.heirloom_list WHERE CharID=%i", getPlayerCharacterGUID(player)))

	local bag1 = player:GetItemByPos(255, 19)
	local bag2 = player:GetItemByPos(255, 20)
	local bag3 = player:GetItemByPos(255, 21)
	local bag4 = player:GetItemByPos(255, 22)
	

    if (intid == class and not query) then
	
	
	for s = 0, 18 do
                local item = player:GetItemByPos(255, s)
				
				if item then

					player:RemoveItem(item, s);

					
				end
				end
	
	
	if bag1 ~= nil and bag1:GetName() ~= "Glacial Bag" then
		player:RemoveItem(bag1, 1);
		player:EquipItem( 41600, 19 )
	end
	
	if bag2 ~= nil and bag2:GetName() ~= "Glacial Bag" then
		player:RemoveItem(bag2, 1);
		player:EquipItem( 41600, 20 )
	end
	
	if bag3 ~= nil and bag3:GetName() ~= "Glacial Bag" then
		player:RemoveItem(bag3, 1);
		player:EquipItem( 41600, 21 )
	end
	
	if bag4 ~= nil and bag4:GetName() ~= "Glacial Bag" then
		player:RemoveItem(bag4, 1);
		player:EquipItem( 41600, 22 )
	end
	
	
	
	
        for _,v in ipairs(T[class]) do
            --player:AddItem(v, 1)

			
			for s = 0, 18 do
			
					player:EquipItem(v, s)
			end
			
			
			--player:SendBroadcastMessage(tostring(v))
           
		
			
        end
	if COGGO and not query then
		WorldDBExecute(string.format("INSERT INTO world.heirloom_list VALUES (%i)", getPlayerCharacterGUID(player)))
	end
	
	
	
	
	
	
	
	
	player:LearnSpell(34091)
	player:LearnSpell(73324)
	if (class == 3) then
	player:LearnSpell(5300)
	player:LearnSpell(1579)
	end
    end
	
	
	 player:GossipComplete()
end


RegisterServerEvent(33, OnLoad)
RegisterCreatureGossipEvent(npcid, 1, OnGossipHello)
RegisterCreatureGossipEvent(npcid, 2, OnGossipSelect)