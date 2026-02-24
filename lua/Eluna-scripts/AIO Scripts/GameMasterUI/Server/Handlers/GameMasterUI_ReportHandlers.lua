-- GameMaster UI System - Report Handlers
-- This file handles report logging and analytics

local AIO = AIO or require("AIO")

local ReportHandlers = {}

-- Register handlers
function ReportHandlers.RegisterHandlers(GameMasterSystem, Config, Utils, Database, DatabaseHelper)
    -- Log report attempts (optional analytics)
    function GameMasterSystem.LogReportAttempt(player, data)
        if not player or not player:IsGM() then
            return
        end
        
        local title = data.title or "No title"
        local category = data.category or "Unknown"
        local hasDescription = data.hasDescription or false
        
        -- Log to console for server administrators
        print(string.format("[GameMasterUI] Report attempt by %s - Category: %s, Title: %s, Has Description: %s",
            player:GetName(),
            category,
            title,
            tostring(hasDescription)
        ))
        
        -- Optional: Log to database for tracking
        -- You could add database logging here if you want to track report attempts
        -- Example:
        -- CharDBExecute([[
        --     INSERT INTO custom_gm_reports_log (player_guid, player_name, category, title, has_description, timestamp)
        --     VALUES (?, ?, ?, ?, ?, NOW())
        -- ]], player:GetGUIDLow(), player:GetName(), category, title, hasDescription and 1 or 0)
        
        -- Send acknowledgment to player
        AIO.Handle(player, "GameMasterSystem", "ReportLogged", {
            success = true,
            message = "Report attempt logged. Please copy the URL and open in your browser."
        })
    end
end

return ReportHandlers