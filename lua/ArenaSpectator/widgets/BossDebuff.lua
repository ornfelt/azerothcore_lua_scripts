
---------------
-- Range Widget
---------------

-- Offset 10px vertical for centering on Neon

-- Use for prototype
local art = {
    FIRE = "Interface\\Addons\\ArenaSpectator\\Widgets\\BossDebuffWidget\\Fire",
    ICE = "Interface\\Addons\\ArenaSpectator\\Widgets\\BossDebuffWidget\\Ice",
    GREEN = "Interface\\Addons\\ArenaSpectator\\Widgets\\BossDebuffWidget\\Green",
    BOMB = "Interface\\Addons\\ArenaSpectator\\Widgets\\BossDebuffWidget\\Bomb",
    SKULLS = "Interface\\Addons\\ArenaSpectator\\Widgets\\BossDebuffWidget\\Skulls",
}

local function UpdateBossDebuffWidget(self, unit)
        if unit.reaction == "FRIENDLY" then --and unit.type == "PLAYER" then 
            self.Texture:SetTexture(art.FIRE)
            self:Show()
        else self:Hide() end
end

local function CreateBossDebuffWidget(parent)
    local frame = CreateFrame("Frame", nil, parent)
    frame:SetWidth(16); frame:SetHeight(16)
    -- Image
    frame.Texture = frame:CreateTexture(nil, "OVERLAY")
    frame.Texture:SetPoint("CENTER")
    frame.Texture:SetWidth(150)
    frame.Texture:SetHeight(150)
    -- Vars and Mech
    frame:Hide()
    frame.Update = UpdateBossDebuffWidget
    return frame
end

TidyPlatesWidgets.CreateBossDebuffWidget = CreateBossDebuffWidget