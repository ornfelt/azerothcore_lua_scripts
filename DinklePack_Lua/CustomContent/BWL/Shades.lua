local Shades = {}
Shades.spellQueue = {}

function Shades.CastAbility1(eventId, delay, calls, creature)
    table.insert(Shades.spellQueue, {spell = 845, targetType = 'victim'})
end

function Shades.CastAbility2(eventId, delay, calls, creature)
    table.insert(Shades.spellQueue, {spell = 25646, targetType = 'victim'})
end

function Shades.CastOnSpawn(creature)
    creature:CastSpell(creature, 41236, true)
end

function Shades.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Shades.spellQueue > 0 then
        local nextSpell = table.remove(Shades.spellQueue, 1)
        local target

        if nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        end

        if target then
            creature:CastSpell(target, nextSpell.spell, false)
        end
    end
end

function Shades.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Shades.CastAbility1, math.random(5000, 11000), 0)
    creature:RegisterEvent(Shades.CastAbility2, math.random(15000, 20000), 0)
    creature:RegisterEvent(Shades.ProcessSpellQueue, 2000, 0)
end

function Shades.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    Shades.spellQueue = {}
end

function Shades.OnDied(event, creature, killer)
    creature:RemoveEvents()
    Shades.spellQueue = {}
	creature:DespawnOrUnsummon(1000)
end

function Shades.OnSpawn(event, creature)
    Shades.CastOnSpawn(creature)
end

RegisterCreatureEvent(400149, 1, Shades.OnEnterCombat)
RegisterCreatureEvent(400149, 2, Shades.OnLeaveCombat)
RegisterCreatureEvent(400149, 4, Shades.OnDied)
RegisterCreatureEvent(400149, 5, Shades.OnSpawn)
