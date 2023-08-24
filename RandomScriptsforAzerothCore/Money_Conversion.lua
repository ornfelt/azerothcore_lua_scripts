-----------------------------------------------------------------------------------|
-----------------------------|Created by Syn|-------------------------------|
-----------------------------------------------------------------------------------|
------------------------------Discord: Synz#0643 ---------------------------------------|

local Transmute = {}

local Team =  {
				[0] = "|TInterface\\PVPFrame\\Pvp-Currency-Alliance.png:22|t",
				[1] = "|TInterface\\PVPFrame\\Pvp-Currency-Horde.png:22|t",
};

local Classes = { 
    [1] = "|TInterface\\icons\\INV_Sword_27.png:22|t",              -- Warrior
    [2] = "|TInterface\\icons\\INV_Hammer_01.png:22|t",             -- Paladin
    [3] = "|TInterface\\icons\\INV_Weapon_Bow_07.png:22|t",          -- Hunter
    [4] = "|TInterface\\icons\\INV_ThrowingKnife_04.png:22|t",        -- Rogue
    [5] = "|TInterface\\icons\\INV_Staff_30.png:22|t",               -- Priest
    [6] = "|TInterface\\icons\\Spell_Deathknight_ClassIcon.png:22|t", -- Death Knight
    [7] = "|TInterface\\icons\\inv_jewelry_talisman_04.png:22|t",    -- Shaman
    [8] = "|TInterface\\icons\\inv_staff_13.png:22|t",                 -- Mage
    [9] = "|TInterface\\icons\\spell_nature_drowsy.png:22|t",              -- Warlock
    [10] = "",                                                            					   -- Unk
    [11] = "[|TInterface\\icons\\Ability_Druid_Maul.png:22|t",         -- Druid
};

local Class = { 
    [1] = "|cffC79C6E Warrior", -- Warrior
    [2] = "|cffF58CBA Paladin", -- Paladin
    [3] = "|cffABD473 Hunter", -- Hunter
    [4] = "|cffFFF569 Rogue", -- Rogue
    [5] = "|cffFFFFFF Priest", -- Priest
    [6] = "|cffC41F3B Dk", -- Death Knight
    [7] = "|cff0070DE Shaman", -- Shaman
    [8] = "|cff69CCF0 Mage", -- Mage
    [9] = "|cff9482C9 Warlock", -- Warlock
    [11] = "|cffFF7D0A Druid" -- Druid
};

local T = {
    [1] = 0, -- Human
    [2] = 1, -- orc
    [3] = 0, -- Dwarf
    [4] = 0, -- Night Elf
    [5] = 1, -- Undead
    [6] = 1, -- Tauren
    [7] = 0, -- Gnome
    [8] = 1, -- Troll
    [10] = 1, -- Blood Elf
    [11] = 0, -- Draenei
};
local maxgold = 200000;

local gold = maxgold*10000
local goldcheck = gold - 1

local function Transmute_Money(event, player, amount)
    if player:GetCoinage() >= goldcheck then
		
		player:SendBroadcastMessage("|cffffff00You have reached the gold limit,your money has been converted into:\n\n|cff1B6B40•   1 |cFF387AACGold Bar\n\n|cffffff00You can use the command|cffffffff: |cffffff00.|cff1B6B40transmute|cffffff00 to have acess to your convertion menu|cffffff00, and |cff1B6B40transmute |cffffff00it back to money if needed.")
		CharDBQuery("INSERT IGNORE INTO `Platinum_Bars` (`guid`, `name`, `race`, `class`) VALUES ('"..player:GetGUIDLow().."', '"..player:GetName().."', "..player:GetRace()..", "..player:GetClass()..")")	
	    CharDBQuery("UPDATE `Platinum_Bars` SET `platinum_amount` = `platinum_amount` +1 WHERE `name` = '"..player:GetName().."'")
        
		player:SetCoinage(player:GetCoinage() - goldcheck)		
		end
end

RegisterPlayerEvent(14, Transmute_Money)

