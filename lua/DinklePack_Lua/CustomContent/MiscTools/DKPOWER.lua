--[[
local DeathKnightPower = {}

DeathKnightPower.CLASS_ID = 6
DeathKnightPower.POWER_TYPES = {
    MANA = 0,
    RAGE = 1,
    FOCUS = 2,
    ENERGY = 3,
    RUNE = 5,
    RUNIC_POWER = 6
}

DeathKnightPower.SPELL_POWER_TYPES = {
    -- [spellId] = powerType
    [2048] = DeathKnightPower.POWER_TYPES.RAGE -- Battle Shout
    -- Add more spells and their power types here
}

function DeathKnightPower.OnPlayerLogin(event, player)
    if player:GetClass() == DeathKnightPower.CLASS_ID then
        for _, powerType in pairs(DeathKnightPower.POWER_TYPES) do
            player:SetPowerType(powerType)
        end
    end
end

function DeathKnightPower.OnPlayerCastSpell(event, player, spell, skipCheck)
    if player:GetClass() == DeathKnightPower.CLASS_ID then
        local runicPower = player:GetPower(DeathKnightPower.POWER_TYPES.RUNIC_POWER)
        player:SetPower(runicPower, DeathKnightPower.POWER_TYPES.RAGE)

        local spellId = spell:GetEntry()
        local spellCost = spell:GetPowerCost()
        local spellPowerType = DeathKnightPower.SPELL_POWER_TYPES[spellId]

        if spellPowerType then
            local currentPower = player:GetPower(spellPowerType)
            player:SetPower(currentPower - spellCost, spellPowerType)
        end
    end
end

RegisterPlayerEvent(3, DeathKnightPower.OnPlayerLogin)
RegisterPlayerEvent(5, DeathKnightPower.OnPlayerCastSpell)
]]