local Valthorax = {} -- don't touch
Valthorax.spellQueue = {} -- don't touch
Valthorax.hasCast50PercentAbilities = false -- don't touch
Valthorax.shouldSpawnMinions = true -- Set false to make fight easier by not spawning minions. Abomination will still spawn. 
Valthorax.shouldCast50PercentAbilities = true -- Set false to disable 50% health mechanic


function Valthorax.ToggleSpawnMinions(shouldSpawn)
    Valthorax.shouldSpawnMinions = shouldSpawn
end

function Valthorax.Toggle50PercentAbilities(shouldCast)
    Valthorax.shouldCast50PercentAbilities = shouldCast
end

function Valthorax.DespawnSpecificMinionsInRange(creature, range)
    local minions = creature:GetCreaturesInRange(range)
    for _, minion in pairs(minions) do
        local entry = minion:GetEntry()
        if entry == 400150 or entry == 400151 or entry == 400152 or entry == 400153 or entry == 83020 then
            minion:DespawnOrUnsummon(100)
        end
    end
end

function Valthorax.CastFrostbreath(eventId, delay, calls, creature)
    table.insert(Valthorax.spellQueue, {spell = 21099, targetType = 'victim'})
end

function Valthorax.Enrage(eventId, delay, calls, creature)
    if not creature:HasAura(26662) then 
        creature:CastSpell(creature, 26662, true) -- Casts Enrage
    end
end

function Valthorax.CastShadowBoltVolley(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 20741, true) -- Cast spell with ID 20741 on the target.
end

