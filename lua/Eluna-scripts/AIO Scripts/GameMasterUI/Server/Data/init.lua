-- Initialize GameMasterUI Data modules
-- This file ensures data modules are loaded in the correct order

-- Load EnchantmentData module
local success, err = pcall(function()
    local EnchantmentData = require("GameMasterUI_EnchantmentData")
    _G.EnchantmentData = EnchantmentData
end)

if not success then
    print("[GameMasterUI] ERROR: Failed to load EnchantmentData module: " .. tostring(err))
end

-- Data modules initialization complete