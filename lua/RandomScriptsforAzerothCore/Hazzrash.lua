Hazzrash = {};

function Hazzrash.CastArcaneBarage(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 44425, false)
end

function Hazzrash.CastArcaneBlast(eventId, delay, calls, creature)
local targets = creature:GetAITargets(10)
local target = targets[math.random(#targets)]
creature:CastSpell(target, 30451, false)
end

function Hazzrash.CastChainBurn(eventId, delay, calls, creature)
local targets = creature:GetAITargets(10)
local target = targets[math.random(#targets)]
creature:CastSpell(target, 8211, false)
end

function Hazzrash.CastCrystalFlash(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), 5106, false)
end

function Hazzrash.CastEvocation(eventId, delay, calls, creature)
creature:CastSpell(creature, 30254, true)
creature:RemoveEvents()
creature:RegisterEvent(Hazzrash.ResumeCasts, 20000, 1)
end

function Hazzrash.ResumeCasts(eventId, delay, calls, creature)
creature:RegisterEvent(Hazzrash.CastArcaneBarage, 6000, 0)
creature:RegisterEvent(Hazzrash.CastArcaneBlast, 16000, 0)
creature:RegisterEvent(Hazzrash.CastCrystalFlash, 25000, 0)
creature:RegisterEvent(Hazzrash.CastChainBurn, 29000, 0)
end

function Hazzrash.OnEnterCombat(event, creature, target)
creature:RegisterEvent(Hazzrash.CastArcaneBarage, 6000, 0)
creature:RegisterEvent(Hazzrash.CastArcaneBlast, 18000, 0)
creature:RegisterEvent(Hazzrash.CastCrystalFlash, 25000, 0)
creature:RegisterEvent(Hazzrash.CastChainBurn, 44000, 0)
creature:RegisterEvent(Hazzrash.CastEvocation, 60000, 1)
end

function Hazzrash.OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

function Hazzrash.OnDied(event, creature, killer)
creature:RemoveEvents()
end

function Hazzrash.OnSpawn(event, creature)
creature:SetMaxHealth(563000)
end

RegisterCreatureEvent(83000, 1, Hazzrash.OnEnterCombat)
RegisterCreatureEvent(83000, 2, Hazzrash.OnLeaveCombat)
RegisterCreatureEvent(83000, 4, Hazzrash.OnDied)
RegisterCreatureEvent(83000, 5, Hazzrash.OnSpawn)