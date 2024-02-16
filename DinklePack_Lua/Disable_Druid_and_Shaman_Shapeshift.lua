FormDisplayModule = {}

FormDisplayModule.enabled = false -- set to true to enable
FormDisplayModule.additionalAurasEnabled = true -- set to true if you want to use a spectral type aura visual instead of the ghost wolf or druid forms

-- enable or disable specific forms
FormDisplayModule.auraConfig = {
    [768] = false,   -- Cat Form
    [5487] = false,  -- Bear Form
    [9634] = false,  -- Dire Bear Form
    [783] = false,   -- Travel Form
    [2645] = false,  -- Ghost Wolf
    [24858] = true,  -- Moonkin Form
    [33891] = true,  -- Tree Form
}

function FormDisplayModule.OnSpellCast(event, player, spell, skipCheck)
    player:RegisterEvent(FormDisplayModule.DisplayChange, 10, 1)
end

function FormDisplayModule.DisplayChange(event, delay, pCall, player)
    local displayId = player:GetDisplayId()
    local PM = player:GetNativeDisplayId()

    local activeForm = (player:GetAura(768) and FormDisplayModule.auraConfig[768]) or
                       (player:GetAura(5487) and FormDisplayModule.auraConfig[5487]) or
                       (player:GetAura(9634) and FormDisplayModule.auraConfig[9634]) or
                       (player:GetAura(783) and FormDisplayModule.auraConfig[783]) or
                       (player:GetAura(2645) and FormDisplayModule.auraConfig[2645]) or
                       (player:GetAura(24858) and FormDisplayModule.auraConfig[24858]) or
                       (player:GetAura(33891) and FormDisplayModule.auraConfig[33891]) -- Added Tree Form

    -- Apply additional auras if enabled and there is an active form
    if FormDisplayModule.additionalAurasEnabled and activeForm then
        player:AddAura(35838, player)
        player:AddAura(22650, player)
    else
        -- Remove additional auras if they are not enabled or there is no active form
        player:RemoveAura(35838)
        player:RemoveAura(22650)
    end

    if activeForm then
        player:SetDisplayId(PM)
    end
end

if FormDisplayModule.enabled then
    RegisterPlayerEvent(5, FormDisplayModule.OnSpellCast)
end
