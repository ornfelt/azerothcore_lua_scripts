-- Initialize GameMasterUI Data modules
-- This file ensures data modules are loaded in the correct order

print("[GameMasterUI] Loading data modules...")

-- Load EnchantmentData module
local success, err = pcall(function()
    local EnchantmentData = require("GameMasterUI_EnchantmentData")
    _G.EnchantmentData = EnchantmentData
    print("[GameMasterUI] EnchantmentData module loaded successfully")
end)

if not success then
    print("[GameMasterUI] ERROR: Failed to load EnchantmentData module: " .. tostring(err))
end

print("[GameMasterUI] Data modules initialization complete")