local MenuId = 9999

function Transmute.onGossipHello(event, player, object)
    local SMSG_NPC_TEXT_UPDATE = 384
    local MAX_GOSSIP_TEXT_OPTIONS = 8

    function Player:GossipSetText(text, textID)
        local data = CreatePacket(SMSG_NPC_TEXT_UPDATE, 100)
        data:WriteULong(textID or 0x7FFFFFFF)
        for i = 1, MAX_GOSSIP_TEXT_OPTIONS do
            data:WriteFloat(0) -- Probability
            data:WriteString(text) -- Text
            data:WriteString(text) -- Text
            data:WriteULong(0) -- language
            data:WriteULong(0) -- emote
            data:WriteULong(0) -- emote
            data:WriteULong(0) -- emote
            data:WriteULong(0) -- emote
            data:WriteULong(0) -- emote
            data:WriteULong(0) -- emote
        end
        self:SendPacket(data)
    end
	
	local Getplatinum_amount = CharDBQuery("SELECT platinum_amount From  characters.Platinum_Bars WHERE name = '"..player:GetName().."'");
    QuantidadePlatinum1 = Getplatinum_amount:GetUInt32(0);
    QuantidadePlatinum = QuantidadePlatinum1

	local Getplatinum_pieces = CharDBQuery("SELECT platinum_pieces From  characters.Platinum_Bars WHERE name = '"..player:GetName().."'");
    QuantidadePlatinum3 = Getplatinum_pieces:GetUInt32(0);
    QuantidadePlatinum2 = QuantidadePlatinum3
	
    local GetTime = CharDBQuery("SELECT totaltime FROM characters WHERE guid= "..player:GetGUIDLow().." ;");
	nSeconds = GetTime:GetUInt32(0);
    nHours = string.format("%02.f", math.floor(nSeconds/3600));
    nMins = string.format("%02.f", math.floor(nSeconds/60 - (nHours*60)));
    nSecs = string.format("%02.f", math.floor(nSeconds - nHours*3600 - nMins *60));	
	
	local pGuid = player:GetGUIDLow()
	
	player:GossipClearMenu()
    player:GossipSetText(string.format("|c1B6B4000 --------------------------------------------\n                   Character Information:\n --------------------------------------------\n Name:|cffffffff "..player:GetName().."|c1B6B4000                 Class:"..Class[player:GetClass()].."|c1B6B4000\n\n           |cff1B6B40•      |TInterface\\icons\\inv_ingot_03:18:18:0:-3|t|cFF387AACGold Bars:|cff1B6B40 "..QuantidadePlatinum.. "|c1B6B4000 \n           |cff1B6B40•      |TInterface\\icons\\inv_misc_coin_17:18:18:0:-3|t|cFF387AACGold Coins:|cff1B6B40 "..QuantidadePlatinum2.."|c1B6B4000  \n\n                     Total Played Time \n --------------------------------------------\n   |cff1B6B40"..nHours.."|c1B6B4000 hour(s) |cff1B6B40"..nMins.."|c1B6B4000 minutes n |cff1B6B40"..nSecs.."|c1B6B4000 seconds\n --------------------------------------------"))

	player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_misc_book_11:27|t |c1B6B4000[|cFF387AACGold System|c1B6B4000] |c1B6B4000- |c1BCEE3F6Information",0, 1)	
    player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_ingot_03:27|t |c1B6B4000[|cFF387AACGold Bars|c1B6B4000] |c1B6B4000- Into |c1BCEE3F6Coins",0, 3)
    player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_misc_coin_17:27|t |c1B6B4000[|cFF387AACGold Coins|c1B6B4000] |c1B6B4000- Back to |c1BCEE3F6Money",0, 4)
    player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_misc_coin_17:27|t |c1B6B4000[|cFF387AACGold Coins|c1B6B4000] |c1B6B4000- Into |c1BCEE3F6Gold Bar",0, 5)	
	player:GossipMenuAddItem(6,"|TInterface\\icons\\Inv_misc_groupneedmore:27|t Top |cff1B6B4010 |c1B6B4000Richest |c1B6B4000- |c1BCEE3F6Gold Miner",0, 6)    
	player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:27:27:0:0|t |cFF8B0000Nevermind",0,500)		
	player:GossipSendMenu(0x7FFFFFFF, player, MenuId)
