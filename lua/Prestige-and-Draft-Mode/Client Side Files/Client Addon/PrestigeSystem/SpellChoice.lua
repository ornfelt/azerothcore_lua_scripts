-- Create a hidden tooltip for reading spell descriptions
local tooltip = CreateFrame("GameTooltip", "DummyTooltip", UIParent, "GameTooltipTemplate")
local totalDrafts = 0
local rarityTextures = {
  "COMM.tga",  -- Common
  "UNCO.tga",  -- Uncommon
  "RARE.tga",  -- Rare
  "EPIC.tga",  -- Epic
  "LEGE.tga",  -- Legendary
  "BROK.tga",  -- Broken (joke/trap cards?)
}
local lastChoiceTime = 0
local lastChoiceHash = ""
local lastSpellIDs = {}
local dismissToggled = false
local restoringFromDismiss = false
local bannedSpells = {}
local currentSpellRarities = {}
tooltip:SetOwner(UIParent, "ANCHOR_NONE")
GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
GameTooltip:SetFrameStrata("TOOLTIP")
GameTooltip:SetFrameLevel(100)
GameTooltip:SetClampedToScreen(true)
-- Filter out SC:123 whispers from showing in chat
local function SpellChoiceWhisperFilter(_, _, msg)
  if msg:match("^SC:%d+$") or msg:match("^SC_BAN:%d+$") then
    return true
  end
end
local bansLeft = 0
local rerollsLeft = 0
local banMode = false
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", SpellChoiceWhisperFilter)         -- incoming
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", SpellChoiceWhisperFilter) -- outgoing

local unlocked = false -- ← Controlled by server response
local frame = SpellChoiceFrame
SpellChoiceFrame:EnableMouse(true)
SpellChoiceFrame:SetFrameStrata("TOOLTIP")
GameTooltip:SetClampedToScreen(true)
local buttons = {SpellChoiceButton1, SpellChoiceButton2, SpellChoiceButton3}

-- Delay function for 3.3.5
local function Delay(seconds, func)
    local waitFrame = CreateFrame("Frame")
    local total = 0
    waitFrame:SetScript("OnUpdate", function(self, elapsed)
        total = total + elapsed
        if total >= seconds then
            self:SetScript("OnUpdate", nil)
            func()
            self = nil
        end
    end)
end
local function UpdateRerollButton()
  if not SpellChoiceRerollButton then return end
  SpellChoiceRerollButton:SetText("Reroll (" .. rerollsLeft .. ")")

  if rerollsLeft > 0 then
    SpellChoiceRerollButton:Enable()
  else
    SpellChoiceRerollButton:Disable()
  end
end
-- Debug helper
local function Debug(msg)
  --DEFAULT_CHAT_FRAME:AddMessage("|cff9999ff[DEBUG]|r " .. tostring(msg))
end

-- Request prestige status on login/reload
local function RequestPrestigeStatus()
  local target = UnitName("player")
  if target then
    SendChatMessage("SC_CHECK", "WHISPER", nil, UnitName("player"))
    --Debug("Sent SC_CHECK to server")
  else
    print("SpellChoice: Failed to send SC message — player name is nil.")
  end
end

local function HandleSpellClick(self)
  local spellID = self:GetID()
  if not spellID or spellID <= 0 then return end

  if bannedSpells[spellID] then
    Debug("[Ban] Blocked click on banned spell ID: " .. spellID)
    return
  end

  PlaySound("igMainMenuOptionCheckBoxOn")

  if banMode then
    local target = UnitName("player")
    if target then
      SendChatMessage("SC_BAN:" .. spellID, "WHISPER", nil, target)
      Debug("[Ban] Attempting to ban spell ID: " .. spellID)
    end
    return
  end

  -- Selection animation block
  for _, otherBtn in ipairs(buttons) do
    if otherBtn ~= self then
      otherBtn:EnableMouse(false)
      UIFrameFadeOut(otherBtn, 0.5, 1, 0.1)
    else
      otherBtn:SetScale(1.1)
      UIFrameFadeOut(otherBtn, 0.5, 1, 1)
    end
  end

  local target = UnitName("player")
  if target then
    Delay(0.5, function()
      SendChatMessage("SC:" .. spellID, "WHISPER", nil, target)
    end)
  end
