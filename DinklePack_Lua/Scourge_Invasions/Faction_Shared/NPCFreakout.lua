local FreakedOutNPC = {}

FreakedOutNPC.FREAKOUT_NPC = { 30217, 4981, 483, 5193, 1402, 70021, 1257, 1286, 1285, 3520, 3513, 1432, 1402, 1444, 7917, 1212, 6173, 5489, 4982, 5484, 14500, 14450, 14496, 14497, 6579, 5519, 6007, 29152, 9977, 1395, 2795, 1320, 1318, 1310, 3399, 7010, 5811, 3351, 400062, 400067 }

function FreakedOutNPC.OnEnterCombat(event, creature, target)
    creature:CastSpell(creature, 31358, true) -- fear spell
    local yellOptions = {
        "Aaahhh! Somebody help!",
        "I can't believe this is happening, why is this happening?!",
        "I don't know what to do, I don't know what to do!",
        "No! Stay away from me!",
        "Please, please let this be a nightmare!",
        "I can't handle this, I can't handle this!",
        "No, no, no!",
        "This can't be happening!",
        "I'm not ready for this!",
        "This is insane, how did we get here?!",
        "Why is this happening to me?!",
        "I don't want to die!",
        "I'm not prepared for this, I'm not prepared for this at all!",
        "Please, someone help me!",
        "There's no way this is happening!"
    }
    local randomIndex = math.random(1, 15)
    local selectedYell = yellOptions[randomIndex]
    creature:SendUnitYell(selectedYell, 0)
end

function FreakedOutNPC.RegisterEventForMultipleNpcs(npcIds, event, handler)
    for _, id in ipairs(npcIds) do
        RegisterCreatureEvent(id, event, handler)
    end
end

FreakedOutNPC.RegisterEventForMultipleNpcs(FreakedOutNPC.FREAKOUT_NPC, 1, FreakedOutNPC.OnEnterCombat)
