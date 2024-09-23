local ThrallBlessing = {}

ThrallBlessing.NPC_ID = 400065
ThrallBlessing.BLESSING_SPELL_ID = 100168 -- replace with the first spell ID
ThrallBlessing.SOULSTONE_SPELL_ID = 20707 -- replace with the second spell ID

function ThrallBlessing.OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(9, "|TInterface\\Icons\\achievement_leader_ thrall:50:50:-23:0|tReceive the Warchief's Rage", 0, 1, false, "", 0)
    player:GossipMenuAddItem(9, "|TInterface\\Icons\\inv_misc_orb_04:50:50:-23:0|tReceive a Soulstone", 0, 2, false, "", 0)
    player:GossipSendMenu(1, creature)
end

function ThrallBlessing.OnGossipSelect(event, player, creature, sender, intid, code, menuid)
    if intid == 1 then
        player:CastSpell(player, ThrallBlessing.BLESSING_SPELL_ID, true)
    elseif intid == 2 then
        player:CastSpell(player, ThrallBlessing.SOULSTONE_SPELL_ID, true)
    end
    player:GossipComplete()
end

function ThrallBlessing.YellDialogue(event, creature)
    creature:SendUnitYell("Adventurers, do not go unprepared! Come speak with me and I will grant you the strength you need!", 0)
end

RegisterCreatureGossipEvent(ThrallBlessing.NPC_ID, 1, ThrallBlessing.OnGossipHello)
RegisterCreatureGossipEvent(ThrallBlessing.NPC_ID, 2, ThrallBlessing.OnGossipSelect)
RegisterCreatureEvent(ThrallBlessing.NPC_ID, 5, ThrallBlessing.YellDialogue)
