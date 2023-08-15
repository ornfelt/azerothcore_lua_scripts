-- simple world chat WITHOUT the '#chat' command...WTF you say?
-- just change chat channels to world channel and chat away.
-- names are clickable for whispers and sub menu.
local on = "#chat on"
local off = "#chat off"
local Team =  {
	[0] = "[|TInterface\\icons\\Inv_Misc_Tournaments_banner_Human.png:13|t]",
	[1] = "[|TInterface\\icons\\Inv_Misc_Tournaments_banner_Orc.png:13|t]"
		};
local Class = { 
	[1] = "[|TInterface\\icons\\INV_Sword_27.png:13|t]",
        [2] = "[|TInterface\\icons\\INV_Hammer_01.png:13|t]",
        [3] = "[|TInterface\\icons\\INV_Weapon_Bow_07.png:13|t]",
        [4] = "[|TInterface\\icons\\INV_ThrowingKnife_04.png:13|t]",
        [5] = "[|TInterface\\icons\\INV_Staff_30.png:13|t",
        [6] = "[|TInterface\\icons\\Spell_Deathknight_ClassIcon.png:13|t]",
        [7] = "[|TInterface\\icons\\inv_jewelry_talisman_04.png:13|t]",
        [8] = "[|TInterface\\icons\\INV_Staff_30.png:13|t]",
        [9] = "[|TInterface\\icons\\INV_Staff_30.png:13|t]",
        [11] = "[|TInterface\\icons\\Ability_Druid_Maul.png:13|t]",
		};
local Gmrank = {
	[0] = "|cff00ffff[Player]|r",
	[1] = "[|TINTERFACE/CHATFRAME/UI-CHATICON-BLIZZ:13:13:0:-1|t]|cffff0000[GM1]|r",
	[2] = "|TINTERFACE/CHATFRAME/UI-CHATICON-BLIZZ:13:13:0:-1|t|cffff0000[GM2]|r",
	[3] = "|TINTERFACE/CHATFRAME/UI-CHATICON-BLIZZ:13:13:0:-1|t|cffff0000[GM3]|r",
	[4] = "|TINTERFACE/CHATFRAME/UI-CHATICON-BLIZZ:13:13:0:-1|t|cff7f00ff[LEAD GM]|r",
	[5] = "[|TINTERFACE/CHATFRAME/UI-CHATICON-BLIZZ:13:13:0:-1|t][|cff999999ADMIN|r]"
		};
	
function ChatSystem(event, player, msg, type, lang, channel)

	if(msg ~= "")then
		
		if(msg ~= "Away")then
			
			local acctid = player:GetAccountId()

				if(msg == off)then
					ACCT[acctid].chat = 0
					player:SendBroadcastMessage("|cff3399ffWorld chat off.|r")
				return false;
				end
			
				if(msg == on)then
					ACCT[acctid].chat = 1
			    		player:SendBroadcastMessage("|cff3399ffWorld chat on.|r")
			    	return false;
				end
			
				if(ACCT[player:GetAccountId()].chat == 1)and(msg ~= ACCT["SERVER"].Commands)then -- 0 = world chat off :: 1 = world chat on
					local Viprank = "[|cff3399ffVIP"..ACCT[player:GetAccountId()].Vip.."|r]";
					local t = table.concat{Team[player:GetTeam()], Class[player:GetClass()], Gmrank[player:GetGMRank()], Viprank, "[|cff3399ff","|Hplayer:", player:GetName(),  "|h", player:GetName(), "|h", "|r]:|cff00cc00",  msg};
					SendWorldMessage(t)
				return false;
				end
		else
		end
	else
	end
end

RegisterPlayerEvent(18, ChatSystem)

function VIP_Wchat_comm(event, player, message, type, language)
    if(message:lower() == ACCT["SERVER"].Commands) then
     	player:SendBroadcastMessage("|cff00cc00World Chat System:|r")
     	player:SendBroadcastMessage("-->/say "..on.."|cff00cc00 to turn on the world chat.|r")
     	player:SendBroadcastMessage("-->|cff00cc00Then just chat away on `/say` channel.|r")
    	player:SendBroadcastMessage("-->/say "..off.."|cff00cc00 to turn off the world chat.|r")
	end
return;
end

RegisterPlayerEvent(18, VIP_Wchat_comm)

print("Grumbo'z VIP World Chat loaded.")
