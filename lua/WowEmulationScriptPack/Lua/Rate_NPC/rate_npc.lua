local npcid = 100031
local cost = 10


local XPSQL = [[ CREATE TABLE IF NOT EXISTS Custom_XP ( CharID int(10) unsigned NOT NULL, Rate float unsigned NOT NULL DEFAULT 1) ENGINE=InnoDB DEFAULT CHARSET=utf8;]]
WorldDBExecute(XPSQL)

local XPSQL2 = [[ INSERT IGNORE world.creature_template (entry,difficulty_entry_1,difficulty_entry_2,difficulty_entry_3,KillCredit1,KillCredit2,modelid1,modelid2,modelid3,modelid4,name,subname,IconName,gossip_menu_id,minlevel,maxlevel,`exp`,faction,npcflag,speed_walk,speed_run,`scale`,`rank`,dmgschool,BaseAttackTime,RangeAttackTime,BaseVariance,RangeVariance,unit_class,unit_flags,unit_flags2,dynamicflags,family,`type`,type_flags,lootid,pickpocketloot,skinloot,PetSpellDataId,VehicleId,mingold,maxgold,AIName,MovementType,HoverHeight,HealthModifier,ManaModifier,ArmorModifier,DamageModifier,ExperienceModifier,RacialLeader,movementId,RegenHealth,mechanic_immune_mask,spell_school_immune_mask,flags_extra,ScriptName,VerifiedBuild) VALUES (100031,0,0,0,0,0,18952,0,0,0,'Skuly','XP Rates',NULL,0,80,80,2,35,129,1.0,1.14286,1.0,0,0,2000,0,1.0,1.0,1,0,0,0,0,7,138936390,0,0,0,0,0,0,0,'',0,1.0,1.0,1.0,1.0,1.0,1.0,0,0,1,0,0,66,'',0);]]
WorldDBExecute(XPSQL2)


local function getPlayerCharacterGUID(player)
    query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end


local function OnGossipHello(event, player, creature)



	player:GossipMenuAddItem(0, "Set Xp Rate to 1x - Cost is 10 Gold", 0, 1)

	player:GossipMenuAddItem(0, "Set Xp Rate to 2x - Cost is 10 Gold", 0, 2)
	
	player:GossipMenuAddItem(0, "Set Xp Rate to 3x - Cost is 10 Gold", 0, 3)
	
	player:GossipMenuAddItem(0, "Set Xp Rate to 4x - Cost is 10 Gold", 0, 4)
	
	player:GossipMenuAddItem(0, "Set Xp Rate to 5x - Cost is 10 Gold", 0, 5)
	
	player:GossipMenuAddItem(0, "Set Xp Rate to 6x - Cost is 10 Gold", 0, 6)
	
	player:GossipMenuAddItem(0, "Set Xp Rate to 7x - Cost is 10 Gold", 0, 7)
	
	player:GossipMenuAddItem(0, "Set Xp Rate to 8x - Cost is 10 Gold", 0, 8)
	
	player:GossipMenuAddItem(0, "Set Xp Rate to 9x - Cost is 10 Gold", 0, 9)
	
	player:GossipMenuAddItem(0, "Set Xp Rate to 10x - Cost is 10 Gold", 0, 10)
	
	player:GossipMenuAddItem(0, "Check your curent XP Rate", 0, 11)
	
	

	player:GossipSendMenu(1, creature)
	
	
end



local function OnGossipSelect(event, player, creature, sender, intid, code)
local PUID = getPlayerCharacterGUID(player)
local Q = WorldDBQuery(string.format("SELECT * FROM world.custom_xp WHERE CharID=%i", PUID))
local money = player:GetCoinage()
local gold = 10000*cost


if intid == 1 then
if  money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 1))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 1x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end

if intid == 2 then
if  money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 2))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 2x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end

if intid == 3 then
if  money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 3))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 3x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end

if intid == 4 then
if  money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 4))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 4x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end

if intid == 5 and money > gold then
if money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 5))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 5x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end

if intid == 6 then
if money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 6))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 6x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end

if intid == 7 then
if money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 7))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 7x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end

if intid == 8 then
if money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 8))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 8x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end

if intid == 9 then
if money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 9))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 9x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end

if intid == 10 then
if money >= gold then
WorldDBExecute(string.format("DELETE FROM world.custom_xp WHERE CharID = %i", PUID))
WorldDBExecute(string.format("INSERT INTO world.custom_xp VALUES (%i, %i)", PUID, 10))
player:SendBroadcastMessage("|cff5af304You changed your XP rate to 10x|r")
player:ModifyMoney( -gold )
else
player:SendAreaTriggerMessage("You don't have enough gold!")
end
end


if intid == 11 then
if Q then
local CharID, Rate = Q:GetUInt32(0), Q:GetUInt32(1)
 player:SendBroadcastMessage(string.format("|cff5af304Your XP rate is curently set to %ix|r", Rate))
 else 
 player:SendBroadcastMessage(string.format("|cff5af304You haven't set a custom rate yet.|r"))
end

end






	 player:GossipComplete()
end


local function OnXP(event, player, amount, victim)
local PUID = getPlayerCharacterGUID(player)
local Q = WorldDBQuery(string.format("SELECT * FROM world.custom_xp WHERE CharID=%i", PUID))

if Q then
local CharID, Rate = Q:GetUInt32(0), Q:GetUInt32(1)

local givexp = amount * Rate
return givexp

end




end


RegisterCreatureGossipEvent(npcid, 1, OnGossipHello)
RegisterCreatureGossipEvent(npcid, 2, OnGossipSelect)
RegisterPlayerEvent(12, OnXP)
