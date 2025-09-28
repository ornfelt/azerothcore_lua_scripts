local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return -- Exit if on server
end

-- Get the shared namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[ERROR] GameMasterSystem namespace not found! Check load order.")
    return
end

-- Get menu system reference
local GMMenus = _G.GMMenus
if not GMMenus then
    print("[ERROR] GMMenus not found! Check load order.")
    return
end

local GMUtils = _G.GMUtils
local GMConfig = _G.GMConfig

-- Common menu item templates
local MenuItems = {
    CANCEL = {
        text = "Cancel",
        func = function() end,
        notCheckable = true,
    },
    
    createTitle = function(text)
        return {
            text = text,
            isTitle = true,
            notCheckable = true,
        }
    end,
    
    createDelete = function(type, entry, handler)
        return {
            text = "Delete",
            func = function()
                if IsControlKeyDown() then
                    handler(entry)
                else
                    GMMenus.showDeleteConfirmation(type, entry)
                end
            end,
            notCheckable = true,
        }
    end,

    createCopyMenu = function(entity)
        local entry = entity.entry or entity.spellID or entity.spellVisualID
        local name = entity.name
        local subMenu = {}

        if entry then
            table.insert(subMenu, {
                text = "Copy ID",
                func = function()
                    GMMenus.copyToClipboard(entry, "ID")
                end,
                notCheckable = true,
            })
        end

        if name then
            table.insert(subMenu, {
                text = "Copy Name",
                func = function()
                    GMMenus.copyToClipboard(name, "Name")
                end,
                notCheckable = true,
            })
        end

        -- For spell visuals, they might have a file path
        if entity.FilePath then
            table.insert(subMenu, {
                text = "Copy FilePath",
                func = function()
                    GMMenus.copyToClipboard(entity.FilePath, "FilePath")
                end,
                notCheckable = true,
            })
        end

        if #subMenu > 0 then
            return {
                text = "Copy",
                hasArrow = true,
                menuList = subMenu,
                notCheckable = true,
            }
        end
    end,
}

-- Export MenuItems for use by other modules
GMMenus.MenuItems = MenuItems

-- Menu items module loaded