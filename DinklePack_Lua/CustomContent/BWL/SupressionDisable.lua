local SUPPRESSION_DEVICE_ENTRY = 179784
local CHAT_COMMAND = "suppress"
local BWL_MAP_ID = 469
local RED_FIREWORK_SPELL_ID = 6668

local function DespawnSuppressionDevices(player)
    if player:GetMapId() == BWL_MAP_ID then
        local nearbySuppressionDevices = player:GetNearObjects(300, 0x1, SUPPRESSION_DEVICE_ENTRY)
        for _, suppressionDevice in ipairs(nearbySuppressionDevices) do
            suppressionDevice:Despawn()
        end
        player:SendBroadcastMessage("Suppression devices have been disarmed temporarily.")
    else
    end
end

local function OnChatCommand(event, player, msg, Type, lang)
    if msg:lower() == CHAT_COMMAND then
        if player:IsGM() then
            DespawnSuppressionDevices(player)
            return false
        else
            player:SendBroadcastMessage("This command can only be used by Game Masters.")
        end
    end
end

local function OnSpellCast(event, player, spell, skipCheck)
    if spell:GetEntry() == RED_FIREWORK_SPELL_ID then
        DespawnSuppressionDevices(player)
    end
end

RegisterPlayerEvent(18, OnChatCommand)
RegisterPlayerEvent(5, OnSpellCast)
