AlterTime = {}

-- Encapsulating the existing variables into the namespace AlterTime
AlterTime.SAVE_LOCATION_SPELL = 100252
AlterTime.TELEPORT_BACK_DURATION = 10 
AlterTime.SPELL_ON_TELEPORT = {54139, 51150, 52662}
AlterTime.MIN_SPELL_ID = 1
AlterTime.MAX_SPELL_ID = 300000
AlterTime.savedLocations = {}

-- Encapsulating the existing functions into the namespace AlterTime
function AlterTime.SaveAuras(player)
    local auras = {}
    for spellId = AlterTime.MIN_SPELL_ID, AlterTime.MAX_SPELL_ID do
        local aura = player:GetAura(spellId)
        if aura then
            auras[spellId] = aura:GetDuration()
        end
    end
    return auras
end

function AlterTime.ApplySavedAuras(player, auras)
    for spellId, duration in pairs(auras) do
        local aura = player:AddAura(spellId, player)
        if aura then
            aura:SetDuration(duration)
        end
    end
end

function AlterTime.Alter_Time_OnSpellCast(event, player, spell)
    local playerGuid = player:GetGUID()

    if spell:GetEntry() == AlterTime.SAVE_LOCATION_SPELL then
        if not AlterTime.savedLocations[playerGuid] then
            local mapId, x, y, z, orientation, health = player:GetMapId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO(), player:GetHealth()
            local auras = AlterTime.SaveAuras(player)
            AlterTime.savedLocations[playerGuid] = { mapId = mapId, x = x, y = y, z = z, orientation = orientation, health = health, auras = auras }
            player:SendBroadcastMessage("Your current state has been stored.")

                local function TeleportBack()
                local savedLocation = AlterTime.savedLocations[playerGuid]
                local player = GetPlayerByGUID(playerGuid)
                
                if not player then
                    AlterTime.savedLocations[playerGuid] = nil
                    return
                end

                player:Teleport(savedLocation.mapId, savedLocation.x, savedLocation.y, savedLocation.z, savedLocation.orientation)
                player:SetHealth(savedLocation.health)

                if player:IsDead() then
                    player:ResurrectPlayer(10)
                end

                AlterTime.ApplySavedAuras(player, savedLocation.auras)

                for _, spellId in ipairs(AlterTime.SPELL_ON_TELEPORT) do
                    player:CastSpell(player, spellId, true)
                end

                player:SendBroadcastMessage("Your Alter Time state has been restored.")
                AlterTime.savedLocations[playerGuid] = nil
            end
            CreateLuaEvent(TeleportBack, AlterTime.TELEPORT_BACK_DURATION * 1000, 1)
        end
    end
end

RegisterPlayerEvent(5, AlterTime.Alter_Time_OnSpellCast)
