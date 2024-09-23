local Lucifron = {}
Lucifron.enrageCasted = false
Lucifron.castShadowShock = false
Lucifron.castFlamestrike = false
Lucifron.castLucifronCurse = false

function Lucifron.CastImpendingDoom(eventId, delay, calls, creature)
    local targets = creature:GetAITargets()
    local targetCount = creature:GetAITargetsCount()
    local randomTarget = targets[math.random(1, targetCount)]
    creature:CastSpell(randomTarget, 19702, false)
end

function Lucifron.CastLucifronCurse(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 19703, false)
end

function Lucifron.CastShadowShock(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 19460, false)
end

function Lucifron.CastFlamestrike(eventId, delay, calls, creature)
    local targets = creature:GetAITargets()
    local targetCount = creature:GetAITargetsCount()
    local randomTarget = targets[math.random(1, targetCount)]
    creature:CastSpell(randomTarget, 10216, true)
end

function Lucifron.CastChaosNova(eventId, delay, calls, creature)
    creature:SendUnitYell("Your resistance falters, too slow to matter!", 0) 
    creature:CastSpell(creature, 30852, false)
end

function Lucifron.CheckHealth(event, delay, calls, creature)
    if creature:HealthBelowPct(75) and not Lucifron.castShadowShock then
        creature:SendUnitYell("Darkness descends, a shocking truth!", 0)
        creature:RegisterEvent(Lucifron.CastShadowShock, 6000, 0) -- Starts casting Shadow Shock at 75% health
        Lucifron.castShadowShock = true
    elseif creature:HealthBelowPct(50) and not Lucifron.castFlamestrike then
        creature:SendUnitYell("Suffer beneath the molten flames!", 0)
        creature:RegisterEvent(Lucifron.CastFlamestrike, 12000, 0) -- Starts casting Flamestrike at 50% health
        Lucifron.castFlamestrike = true
    elseif creature:HealthBelowPct(35) and not Lucifron.castLucifronCurse then
        creature:SendUnitYell("The shadow of doom approaches!", 0)
        creature:RegisterEvent(Lucifron.CastLucifronCurse, math.random(8000, 12000), 0) -- Starts casting Lucifron Curse at 25% health
        Lucifron.castLucifronCurse = true
    end
end


function Lucifron.OnEnterCombat(event, creature, target)
    creature:RegisterEvent(Lucifron.CastImpendingDoom, 20000, 0) -- Cast Impending Doom every 12 seconds
    creature:RegisterEvent(Lucifron.CastChaosNova, 180000, 0) -- Added new ability: Chaos Nova
    creature:RegisterEvent(Lucifron.CheckHealth, 1000, 0) -- Check health every second to update abilities
end

function Lucifron.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Lucifron.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function Lucifron.OnDamageTaken(event, creature, attacker, damage)
    if(not Lucifron.enrageCasted and creature:HealthBelowPct(10)) then -- Enrage triggers at 30% health
        creature:CastSpell(creature, 38166, true)
        Lucifron.enrageCasted = true
    end
end

function Lucifron.OnSpawn(event, creature)
    --creature:SetMaxHealth(748000 * 1.25) -- Increase health pool by 25%
end

RegisterCreatureEvent(12118, 1, Lucifron.OnEnterCombat)
RegisterCreatureEvent(12118, 2, Lucifron.OnLeaveCombat)
RegisterCreatureEvent(12118, 4, Lucifron.OnDied)
RegisterCreatureEvent(12118, 9, Lucifron.OnDamageTaken)
RegisterCreatureEvent(12118, 5, Lucifron.OnSpawn)
