local LitheStalker = {}

LitheStalker.NPC_ID = 400015
LitheStalker.SPELL_IDS = {
    WHIRLING_TIP = 24048,
    SWEEPING_SLAM = 53399
}

function LitheStalker.CastWhirlingTip(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), LitheStalker.SPELL_IDS.WHIRLING_TIP, true)
end

function LitheStalker.CastSweepingSlam(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), LitheStalker.SPELL_IDS.SWEEPING_SLAM, true)
end

function LitheStalker.OnEnterCombat(event, creature, target)
    if math.random(1, 100) <= 25 then
        creature:SendUnitYell("The Master will have your guts!", 0)
    end
    creature:RegisterEvent(LitheStalker.CastWhirlingTip, 5000, 0)
    creature:RegisterEvent(LitheStalker.CastSweepingSlam, 10000, 0)
end

function LitheStalker.OnLeaveCombat(event, creature)
    if math.random(1, 100) <= 25 then
        creature:SendUnitSay("Mmmm....", 0)
    end
    creature:RemoveEvents()
end

function LitheStalker.OnDied(event, creature, killer)
    if killer:GetObjectType() == "Player" then
        killer:SendBroadcastMessage("You killed " .. creature:GetName() .. "!")
    end
    creature:RemoveEvents()
end

RegisterCreatureEvent(LitheStalker.NPC_ID, 1, LitheStalker.OnEnterCombat)
RegisterCreatureEvent(LitheStalker.NPC_ID, 2, LitheStalker.OnLeaveCombat)
RegisterCreatureEvent(LitheStalker.NPC_ID, 4, LitheStalker.OnDied)
