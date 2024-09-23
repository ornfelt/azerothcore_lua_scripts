local tUndeadWarlord = {}

tUndeadWarlord.NPC_ID = 300018

tUndeadWarlord.CastShadowStrike = function(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 33914, true)
end

tUndeadWarlord.CastFear = function(eventId, delay, calls, creature)
    creature:CastSpell(creature:GetVictim(), 5782, true)
end

tUndeadWarlord.CastSummonSkeleton = function(eventId, delay, calls, creature)
    creature:CastSpell(creature, 59711, true)
end

tUndeadWarlord.enterCombatDialogue = {
    "Your life is forfeit to the Lich King!",
    "The Scourge will devour your soul!",
    "You dare challenge the might of the Scourge?",
    "Your pitiful existence ends here!"
}

tUndeadWarlord.leaveCombatDialogue = {
    "Your cowardice prolongs the inevitable!",
    "The Lich King's grasp reaches far, mortal!",
    "We will meet again, and you will fall!",
    "Your luck will run out soon enough."
}

tUndeadWarlord.killTargetDialogue = {
    "Another soul for the taking!",
    "Your life serves the Scourge now!",
    "You never stood a chance against the Scourge!",
    "Your death only strengthens our ranks."
}

tUndeadWarlord.deathDialogue = {
    "You... How?",
    "I'll be back!",
    "This is not the end!",
    "I'll haunt your dreams!"
}

function tUndeadWarlord.OnEnterCombat(event, creature, target)
    if math.random(100) <= 40 then
        local randomDialogue = tUndeadWarlord.enterCombatDialogue[math.random(4)]
        creature:SendUnitYell(randomDialogue, 0)
    end
    creature:RegisterEvent(tUndeadWarlord.CastShadowStrike, math.random(7000, 9000), 0)
    creature:RegisterEvent(tUndeadWarlord.CastFear, math.random(9500, 13000), 0)
    creature:RegisterEvent(tUndeadWarlord.CastSummonSkeleton, math.random(13500, 17000), 0)
end


function tUndeadWarlord.OnLeaveCombat(event, creature)
    if math.random(100) <= 40 then
        local randomDialogue = tUndeadWarlord.leaveCombatDialogue[math.random(4)]
        creature:SendUnitYell(randomDialogue, 0)
    end
    creature:RemoveEvents()
end

function tUndeadWarlord.OnKilledTarget(event, creature, victim)
    local randomDialogue = tUndeadWarlord.killTargetDialogue[math.random(4)]
    creature:SendUnitYell(randomDialogue, 0)
end

function tUndeadWarlord.OnDied(event, creature, killer)
    local randomDialogue = tUndeadWarlord.deathDialogue[math.random(4)]
    creature:SendUnitYell(randomDialogue, 0)
    creature:CastSpell(creature, 100202, true)
    creature:RemoveEvents()
end

function tUndeadWarlord.OnSpawn(event, creature)
    creature:SetEquipmentSlots(41383, 0 ,0)
    --creature:SetMaxHealth(48420)
    creature:CastSpell(creature:GetVictim(), 17683, true)
    if creature == nil or not creature:IsInWorld() then return end
    creature:SendUnitYell("Quickly servants! The Master expects swift results.", 0)
    creature:CastSpell(creature, 59711, true)
    creature:RegisterEvent(function (eventId, delay, calls, creature)
        if creature == nil or not creature:IsInWorld() then return end
        creature:CastSpell(creature, 59711, true)
    end, 15000, 0)
end

RegisterCreatureEvent(tUndeadWarlord.NPC_ID, 1, tUndeadWarlord.OnEnterCombat)
RegisterCreatureEvent(tUndeadWarlord.NPC_ID, 2, tUndeadWarlord.OnLeaveCombat)
RegisterCreatureEvent(tUndeadWarlord.NPC_ID, 3, tUndeadWarlord.OnKilledTarget)
RegisterCreatureEvent(tUndeadWarlord.NPC_ID, 4, tUndeadWarlord.OnDied)
RegisterCreatureEvent(tUndeadWarlord.NPC_ID, 5, tUndeadWarlord.OnSpawn)
