local Firemaw = {}
Firemaw.spellQueue = {}

function Firemaw.CastShadowFlame(eventId, delay, calls, creature)
    table.insert(Firemaw.spellQueue, {spell = 22539, targetType = 'victim'})
end

function Firemaw.CastWingBuffet(eventId, delay, calls, creature)
    table.insert(Firemaw.spellQueue, {spell = 23339, targetType = 'victim'})
end

function Firemaw.CastThrash(eventId, delay, calls, creature)
    table.insert(Firemaw.spellQueue, {spell = 3391, targetType = 'victim'})
end

function Firemaw.CastChainLightning(eventId, delay, calls, creature)
    table.insert(Firemaw.spellQueue, {spell = 10605, targetType = 'random'})
end

function Firemaw.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Firemaw.spellQueue > 0 then
        local nextSpell = table.remove(Firemaw.spellQueue, 1)
        local target

        if nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'random' then
            local targets = creature:GetAITargets()
            if #targets > 0 then
                target = targets[math.random(1, #targets)]
            end
        end

        if target then
            creature:CastSpell(target, nextSpell.spell, false)
        end
    end
end


function Firemaw.OnEnterCombat(event, creature, target)
    creature:SendUnitYell("You dare challenge the power of the Black Dragonflight?", 0)
    creature:RegisterEvent(Firemaw.CastShadowFlame, math.random(15000, 19000), 0)
    creature:RegisterEvent(Firemaw.CastWingBuffet, math.random(16000, 18000), 0)
    creature:RegisterEvent(Firemaw.CastThrash, math.random(10000, 15000), 0)
    creature:RegisterEvent(Firemaw.CastChainLightning, math.random(15000, 20000), 0)
    creature:RegisterEvent(Firemaw.ProcessSpellQueue, 1000, 0)
end

function Firemaw.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    Firemaw.spellQueue = {}
end

function Firemaw.OnTargetDied(event, creature, victim)
    creature:SendUnitYell("Feel the wrath of the Black Dragonflight!", 0)
end

function Firemaw.OnDied(event, creature, killer)
    creature:SendUnitYell("My death... changes... nothing...", 0)
    creature:RemoveEvents()
    Firemaw.spellQueue = {}
end

RegisterCreatureEvent(11983, 1, Firemaw.OnEnterCombat)
RegisterCreatureEvent(11983, 2, Firemaw.OnLeaveCombat)
RegisterCreatureEvent(11983, 3, Firemaw.OnTargetDied)
RegisterCreatureEvent(11983, 4, Firemaw.OnDied)
