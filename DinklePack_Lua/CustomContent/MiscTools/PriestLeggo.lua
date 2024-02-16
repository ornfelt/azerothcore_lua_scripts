local PriestLeggoOne = {}

PriestLeggoOne.AURA_CHECK = 107103
PriestLeggoOne.SPELLS_RENEW_FLASH_HEAL_SMITE = {585, 591, 598, 984, 1004, 10934, 25363, 48122, 48123, 2061, 9472, 9473, 9474, 10915, 10916, 10917, 25233, 25235, 48070, 48071, 10928, 10929}
PriestLeggoOne.SPELLS_MIND_FLAY = {15407, 17311, 17312, 17313, 17314, 18807, 25387, 48155, 48156}
PriestLeggoOne.CHANCE_RENEW_FLASH_HEAL_SMITE = 50
PriestLeggoOne.CHANCE_MIND_FLAY = 50
PriestLeggoOne.SPELL_TO_CAST_RENEW_FLASH_HEAL_SMITE = 107102
PriestLeggoOne.SPELL_TO_CAST_MIND_FLAY = 107101
PriestLeggoOne.COOLDOWN = 10

PriestLeggoOne.playerLastCast = {}

function PriestLeggoOne.IsInTable(value, table)
    for _, v in ipairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

function PriestLeggoOne.OnPlayerCastSpell(event, player, spell, skipCheck)
    if player:HasAura(PriestLeggoOne.AURA_CHECK) then
        local spellEntryId = spell:GetEntry()
        local currentTime = GetGameTime()
        local playerGuid = player:GetGUIDLow()

        if not PriestLeggoOne.playerLastCast[playerGuid] or (currentTime - PriestLeggoOne.playerLastCast[playerGuid]) >= PriestLeggoOne.COOLDOWN then
            if PriestLeggoOne.IsInTable(spellEntryId, PriestLeggoOne.SPELLS_RENEW_FLASH_HEAL_SMITE) then
                if math.random(100) <= PriestLeggoOne.CHANCE_RENEW_FLASH_HEAL_SMITE then
                    player:CastSpell(player, PriestLeggoOne.SPELL_TO_CAST_RENEW_FLASH_HEAL_SMITE, true)
                    PriestLeggoOne.playerLastCast[playerGuid] = currentTime
                end
            elseif PriestLeggoOne.IsInTable(spellEntryId, PriestLeggoOne.SPELLS_MIND_FLAY) then
                if math.random(100) <= PriestLeggoOne.CHANCE_MIND_FLAY then
                    player:CastSpell(player, PriestLeggoOne.SPELL_TO_CAST_MIND_FLAY, true)
                    PriestLeggoOne.playerLastCast[playerGuid] = currentTime
                end
            end
        end
    end
end

RegisterPlayerEvent(5, PriestLeggoOne.OnPlayerCastSpell)
