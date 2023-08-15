-- This CANNOT run with the VIP_MG_Drop_Table_V1. Cannot have 2 scripts hooked to the same event of a creature.
-- this is an alternate vesion for adding instant loot of mg to ALL creatures.
-- first you must add a new column to your world.creature_template called 'mg'
-- then set Datatype = smallint, Length/Set = 6, Unsigned = checked, Allow Null = unchecked, Default = 0

NPCMG = {};

local query = WorldDBQuery("SELECT `entry`, `mg` FROM creature_template WHERE `mg` > 0;")
	if(query)then
		repeat
			NPCMG[query:GetUInt32(0)] = {query:GetUInt32(0), query:GetUInt32(1)};
		until not query:NextRow()
	end

function NpcDieMG(eventid, creature, player)
local Cid = creature:GetEntry()
local Paccid = player:GetAccountId()

	if(NPCMG[Cid][2]~=0)then
		if(player:IsInGroup()) then
			for _, v in ipairs(player:GetGroup():GetMembers()) do
				if v:IsInWorld() then
					local GroupVip = ACCT[v:GetAccountId()].Vip
					if(v:IsInGuild())then
						v:AddItem(ACCT["SERVER"].Mg, (math.random(1, NPCMG[Cid][2])*(GroupVip)))
					else
						v:AddItem(ACCT["SERVER"].Mg, ((math.random(1, NPCMG[Cid][2])*(GroupVip)/2)))
						v:SendBroadcastMessage("|cff00cc00Join a guild to earn extra rewards.|r")
					end
				end
			end
		else	
			if(player:IsInGuild())then
				player:AddItem(ACCT["SERVER"].Mg, (math.random(1, NPCMG[Cid][2]))*ACCT[Paccid].Vip)
			else
				player:AddItem(ACCT["SERVER"].Mg, ((math.random(1, NPCMG[Cid][2])*(ACCT[Paccid].Vip)/2)))
				player:SendBroadcastMessage("|cff00cc00Join a guild to earn extra rewards.|r")
			end
		end
	else
	end
end

for a = 1,#NPCMG do
	if(NPCMG[a])then
		RegisterCreatureEvent(NPCMG[a][1], 4, NpcDieMG)
	else
	end
end

print("Grumbo'z VIP MG Drop Table V2 loaded.")
