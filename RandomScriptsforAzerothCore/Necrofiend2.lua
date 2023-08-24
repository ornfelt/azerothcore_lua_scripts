local Necrofiend = {}

function Necrofiend.OnEnterCombat(event, creature, target)
  creature:RegisterEvent(Necrofiend.WebSpray, 12000, 0, creature)
  creature:RegisterEvent(Necrofiend.CastBanefulPoison, 7000, 0, creature)
  creature:RegisterEvent(Necrofiend.DeadlyPoison, 10000, 0, creature)
end

function Necrofiend.WebSpray(event, delay, calls, creature)
  creature:CastSpell(creature:GetVictim(), 55508, true)
end

function Necrofiend.DeadlyPoison(event, delay, calls, creature)
  creature:CastSpell(creature:GetVictim(), 34616, true)
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
  creature:RemoveEvents()
end

RegisterCreatureEvent(11551, 1, Necrofiend.OnEnterCombat)
RegisterCreatureEvent(11551, 2, Necrofiend.OnLeaveCombat)
RegisterCreatureEvent(11551, 4, Necrofiend.OnDied)
