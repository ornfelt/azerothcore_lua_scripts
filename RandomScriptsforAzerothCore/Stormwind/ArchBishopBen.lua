local ABishop = {}

local function CastHolyB(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature:GetVictim(), 59700, false)
end
end

local function CastHolyFire(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature:GetVictim(), 48134, false)
end
end

local function CastSWP(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature:GetVictim(), 27605, false)
end
end

local function CastHV(eventId, delay, calls, creature)
if not creature:IsCasting() then
creature:CastSpell(creature:GetVictim(), 37959, false)
end
end

local function OnEnterCombat(event, creature, target)
creature:PlayDirectSound(20417)
creature:RegisterEvent(CastHolyB, 4600, 0)
creature:RegisterEvent(CastHolyFire, 1500, 0)
creature:RegisterEvent(CastSWP, 15000, 0)
creature:RegisterEvent(CastHV, 25000, 0)

local yellOptions = { "I am the Light's instrument of justice!", "I shall smite the unholy!", "The Light will purify you!", "For the glory of the holy Light!", "In the name of the Light, I will crush you!", "The Light shall guide my every strike!", "You stand no chance against the holy power within me!", "I am the Light's chosen champion!" }
local randomIndex = math.random(1, 8)
local selectedYell = yellOptions[randomIndex]
creature:SendUnitYell(selectedYell, 0)
end

local function OnLeaveCombat(event, creature)
creature:RemoveEvents()
end

local function OnDied(event, creature, killer)
creature:RemoveEvents()
end

function OnSpawn(event, creature)
creature:SetMaxHealth(1321000)
creature:SetMaxPower(0, 13400000)

end

RegisterCreatureEvent(1284, 1, OnEnterCombat)
RegisterCreatureEvent(1284, 2, OnLeaveCombat)
RegisterCreatureEvent(1284, 4, OnDied)
RegisterCreatureEvent(1284, 5, OnSpawn)