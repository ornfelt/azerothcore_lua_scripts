--[[ 
    Scripted by New-HavenWotLK (Krisande#5411 on Discord)
    This Script provides you with a Buffer-NPC which is able to buff up players + checks if there is a pet... if a pet was found, it also will buff up your pet!
]]--
    

local NPC_ID = 601015

-- BUFF_CHECK checks if this buff is active... if not... it triggers the buff action (should be a buff which runs out early... here it is PoSP since it only runs ~ 20mins)
local BUFF_CHECK = 48170
local BUFF_IDS = {
   	72586,
	  48470,
	    48074,
	      48162,
		43002,
		  48170,
              -- u can also declare more buffs if you want to... my buffer is not limited to 6 buffs only!!! =)
		  
}

-- EDIT BELOW ONLY IF YOU REALLY KNOW WHAT YOU ARE DOING! 
-- IN CASE YOU FUCK THE CODE, COPY A FRESH VERSION FROM MY REPO! https://github.com/New-HavenWotLK/lua-Super-BufferNPC

local function Buff_on_Sight(event, creature, player)
    if creature:IsInRange(player, 1, 15) then -- checks if player is in given range
       local playerGUID = player:GetGUIDLow() -- get the lowGUID of a player
        if (playerGUID > 0) then -- checks if it is a player
            local player = GetPlayerByGUID(playerGUID) -- get exact playerGUID
            if (player ~= nil) then 
                if not player:HasAura(BUFF_CHECK) then -- checks if the player has 
                    for k, v in pairs(BUFF_IDS) do -- loop which runs through the BUFF_IDS array untill all buffs are buffed to a player, then stops the action.
                        local petGUID = player:GetPetGUID() -- declaration of pet
                        local petEntry = GetGUIDEntry(petGUID) -- get the petGUID entry
                        local target = player:GetNearestCreature(3, nil, 2, 1) -- checks for a target near the player which is friendly and alive(pet)
                        if (petGUID > 0) then -- checks if there is a pet
                            if (petEntry ~= nil) then
                                player:AddAura(v, target) -- adds the auras to target which is the pet (v are the BUFF_IDS)
                                player:AddAura(v, player) -- adds the auras to player (v are the BUFF_IDS)
                            end
                        else -- in case no pet is found just add aura to player (v are the BUFF_IDS)
                            player:AddAura(v, player)
                        end
                    end
                end
            end
        end
    end
end
RegisterCreatureEvent(NPC_ID, 27, Buff_on_Sight)
