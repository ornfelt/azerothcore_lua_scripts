local Bladestorm = {}

Bladestorm.SPELL_IDS = {
    BLADESTORM = 46924,
    TO_LEARN = 994999,
    TO_UNLEARN = 994999
}

function Bladestorm.OnLearnSpell(event, player, spellId)
    if spellId == Bladestorm.SPELL_IDS.BLADESTORM then
        player:LearnSpell(Bladestorm.SPELL_IDS.TO_LEARN)
    end
end

function Bladestorm.OnTalentsReset(event, player, noCost)
    if player:HasSpell(Bladestorm.SPELL_IDS.TO_UNLEARN) then
        player:RemoveSpell(Bladestorm.SPELL_IDS.TO_UNLEARN)
    end
end

RegisterPlayerEvent(44, Bladestorm.OnLearnSpell)
RegisterPlayerEvent(17, Bladestorm.OnTalentsReset)