end

function Transmute.onCommand(event, player, command)
    if (string.lower(command) == "transmute") then
        Transmute.onGossipHello(event, player, player)
        return false
    end
end

RegisterPlayerEvent(42, Transmute.onCommand)

function OnGossipSelect(event, player, object, sender, intid, code, menuid)

	local Getplatinum_amount = CharDBQuery("SELECT platinum_amount From  characters.Platinum_Bars WHERE name = '"..player:GetName().."'");
    QuantidadePlatinum1 = Getplatinum_amount:GetUInt32(0);
    QuantidadePlatinum = QuantidadePlatinum1

	local Getplatinum_pieces = CharDBQuery("SELECT platinum_pieces From  characters.Platinum_Bars WHERE name = '"..player:GetName().."'");
    QuantidadePlatinum3 = Getplatinum_pieces:GetUInt32(0);
    QuantidadePlatinum2 = QuantidadePlatinum3

if(intid == 1) then
   player:GossipClearMenu()
   player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:27:27:0:0|t |cFF8B0000Information",0,510, false, "|cffffff00This is our Gold Convertion System, check bellow to have access to all Information:\n|cffffffff------------------------------\n|cff00ccffGold Bars:\n|cffffffff------------------------------\n|cff1B6B40• |cffffffffWhen the player reach the gold limit of 200k, his gold will be converted into a Gold Bars. The Gold Bars are stored in our database, to see your balance use the command |cffFA5858.transmute\n|cffffffff------------------------------\n|cff00ccffGold Coins:\n|cffffffff------------------------------\n|cff1B6B40• |cffffffffDifferent of the Gold Bars, you can convert your Gold Coins into gold everytime if you have some, by using the gossip options from transmute menu.\n|cffffffff------------------------------\n|cff00ccffExtra Information:\n|cffffffff------------------------------\n|cff1B6B40• |cffffffffYour Gold Bars, can be turned into coins again If needed, access transmute options to do this.\n|cff1B6B40• |cffffffffYour Gold Coins, can be turned into gold If needed, access transmute options to do this.\n\n|cffffff00A doubt still remain? Don't worry, in case of any doubt, don't hesitate to contact a  |cffFA5858Staff |cffffff00Member.\n\n|cffffffff------------------------------\n|cffffff00Best Regards |cffffffff- |cffFA5858Staff Forbidden WoW \n|cffffffff------------------------------")
   player:GossipComplete()
   player:GossipSendMenu(0x7FFFFFFF, player, MenuId)   
   end   
   
if(intid == 3) then  
   player:GossipClearMenu()
   player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_ingot_03:27|t |c1B6B4000[STORE] |cFF387AACGold Bars |c1BCEE3F6[|cff1B6B401x|c1BCEE3F6]",0, 11, false, "   \n\n|TInterface\\icons\\inv_misc_coin_17:40:40:0:20|t\n|cffffff00In case you have a physical |cFF387AACGold Bars, |cffffff00this option allow you to store it inside your personal |cff1B6B40STORE Bank, |cffffff00where no one but you have acess.\n\n|cff1B6B40Note: |cffffff00When you accept, your physical bar will be removed and stored safely inside our |cff1B6B40STORE|cffffff00, you can verify how many bars you have stored, by check it writing .transmute.")   
   player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_ingot_03:27|t |cFF387AACGold Bars |c1BCEE3F6[|cff1B6B401x|c1BCEE3F6] |c1B6B4000- Into |cff387AACGold Coins |cff1B6B402x",0, 21, false, "   \n\n|TInterface\\icons\\inv_misc_coin_17:40:40:0:20|t\n|cffffff00Would you like to exchange|cffffffff: \n\n |cff1B6B40• 1 |cFF387AACGold Bars\n\n   |cffffff00for\n\n |cff1B6B40• 2 |cff610B21Gold Coins|cffffffff?\n\n|cffffff00By use this option, you will create a |cff1B6B40physical bar |cffffff00in your |cff1B6B40Inventory|cffffff00, to store it inside your personal |cff1B6B40DB Bank|cffffff00, use the other options from our convertion |cff1B6B40menu|cffffff00.\n\n|cffffff00Are you sure, you want to continue|cffffffff?")   
   player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:27:27:0:0|t |cFF8B0000Back",0,499)
   player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:27:27:0:0|t |cFF8B0000Nevermind",0,500)   
   player:GossipSendMenu(0x7FFFFFFF, player, MenuId)    
   end

