local LocationTeleport = {}

LocationTeleport.SAVE_LOCATION_SPELL = 100232
LocationTeleport.TELEPORT_BACK_SPELL = 100232
LocationTeleport.TELEPORT_BACK_DURATION = 180 -- 3 minutes in seconds
LocationTeleport.SPELL_ON_TELEPORT = 72313
LocationTeleport.EMOTE_ON_SPELL_CAST = 51

LocationTeleport.savedLocations = {}
LocationTeleport.spellUsage = {}

function LocationTeleport.OnSpellCast(event, player, spell)
    local playerGuid = player:GetGUIDLow()

    if spell:GetEntry() ~= LocationTeleport.SAVE_LOCATION_SPELL then
        return
    end
	
    if spell:GetEntry() == LocationTeleport.SAVE_LOCATION_SPELL then
        player:PerformEmote(LocationTeleport.EMOTE_ON_SPELL_CAST)  -- Perform emote when the spell is cast
        if not LocationTeleport.savedLocations[playerGuid] then
            local mapId, x, y, z, orientation = player:GetMapId(), player:GetX(), player:GetY(), player:GetZ(), player:GetO()
            LocationTeleport.savedLocations[playerGuid] = { mapId = mapId, x = x, y = y, z = z, orientation = orientation }
            player:SendBroadcastMessage("Your rift location has been saved for 3 minutes.")
            
            -- Reset spell cooldown if it's the first, third, or any odd-numbered use
            if not LocationTeleport.spellUsage[playerGuid] then
                LocationTeleport.spellUsage[playerGuid] = 1
            else
                LocationTeleport.spellUsage[playerGuid] = LocationTeleport.spellUsage[playerGuid] + 1
            end

            if LocationTeleport.spellUsage[playerGuid] % 2 == 1 then
                player:ResetSpellCooldown(LocationTeleport.SAVE_LOCATION_SPELL, true)
            end

            -- Remove saved location after 3 minutes
            local function RemoveSavedLocation(eventId, delay, repeats)
                LocationTeleport.savedLocations[playerGuid] = nil
                player:SendBroadcastMessage("Your rift location has expired.")
            end
            player:RegisterEvent(RemoveSavedLocation, LocationTeleport.TELEPORT_BACK_DURATION * 1000, 1)
        else
            local savedLocation = LocationTeleport.savedLocations[playerGuid]
            player:Teleport(savedLocation.mapId, savedLocation.x, savedLocation.y, savedLocation.z, savedLocation.orientation)
            player:CastSpell(player, LocationTeleport.SPELL_ON_TELEPORT, true)
            player:SendBroadcastMessage("You have been teleported back to your rift location.")
            
            -- Remove saved location after teleport
            LocationTeleport.savedLocations[playerGuid] = nil
            player:SendBroadcastMessage("Your rift location has expired.")
        end
    end
end

RegisterPlayerEvent(5, LocationTeleport.OnSpellCast)