end



-- Show spell choices to the player
local function ShowSpellChoices(spellIDs)
  if dismissToggled then
    -- Full suppression: disable everything interactable
    for _, btn in ipairs(buttons) do
      btn:Hide()
      btn:EnableMouse(false)
      btn:SetScript("OnEnter", nil)
      btn:SetScript("OnLeave", nil)
      btn:SetScript("OnClick", nil)
    end

    GameTooltip:Hide()
    GameTooltip:ClearAllPoints()
    GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")

    SpellChoiceFrame:Hide()
    SpellChoiceFrame:EnableMouse(false)
    SpellChoiceFrame:SetAlpha(0)
    return
  end

  --print("SpellChoiceTitle is", SpellChoiceTitle and "found" or "MISSING")
  if not unlocked then
    --Debug("Blocked: Player is not prestiged.")
    return
  end

  -- if UnitLevel("player") == 1 then
  --   Debug("Blocked: Player is level 1. Spell choices disabled.")
  --   return
  -- end

  --Debug("Showing spell choices...")

  for i = 1, #buttons do
    local spellID = tonumber(spellIDs[i])
    local btn = buttons[i]

    if spellID and btn then
      local name, _, icon = GetSpellInfo(spellID)

      btn.icon        = _G[btn:GetName() .. "Icon"]
      btn.name        = _G[btn:GetName() .. "Name"]
      --btn.mana        = _G[btn:GetName() .. "Mana"]
      --btn.castTime    = _G[btn:GetName() .. "CastTime"]
      --btn.description = _G[btn:GetName() .. "Description"]
      btn.levelReq    = _G[btn:GetName() .. "LevelReq"]

      if name and icon then
        Debug("Spell " .. i .. ": " .. name .. " (ID: " .. spellID .. ")")
        -- Force spell to load into cache
        local cacheTooltip = CreateFrame("GameTooltip", "CacheTooltip", UIParent, "GameTooltipTemplate")
        cacheTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        cacheTooltip:SetHyperlink("spell:" .. spellID)
        
      btn:SetID(spellID)
      btn:SetNormalTexture("Interface\\Icons\\" .. icon)
      btn.icon:SetTexture(icon)
      btn.name:SetText(name)

      if bannedSpells[spellID] then
        btn:SetAlpha(0.3)
        btn:Disable()
        btn:EnableMouse(false)
        Debug("[Ban] Auto-disabled banned spell ID: " .. spellID)
      else
        btn:SetAlpha(1)
        btn:Enable()
        btn:EnableMouse(true)
      end


        btn.icon:SetTexture(icon)
        btn.name:SetText(name)
        local rarityFrame = _G[btn:GetName() .. "Rarity"]
        local rarityIndex = currentSpellRarities[i] or -1
        if rarityFrame and rarityIndex >= 0 then
          local rarityTex = rarityTextures[rarityIndex + 1]
          if rarityTex then
            rarityFrame:SetTexture("Interface\\AddOns\\PrestigeSystem\\Textures\\" .. rarityTex)
            rarityFrame:Show()
          else
            rarityFrame:Hide()
          end
        elseif rarityFrame then
          rarityFrame:Hide()
        end
        tooltip:ClearLines()
        tooltip:SetHyperlink("spell:" .. spellID)

        local descriptionLines = {}
        for i = 2, tooltip:NumLines() do
          local line = _G["DummyTooltipTextLeft" .. i]
          local text = line and line:GetText()
          if text and text:find("%S") then
            table.insert(descriptionLines, text)
          end
        end

        --btn.description:SetText(table.concat(descriptionLines, "\n"))
        --btn.levelReq:SetText("Required level: 1")
        if not restoringFromDismiss then
        btn:SetScale(0.8)
        btn:SetAlpha(0)
        UIFrameFadeIn(btn, 0.6, 0, 1)

        -- Pulse animation
        local t = 0
        local pulseSpeed = 10
        local pulseDuration = (2 * math.pi) / pulseSpeed

        btn:SetScript("OnUpdate", function(self, elapsed)
          t = t + elapsed
          if t >= pulseDuration then
            self:SetScript("OnUpdate", nil)
            self:SetScale(1)
          else
            local scale = 1 + 0.05 * math.sin(t * pulseSpeed)
            self:SetScale(scale)
          end
        end)
      else
        btn:SetScale(1)
        btn:SetAlpha(1)
        btn:SetScript("OnUpdate", nil)
      end
        btn:EnableMouse(true)
        btn:Show()
      else
        Debug("Missing data for spell ID: " .. tostring(spellID))
        btn:SetID(0)
        btn.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        btn.name:SetText("Unknown Spell")
        btn.description:SetText("Spell data not cached.")
        btn.levelReq:SetText("")
        btn:EnableMouse(true)
        btn:Show()
        local rarityFrame = _G[btn:GetName() .. "Rarity"]
        if rarityFrame then
          rarityFrame:Hide()
        end
      end
    else
      Debug("Invalid spell or button at index " .. tostring(i))
      if btn then btn:Hide() end
    end
  end

  frame:Show()
