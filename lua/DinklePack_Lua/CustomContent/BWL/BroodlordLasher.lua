local Broodlord = {}

function Broodlord.CastBlastWave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 23331, false)
end

function Broodlord.CastMortalStrike(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 24573, false)
end

function Broodlord.CastKnockAway(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 18670, false)
end

function Broodlord.CastCleave(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 15284, false)
end

function Broodlord.SpawnAdds(eventId, delay, calls, creature)
    local x, y, z, o = creature:GetLocation()
    local add_x, add_y, add_z

    repeat
        add_x = x + math.random(-10, 10)
        add_y = y + math.random(-10, 10)
        add_z = z
    until creature:IsWithinLoS(add_x, add_y, add_z)

    local add = creature:SpawnCreature(12463, add_x, add_y, z, o, 3, 180000)
    local nearestPlayer = add:GetNearestPlayer(100, 1, 1)
    if nearestPlayer then
        add:AttackStart(nearestPlayer)
    end
end


function Broodlord.OnEnterCombat(event, creature, target)
    creature:SendUnitYell("None of your kind should be here! You've doomed only yourselves!", 0)
    creature:RegisterEvent(Broodlord.CastBlastWave, math.random(12000, 18000), 0)
    creature:RegisterEvent(Broodlord.CastMortalStrike, math.random(8000, 11000), 0)
    creature:RegisterEvent(Broodlord.CastKnockAway, math.random(10000, 20000), 0)
    creature:RegisterEvent(Broodlord.CastCleave, math.random(3000, 5000), 0)
    creature:RegisterEvent(Broodlord.SpawnAdds, 40000, 0) 
end

function Broodlord.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function Broodlord.OnTargetDied(event, creature, victim)
    creature:SendUnitYell("The strands of fate are severed!", 0)
end

function Broodlord.OnDied(event, creature, killer)
    creature:SendUnitYell("At last, the long nightmare is over...", 0)
    creature:RemoveEvents()

    local DoorObjectID = 179365
    local doors = creature:GetNearObjects(100, 0, DoorObjectID) -- 5 is the gameobject type
    
    if doors and doors[1] then
        doors[1]:UseDoorOrButton()
    end
end



RegisterCreatureEvent(12017, 1, Broodlord.OnEnterCombat)
RegisterCreatureEvent(12017, 2, Broodlord.OnLeaveCombat)
RegisterCreatureEvent(12017, 3, Broodlord.OnTargetDied)
RegisterCreatureEvent(12017, 4, Broodlord.OnDied)
