local MountRestrictHandler = {}

MountRestrictHandler.ALLOWED_MAPS = {0, 1}
MountRestrictHandler.ALLOWED_SPELLS = {100150, 100160, 100161, 100177, 100186, 100168, 80029, 80097}

function MountRestrictHandler.tableIndexOf(t, value)
    for k, v in ipairs(t) do
        if v == value then
            return k
        end
    end
    return -1
end

function MountRestrictHandler.OnPlayerCastSpell(event, player, spell)
    local spellId = spell:GetEntry()
    local mapId = player:GetMapId()

    if MountRestrictHandler.tableIndexOf(MountRestrictHandler.ALLOWED_SPELLS, spellId) ~= -1 then
        if MountRestrictHandler.tableIndexOf(MountRestrictHandler.ALLOWED_MAPS, mapId) == -1 then
            spell:Cancel()
            player:SendBroadcastMessage("You can't use that here.")
        else
            if spellId == 100150 then
                player:PlayDirectSound(20428)
            end
        end
    end
end

function MountRestrictHandler.OnPlayerZoneChange(event, player, newZone, newArea)
    local mapId = player:GetMapId()
    if MountRestrictHandler.tableIndexOf(MountRestrictHandler.ALLOWED_MAPS, mapId) == -1 then
        for i, allowedSpell in ipairs(MountRestrictHandler.ALLOWED_SPELLS) do
            local aura = player:GetAura(allowedSpell)
            if aura then
                player:RemoveAura(allowedSpell)
            end
        end
    end
end

RegisterPlayerEvent(27, MountRestrictHandler.OnPlayerZoneChange)
RegisterPlayerEvent(5, MountRestrictHandler.OnPlayerCastSpell)
