local PRINCE_TENRIS_MIRKBLOOD = 28194 -- The id of Prince Tenris Mirkblood
local BLOOD_MIRROR = 70838
local SUMMON_SANGUINE_SPIRIT = 51280
local SANGUINE_STRIKE = 51285
local BLOOD_SWOOP = 50923

local function CastBloodMirror(eventId, delay, calls, creature)
local raidMembers = creature:GetAITargets(10) -- Get up to 10 raid members
if #raidMembers > 0 then
local targetIndex = math.random(1, #raidMembers)
local randomTarget = raidMembers[targetIndex]
if randomTarget then
creature:CastSpell(randomTarget, BLOOD_MIRROR)
end
end
end

local function CastSanguineSpirit(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), SUMMON_SANGUINE_SPIRIT, true)
end

local function CastSanguineStrike(eventId, delay, calls, creature)
creature:CastSpell(creature:GetVictim(), SANGUINE_STRIKE)
end

local function CastBloodSwoop(eventId, delay, calls, creature)
local raidMembers = creature:GetAITargets(10) -- Get up to 10 raid members
if #raidMembers > 0 then
local targetIndex = math.random(1, #raidMembers)
local randomTarget = raidMembers[targetIndex]
if randomTarget then
creature:CastSpell(randomTarget, BLOOD_SWOOP)
end
end
end

local function OnEnterCombat(event, creature, target)
creature:RegisterEvent(CastBloodMirror, math.random(26000, 42000), 0)
creature:RegisterEvent(CastSanguineSpirit, math.random(3000, 6000), 0)
creature:RegisterEvent(CastSanguineStrike, math.random(11000, 19000), 0)
creature:RegisterEvent(CastBloodSwoop, 23000, 0)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

RegisterCreatureEvent(PRINCE_TENRIS_MIRKBLOOD, 1, OnEnterCombat)
RegisterCreatureEvent(PRINCE_TENRIS_MIRKBLOOD, 2, OnLeaveCombat)
RegisterCreatureEvent(PRINCE_TENRIS_MIRKBLOOD, 4, OnDied)



