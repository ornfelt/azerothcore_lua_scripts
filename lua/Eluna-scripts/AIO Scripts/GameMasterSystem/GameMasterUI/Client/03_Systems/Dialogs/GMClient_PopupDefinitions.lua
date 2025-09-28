local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return  -- Exit if on server
end

-- Use existing namespace
local GameMasterSystem = _G.GameMasterSystem
if not GameMasterSystem then
    print("[GameMasterSystem] ERROR: Namespace not found in PopupDefinitions! Check load order.")
    return
end

-- Access shared data and UI references
local GMData = _G.GMData
local GMUI = _G.GMUI
local GMConfig = _G.GMConfig

-- ============================================================================
-- Static Popup Dialogs
-- ============================================================================

-- Player Management Popups

StaticPopupDialogs["GM_GIVE_PLAYER_ITEM"] = {
    text = "Give item to %s:\nEnter Item ID:",
    button1 = "Give",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 200,
    maxLetters = 10,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local itemId = tonumber(self.editBox:GetText())
        if itemId and itemId > 0 then
            -- Default to 1 item, could be extended with quantity dialog
            AIO.Handle("GameMasterSystem", "givePlayerItem", data.name, itemId, 1)
        else
            -- Invalid item ID
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local itemId = tonumber(self:GetText())
        if itemId and itemId > 0 then
            AIO.Handle("GameMasterSystem", "givePlayerItem", data.name, itemId, 1)
        end
        parent:Hide()
    end,
}

StaticPopupDialogs["GM_KICK_PLAYER"] = {
    text = "Kick player %s?\nEnter reason:",
    button1 = "Kick",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 300,
    maxLetters = 100,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local reason = self.editBox:GetText()
        if reason and reason ~= "" then
            AIO.Handle("GameMasterSystem", "kickPlayer", data.name, reason)
        else
            AIO.Handle("GameMasterSystem", "kickPlayer", data.name, "Kicked by GM")
        end
    end,
}

-- Buff/Spell related dialogs

StaticPopupDialogs["GM_APPLY_CUSTOM_BUFF"] = {
    text = "Apply buff to %s:\nEnter Spell ID:",
    button1 = "Apply",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 200,
    maxLetters = 10,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local spellId = tonumber(self.editBox:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "applyBuffToPlayer", data.name, spellId)
        else
            -- Invalid spell ID
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local spellId = tonumber(self:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "applyBuffToPlayer", data.name, spellId)
        end
        parent:Hide()
    end,
}

