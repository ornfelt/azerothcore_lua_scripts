local undeadDragon = {}

function undeadDragon.OnSpawn(event, creature)
creature:DespawnOrUnsummon(3600000) 
creature:SetMaxHealth(8554119)
creature:CanFly(true)
creature:SetDisableGravity(true)
creature:SetReactState(0)
creature:SetRegeneratingHealth(false)
creature:SendUnitYell("Your warm flesh will freeze under the shadow of my wings!", 0)
creature:PlayDirectSound(20429)
creature:CastSpell(creature, 100151, true)
creature:CastSpell(creature, 17683, true)

creature:RegisterEvent(undeadDragon.CastSpell2, 15000, 0)
creature:RegisterEvent(undeadDragon.CastSpell3, 3500, 0)
creature:RegisterEvent(undeadDragon.CastSpell4, 7000, 0)
creature:RegisterEvent(undeadDragon.CastSpell5, 23000, 0)
creature:RegisterEvent(undeadDragon.CastSpell6, 35000, 0)
creature:RegisterEvent(undeadDragon.CastBlizzard, 5000, 0)
end

function undeadDragon.SpawnCreatureOnDeath(creature)
    local x, y, z, o = creature:GetLocation()
    creature:SpawnCreature(400121, x, y, z, o, 3, 1800000) -- Spawn 400121 for 30 minutes
end



function undeadDragon.OnLeaveCombat(event, creature)
creature:SetRegeneratingHealth(false)
end

function undeadDragon.CastSpell2(event, delay, pCall, creature)
creature:CastSpell(creature:GetVictim(), 58532, true) -- Frostbolt Volley
end

function undeadDragon.CastSpell3(event, delay, pCall, creature)
-- Get all creatures within 100 yards of the undead dragon
local targets = creature:GetAITargets()

-- Filter out creatures with NPC ID 400058
local validTargets = {}
for i, target in pairs(targets) do
if target:GetEntry() ~= 400058 then
table.insert(validTargets, target)
end
end

-- If there are any valid targets, select a random one and cast Frostfire on it
if #validTargets > 0 then
local target = validTargets[math.random(1, #validTargets)]
creature:CastSpell(target, 47610, true)
end
end

function undeadDragon.CastSpell4(event, delay, pCall, creature)
-- Get all creatures with NPC ID 400058 within 100 yards of the undead dragon
local targets = creature:GetCreaturesInRange(100, 400058)
if targets ~= nil then
-- Pick 3 random targets from the list of creatures
for i = 1, math.min(3, #targets) do
local target = targets[math.random(1, #targets)]
-- Cast Frozen Orb on the random target
creature:CastSpell(target, 71285, true)
end
end
end

function undeadDragon.CastSpell5(event, delay, pCall, creature)
-- Get all creatures with NPC ID 400058 within 100 yards of the undead dragon
local targets = creature:GetCreaturesInRange(100, 400058)
if targets ~= nil then
-- Pick 4 random targets from the list of creatures
for i = 1, math.min(3, #targets) do
local target = targets[math.random(1, #targets)]
-- Cast Freeze on the random target
creature:CastSpell(target, 50635, true)
end
end
end

function undeadDragon.CastSpell6(event, delay, pCall, creature)
creature:CastSpell(creature:GetVictim(), 364730, true) -- Whelps
end

function undeadDragon.CastBlizzard(event, delay, pCall, creature)
-- Get all creatures with NPC ID 400058 within 100 yards of the undead dragon
local targets = creature:GetCreaturesInRange(100, 400058)
if targets ~= nil then
-- Pick 3 random targets from the list of creatures
for i = 1, math.min(3, #targets) do
local target = targets[math.random(1, #targets)]
-- Cast Blizzard on the random target
creature:CastSpell(target, 33634, true)
end
end
end


function undeadDragon.OnDeath(event, creature, killer)
	creature:RemoveEvents()
    undeadDragon.SpawnCreatureOnDeath(creature)
end

RegisterCreatureEvent(400035, 5, undeadDragon.OnSpawn)
RegisterCreatureEvent(400035, 2, undeadDragon.OnLeaveCombat)
RegisterCreatureEvent(400035, 4, undeadDragon.OnDeath)