if(intid == 4) then  
   player:GossipClearMenu()
   player:GossipSetText(string.format("|c1B6B4000 --------------------------------------------\n                   Character Information:\n --------------------------------------------\n Name:|cffffffff "..player:GetName().."|c1B6B4000                 Class:"..Class[player:GetClass()].."|c1B6B4000\n\n           |cff1B6B40•      |TInterface\\icons\\inv_ingot_03:18:18:0:-3|t|cFF387AACGold Bars:|cff1B6B40 "..QuantidadePlatinum.. "|c1B6B4000 \n           |cff1B6B40•      |TInterface\\icons\\inv_misc_coin_17:18:18:0:-3|t|cFF387AACGold Coins:|cff1B6B40 "..QuantidadePlatinum2.."|c1B6B4000  \n\n                     Total Played Time \n --------------------------------------------\n   |cff1B6B40"..nHours.."|c1B6B4000 hour(s) |cff1B6B40"..nMins.."|c1B6B4000 minutes n |cff1B6B40"..nSecs.."|c1B6B4000 seconds\n --------------------------------------------"))   
   player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_misc_coin_17:27|t |cFF387AACGold Coins |c1BCEE3F6[|cff1B6B401x|c1BCEE3F6] |c1B6B4000- Into |cff610B21100,000g",0, 22, false, "   \n\n|TInterface\\icons\\inv_misc_coin_17:40:40:0:20|t\n|cffffff00Would you like to exchange|cffffffff: \n\n |cff1B6B40• 1 |cFF387AACGold Coin\n\n   |cffffff00for\n\n |cff1B6B40• |cff610B21100.000g|cffffffff?\n\n|cffffff00Are you sure, you want to continue|cffffffff?")   
   player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:27:27:0:0|t |cFF8B0000Back",0,499)
   player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:27:27:0:0|t |cFF8B0000Nevermind",0,500)   
   player:GossipSendMenu(0x7FFFFFFF, player, MenuId)    
   end

