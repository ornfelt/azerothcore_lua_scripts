local SylvanasOrgrimmar = {}

SylvanasOrgrimmar.NPC_ID = 400071
SylvanasOrgrimmar.SPELL_IDS = {
    RAPID_SHOT = 71251,
    SHOOT = 39079,
    MULTI_SHOT = 59713,
    EXPLOSIVE_SHOT = 60053,
    BLACK_ARROW = 63672,
    SHADOWSTEP = 58984
}

function SylvanasOrgrimmar.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(SylvanasOrgrimmar.CastRapidShot, 7100, 0)
    creature:RegisterEvent(SylvanasOrgrimmar.CastMultiShot, 6100, 0)
    creature:RegisterEvent(SylvanasOrgrimmar.CastExplosiveShot, 6600, 0)
    creature:RegisterEvent(SylvanasOrgrimmar.CastBlackArrow, 15300, 0)
    creature:RegisterEvent(SylvanasOrgrimmar.CastShoot, 499, 0)
end

function SylvanasOrgrimmar.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function SylvanasOrgrimmar.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function SylvanasOrgrimmar.CastRapidShot(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or creature:IsCasting(SylvanasOrgrimmar.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, SylvanasOrgrimmar.SPELL_IDS.RAPID_SHOT, true)
    end
end

function SylvanasOrgrimmar.CastShoot(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(SylvanasOrgrimmar.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, SylvanasOrgrimmar.SPELL_IDS.SHOOT, true)
    end
end

function SylvanasOrgrimmar.CastMultiShot(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(SylvanasOrgrimmar.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, SylvanasOrgrimmar.SPELL_IDS.MULTI_SHOT, true)
    end
end

function SylvanasOrgrimmar.CastExplosiveShot(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(SylvanasOrgrimmar.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, SylvanasOrgrimmar.SPELL_IDS.EXPLOSIVE_SHOT, true)
    end
end

function SylvanasOrgrimmar.CastBlackArrow(event, delay, calls, creature)
    local victim = creature:GetVictim()
    if not creature:IsCasting() or not creature:IsCasting(SylvanasOrgrimmar.SPELL_IDS.RAPID_SHOT) then
        creature:CastSpell(victim, SylvanasOrgrimmar.SPELL_IDS.BLACK_ARROW, true)
    end
end

function SylvanasOrgrimmar.OnSpawn(event, creature)
    creature:SendUnitSay("Hello Thrall. You didn't think I'd let you have all the fun, did you?", 0)
    creature:CastSpell(creature, SylvanasOrgrimmar.SPELL_IDS.SHADOWSTEP, true)
end

function SylvanasOrgrimmar.OnHealthCheck(event, creature, attacker, damage)
    if (creature:GetHealth() - damage) <= 15 then
        creature:RegisterEvent(SylvanasOrgrimmar.CastShadowstep, 4800, 1)
    end
end

function SylvanasOrgrimmar.CastShadowstep(event, delay, calls, creature)
    creature:CastSpell(creature, SylvanasOrgrimmar.SPELL_IDS.SHADOWSTEP, true)
    creature:CastSpell(creature, SylvanasOrgrimmar.SPELL_IDS.SHADOWSTEP, true)
    creature:SendUnitYell("Thrall...I must be going. Hopefully I thinned enough of the scourge forces for you...now you can handle the rest.", 0)
    creature:DespawnOrUnsummon(5000)
end

RegisterCreatureEvent(SylvanasOrgrimmar.NPC_ID, 9, SylvanasOrgrimmar.OnHealthCheck)
RegisterCreatureEvent(SylvanasOrgrimmar.NPC_ID, 5, SylvanasOrgrimmar.OnSpawn)
RegisterCreatureEvent(SylvanasOrgrimmar.NPC_ID, 1, SylvanasOrgrimmar.OnEnterCombat)
RegisterCreatureEvent(SylvanasOrgrimmar.NPC_ID, 2, SylvanasOrgrimmar.OnLeaveCombat)
RegisterCreatureEvent(SylvanasOrgrimmar.NPC_ID, 4, SylvanasOrgrimmar.OnDied)
