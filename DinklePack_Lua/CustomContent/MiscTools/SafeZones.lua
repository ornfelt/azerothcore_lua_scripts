local ZoneAuraApplier = {}

ZoneAuraApplier.PLAYER_EVENT = 27 -- PLAYER_EVENT_ON_UPDATE_ZONE
ZoneAuraApplier.AURA_ID = 80094
ZoneAuraApplier.AREA_ID_LIST = {976, 541, 3425, 1446, 69, 42, 35, 2268, 152, 108, 1099, 392, 99, 117, 608, 2255}

-- Convert the array into a set for faster access
ZoneAuraApplier.AREA_ID_SET = {}
for _, id in ipairs(ZoneAuraApplier.AREA_ID_LIST) do
    ZoneAuraApplier.AREA_ID_SET[id] = true
end

-- Event Handler
function ZoneAuraApplier.OnPlayerUpdateZone(event, player, newZone, newArea)
    -- If the new area id is in the list and the player does not have the aura, apply it
    if ZoneAuraApplier.AREA_ID_SET[newArea] and not player:HasAura(ZoneAuraApplier.AURA_ID) then
        player:AddAura(ZoneAuraApplier.AURA_ID, player)
    -- If the new area id is not in the list and the player has the aura, remove it
    elseif not ZoneAuraApplier.AREA_ID_SET[newArea] and player:HasAura(ZoneAuraApplier.AURA_ID) then
        player:RemoveAura(ZoneAuraApplier.AURA_ID)
    end
end

RegisterPlayerEvent(ZoneAuraApplier.PLAYER_EVENT, ZoneAuraApplier.OnPlayerUpdateZone)
