local UndeadWarlord = {};

local function CastShadowStrike(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 33914, true)
end

local function CastFear(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 5782, true)
end

local function CastSummonSkeleton(eventId, delay, calls, creature)
creature:CastSpell(creature, 59711, true)
end

local enterCombatDialogue = {
"Your life is forfeit to the Lich King!",
"The Scourge will devour your soul!",
"You dare challenge the might of the Scourge?",
"Your pitiful existence ends here!"
}

local leaveCombatDialogue = {
"Your cowardice prolongs the inevitable!",
"The Lich King's grasp reaches far, mortal!",
"We will meet again, and you will fall!",
"Your luck will run out soon enough."
}

local killTargetDialogue = {
"Another soul for the taking!",
"Your life serves the Scourge now!",
"You never stood a chance against the Scourge!",
"Your death only strengthens our ranks."
}

local deathDialogue = {
"You... How?",
"I'll be back!",
"This is not the end!",
"I'll haunt your dreams!"
}

function UndeadWarlord.OnEnterCombat(event, creature, target)
if math.random(100) <= 40 then
local randomDialogue = enterCombatDialogue[math.random(4)]
creature:SendUnitYell(randomDialogue, 0)
end
creature:RegisterEvent(CastShadowStrike, math.random(7000, 9000), 0)
creature:RegisterEvent(CastFear, math.random(9500, 13000), 0)
creature:RegisterEvent(CastSummonSkeleton, math.random(13500, 17000), 0)

end

function UndeadWarlord.OnLeaveCombat(event, creature)
if math.random(100) <= 40 then
local randomDialogue = leaveCombatDialogue[math.random(4)]
creature:SendUnitYell(randomDialogue, 0)
end
creature:RemoveEvents()
end

function UndeadWarlord.OnKilledTarget(event, creature, victim)
local randomDialogue = killTargetDialogue[math.random(4)]
creature:SendUnitYell(randomDialogue, 0)
end


function UndeadWarlord.OnDied(event, creature, killer)
  local randomDialogue = deathDialogue[math.random(4)]
  creature:SendUnitYell(randomDialogue, 0)
  creature:CastSpell(creature, 100202, true)
  creature:RemoveEvents()
end


function UndeadWarlord.OnSpawn(event, creature)
creature:SetMaxHealth(48420)
creature:CastSpell(creature:GetVictim(), 17683, true)
if creature == nil or not creature:IsInWorld() then return end
creature:SendUnitYell("Quickly servants! The Master expects swift results.", 0)
creature:CastSpell(creature, 59711, true)
creature:RegisterEvent(function (eventId, delay, calls, creature)
if creature == nil or not creature:IsInWorld() then return end
creature:CastSpell(creature, 59711, true)
end, 15000, 0)
end

RegisterCreatureEvent(300018, 1, UndeadWarlord.OnEnterCombat)
RegisterCreatureEvent(300018, 2, UndeadWarlord.OnLeaveCombat)
RegisterCreatureEvent(300018, 3, UndeadWarlord.OnKilledTarget)
RegisterCreatureEvent(300018, 4, UndeadWarlord.OnDied)
RegisterCreatureEvent(300018, 5, UndeadWarlord.OnSpawn)



