local HunterTalents = {}

HunterTalents.SPELL_IDS = {
    READINESS = 23989,
    LONE_WOLF = 80028,
    CALL_PET = 2641,
    CALL_PET_VANILLA = 883
}

function HunterTalents.OnLearnSpell(event, player, spellId)
    if spellId == HunterTalents.SPELL_IDS.READINESS then
        player:CastSpell(player, HunterTalents.SPELL_IDS.LONE_WOLF, true)
        player:CastSpell(player, HunterTalents.SPELL_IDS.CALL_PET, true)
    end
end

function HunterTalents.OnSpellCast(event, player, spell, skipCheck)
    local spellId = spell:GetEntry()
    if player:HasSpell(HunterTalents.SPELL_IDS.READINESS) then
        if spellId == HunterTalents.SPELL_IDS.CALL_PET_VANILLA then
            if player:HasAura(HunterTalents.SPELL_IDS.LONE_WOLF) then
                player:RemoveAura(HunterTalents.SPELL_IDS.LONE_WOLF)
            end
        elseif spellId == HunterTalents.SPELL_IDS.CALL_PET then
            player:CastSpell(player, HunterTalents.SPELL_IDS.LONE_WOLF, true)
        end
    end
end

function HunterTalents.OnTalentsReset(event, player, noCost)
    if player:HasAura(HunterTalents.SPELL_IDS.LONE_WOLF) then
        player:RemoveAura(HunterTalents.SPELL_IDS.LONE_WOLF)
    end
end

RegisterPlayerEvent(44, HunterTalents.OnLearnSpell)
RegisterPlayerEvent(5, HunterTalents.OnSpellCast)
RegisterPlayerEvent(17, HunterTalents.OnTalentsReset)
