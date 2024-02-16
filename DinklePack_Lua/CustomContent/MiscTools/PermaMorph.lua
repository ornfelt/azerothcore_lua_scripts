local MorphDisplay = {}

MorphDisplay.CreateTableSQL = [[
CREATE TABLE IF NOT EXISTS player_morph_displayids (
    `guid` INT UNSIGNED NOT NULL,
    `displayId` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
]]
CharDBExecute(MorphDisplay.CreateTableSQL)

function MorphDisplay.OnCustomCommand(event, player, command)
    local cmd, displayId = string.match(command, "^(m?orph) (%d+)$")
    if cmd and displayId then
        displayId = tonumber(displayId)
        player:SetDisplayId(displayId)
        local query = ("INSERT INTO player_morph_displayids (guid, displayId) VALUES (%d, %d) ON DUPLICATE KEY UPDATE displayId = %d"):format(player:GetGUIDLow(), displayId, displayId)
        CharDBExecute(query)
        return false
    end

    if command:lower() == "demorph" then
        player:DeMorph()
        local deleteQuery = ("DELETE FROM player_morph_displayids WHERE guid = %d"):format(player:GetGUIDLow())
        CharDBExecute(deleteQuery)
        return false
    end

    if command:lower() == "display" then
        local target = player:GetSelection()
        if target then
            local displayId = target:GetDisplayId()
            player:SendBroadcastMessage("Target's Display ID: " .. displayId)
        else
            player:SendBroadcastMessage("No target selected.")
        end
        return false
    end
end

function MorphDisplay.OnPlayerLogin(event, player)
    local guid = player:GetGUIDLow()
    local query = ("SELECT displayId FROM player_morph_displayids WHERE guid = %d"):format(guid)
    local result = CharDBQuery(query)
    
    if result then
        local displayId = result:GetUInt32(0)
        player:SetDisplayId(displayId)
    end
end

RegisterPlayerEvent(42, MorphDisplay.OnCustomCommand)
RegisterPlayerEvent(3, MorphDisplay.OnPlayerLogin)
