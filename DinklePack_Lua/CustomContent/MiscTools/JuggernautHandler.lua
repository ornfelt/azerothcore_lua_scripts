local WarriorL = {}

WarriorL.REQUIRED_ITEM_IDS = {60102, 800030}
WarriorL.JUGGERNAUT_SPELL_ID = 100248
WarriorL.EXECUTE_SPELL_IDS = {47471, 47470, 25236, 25234, 20662, 20661, 20660, 20658, 5308}
WarriorL.VANGUARD_DEFENSE_SPELL_ID = 100250
WarriorL.DEVASTATE_SPELL_IDS = {47498, 20243, 30016, 30022, 47497}

function WarriorL.hasRequiredItemEquipped(player)
    for _, itemId in ipairs(WarriorL.REQUIRED_ITEM_IDS) do
        local item = player:GetItemByEntry(itemId)
        if item and item:IsEquipped() then
            return true
        end
    end
    return false
end

function WarriorL.OnAbilityCast(event, player, spell, skipCheck)
    if not WarriorL.hasRequiredItemEquipped(player) then
        return
    end

    local spellId = spell:GetEntry()

    -- Convert EXECUTE_SPELL_IDS and DEVASTATE_SPELL_IDS to sets for fast lookup
    local execute_spell_set = {}
    for _, v in ipairs(WarriorL.EXECUTE_SPELL_IDS) do
        execute_spell_set[v] = true
    end

    local devastate_spell_set = {}
    for _, v in ipairs(WarriorL.DEVASTATE_SPELL_IDS) do
        devastate_spell_set[v] = true
    end

    -- If the spell is not an Execute or Devastate spell, return early
    if not execute_spell_set[spellId] and not devastate_spell_set[spellId] then
        return
    end

    -- Now cast the corresponding spell
    if execute_spell_set[spellId] then
        player:CastSpell(player, WarriorL.JUGGERNAUT_SPELL_ID, true)
    elseif devastate_spell_set[spellId] then
        player:CastSpell(player, WarriorL.VANGUARD_DEFENSE_SPELL_ID, true)
    end
end

RegisterPlayerEvent(5, WarriorL.OnAbilityCast)
