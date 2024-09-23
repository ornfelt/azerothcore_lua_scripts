local BlightedZombie = {} -- unecessary but gives me an easy way to label

function BlightedZombie.OnSpawn(event, creature) -- on spawn event
--creature:SetMaxHealth(17720) -- this was commented out because it interfered with Auto Balance module but it's fine to set health this way.
creature:CastSpell(creature, 17683, true) -- cast spell function. creature targets self, GetVictim targets current target, ie the tank or whatever. True means they cast the spell for free and instantly and can cast other spells simultaneously. 17683 is the spell ID. 17683 is a full heal spell that they cast on themself on spawn
end

function BlightedZombie.OnCombat(event, creature, target) -- These are the timers for the various abilities called when the creature enters combat
creature:RegisterEvent(BlightedZombie.Ability1, 7000, 0) -- uses ability 1 every 7 seconds indefinitely. 0 means indefinitely. If set to 1, they only cast it once.
creature:RegisterEvent(BlightedZombie.Ability2, 14000, 0) -- uses ability 2 every 14 seconds indefinitely.
end

function BlightedZombie.Ability1(event, delay, calls, creature) -- ability 1
creature:CastSpell(creature:GetVictim(), 52476, true) -- targets threat target
end

function BlightedZombie.Ability2(event, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 37597, true) 
end

function BlightedZombie.OnLeaveCombat(event, creature)
creature:RemoveEvents() -- removes events so they don't keep casting out of combat indefinitely
end

function BlightedZombie.OnDeath(event, creature, killer)
    creature:DespawnOrUnsummon(5000) -- removes corpse after 5 seconds
    creature:RemoveEvents() -- removes events so they don't keep casting while dead
end

RegisterCreatureEvent(400051, 1, BlightedZombie.OnCombat) -- 40051 is the creature's creature_template id
RegisterCreatureEvent(400051, 2, BlightedZombie.OnLeaveCombat)
RegisterCreatureEvent(400051, 4, BlightedZombie.OnDeath)
RegisterCreatureEvent(400051, 5, BlightedZombie.OnSpawn)


