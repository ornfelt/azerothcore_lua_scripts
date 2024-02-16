local ABishop = {}

ABishop.NPC_ID = 1284
ABishop.SPELL_IDS = {
    HOLY_B = 59700,
    HOLY_FIRE = 48134,
    SWP = 27605,
    HV = 37959
}

local function CastHolyB(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        creature:CastSpell(creature:GetVictim(), ABishop.SPELL_IDS.HOLY_B, false)
    end
end

local function CastHolyFire(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        creature:CastSpell(creature:GetVictim(), ABishop.SPELL_IDS.HOLY_FIRE, false)
    end
end

local function CastSWP(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        creature:CastSpell(creature:GetVictim(), ABishop.SPELL_IDS.SWP, false)
    end
end

local function CastHV(eventId, delay, calls, creature)
    if not creature:IsCasting() then
        creature:CastSpell(creature:GetVictim(), ABishop.SPELL_IDS.HV, false)
    end
end

function ABishop.OnEnterCombat(event, creature, target)
    --creature:PlayDirectSound(20417)
    creature:RegisterEvent(CastHolyB, 4600, 0)
    creature:RegisterEvent(CastHolyFire, 1500, 0)
    creature:RegisterEvent(CastSWP, 15000, 0)
    creature:RegisterEvent(CastHV, 25000, 0)

    local yellOptions = { "I am the Light's instrument of justice!", "I shall smite the unholy!", "The Light will purify you!", "For the glory of the holy Light!", "In the name of the Light, I will crush you!", "The Light shall guide my every strike!", "You stand no chance against the holy power within me!", "I am the Light's chosen champion!" }
    local randomIndex = math.random(1, 8)
    local selectedYell = yellOptions[randomIndex]
    creature:SendUnitYell(selectedYell, 0)
end

function ABishop.OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

function ABishop.OnDied(event, creature, killer)
    creature:RemoveEvents()
end

function ABishop.OnSpawn(event, creature)
    creature:SetMaxHealth(1321000)
    creature:SetMaxPower(0, 13400000)
end

RegisterCreatureEvent(ABishop.NPC_ID, 1, ABishop.OnEnterCombat)
RegisterCreatureEvent(ABishop.NPC_ID, 2, ABishop.OnLeaveCombat)
RegisterCreatureEvent(ABishop.NPC_ID, 4, ABishop.OnDied)
RegisterCreatureEvent(ABishop.NPC_ID, 5, ABishop.OnSpawn)
