local AIO = require("AIO")

-- ===================================
-- UI STYLE LIBRARY SERVER COMPONENT
-- ===================================
-- Minimal server-side component for the UIStyleLibrary
-- Handles any server-side coordination if needed

-- Create AIO handlers namespace
local UIStyleLibraryHandlers = AIO.AddHandlers("UIStyleLibrary", {})

-- Currently no server-side functionality needed for UI library
-- This file exists to maintain AIO pattern consistency
-- Future server-side features can be added here if needed

print("UIStyleLibrary server component loaded.")