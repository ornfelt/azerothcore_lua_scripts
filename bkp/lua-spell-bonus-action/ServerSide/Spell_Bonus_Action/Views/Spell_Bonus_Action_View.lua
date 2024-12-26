local AIO = AIO or require("AIO")
if AIO.AddAddon() then return end

local Server                        = AIO.AddHandlers("Spell_Bonus_Action", {})
local Spell_Bonus_Action      = { }

function Spell_Bonus_Action.Generate(texture, spell_id)
    if (not Spell_Bonus_Action.Frame) then
        Spell_Bonus_Action.GenerateMainFrame()
    end
    Spell_Bonus_Action.SetTexture(texture)

    Spell_Bonus_Action.GenerateSpellIcon(spell_id)
    Spell_Bonus_Action.GenerateCoolDown(Spell_Bonus_Action.ExtraIcon)
    Spell_Bonus_Action.SetCooldown(Spell_Bonus_Action.ExtraIcon)
end

function Spell_Bonus_Action.GenerateMainFrame()
    Spell_Bonus_Action.Frame = CreateFrame("Frame", "ExtraButtonFrame", UIParent)

    Spell_Bonus_Action.Frame:EnableMouse(true)
    Spell_Bonus_Action.Frame:SetToplevel(true)
    Spell_Bonus_Action.Frame:SetMovable(true)
    Spell_Bonus_Action.Frame:SetClampedToScreen(true)

    Spell_Bonus_Action.Frame:SetSize(250, 120)

    Spell_Bonus_Action.Frame:SetPoint("CENTER")
    Spell_Bonus_Action.Frame:RegisterForDrag("LeftButton")
    Spell_Bonus_Action.Frame:SetScript("OnDragStart", Spell_Bonus_Action.Frame.StartMoving)
    Spell_Bonus_Action.Frame:SetScript("OnHide", Spell_Bonus_Action.Frame.StopMovingOrSizing)
    Spell_Bonus_Action.Frame:SetScript("OnDragStop", Spell_Bonus_Action.Frame.StopMovingOrSizing)

    AIO.SavePosition(Spell_Bonus_Action.Frame)
end

function Spell_Bonus_Action.GenerateSpellIcon(spellId)
    Spell_Bonus_Action.ExtraButtonIcon = CreateFrame("Button", Spell_Bonus_Action.ExtraButtonIcon, Spell_Bonus_Action.Frame, "SecureActionButtonTemplate")
    Spell_Bonus_Action.ExtraButtonIcon:SetSize(50, 50)
    Spell_Bonus_Action.ExtraButtonIcon:SetPoint("Center", 1, 0)

    local _, _, icon, _, _, _, _, _, _ = GetSpellInfo(spellId)
    Spell_Bonus_Action.ExtraButtonIcon:SetFrameLevel(Spell_Bonus_Action.ExtraButtonIcon:GetParent():GetFrameLevel() - 1)
    Spell_Bonus_Action.ExtraButtonIcon:SetNormalTexture(icon)

    Spell_Bonus_Action.ExtraIcon = CreateFrame("Button", Spell_Bonus_Action.ExtraIcon, Spell_Bonus_Action.Frame, "SecureActionButtonTemplate")
    Spell_Bonus_Action.ExtraIcon:SetSize(45, 45)
    Spell_Bonus_Action.ExtraIcon:SetPoint("Center", 0, 0)
    Spell_Bonus_Action.ExtraIcon:SetAttribute("spellId", spellId)
    Spell_Bonus_Action.ExtraIcon:SetFrameLevel(Spell_Bonus_Action.ExtraIcon:GetParent():GetFrameLevel() + 1)

    Spell_Bonus_Action.ExtraIcon:SetScript("OnClick", function()
        AIO.Handle("Spell_Bonus_Action", "Cast", spellId)
    end)

    Spell_Bonus_Action.ExtraIcon:SetScript("OnEnter", function(self, button, down)
        Tooltip:SetOwner(self, "ANCHOR_CURSOR")
        Tooltip:SetHyperlink("spell:" .. spellId)
        Tooltip:Show()
    end)

    Spell_Bonus_Action.ExtraIcon:SetScript("OnLeave", function (self, button, down)
        Tooltip:Hide()
    end)
end

function Spell_Bonus_Action.GenerateCoolDown(parent)
    Spell_Bonus_Action.Cooldown = CreateFrame("Cooldown", Spell_Bonus_Action.Cooldown, parent, "CooldownFrameTemplate")
    Spell_Bonus_Action.Cooldown:SetAllPoints()

    Spell_Bonus_Action.Cooldown:SetCooldown(0, 0)
    Spell_Bonus_Action.Cooldown:Show()

    Spell_Bonus_Action.Cooldown:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    Spell_Bonus_Action.Cooldown:SetScript("OnEvent", function(_, event, ...)
        if (event == "SPELL_UPDATE_COOLDOWN") then
            Spell_Bonus_Action.SetCooldown(parent)
        end

    end)
end

function Spell_Bonus_Action.SetCooldown(parent)
    if (not Spell_Bonus_Action.Cooldown) then
        Spell_Bonus_Action.GenerateCoolDown(parent)
    end

    local start, duration, _ = GetSpellCooldown(parent:GetAttribute("spellId"));
    if (duration and duration > 0) then
        Spell_Bonus_Action.Cooldown:SetCooldown(start, duration)
    else
        Spell_Bonus_Action.Cooldown:SetCooldown(0, 0)
    end
    Spell_Bonus_Action.Cooldown:Show()
end

function Spell_Bonus_Action.SetTexture(texture)
    Spell_Bonus_Action.Texture = Spell_Bonus_Action.Frame:CreateTexture()
    Spell_Bonus_Action.Texture:SetSize(250, 120)
    Spell_Bonus_Action.Texture:SetPoint("CENTER")
    Spell_Bonus_Action.Texture:SetTexture("Interface/extrabutton/" .. texture)
end

function Server.StartCooldown()
    Spell_Bonus_Action.ExtraIcon:SetCooldown(Spell_Bonus_Action.ExtraIcon)
end

function Server.ShowFrame(_, texture, spell_id)
    if (Spell_Bonus_Action.Frame) then
        Spell_Bonus_Action.Frame:Hide()

        Spell_Bonus_Action.Frame = nil
        Spell_Bonus_Action.ExtraIcon = nil
        Spell_Bonus_Action.ExtraButtonIcon = nil
        Spell_Bonus_Action.Cooldown = nil
        Spell_Bonus_Action.Texture = nil
    end

    Spell_Bonus_Action.Generate(texture, spell_id)

    if (not Spell_Bonus_Action.Frame:IsShown()) then
        Spell_Bonus_Action.Frame:Show()
    end
end

function Server.HideFrame(_)
    if (not Spell_Bonus_Action.Frame) then
        return
    end

    Spell_Bonus_Action.Frame:Hide()
end
