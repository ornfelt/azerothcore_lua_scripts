local Gehennas = {}
Gehennas.spellQueue = {}

function Gehennas.CastGehennasCurse(eventId, delay, calls, creature)
    table.insert(Gehennas.spellQueue, {spell = 19716, targetType = 'victim'})
end

function Gehennas.CastRainOfFire(eventId, delay, calls, creature)
    table.insert(Gehennas.spellQueue, {spell = 19717, targetType = 'random', range = 10})
end

function Gehennas.CastShadowBolt(eventId, delay, calls, creature)
    table.insert(Gehennas.spellQueue, {spell = 21077, targetType = 'random', chance = 0.5, range = 10})
end

function Gehennas.CastShadowboltVolley(eventId, delay, calls, creature)
    table.insert(Gehennas.spellQueue, {spell = 27646, targetType = 'victim'})
end

function Gehennas.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Gehennas.spellQueue > 0 then
        local nextSpell = table.remove(Gehennas.spellQueue, 1)
        local target

        if nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'random' then
            local targets = creature:GetAITargets(nextSpell.range or 0)
            if #targets > 0 then
                target = targets[math.random(1, #targets)]
            end
        end

        if target then
            if type(nextSpell.spell) == "table" then
                local spellToCast = nextSpell.spell[1]
                if math.random() <= (nextSpell.chance or 0.5) then
                    spellToCast = nextSpell.spell[2]
                end
                creature:CastSpell(target, spellToCast, true)
            else
                creature:CastSpell(target, nextSpell.spell, true)
            end
        end
    end
end

function Gehennas.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Gehennas.CastGehennasCurse, math.random(25000, 30000), 0)
    creature:RegisterEvent(Gehennas.CastRainOfFire, 6000, 0)
    creature:RegisterEvent(Gehennas.CastShadowBolt, 5000, 0)
    creature:RegisterEvent(Gehennas.CastShadowboltVolley, 15000, 0)
    creature:RegisterEvent(Gehennas.ProcessSpellQueue, 2000, 0)
end

function Gehennas.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
    Gehennas.spellQueue = {}
end

function Gehennas.OnDied(event, creature, killer)
    creature:RemoveEvents()
    Gehennas.spellQueue = {}
end

function Gehennas.OnSpawn(event, creature)
    --creature:SetMaxHealth(648000)
end

RegisterCreatureEvent(12259, 1, Gehennas.OnEnterCombat)
RegisterCreatureEvent(12259, 2, Gehennas.OnLeaveCombat)
RegisterCreatureEvent(12259, 4, Gehennas.OnDied)
RegisterCreatureEvent(12259, 5, Gehennas.OnSpawn)