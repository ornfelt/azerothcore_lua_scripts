local AlliancePaladin = {}

AlliancePaladin.NPC_ID = 400030
AlliancePaladin.SPELL_IDS = {
    KINGS = 25898,
    WISDOM = 25918,
    MIGHT = 25916
}

function AlliancePaladin.OnSpawn(event, creature)
    creature:CastSpell(creature, AlliancePaladin.SPELL_IDS.KINGS, true)
end

function AlliancePaladin.OnGossipHello(event, player, creature)
    player:GossipMenuAddItem(9, "|TInterface\\Icons\\spell_magic_magearmor:50:50:-13:0|tGrant me a Blessing of Kings", 0, 1, false, "", 0)
    player:GossipMenuAddItem(9, "|TInterface\\Icons\\spell_holy_sealofwisdom:50:50:-13:0|tGrant me a Blessing of Wisdom", 0, 2, false, "", 0)
    player:GossipMenuAddItem(9, "|TInterface\\Icons\\spell_holy_fistofjustice:50:50:-13:0|tGrant me a Blessing of Might", 0, 3, false, "", 0)
    player:GossipSendMenu(1, creature)
end

function AlliancePaladin.OnGossipSelect(event, player, creature, sender, intid, code, menuid)
    if intid == 1 then
        player:CastSpell(player, AlliancePaladin.SPELL_IDS.KINGS, true)
    elseif intid == 2 then
        player:CastSpell(player, AlliancePaladin.SPELL_IDS.WISDOM, true)
    elseif intid == 3 then
        player:CastSpell(player, AlliancePaladin.SPELL_IDS.MIGHT, true)
    end
    player:GossipComplete()
end

RegisterCreatureEvent(AlliancePaladin.NPC_ID, 5, AlliancePaladin.OnSpawn)
RegisterCreatureGossipEvent(AlliancePaladin.NPC_ID, 1, AlliancePaladin.OnGossipHello)
RegisterCreatureGossipEvent(AlliancePaladin.NPC_ID, 2, AlliancePaladin.OnGossipSelect)