end


-- Event listening for addon messages
local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("CHAT_MSG_ADDON")
eventFrame:RegisterEvent("PLAYER_LOGIN")

local statusReceived = false -- Prevent duplicate prestige status handling

eventFrame:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
  if event == "PLAYER_LOGIN" then
    RequestPrestigeStatus()

  elseif event == "CHAT_MSG_ADDON" then
    if prefix == "SpellChoiceStatus" then
      if statusReceived then return end
      statusReceived = true

      if message == "prestiged" then
        unlocked = true
        Debug("SpellChoice unlocked (prestiged).")
      else
        unlocked = false
        Debug("SpellChoice locked (not prestiged).")
      end

    elseif prefix == "SpellChoiceBansLeft" then
      bansLeft = tonumber(message) or 0
      if SpellChoiceBanButton then
        SpellChoiceBanButton:SetText(banMode and ("Ban [ON] (" .. bansLeft .. ")") or ("Ban (" .. bansLeft .. ")"))
      end
  elseif prefix == "SpellChoiceBans" then
    bannedSpells = {}
    for id in string.gmatch(message, "%d+") do
      bannedSpells[tonumber(id)] = true
    end
    Debug("Loaded " .. tostring(table.getn(message)) .. " banned spells from server.")   
  elseif prefix == "SpellChoiceBanAccepted" then
    local bannedID = tonumber(message)
    for _, btn in ipairs(buttons) do
      if btn:GetID() == bannedID then
        btn:SetAlpha(0.3)
        btn:Disable()
        Debug("[Ban] Server confirmed ban of spell ID " .. bannedID)
      end
    end

    -- Immediately refresh with new spell if needed
    local target = UnitName("player")
    if target then
      Delay(0.3, function()
        SendChatMessage("SC_REPLACE_BANNED", "WHISPER", nil, target)
      end)      
      Debug("[Ban] Immediately requested replacement for banned spell ID: " .. bannedID)
    end

  elseif prefix == "SpellChoiceBanDenied" then
      UIErrorsFrame:AddMessage("No bans remaining.", 1.0, 0.2, 0.2, 1)
      Debug("[Ban] Ban denied: no bans left")
    elseif prefix == "SpellChoice" then
      Debug("Received SpellChoice message: " .. message)

      local spellIDs = {}
      for id in string.gmatch(message, "%d+") do
        table.insert(spellIDs, tonumber(id))
      end

      -- Compare to last shown list
      local isDuplicate = #spellIDs == #lastSpellIDs
      if isDuplicate then
        for i = 1, #spellIDs do
          if spellIDs[i] ~= lastSpellIDs[i] then
            isDuplicate = false
            break
          end
        end
      end

      if isDuplicate then
        Debug("Ignored duplicate spellID list.")
        return
      end

      -- If we got here, it's a new set
      lastSpellIDs = spellIDs
      Delay(0.5, function()
        ShowSpellChoices(spellIDs)
      end)
    elseif prefix == "SpellChoiceClose" then
      frame:Hide()

    elseif prefix == "SpellChoiceRerollDenied" then
      UIErrorsFrame:AddMessage("You have no rerolls remaining.", 1, 0, 0, 1)

    elseif prefix == "SpellChoiceRerolls" then
      rerollsLeft = tonumber(message) or 0
      UpdateRerollButton()

    elseif prefix == "SpellChoiceDrafts" then
      local totalDrafts = tonumber(message) or 0
      if SpellChoiceTitle then
        SpellChoiceTitle:SetText("" .. totalDrafts .. " Drafts Remaining")
      end
      if dismissToggled and SpellChoiceDismissButton then
        SpellChoiceDismissButton:SetText(totalDrafts .. " Draft(s) Left")
      end
    elseif prefix == "SpellChoiceRarities" then
      currentSpellRarities = {}
      for r in string.gmatch(message, "-?%d+") do
        table.insert(currentSpellRarities, tonumber(r))
      end
      local rarities = {}
      for r in string.gmatch(message, "-?%d+") do
        table.insert(rarities, tonumber(r))
      end

      for i, rarity in ipairs(rarities) do
        local btn = buttons[i]
        local rarityFrame = _G[btn:GetName() .. "Rarity"]

        if rarity and rarity >= 0 then
          local rarityTex = rarityTextures[rarity + 1]
          if rarityTex and rarityFrame then
            rarityFrame:SetTexture("Interface\\AddOns\\PrestigeSystem\\Textures\\" .. rarityTex)
            rarityFrame:Show()
          elseif rarityFrame then
            rarityFrame:Hide()
          end
        elseif rarityFrame then
          -- Rarity is -1 or invalid (NULL or missing)
          rarityFrame:Hide()
        end
      end
    end
  end
