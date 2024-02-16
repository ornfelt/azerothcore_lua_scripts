local BlessingGiver = {}

BlessingGiver.NPC_ID = 35200
BlessingGiver.SPELL_IDS = {
    BLESSING = 100003,
    SOULSTONE = 20707
}

function BlessingGiver.OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(9, "|TInterface\\Icons\\Spell_Holy_ReviveChampion:50:50:-43:0|tReceive the King's blessing", 0, 1, false, "", 0)
    player:GossipMenuAddItem(9, "|TInterface\\Icons\\inv_misc_orb_04:50:50:-43:0|tReceive a Soulstone", 0, 2, false, "", 0)
    player:GossipSendMenu(1, creature)
end

function BlessingGiver.OnGossipSelect(event, player, creature, sender, intid, code, menuid)
    if intid == 1 then
        player:CastSpell(player, BlessingGiver.SPELL_IDS.BLESSING, true)
    elseif intid == 2 then
        player:CastSpell(player, BlessingGiver.SPELL_IDS.SOULSTONE, true)
    end
    player:GossipComplete()
end

function BlessingGiver.YellDialogue(event, creature)
    creature:SendUnitYell("Adventurers, do not go unprepared! Come speak with me and I will grant you a blessing!", 0)
end

RegisterCreatureGossipEvent(BlessingGiver.NPC_ID, 1, BlessingGiver.OnGossipHello)
RegisterCreatureGossipEvent(BlessingGiver.NPC_ID, 2, BlessingGiver.OnGossipSelect)

-- triggers the yell function on spawn
RegisterCreatureEvent(BlessingGiver.NPC_ID, 5, BlessingGiver.YellDialogue)
