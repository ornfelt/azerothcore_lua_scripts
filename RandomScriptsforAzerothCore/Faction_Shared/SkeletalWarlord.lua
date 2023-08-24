local SkeletalWarlord = {}
SkeletalWarlord.minChargeRange = 10

function SkeletalWarlord.OnEnterCombat(event, creature, target)
creature:RegisterEvent(SkeletalWarlord.Whirlwind, 15000, 0)
creature:RegisterEvent(SkeletalWarlord.MortalStrike, 7000, 0)
creature:RegisterEvent(SkeletalWarlord.Charge, 10000, 0)
end

function SkeletalWarlord.Whirlwind(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 36982, true)
end

function SkeletalWarlord.MortalStrike(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 21553, true)
end

function SkeletalWarlord.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function SkeletalWarlord.OnDied(event, creature, killer)
creature:DespawnOrUnsummon(15000)
creature:RemoveEvents()
end

function SkeletalWarlord.Charge(eventId, delay, calls, creature)
  local targets = creature:GetAITargets(SkeletalWarlord.minChargeRange)
  if #targets == 0 then
    return
  end
  local target = targets[math.random(#targets)]
  creature:CastSpell(target, 19471, true)
end



RegisterCreatureEvent(400056, 1, SkeletalWarlord.OnEnterCombat)
RegisterCreatureEvent(400056, 2, SkeletalWarlord.OnLeaveCombat)
RegisterCreatureEvent(400056, 4, SkeletalWarlord.OnDied)


RegisterCreatureEvent(1788, 1, SkeletalWarlord.OnEnterCombat)
RegisterCreatureEvent(1788, 2, SkeletalWarlord.OnLeaveCombat)
RegisterCreatureEvent(1788, 4, SkeletalWarlord.OnDied)



