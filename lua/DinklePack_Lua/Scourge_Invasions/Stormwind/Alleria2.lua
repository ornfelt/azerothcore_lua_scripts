local StormwindAlleria = {}

StormwindAlleria.NPC_ID = 400021
StormwindAlleria.SPELL_IDS = {
    FD = 23604,
    ROOT = 50762,
    DISENGAGE = 57635,
    RAPID_SHOT = 71251,
    MULTI_SHOT = 59713,
    EXPLOSIVE_SHOT = 60053,
    BLACK_ARROW = 63672,
    SHOOT = 39079
}

function StormwindAlleria.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(StormwindAlleria.CastFD, 1, 1)
    creature:RegisterEvent(StormwindAlleria.CastRoot, 10300, 1)
    creature:RegisterEvent(StormwindAlleria.CastDisengage, 10400, 1)
    creature:RegisterEvent(StormwindAlleria.CastRapidShot, 7100, 0)
    creature:RegisterEvent(StormwindAlleria.CastMultiShot, 6100, 0)
    creature:RegisterEvent(StormwindAlleria.CastExplosiveShot, 6600, 0)
    creature:RegisterEvent(StormwindAlleria.CastBlackArrow, 15300, 0)
    creature:RegisterEvent(StormwindAlleria.CastShoot, 499, 0)
    creature:RegisterEvent(StormwindAlleria.ForceDespawn, 90000, 1)
end

function StormwindAlleria.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function StormwindAlleria.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function StormwindAlleria.CastRapidShot(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or creature:IsCasting(StormwindAlleria.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, StormwindAlleria.SPELL_IDS.RAPID_SHOT, true)
    end
end

function StormwindAlleria.CastShoot(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(StormwindAlleria.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, StormwindAlleria.SPELL_IDS.SHOOT, true)
    end
end

function StormwindAlleria.CastMultiShot(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(StormwindAlleria.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, StormwindAlleria.SPELL_IDS.MULTI_SHOT, false)
    end
end

function StormwindAlleria.CastExplosiveShot(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(StormwindAlleria.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, StormwindAlleria.SPELL_IDS.EXPLOSIVE_SHOT, false)
    end
end

function StormwindAlleria.CastBlackArrow(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(StormwindAlleria.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, StormwindAlleria.SPELL_IDS.BLACK_ARROW, false)
    end
end

function StormwindAlleria.CastDisengage(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(StormwindAlleria.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, StormwindAlleria.SPELL_IDS.DISENGAGE, false)
    end
end

function StormwindAlleria.CastFD(event, delay, calls, creature)
    if not creature:IsCasting() or not creature:IsCasting(StormwindAlleria.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(creature, StormwindAlleria.SPELL_IDS.FD, false)
    end
end

function StormwindAlleria.CastRoot(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(StormwindAlleria.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, StormwindAlleria.SPELL_IDS.ROOT, false)
    end
end

function StormwindAlleria.ForceDespawn(event, delay, calls, creature)
    creature:DespawnOrUnsummon(1)
end

RegisterCreatureEvent(StormwindAlleria.NPC_ID, 1, StormwindAlleria.OnEnterCombat)
RegisterCreatureEvent(StormwindAlleria.NPC_ID, 2, StormwindAlleria.OnLeaveCombat)
RegisterCreatureEvent(StormwindAlleria.NPC_ID, 4, StormwindAlleria.OnDied)
