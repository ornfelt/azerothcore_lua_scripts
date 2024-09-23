-- CANNOT run with VIP_MG_Drop_Table_V2.lua
-- ok what is this... well ok this is more a HD space saver. Instead of a drop lua for each mob just add the mob
-- entry ID to a numbered table. this will create a vaporous"no physical exsistance" lua script for that mob
-- and depending on which numbered table it is in is how the item or items will drop.
-- There is also an added calculation for the VIP system to adjust based on vip level.
-- it may have been my idea but never would be in exsistance with out the extreme major help of FoeReaper -- TNX -- :D
-- custom function called by npc died functions for all mobs.
-- This is just pure super-hyper-dynamic-script-creator-event-hooker-gargle-blaster
-- Wrote by FoeReaper
-- idea by Slp13at420
local DROPnpc = {
[1] = {3100, 3225, 49999}, --  drop level 1 npc's
[2] = {}, -- drop level 2 npc's
[3] = {},
[4] = {}
};

local function drop(eventId, creature, player, level)

local ostime = tonumber(GetGameTime())
local seed = (ostime*ostime)
math.randomseed(seed)

local Paccid = player:GetAccountId()
local base = 50
local PlayerVip = ACCT[Paccid].Vip

	if(player:IsInGroup()) then
		for _, v in ipairs(player:GetGroup():GetMembers()) do
			if v:IsInWorld() then
				local GroupVip = ACCT[v:GetAccountId()].Vip
				if(v:IsInGuild())then
					v:AddItem(ACCT["SERVER"].Mg, (math.random(1, (base*level))*(GroupVip)))
				else
					v:AddItem(ACCT["SERVER"].Mg, ((math.random(1, (base*level))*(GroupVip)/2)))
					v:SendBroadcastMessage("|cff00cc00Join a guild to earn extra rewards.|r")
				end
			end
		end
	else	
		if(player:IsInGuild())then
			player:AddItem(ACCT["SERVER"].Mg, (math.random(1, (base*level))*(PlayerVip)))
		else
			player:AddItem(ACCT["SERVER"].Mg, ((math.random(1, (base*level))*(PlayerVip)/2)))
			player:SendBroadcastMessage("|cff00cc00Join a guild to earn extra rewards.|r")
		end
	end
end

for i = 1, #DROPnpc do
	for _, v in ipairs(DROPnpc[i]) do
	RegisterCreatureEvent(v, 4, function(arg1, arg2, arg3) drop(arg1, arg2, arg3, i) end) -- Automatically finds level based on table key that the entry is in
	end
end
print("Grumbo'z VIP MG Drop Table V1 loaded.")
-- 'Now .... Don't you just .. love it?'