function Valthorax.GetRandomPlayerTarget(creature)
    local targets = creature:GetAITargets()
    if #targets > 0 then
        return targets[math.random(1, #targets)]
    else
        return nil
    end
end

function Valthorax.CastFrenzy(creature)
    if not creature:HasAura(28468) then  
        creature:CastSpell(creature, 28468, true)
    end
end

function Valthorax.CastNecroticAura(eventId, delay, calls, creature)
	creature:CastSpell(creature, 80030, true)
end

function Valthorax.CastIceboundTomb(eventId, delay, calls, creature)
    -- Cast the spell on the first random player
    table.insert(Valthorax.spellQueue, {spell = 80034, targetType = 'randomPlayer'})
end


function Valthorax.SpawnUndeadMinions(eventId, delay, calls, creature)
    if not Valthorax.shouldSpawnMinions then
        return
    end
    
    local x, y, z, o = creature:GetLocation()

    -- Skeletons, Ghouls, and Banshees are spawned
    creature:SpawnCreature(400150, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
    creature:SpawnCreature(400151, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
    creature:SpawnCreature(400150, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
    creature:SpawnCreature(400151, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
    creature:SpawnCreature(400152, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
    creature:SpawnCreature(400150, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
    creature:SpawnCreature(400151, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
    creature:SpawnCreature(400152, x + math.random(-15, 15), y + math.random(-15, 15), z, o, 2, 600000)
end


function Valthorax.SpawnAbomination(eventId, delay, calls, creature)
    creature:SpawnCreature(400153, -7470.265, -1138.114, 476.534, 3.736, 2, 600000)
	creature:SpawnCreature(83020, -7486.763, -1149.3397, 476.534241, 3.765, 2, 450000)
	creature:SpawnCreature(83020, -7486.763, -1149.3397, 476.534241, 3.765, 2, 450000)
	creature:SpawnCreature(83020, -7461.474, -1107.0505, 476.552216, 5.3, 2, 450000)
	creature:SpawnCreature(83020, -7461.474, -1107.0505, 476.552216, 5.3, 2, 450000)
end


function Valthorax.ProcessSpellQueue(eventId, delay, calls, creature)
    if not creature:IsCasting() and #Valthorax.spellQueue > 0 then
        local nextSpell = table.remove(Valthorax.spellQueue, 1)
        local target

        if nextSpell.targetType == 'victim' then
            target = creature:GetVictim()
        elseif nextSpell.targetType == 'self' then
            target = creature
        elseif nextSpell.targetType == 'randomPlayer' then
            local targets = creature:GetAITargets()
            if #targets > 0 then
                target = targets[math.random(1, #targets)]
            end
        end

        if target then
            creature:CastSpell(target, nextSpell.spell, false)

            -- Notify players if Frost Bomb is being cast
            if nextSpell.spell == 80031 then
                local targets = creature:GetAITargets()
                for _, playerTarget in pairs(targets) do
                    if playerTarget:IsPlayer() then
                        playerTarget:SendNotification("Valthorax begins to cast a devastating spell...")
                    end
                end
            end
        end
    end
end


function Valthorax.OnEnterCombat(event, creature, target)
    creature:SendUnitYell("So bold to disrupt the dealings of the Lich King? You will regret this audacity!", 0)
    creature:RegisterEvent(Valthorax.CastFrostbreath, math.random(15000, 19000), 0)
    creature:RegisterEvent(Valthorax.CastNecroticAura, 60000, 0)
    creature:RegisterEvent(Valthorax.CastIceboundTomb, math.random(19000, 22000), 0)
	creature:RegisterEvent(Valthorax.Enrage, 300000, 1) -- Enrage after 5 minutes
	creature:RegisterEvent(Valthorax.CastNecroticAura, 100, 1)
    creature:RegisterEvent(Valthorax.SpawnUndeadMinions, 35000, 0)
	creature:RegisterEvent(Valthorax.SpawnAbomination, 40000, 0) -- every 40 seconds
    creature:RegisterEvent(Valthorax.SpawnAbomination, 5000, 1) 
	creature:RegisterEvent(Valthorax.CastShadowBoltVolley, 15000, 0)
    creature:RegisterEvent(Valthorax.ProcessSpellQueue, 2000, 0)
end

function Valthorax.OnLeaveCombat(event, creature)
    Valthorax.DespawnSpecificMinionsInRange(creature, 200) -- 200 yd range
    creature:RemoveEvents()
    Valthorax.spellQueue = {}
    Valthorax.hasCast50PercentAbilities = false -- Reset the flag back to false
end

function Valthorax.OnTargetDied(event, creature, victim)
    creature:SendUnitYell("Such a pity...", 0)
end

function Valthorax.OnDied(event, creature, killer)
    creature:SendUnitYell("Master...forgive me...", 0)
    Valthorax.DespawnSpecificMinionsInRange(creature, 200) -- 200 yd range
    creature:RemoveEvents()
    Valthorax.spellQueue = {}
end

function Valthorax.RemoveRoot(eventId, delay, calls, creature)
    creature:RemoveAura(80000)
end

function Valthorax.ClearSpellQueue()
    Valthorax.spellQueue = {}
end

function Valthorax.OnTakeDamage(event, creature, attacker, damage)
    local healthPct = creature:GetHealthPct()
    
    if healthPct <= 15 then
        Valthorax.ClearSpellQueue()
        Valthorax.CastFrenzy(creature)
        creature:SendUnitYell("Feel the true wrath of the Lich King!", 0)
    end
    
if healthPct <= 50 and not Valthorax.hasCast50PercentAbilities and Valthorax.shouldCast50PercentAbilities then
    Valthorax.hasCast50PercentAbilities = true
    -- Clear the spell queue
    Valthorax.ClearSpellQueue()
    
    creature:CastSpell(creature, 80032, true)
    creature:CastSpell(creature, 80033, true)
    -- Add Frost Bomb to spell queue
    table.insert(Valthorax.spellQueue, {spell = 80031, targetType = 'self'})
    
    -- Cast Frost Nova
    creature:CastSpell(creature:GetVictim(), 6131, true)
    
    -- Root in place
    creature:CastSpell(creature, 80000, true)

    -- Yell
    creature:SendUnitYell("I will freeze your very soul!", 0)
    
    -- Schedule removal of root after 15 seconds
    creature:RegisterEvent(Valthorax.RemoveRoot, 15000, 1, creature)
    creature:PlayDirectSound(23983)

    -- Despawn creature with entry ID 400153
    local range = 100 -- Set appropriate range, here I am using 100 as an example
    local minions = creature:GetCreaturesInRange(range)
    for _, minion in pairs(minions) do
        local entry = minion:GetEntry()
        if entry == 400153 then
            minion:DespawnOrUnsummon(100)
        end
    end
end
end



function Valthorax.SetPowerOnSpawn(event, creature)
   -- creature:SetPower(2000000, 0)
end

RegisterCreatureEvent(100184, 1, Valthorax.OnEnterCombat)  
RegisterCreatureEvent(100184, 2, Valthorax.OnLeaveCombat)  
RegisterCreatureEvent(100184, 3, Valthorax.OnTargetDied)   
RegisterCreatureEvent(100184, 4, Valthorax.OnDied) 
RegisterCreatureEvent(100184, 5, Valthorax.SetPowerOnSpawn)        
RegisterCreatureEvent(100184, 9, Valthorax.OnTakeDamage)





