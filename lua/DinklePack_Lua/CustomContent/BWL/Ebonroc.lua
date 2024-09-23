local Ebonroc = {}
Ebonroc.spellQueue = {}

function Ebonroc.CastShadowFlame(eventId, delay, calls, creature)
    table.insert(Ebonroc.spellQueue, {spell = 22539, targetType = 'victim'})
end

function Ebonroc.CastWingBuffet(eventId, delay, calls, creature)
    table.insert(Ebonroc.spellQueue, {spell = 23339, targetType = 'victim'})
end

function Ebonroc.CastShadowOfEbonroc(eventId, delay, calls, creature)
    table.insert(Ebonroc.spellQueue, {spell = 23340, targetType = 'victim'})
end

function Ebonroc.CastCharredEarth(eventId, delay, calls, creature)
    table.insert(Ebonroc.spellQueue, {spell = 100272, targetType = 'random'})
end

function Ebonroc.CastSummonPlayer(eventId, delay, calls, creature)
    table.insert(Ebonroc.spellQueue, {spell = 20279, targetType = 'random'})
end

function Ebonroc.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Ebonroc.spellQueue > 0 then
        local nextSpell = table.remove(Ebonroc.spellQueue, 1)
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


function Ebonroc.OnEnterCombat(event, creature, target)
    creature:SendUnitYell("You dare challenge the power of the Black Dragonflight?", 0)
    creature:RegisterEvent(Ebonroc.CastShadowFlame, math.random(15000, 19000), 0)
    creature:RegisterEvent(Ebonroc.CastWingBuffet, math.random(16000, 18000), 0)
    creature:RegisterEvent(Ebonroc.CastShadowOfEbonroc, math.random(10000, 15000), 0)
	creature:RegisterEvent(Ebonroc.CastCharredEarth, math.random(15000, 18000), 0)
	creature:RegisterEvent(Ebonroc.CastSummonPlayer, math.random(18000, 20000), 0)
    creature:RegisterEvent(Ebonroc.ProcessSpellQueue, 2000, 0)
end

function Ebonroc.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    Ebonroc.spellQueue = {}
end

function Ebonroc.OnTargetDied(event, creature, victim)
    creature:SendUnitYell("Feel the wrath of the Black Dragonflight!", 0)
end

function Ebonroc.OnDied(event, creature, killer)
    creature:SendUnitYell("My death... changes... nothing...", 0)
    creature:RemoveEvents()
    Ebonroc.spellQueue = {}
end

RegisterCreatureEvent(14601, 1, Ebonroc.OnEnterCombat)
RegisterCreatureEvent(14601, 2, Ebonroc.OnLeaveCombat)
RegisterCreatureEvent(14601, 3, Ebonroc.OnTargetDied)
RegisterCreatureEvent(14601, 4, Ebonroc.OnDied)
