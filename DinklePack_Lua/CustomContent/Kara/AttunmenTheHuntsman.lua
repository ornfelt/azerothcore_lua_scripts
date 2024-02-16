-- Set this to true to enable the script and false to disable it.
ENABLE_SCRIPT = false

-- Attumen the Huntsman, custom
local NPC_ATTUMEN_THE_HUNTSMAN = 16152
local SPELL_MORTAL_STRIKE = 12294
local SPELL_SHADOW_CLEAVE = 29832
local SPELL_BERSERKER_CHARGE = 26561
local SPELL_INTANGIBLE_PRESENCE = 29833

local AttumenTheHuntsman = {}

function AttumenTheHuntsman.OnEnterCombat(event, creature, target)
    if not ENABLE_SCRIPT then return end

    creature:RegisterEvent(AttumenTheHuntsman.MortalStrike, 5000, 0)
    creature:RegisterEvent(AttumenTheHuntsman.ShadowCleave, 10000, 0)
    creature:RegisterEvent(AttumenTheHuntsman.BerserkerCharge, 15000, 0)
end

function AttumenTheHuntsman.OnLeaveCombat(event, creature)
    if not ENABLE_SCRIPT then return end

    creature:RemoveEvents()
end

function AttumenTheHuntsman.OnDied(event, creature, killer)
    if not ENABLE_SCRIPT then return end

    creature:RemoveEvents()
    creature:SendUnitYell("Ugh, I always knew that someday I would become...the hunted...", 0)
    creature:PlayDirectSound(9165)

    local nearbyCreatures = creature:GetCreaturesInRange(30) -- Find nearby creatures within a range of 30 units
    for _, nearbyCreature in ipairs(nearbyCreatures) do
        if nearbyCreature:GetEntry() == 16151 then -- Check if the nearby creature has NPC ID 16151
            nearbyCreature:RegisterEvent(function(eventId, delay, repeats, creature)
                creature:DespawnOrUnsummon() -- Despawn the nearby creature
            end, 500, 1)
        end
    end
end

function AttumenTheHuntsman.ShadowCleave(event, delay, pCall, creature)
    if not ENABLE_SCRIPT then return end

    if (math.random(1, 100) <= 90) then
        creature:CastSpell(creature:GetVictim(), SPELL_SHADOW_CLEAVE, false)
    end
end

function AttumenTheHuntsman.BerserkerCharge(event, delay, pCall, creature)
    if not ENABLE_SCRIPT then return end

    if (math.random(1, 100) <= 70) then
        local targetCount = creature:GetAITargetsCount()

        if targetCount > 0 then
            local randomTargetIndex = math.random(1, targetCount)
            local targets = creature:GetAITargets()
            local randomTarget = targets[randomTargetIndex]
            local distance = creature:GetDistance(randomTarget)

            if distance >= 8 and distance <= 40 then
                creature:CastSpell(randomTarget, SPELL_BERSERKER_CHARGE, true)
            end
        end
    end
end

function AttumenTheHuntsman.IntangiblePresence(event, delay, pCall, creature)
    if not ENABLE_SCRIPT then return end

    local targetCount = creature:GetAITargetsCount()

    if targetCount > 0 then
		local randomTargetIndex = math.random(1, targetCount)
		local targets = creature:GetAITargets()
		local randomTarget = targets[randomTargetIndex]
		creature:CastSpell(randomTarget, SPELL_INTANGIBLE_PRESENCE, true)
	end
end

if ENABLE_SCRIPT then
    RegisterCreatureEvent(NPC_ATTUMEN_THE_HUNTSMAN, 1, AttumenTheHuntsman.OnEnterCombat)
    RegisterCreatureEvent(NPC_ATTUMEN_THE_HUNTSMAN, 2, AttumenTheHuntsman.OnLeaveCombat)
    RegisterCreatureEvent(NPC_ATTUMEN_THE_HUNTSMAN, 4, AttumenTheHuntsman.OnDied)
end