if(intid == 5) then  
   player:GossipClearMenu()
   player:GossipSetText(string.format("|c1B6B4000 --------------------------------------------\n                   Character information:\n --------------------------------------------\n Name:|cffffffff "..player:GetName().."|c1B6B4000                 Class:"..Class[player:GetClass()].."|c1B6B4000\n\n           |cff1B6B40•      |TInterface\\icons\\inv_ingot_03:18:18:0:-3|t|cFF387AACGold Bars:|cff1B6B40 "..QuantidadePlatinum.. "|c1B6B4000 \n           |cff1B6B40•      |TInterface\\icons\\inv_misc_coin_17:18:18:0:-3|t|cFF387AACGold Coins:|cff1B6B40 "..QuantidadePlatinum2.."|c1B6B4000  \n\n                     Total Played Time \n --------------------------------------------\n   |cff1B6B40"..nHours.."|c1B6B4000 hour(s) |cff1B6B40"..nMins.."|c1B6B4000 minutes n |cff1B6B40"..nSecs.."|c1B6B4000 seconds\n --------------------------------------------"))   
   player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_misc_coin_17:27|t |c1B6B4000[STORE] |cFF387AACGold Coin |c1BCEE3F6[|cff1B6B401x|c1BCEE3F6]",0, 13, false, "   \n\n|TInterface\\icons\\inv_misc_coin_17:40:40:0:20|t\n|cffffff00In case you have a physical |cFF387AACGold Coin, |cffffff00this option allow you to store it inside your personal |cff1B6B40STORE Bank, |cffffff00where no one but you have acess.\n\n|cff1B6B40Note: |cffffff00When you accept, your physical bar will be removed and stored safely inside our |cff1B6B40STORE|cffffff00, you can verify how many bars you have stored, by check it writing .transmute.")   
   player:GossipMenuAddItem(6,"|TInterface\\icons\\inv_misc_coin_17:27|t |cFF387AACGold Coins |c1BCEE3F6[|cff1B6B402x|c1BCEE3F6] |c1B6B4000- Into |cff387AACGold Bars |cff1B6B401x",0, 23, false, "   \n\n|TInterface\\icons\\inv_misc_coin_17:40:40:0:20|t\n|cffffff00Would you like to exchange|cffffffff: \n\n |cff1B6B40• 2 |cFF387AACGold Coins\n\n   |cffffff00for\n\n |cff1B6B40• 1 |cff610B21Gold Bars|cffffffff?\n\n|cffffff00By use this option, you will create a |cff1B6B40physical bar |cffffff00in your |cff1B6B40Inventory|cffffff00, to store it inside your personal |cff1B6B40DB Bank|cffffff00, use the other options from our convertion |cff1B6B40menu|cffffff00.\n\n|cffffff00Are you sure, you want to continue|cffffffff?")  
   player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:27:27:0:0|t |cFF8B0000Back",0,499)
   player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:27:27:0:0|t |cFF8B0000Nevermind",0,500)   
   player:GossipSendMenu(0x7FFFFFFF, player, MenuId)    
   end

if(intid == 6) then
    player:GossipSetText(string.format("|c1B6B4000 --------------------------------------------\n                   Character information:\n --------------------------------------------\n Name:|cffffffff "..player:GetName().."|c1B6B4000                 Class:"..Class[player:GetClass()].."|c1B6B4000\n\n           |cff1B6B40•      |TInterface\\icons\\inv_ingot_03:18:18:0:-3|t|cFF387AACGold Bars:|cff1B6B40 "..QuantidadePlatinum.. "|c1B6B4000 \n           |cff1B6B40•      |TInterface\\icons\\inv_misc_coin_17:18:18:0:-3|t|cFF387AACGold Coins:|cff1B6B40 "..QuantidadePlatinum2.."|c1B6B4000  \n\nMenu dedicated for the players that care about the future and store their |cff1B6B40golds |c1B6B4000into |cff1B6B40bars|c1B6B4000, as a security method.\n\n|cff1B6B40Note|c1B6B4000: This menu displays the |cff1B6B40richest |c1B6B4000players, don't you see your name on the |cff1B6B40list|c1B6B4000? Simple, start to save |cff1B6B40money|c1B6B4000!"))

    local score = CharDBQuery("SELECT name,platinum_amount,platinum_pieces,race,class FROM Platinum_Bars ORDER BY platinum_amount and platinum_pieces DESC LIMIT 10")
        repeat
		local playername = score:GetString(0);			
        local amount = score:GetUInt32(1);
		local pieces = score:GetUInt32(2);
		local race = score:GetUInt32(3);
		local class = score:GetUInt32(4);		
		player:GossipMenuAddItem(9," "..Team[T[race]].." |cff1B6B40"..score:GetString(0).."|r - |cFF387AACTotal Gold  |c1B6B4000= |cff1B6B40["..score:GetUInt32(1).."]|r |cFF387AACGold Coins  |c1B6B4000= |cff1B6B40["..score:GetUInt32(2).."]|r", 7, 1)
        until not score:NextRow()
        player:GossipMenuAddItem(3,"|TInterface/PaperDollInfoFrame/UI-GearManager-Undo:22:22:0:0|t |cFF8B0000Back",0,499)
        player:GossipMenuAddItem(3,"|TInterface\\RaidFrame\\ReadyCheck-NotReady:22:22:0:0|t |cFF8B0000Nevermind",0,500)		
        player:GossipSendMenu(0x7FFFFFFF, player, MenuId) 
        end