end)

Debug("SpellChoice addon loaded.")

for _, btn in ipairs(buttons) do
  btn:SetScript("OnEnter", function(self)
    local spellID = self:GetID()
    if spellID and spellID > 0 then
      GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
      GameTooltip:SetHyperlink("spell:" .. spellID)
      GameTooltip:Show()
    end
  end)
  btn:SetScript("OnLeave", function(self)
    GameTooltip:Hide()
  end)
btn:SetScript("OnClick", HandleSpellClick)
end



local rerollCooldown = false

SpellChoiceRerollButton:SetScript("OnClick", function()
  PlaySound("igMainMenuOptionCheckBoxOn")
  if rerollCooldown or not unlocked or rerollsLeft <= 0 then
    UIErrorsFrame:AddMessage("Cannot reroll at this time.", 1, 0, 0, 1)
    return
  end

  rerollCooldown = true
  SpellChoiceRerollButton:Disable()

  Delay(0.5, function()
    rerollCooldown = false
    UpdateRerollButton() -- Re-enables if rerollsLeft > 0
  end)

  local target = UnitName("player")
  if target then
    SendChatMessage("SC_REROLL", "WHISPER", nil, target)
  else
    print("SpellChoice: Failed to send SC_REROLL — player name is nil.")
  end
end)
SpellChoiceBanButton = CreateFrame("Button", "SpellChoiceBanButton", SpellChoiceFrame, "UIPanelButtonTemplate")
SpellChoiceBanButton:SetSize(100, 22)
SpellChoiceBanButton:SetText("Ban")
SpellChoiceBanButton:SetPoint("LEFT", SpellChoiceRerollButton, "RIGHT", 10, 0)
SpellChoiceBanButton:SetScript("OnClick", function(self)
  PlaySound("igMainMenuOptionCheckBoxOn")
  banMode = not banMode

  -- Toggle appearance
  if banMode then
    self:SetText("Ban [ON] (" .. bansLeft .. ")")
    SpellChoiceRerollButton:Disable()
    UIErrorsFrame:AddMessage("Ban Mode Activated", 1.0, 0.5, 0.0, 1)
    Debug("[Ban] Mode activated")
  else
    self:SetText("Ban (" .. bansLeft .. ")")
    SpellChoiceRerollButton:Enable()
    Debug("[Ban] Mode deactivated")

    -- Check if any shown spell is banned
    local found = false
    for _, btn in ipairs(buttons) do
      local id = btn:GetID()
      if bannedSpells[id] then
        found = true
        Debug("[Ban] Detected banned spell in current draft: " .. id)
        break
      end
    end

    -- If so, request replacements for just banned ones
    if found then
      local target = UnitName("player")
      if target then
        SendChatMessage("SC_REPLACE_BANNED", "WHISPER", nil, target)
        Debug("[Ban] Requesting replacement for banned spells...")
        SendChatMessage("SC_CHECK", "WHISPER", nil, target)  -- Refresh bans too
        Debug("[Ban] Also re-requesting ban list to clear replaced spell")
      end
    end
  end
end)
SpellChoiceBanButton:Show()
SpellChoiceDismissButton:SetScript("OnClick", function(self)
    PlaySound("igMainMenuOptionCheckBoxOn")
    dismissToggled = not dismissToggled

    if dismissToggled then
        local label = SpellChoiceTitle:GetText() or ""
        local count = label:match("(%d+)") or "0"
        self:SetText(count .. " Draft(s) Left")

        for _, btn in ipairs(buttons) do
            btn:Hide()
            btn:EnableMouse(false)
            btn:SetScript("OnEnter", nil)
            btn:SetScript("OnLeave", nil)
            btn:SetScript("OnClick", nil)
        end

        SpellChoiceTitle:Hide()
        SpellChoiceRerollButton:Hide()
        SpellChoiceFrame:EnableMouse(false)
        SpellChoiceFrame:SetAlpha(0.01)

        self:SetParent(UIParent)
        self:ClearAllPoints()
        self:SetPoint("CENTER", UIParent, "CENTER", 0, -300)
        self:SetFrameStrata("FULLSCREEN_DIALOG")
        self:EnableMouse(true)
        self:Show()

        -- Reset ban state when hidden
        banMode = false
        SpellChoiceBanButton:SetText("Ban")
        SpellChoiceRerollButton:Enable()
        Debug("[Ban] Ban mode reset due to dismissal")
    else
        self:SetText("Dismiss")

        -- Reset ban mode just in case
        banMode = false
        SpellChoiceBanButton:SetText("Ban")
        SpellChoiceRerollButton:Enable()
        Debug("[Ban] Ban mode reset on re-toggle")

        -- Restore full UI state
        if lastSpellIDs and #lastSpellIDs > 0 then
        local target = UnitName("player")
        if target then
          SendChatMessage("SC_CHECK", "WHISPER", nil, target)
          Debug("[Ban] Re-requested banned spell list before restoring UI.")
        end

        restoringFromDismiss = true
        Delay(0.2, function()
          ShowSpellChoices(lastSpellIDs)
          restoringFromDismiss = false
        end)
      end

        SpellChoiceFrame:EnableMouse(true)
        SpellChoiceFrame:SetAlpha(1)
        SpellChoiceFrame:Show()

        for _, btn in ipairs(buttons) do
            btn:EnableMouse(true)
            btn:Show()

            btn:SetScript("OnEnter", function(self)
                local spellID = self:GetID()
                if spellID and spellID > 0 then
                    GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
                    GameTooltip:SetHyperlink("spell:" .. spellID)
                    GameTooltip:Show()
                end
            end)

            btn:SetScript("OnLeave", function(self)
                GameTooltip:Hide()
            end)

            btn:SetScript("OnClick", HandleSpellClick)
        end

        SpellChoiceTitle:Show()
        SpellChoiceRerollButton:Show()

        self:SetParent(SpellChoiceFrame)
        self:ClearAllPoints()
        self:SetPoint("BOTTOM", SpellChoiceTitle, "TOP", 0, -290)
    end
end)



local flash = SpellChoiceFrame:CreateTexture(nil, "OVERLAY")
flash:SetAllPoints(SpellChoiceFrame)
if flash.SetColorTexture then
    flash:SetColorTexture(1, 1, 1)
else
    flash:SetTexture("Interface\\Buttons\\WHITE8x8")
    flash:SetVertexColor(1, 1, 1)
end
flash:SetAlpha(0)
UIFrameFadeIn(flash, 0.1, 0, 0.8)
Delay(0.1, function()
    UIFrameFadeOut(flash, 0.4, 0.8, 0)
end)