StaticPopupDialogs["GM_APPLY_BUFF_DURATION"] = {
    text = "Apply buff to %s (Duration: %s):\nEnter Spell ID:",
    button1 = "Apply",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 200,
    maxLetters = 10,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local spellId = tonumber(self.editBox:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", data.name, spellId, data.duration)
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local spellId = tonumber(self:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "playerApplyAuraWithDuration", data.name, spellId, data.duration)
        end
        parent:Hide()
    end,
}

StaticPopupDialogs["GM_PLAYER_CAST_SELF"] = {
    text = "Make %s cast on self:\nEnter Spell ID:",
    button1 = "Cast",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 200,
    maxLetters = 10,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local spellId = tonumber(self.editBox:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "makePlayerCastOnSelf", data.name, spellId)
        else
            -- Invalid spell ID
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local spellId = tonumber(self:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "makePlayerCastOnSelf", data.name, spellId)
        end
        parent:Hide()
    end,
}

StaticPopupDialogs["GM_PLAYER_CAST_TARGET"] = {
    text = "Make %s cast on their target:\nEnter Spell ID:",
    button1 = "Cast",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 200,
    maxLetters = 10,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local spellId = tonumber(self.editBox:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "makePlayerCastOnTarget", data.name, spellId)
        else
            -- Invalid spell ID
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local spellId = tonumber(self:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "makePlayerCastOnTarget", data.name, spellId)
        end
        parent:Hide()
    end,
}

StaticPopupDialogs["GM_CAST_ON_PLAYER"] = {
    text = "Cast spell on %s:\nEnter Spell ID:",
    button1 = "Cast",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 200,
    maxLetters = 10,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local spellId = tonumber(self.editBox:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "castSpellOnPlayer", data.name, spellId)
        else
            -- Invalid spell ID
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local spellId = tonumber(self:GetText())
        if spellId and spellId > 0 then
            AIO.Handle("GameMasterSystem", "castSpellOnPlayer", data.name, spellId)
        end
        parent:Hide()
    end,
}

-- Confirmation dialogs

StaticPopupDialogs["GM_CONFIRM_SUMMON"] = {
    text = "Summon %s to your location?",
    button1 = "Summon",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        AIO.Handle("GameMasterSystem", "summonPlayer", data.name)
    end,
}

StaticPopupDialogs["GM_CONFIRM_APPEAR"] = {
    text = "Appear at %s's location?",
    button1 = "Appear",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        AIO.Handle("GameMasterSystem", "appearAtPlayer", data.name)
    end,
}

StaticPopupDialogs["GM_CONFIRM_REVIVE"] = {
    text = "Revive %s?",
    button1 = "Revive",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        AIO.Handle("GameMasterSystem", "revivePlayer", data.name)
    end,
}

StaticPopupDialogs["GM_CONFIRM_CAST_SPELL_ID"] = {
    text = "Cast %s (ID: %d) on %s?",
    button1 = "Cast",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        if data.spellId and data.targetName then
            AIO.Handle("GameMasterSystem", "castSpellOnPlayer", data.targetName, data.spellId)
        end
    end,
}

StaticPopupDialogs["GM_CONFIRM_KICK"] = {
    text = "Kick %s from the server?",
    button1 = "Kick",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        AIO.Handle("GameMasterSystem", "kickPlayer", data.name, "Kicked by GM")
    end,
}

StaticPopupDialogs["GM_CONFIRM_DELETE_ITEM"] = {
    text = "Delete %s from %s's inventory?\n\n|cffff0000This action cannot be undone!|r",
    button1 = "Delete",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        if data.itemData and data.playerName then
            local slotInfo
            if data.isEquipment then
                slotInfo = tostring(data.itemData.slot)
            else
                slotInfo = string.format("%d:%d", data.itemData.bag, data.itemData.slot)
            end
            AIO.Handle("GameMasterSystem", "deletePlayerItem", data.playerName, slotInfo, data.isEquipment)
        end
    end,
}

-- Item quantity dialog
StaticPopupDialogs["GM_GIVE_ITEM_QUANTITY"] = {
    text = "Give %s to %s\nEnter quantity:",
    button1 = "Give",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 100,
    maxLetters = 6,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        local quantity = tonumber(self.editBox:GetText())
        if quantity and quantity > 0 then
            AIO.Handle("GameMasterSystem", "givePlayerItem", data.playerName, data.itemId, quantity)
            CreateStyledToast(string.format("Gave %dx %s to %s", quantity, data.itemName or "item", data.playerName), 3, 0.5)
        else
            CreateStyledToast("Invalid quantity!", 3, 0.5)
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local quantity = tonumber(self:GetText())
        if quantity and quantity > 0 then
            AIO.Handle("GameMasterSystem", "givePlayerItem", data.playerName, data.itemId, quantity)
            CreateStyledToast(string.format("Gave %dx %s to %s", quantity, data.itemName or "item", data.playerName), 3, 0.5)
        end
        parent:Hide()
    end,
    OnShow = function(self)
        self.editBox:SetText("1")
        self.editBox:HighlightText()
    end,
}

-- Level and XP dialogs
StaticPopupDialogs["GM_SET_PLAYER_LEVEL"] = {
    text = "Set %s's level:\nEnter new level (1-80):",
    button1 = "Set",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 100,
    maxLetters = 2,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local level = tonumber(self.editBox:GetText())
        if level and level >= 1 and level <= 80 then
            AIO.Handle("GameMasterSystem", "setPlayerLevel", data.name, level)
        else
            CreateStyledToast("Invalid level! Must be 1-80", 3, 0.5)
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local level = tonumber(self:GetText())
        if level and level >= 1 and level <= 80 then
            AIO.Handle("GameMasterSystem", "setPlayerLevel", data.name, level)
        end
        parent:Hide()
    end,
}

StaticPopupDialogs["GM_ADD_PLAYER_XP"] = {
    text = "Add XP to %s:\nEnter amount:",
    button1 = "Add",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 150,
    maxLetters = 10,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local xp = tonumber(self.editBox:GetText())
        if xp and xp > 0 then
            AIO.Handle("GameMasterSystem", "givePlayerXP", data.name, xp)
        else
            CreateStyledToast("Invalid XP amount!", 3, 0.5)
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local xp = tonumber(self:GetText())
        if xp and xp > 0 then
            AIO.Handle("GameMasterSystem", "givePlayerXP", data.name, xp)
        end
        parent:Hide()
    end,
}

-- Speed modification dialogs
StaticPopupDialogs["GM_SET_PLAYER_SPEED"] = {
    text = "Set %s's %s speed:\nEnter multiplier (0.1-10):",
    button1 = "Set",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 100,
    maxLetters = 5,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local speed = tonumber(self.editBox:GetText())
        if speed and speed >= 0.1 and speed <= 10 then
            AIO.Handle("GameMasterSystem", "setPlayerSpeed", data.name, data.speedType, speed)
        else
            CreateStyledToast("Invalid speed! Must be 0.1-10", 3, 0.5)
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local speed = tonumber(self:GetText())
        if speed and speed >= 0.1 and speed <= 10 then
            AIO.Handle("GameMasterSystem", "setPlayerSpeed", data.name, data.speedType, speed)
        end
        parent:Hide()
    end,
    OnShow = function(self)
        self.editBox:SetText("1")
        self.editBox:HighlightText()
    end,
}

-- Teleport dialogs
StaticPopupDialogs["GM_TELEPORT_PLAYER"] = {
    text = "Teleport %s to:\nEnter destination name:",
    button1 = "Teleport",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 250,
    maxLetters = 50,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local destination = self.editBox:GetText()
        if destination and destination ~= "" then
            AIO.Handle("GameMasterSystem", "teleportPlayer", data.name, destination)
        else
            CreateStyledToast("Please enter a destination!", 3, 0.5)
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local destination = self:GetText()
        if destination and destination ~= "" then
            AIO.Handle("GameMasterSystem", "teleportPlayer", data.name, destination)
        end
        parent:Hide()
    end,
}

-- Faction change dialog
StaticPopupDialogs["GM_CHANGE_FACTION"] = {
    text = "Change %s's faction to %s?\n\n|cffff0000Warning: This will affect reputation, quests, and more!|r",
    button1 = "Change",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        AIO.Handle("GameMasterSystem", "changePlayerFaction", data.name, data.faction)
    end,
}

-- Race change dialog
StaticPopupDialogs["GM_CHANGE_RACE"] = {
    text = "Change %s's race to %s?\n\n|cffff0000Warning: This may affect appearance and racial abilities!|r",
    button1 = "Change",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        AIO.Handle("GameMasterSystem", "changePlayerRace", data.name, data.race)
    end,
}

-- Rename dialog
StaticPopupDialogs["GM_RENAME_PLAYER"] = {
    text = "Rename %s:\nEnter new name:",
    button1 = "Rename",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 200,
    maxLetters = 12,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local newName = self.editBox:GetText()
        if newName and newName ~= "" and newName:len() >= 2 then
            AIO.Handle("GameMasterSystem", "renamePlayer", data.name, newName)
        else
            CreateStyledToast("Invalid name! Must be at least 2 characters", 3, 0.5)
        end
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local newName = self:GetText()
        if newName and newName ~= "" and newName:len() >= 2 then
            AIO.Handle("GameMasterSystem", "renamePlayer", data.name, newName)
        end
        parent:Hide()
    end,
}

-- Mute dialog
StaticPopupDialogs["GM_MUTE_PLAYER"] = {
    text = "Mute %s for how many minutes?\n(0 for permanent):",
    button1 = "Mute",
    button2 = "Cancel",
    hasEditBox = true,
    editBoxWidth = 100,
    maxLetters = 6,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    OnAccept = function(self, data)
        local duration = tonumber(self.editBox:GetText()) or 0
        AIO.Handle("GameMasterSystem", "mutePlayer", data.name, duration)
    end,
    EditBoxOnEnterPressed = function(self, data)
        local parent = self:GetParent()
        local duration = tonumber(self:GetText()) or 0
        AIO.Handle("GameMasterSystem", "mutePlayer", data.name, duration)
        parent:Hide()
    end,
    OnShow = function(self)
        self.editBox:SetText("5")
        self.editBox:HighlightText()
    end,
}

-- Unmute dialog
StaticPopupDialogs["GM_UNMUTE_PLAYER"] = {
    text = "Unmute %s?",
    button1 = "Unmute",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        AIO.Handle("GameMasterSystem", "unmutePlayer", data.name)
    end,
}

-- Batch action confirmation dialogs
StaticPopupDialogs["CONFIRM_BATCH_SUMMON"] = {
    text = "Summon %d players to your location?",
    button1 = "Summon All",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        if data.action then
            data.action()
        end
    end,
}

StaticPopupDialogs["CONFIRM_BATCH_KICK"] = {
    text = "Kick %d players from the server?",
    button1 = "Kick All",
    button2 = "Cancel",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
    OnAccept = function(self, data)
        if data.action then
            data.action()
        end
    end,
}

-- Debug message
if GMConfig and GMConfig.config and GMConfig.config.debug then
    print("[GameMasterSystem] Popup definitions module loaded")
end