if(intid == 21) then
  if(QuantidadePlatinum>=1) then
     WorldDBQuery("UPDATE  characters.Platinum_Bars SET platinum_amount = (platinum_amount-1) WHERE name = '"..player:GetName().."'");  
     player:AddItem(500000, 2)
     player:SendBroadcastMessage("|cffffff00Purchase successfully done: |cff1B6B401 |cFF387AACGold Bars |cffffff00for |cff1B6B402 |cFF387AACGold Coins|cffffff00.")        
     player:GossipComplete()
   else
     player:SendBroadcastMessage("|cffffff00You do not have the requirements to make this purchase, save money and store it into bars.")
     player:GossipComplete()
   end
end

if(intid == 22) then
  if(QuantidadePlatinum2>=1) then
     WorldDBQuery("UPDATE  characters.Platinum_Bars SET platinum_pieces = (platinum_pieces-1) WHERE name = '"..player:GetName().."'"); 
     player:SetCoinage(1000000000) 
     player:SendBroadcastMessage("|cffffff00Purchase successfully done: |cff1B6B401 |cFF387AACGold Coin |cffffff00for |cFF387AAC100.000g|cffffff00.")       
     player:GossipComplete()
   else
     player:SendBroadcastMessage("|cffffff00You do not have the requirements to make this purchase, save money and store it into bars.")
     player:GossipComplete()
   end
end

if(intid == 23) then
  if(QuantidadePlatinum2>=2) then
     WorldDBQuery("UPDATE  characters.Platinum_Bars SET platinum_pieces = (platinum_pieces-2) WHERE name = '"..player:GetName().."'");  
     player:AddItem(500002, 1) 
     player:SendBroadcastMessage("|cffffff00Purchase successfully done: |cff1B6B402 |cFF387AACGold Coins |cffffff00for |cff1B6B401 |cFF387AACGold Bars|cffffff00.")        
     player:GossipComplete()
   else
     player:SendBroadcastMessage("|cffffff00You do not have the requirements to make this purchase, save money and store it into bars.")
     player:GossipComplete()
   end
end

if(intid == 11) then
   if(player:HasItem(500002, 1)) then
      player:RemoveItem(500002, 1)
	  
	  CharDBQuery("UPDATE `Platinum_Bars` SET `platinum_amount` = `platinum_amount` +1 WHERE `name` = '"..player:GetName().."'")
	 
	  player:SendBroadcastMessage("|cffffff00Your |cFF387AACGold Bars|cffffff00, has been stored with sucess. |cffffff00Acess |cFF387AAC.transmute|cffffff00, to verify how many bars you have.")       
      player:GossipComplete()
	else
      player:SendBroadcastMessage("|cffffff00You do not have the requirements to make this purchase, save money and store it into bars.")
      player:GossipComplete()
   end
end

if(intid == 13) then
   if(player:HasItem(500000, 1)) then
      player:RemoveItem(500000, 1)
	  
	  CharDBQuery("UPDATE `Platinum_Bars` SET `platinum_pieces` = `platinum_pieces` +1 WHERE `name` = '"..player:GetName().."'")
	 
	  player:SendBroadcastMessage("|cffffff00Your |cFF387AACGold Coin|cffffff00, has been stored with sucess. |cffffff00Acess |cFF387AAC.transmute|cffffff00, to verify how many bars you have.")       
      player:GossipComplete()
	else
      player:SendBroadcastMessage("|cffffff00You do not have the requirements to make this purchase, save money and store it into bars.")
      player:GossipComplete()
   end
end	
	  
		
if (intid == 499) then
   Transmute.onGossipHello(event, player, object) 
   end

if (intid == 500) then
   player:GossipComplete()	
   end			
end   

RegisterPlayerGossipEvent(MenuId, 2, OnGossipSelect)
