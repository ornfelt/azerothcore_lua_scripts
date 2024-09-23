local Necrofiend = {}

function Necrofiend.OnEnterCombat(event, creature, target)
  creature:RegisterEvent(Necrofiend.WebSpray, 15000, 0, creature)
  creature:RegisterEvent(Necrofiend.CastBanefulPoison, 7000, 0, creature)
  creature:RegisterEvent(Necrofiend.SpecialSpell, 1000, 0, creature)
end

function Necrofiend.SpecialSpell(eventId, delay, calls, creature)
  local victim = creature:GetVictim()
  if not victim then
    return
  end
  if victim:GetEntry() == 32666 or victim:GetEntry() == 32667 or victim:GetEntry() == 31144 or victim:GetEntry() == 31146 then
    creature:CastSpell(victim, 5, true)
  end
end



function Necrofiend.WebSpray(event, delay, calls, creature)
  creature:CastSpell(creature:GetVictim(), 55508, true)
end

function Necrofiend.CastBanefulPoison(event, delay, calls, creature)
  local targets = creature:GetAITargets(10)
  if #targets == 0 then
    return
  end
  local target = targets[math.random(#targets)]
  creature:CastSpell(target, 15475, true)
end

function Necrofiend.OnLeaveCombat(event, creature)
  creature:RemoveEvents()
end

function Necrofiend.OnDied(event, creature, killer)
  creature:DespawnOrUnsummon(5000)
  creature:RemoveEvents()
end

RegisterCreatureEvent(400055, 1, Necrofiend.OnEnterCombat)
RegisterCreatureEvent(400055, 2, Necrofiend.OnLeaveCombat)
RegisterCreatureEvent(400055, 4, Necrofiend.OnDied)
