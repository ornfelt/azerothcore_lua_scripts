-- Settings
local config = require ('!config')-- Need Don't Remove

local luaName = "NPC Summon Menu"
local luaNameShort = "NSM_"

local debugON = config.get(luaNameShort.."debugOn")
local enabled = config.get(luaNameShort.."enabled", debugON)
local GossipID = config.get(luaNameShort.."GossipID", debugON)
local NPC_Spawn = config.get(luaNameShort.."NPC_Spawn", debugON)
local NPC_Trainers = config.get(luaNameShort.."NPC_Trainers", debugON)
local NPC_CheckNear = config.get("NPC_CheckNear", debugON) -- Global Setting


function table.contains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end
--(Start) The Gossip Menu that shows Main Menu
function NPC_Summon_MenuGossip(event, player)


	for k, v in pairs(NPC_Spawn) do
		player:GossipMenuAddItem(3, v[3].." "..v[4], 0, v[1]+100)
	end
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:45:45:-40|t [Back]", 0, 9999)		
	player:GossipSendMenu(1, player, GossipID)
end
--(End)

--(Start)
local function OnSelect(event, player, _, sender, intid, code)
	if player:IsInCombat() then
        return
    end
	
	local x = player:GetX()
	local y = player:GetY()
	local z = player:GetZ()
	local o = player:GetO()
	local map = player:GetMap()
	local mapID = map:GetMapId()
	local areaId = map:GetAreaId( x, y, z )
	for k, v in pairs(NPC_Spawn) do
		
		if(intid== v[1]+100) then
			if v[1] == 24939 then
				player:CastSpell(player, 24939)
				player:GossipComplete()
				return
			elseif v[1] == 1 then
				local playerClass = player:GetClass()
				if NPC_Trainers[playerClass] then
					for k, Trainer in pairs(NPC_Trainers[playerClass] ) do
						local TrainerNPC = player:GetNearestCreature( 80, Trainer )
					local TrainerNPC_Spawned
						if TrainerNPC == nil or NPC_CheckNear == false then
							TrainerNPC_Spawned = player:SpawnCreature( Trainer, x+1, y+1, z+0.5, o-3.5, 1, 60000 )
							TrainerNPC_Spawned:SetFaction(35) -- Set the creature's faction to 35
							TrainerNPC_Spawned:MoveFollow(player, 2, v[2])
							TrainerNPC_Spawned:SetMaxHealth(5000000)
							TrainerNPC_Spawned:SetHealth(5000000)
						else
							player:SendAreaTriggerMessage("|cffff3347Note: |cffffd000"..v[4].." is already nearby!")
						end
					end
				end
				player:GossipComplete()
				return			
			else
			local NPC_Spawned= player:GetNearestCreature( 80, v[1] )
			local NPC
			if NPC_Spawned == nil or NPC_CheckNear == false then
				NPC = player:SpawnCreature( v[1], x+1, y+1, z+0.5, o-3.5, 1, 60000 )
					NPC:SetFaction(35) -- Set the creature's faction to 35
					NPC:MoveFollow(player, 2, v[2])
					NPC:SetLevel(80)
					NPC:SetMaxHealth(5000000)
					NPC:SetHealth(5000000)
				else
				player:SendAreaTriggerMessage("|cffff3347Note: |cffffd000"..v[4].." is already nearby!")
			end
				player:GossipComplete()
				return
			end
		end
	end	
	
	if(intid == 9999) then --Back
		OtherMenuGossip(event, player)
		return false
	end
end
--(End)

if enabled then
RegisterPlayerGossipEvent(GossipID, 2, OnSelect)
end
