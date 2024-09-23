local ShockwaveManager = {}

ShockwaveManager.SPELLS = {
    SHOCKWAVE = 46968,
    TO_LEARN = 920356,
    TO_UNLEARN = 920356
}

function ShockwaveManager.OnLearnSpell(event, player, spellId)
    if spellId == ShockwaveManager.SPELLS.SHOCKWAVE then
        player:LearnSpell(ShockwaveManager.SPELLS.TO_LEARN)
    end
end

function ShockwaveManager.OnTalentsReset(event, player, noCost)
    if player:HasSpell(ShockwaveManager.SPELLS.TO_UNLEARN) then
        player:RemoveSpell(ShockwaveManager.SPELLS.TO_UNLEARN)
    end
end

RegisterPlayerEvent(44, ShockwaveManager.OnLearnSpell)
RegisterPlayerEvent(17, ShockwaveManager.OnTalentsReset)
