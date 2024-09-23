local UndeadWarlord = {};

local function CastShadowStrike(eventId, delay, calls, creature)
  creature:CastSpell(creature:GetVictim(), 33914, true)
end

local function CastFear(eventId, delay, calls, creature)
  creature:CastSpell(creature:GetVictim(), 5782, true)
end

local enterCombatDialogue = {
  "Your end has come. I will feast on your bones.",
  "You are no match for me!",
  "Your death will be swift.",
  "You dare challenge me?"
}

local leaveCombatDialogue = {
  "Coward!",
  "You won't escape next time!",
  "I'll be back for more!",
  "You are lucky to leave this place alive."
}

local killTargetDialogue = {
  "Another soul for the taking!",
  "Your life is mine!",
  "You were no match for me!",
  "Your death was inevitable."
}

local deathDialogue = {
  "You... How?",
  "I'll be back!",
  "This is not the end!",
  "I'll haunt your dreams!"
}

function UndeadWarlord.OnEnterCombat(event, creature, target)
  local randomDialogue = enterCombatDialogue[math.random(4)]
  creature:SendUnitYell(randomDialogue, 0)
  creature:RegisterEvent(CastShadowStrike, 5000, 0)
  creature:RegisterEvent(CastFear, 7000, 0)
end

function UndeadWarlord.OnLeaveCombat(event, creature)
  local randomDialogue = leaveCombatDialogue[math.random(4)]
  creature:SendUnitYell(randomDialogue, 0)
  creature:RemoveEvents()
end

function UndeadWarlord.OnKilledTarget(event, creature, victim)
  local randomDialogue = killTargetDialogue[math.random(4)]
  creature:SendUnitYell(randomDialogue, 0)
end

function UndeadWarlord.OnDied(event, creature, killer)
  local randomDialogue = deathDialogue[math.random(4)]
  creature:SendUnitYell(randomDialogue, 0)
  creature:RemoveEvents()
end

function UndeadWarlord.OnSpawn(event, creature)
  creature:SendUnitYell("Quickly servants! The Master expects swift results.", 0)
end

RegisterCreatureEvent(300018, 1, UndeadWarlord.OnEnterCombat)
RegisterCreatureEvent(300018, 2, UndeadWarlord.OnLeaveCombat)
RegisterCreatureEvent(300018, 3, UndeadWarlord.OnKilledTarget)
RegisterCreatureEvent(300018, 4, UndeadWarlord.OnDied)
RegisterCreatureEvent(300018, 5, UndeadWarlord.OnSpawn)