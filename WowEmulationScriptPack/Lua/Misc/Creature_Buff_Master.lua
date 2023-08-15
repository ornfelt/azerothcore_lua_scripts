local NPC_ID = 190011 -- Edit ID with id of your npc
local BUFF_IDS = {48162, 48074, 48170, 43223, 36880, 48469, 26393} -- Feel free to add here more buffs

function BuffOnSight(event, creature, player)
    if (player:GetObjectType() == "Player" and creature:IsWithinDistInMap(player, 15)) then
        for k, v in pairs(BUFF_IDS) do
            if not player:HasAura(v) then
                player:AddAura(v, player)
            end
        end
    end
end
   
RegisterCreatureEvent(NPC_ID, 27, BuffOnSight)