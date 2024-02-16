local Flamegor = {}
Flamegor.spellQueue = {}

function Flamegor.CastShadowFlame(eventId, delay, calls, creature)
    table.insert(Flamegor.spellQueue, {spell = 22539, targetType = 'victim'})
end

function Flamegor.CastWingBuffet(eventId, delay, calls, creature)
    table.insert(Flamegor.spellQueue, {spell = 23339, targetType = 'victim'})
end


function Flamegor.CastEnrage(eventId, delay, calls, creature)
    table.insert(Flamegor.spellQueue, {spell = 23342, targetType = 'self'})
end

function Flamegor.CastThrash(eventId, delay, calls, creature)
    table.insert(Flamegor.spellQueue, {spell = 3391, targetType = 'self'})
end

function Flamegor.SpawnShades(eventId, delay, calls, creature)
    local x, y, z, o = creature:GetLocation()

    creature:SpawnCreature(400149, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
    creature:SpawnCreature(400149, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
end

function Flamegor.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Flamegor.spellQueue > 0 then
        local nextSpell = table.remove(Flamegor.spellQueue, 1)
        local target

        if nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'self' then
            target = creature
        end

        if target then
            creature:CastSpell(target, nextSpell.spell, false)
        end
    end
end

function Flamegor.OnEnterCombat(event, creature, target)
    creature:SendUnitYell("You dare challenge the power of the Black Dragonflight?", 0)
    creature:RegisterEvent(Flamegor.CastShadowFlame, math.random(15000, 19000), 0)
    creature:RegisterEvent(Flamegor.CastWingBuffet, math.random(16000, 18000), 0)
    creature:RegisterEvent(Flamegor.CastEnrage, math.random(10000, 15000), 0)
    creature:RegisterEvent(Flamegor.CastThrash, math.random(8000, 12000), 0)
    creature:RegisterEvent(Flamegor.SpawnShades, 45000, 0)
    creature:RegisterEvent(Flamegor.ProcessSpellQueue, 2000, 0)
end

function Flamegor.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    Flamegor.spellQueue = {}
end

function Flamegor.OnTargetDied(event, creature, victim)
    creature:SendUnitYell("Feel the wrath of the Black Dragonflight!", 0)
end

function Flamegor.OnDied(event, creature, killer)
    creature:SendUnitYell("My death... changes... nothing...", 0)
    creature:RemoveEvents()
    Flamegor.spellQueue = {}
end

RegisterCreatureEvent(11981, 1, Flamegor.OnEnterCombat)
RegisterCreatureEvent(11981, 2, Flamegor.OnLeaveCombat)
RegisterCreatureEvent(11981, 3, Flamegor.OnTargetDied)
RegisterCreatureEvent(11981, 4, Flamegor.OnDied)