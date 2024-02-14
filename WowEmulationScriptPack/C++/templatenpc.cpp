// Template NPC
// Smolderforge
// Template by Robin

#include "ScriptPCH.h"
#include "beastmaster.h"

void AddTrinketTabardShirt(Player *player)
{
    // general defines
    uint32 trinketHorde = 37865;
    uint32 trinketAlly  = 37864;
    uint32 guildtabard  = 5976;
    uint32 shirt        = 4333;

    if (player->GetTeam() == HORDE)
        player->StoreNewItemInBestSlots(trinketHorde, 1);
    else
        player->StoreNewItemInBestSlots(trinketAlly, 1);

    //player->StoreNewItemInBestSlots(guildtabard, 1);
    player->StoreNewItemInBestSlots(shirt, 1);
}

void AddEnchantment(Player *player, Item *item, uint32 enchantId)
{
    if (!player || !item || !enchantId)
        return;
    
    // remove old enchanting before applying new if equipped
    player->ApplyEnchantment(item, PERM_ENCHANTMENT_SLOT, false);
    item->SetEnchantment(PERM_ENCHANTMENT_SLOT, enchantId, 0, 0);
    
    // add new enchanting if equipped
    player->ApplyEnchantment(item, PERM_ENCHANTMENT_SLOT, true);
}

void AddSocket(Player *player, Item *item, uint32 enchantId_1, uint32 enchantId_2, uint32 enchantId_3)
{
    if (!player || !item)
        return;

    //remove ALL enchants
    for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT+3; ++enchant_slot)
        player->ApplyEnchantment(item, EnchantmentSlot(enchant_slot), false);

    if (enchantId_1)
        item->SetEnchantment(EnchantmentSlot(SOCK_ENCHANTMENT_SLOT), enchantId_1, 0, 0);
    if (enchantId_2)
        item->SetEnchantment(EnchantmentSlot(SOCK_ENCHANTMENT_SLOT_2), enchantId_2, 0, 0);
    if (enchantId_3)
        item->SetEnchantment(EnchantmentSlot(SOCK_ENCHANTMENT_SLOT_3), enchantId_3, 0, 0);

    for (uint32 enchant_slot = SOCK_ENCHANTMENT_SLOT; enchant_slot < SOCK_ENCHANTMENT_SLOT+3; ++enchant_slot)
        player->ApplyEnchantment(item, EnchantmentSlot(enchant_slot), true);
}

void AddItemsEnchantsGemsTalents(Player* player, uint32 items[], uint32 sockets[][3], uint32 enchants[], uint32 talents[], uint32 itemsCount, uint32 talentsCount)
{
    // wipe talents without confirmation
    player->resetTalents(true);

    // learn talents from array
    for (uint32 talent_i = 0; talent_i < talentsCount; talent_i++)
    {
        player->learnSpell(talents[talent_i]);
        player->addTalent(talents[talent_i], player->GetActiveSpec(), true);
    }

    // remove all talents points
    player->SetFreeTalentPoints(0);

    // add items and equipt it
    for (uint32 i = 0; i < itemsCount; i++)
        player->StoreNewItemInBestSlots(items[i], 1);

    // add socket to items
    for (int i_slot = EQUIPMENT_SLOT_START; i_slot < EQUIPMENT_SLOT_END; i_slot++)
    {
        Item *itemTarget = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i_slot);

        if (sockets[i_slot][0] || sockets[i_slot][1] || sockets[i_slot][2]) // if there is at least 1 gem
            AddSocket(player, itemTarget, sockets[i_slot][0], sockets[i_slot][1], sockets[i_slot][2]);

        AddEnchantment(player, itemTarget, enchants[i_slot]);

        if (i_slot >= INVENTORY_SLOT_BAG_END || !itemTarget)
            continue;

        ItemPrototype const *proto = itemTarget->GetProto();

        player->ApplyEnchantment(itemTarget,BONUS_ENCHANTMENT_SLOT, false);
        itemTarget->SetEnchantment(BONUS_ENCHANTMENT_SLOT, proto->socketBonus, 0, 0);
        player->ApplyEnchantment(itemTarget, BONUS_ENCHANTMENT_SLOT, true);
    }

    player->ToggleMetaGemsActive(23, true); // 23 is INVENTORY_SLOT_ITEM_1, not defined in oregon anymore

    // add trinkets tabard and shirt from function
    AddTrinketTabardShirt(player);

    player->ResetAllPowers(); // set health, mana, etc. to full
}

bool GossipHello_npc_template(Player *player, Creature *creature)
{
    if (creature->isQuestGiver())
        player->PrepareQuestMenu(creature->GetGUID());

    player->ADD_GOSSIP_ITEM(0, "Equip all my items, enchants, gems and spec my talents please.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

    player->SEND_GOSSIP_MENU(9, creature->GetGUID());
    return true;
}

bool GossipSelect_npc_template(Player *player, Creature *creature, uint32 sender, uint32 action)
{
    uint32 itemsCount = 0;
    uint32 talentsCount = 0;

    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
        {
            // check if player has item equipped
            for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
            {
                Item *itemTarget = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);

                if (itemTarget)
                {
                    player->GetSession()->SendNotification("You must unequip all items first.");
                    player->CLOSE_GOSSIP_MENU();
                    return true;
                }
            }

            // check if player is in bg queue
            if (player->InBattleGroundQueue())
            {
                player->GetSession()->SendNotification("You must leave all queues before resetting talents");
                return true;
            }

            switch (player->getClass())
            {
                case CLASS_WARRIOR:
                    player->ADD_GOSSIP_ITEM(0, "Arms (Axe)", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 101);
                    player->ADD_GOSSIP_ITEM(0, "Arms (Mace)", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 102);
                    player->ADD_GOSSIP_ITEM(0, "Arms (Sword)", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 103);
                    break;
                case CLASS_PALADIN:
                    player->ADD_GOSSIP_ITEM(0, "Holy", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 201);
                    player->ADD_GOSSIP_ITEM(0, "Shockadin", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 202);
                    player->ADD_GOSSIP_ITEM(0, "Retribution", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 203);
                    break;
                case CLASS_HUNTER:
                    player->ADD_GOSSIP_ITEM(0, "Beastmastery", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 301);
                    player->ADD_GOSSIP_ITEM(0, "Marksmanship", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 302);
                    player->ADD_GOSSIP_ITEM(0, "Survival", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 303);
                    break;
                case CLASS_ROGUE:
                    player->ADD_GOSSIP_ITEM(0, "Assassination (Mutilate)", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 401);
                    player->ADD_GOSSIP_ITEM(0, "Subtlety (Hemorrhage)", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 403);
                    break;
                case CLASS_PRIEST:
                    player->ADD_GOSSIP_ITEM(0, "Discipline / Holy", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 501);
                    player->ADD_GOSSIP_ITEM(0, "Shadow", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 502);
                    break;
                case CLASS_SHAMAN:
                    player->ADD_GOSSIP_ITEM(0, "Elemental", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 601);
                    player->ADD_GOSSIP_ITEM(0, "Enhancement", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 602);
                    player->ADD_GOSSIP_ITEM(0, "Restoration", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 603);
                    break;
                case CLASS_MAGE:
                    //player->ADD_GOSSIP_ITEM(0, "Arcane/Fire (PoM/Pyro)", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 701);
                    player->ADD_GOSSIP_ITEM(0, "Fire", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 702);
                    player->ADD_GOSSIP_ITEM(0, "Frost", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 703);
                    break;
                case CLASS_WARLOCK:
                    player->ADD_GOSSIP_ITEM(0, "Affliction", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 801);
                    player->ADD_GOSSIP_ITEM(0, "Demonology", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 802);
                    player->ADD_GOSSIP_ITEM(0, "SL/SL", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 803);
                    player->ADD_GOSSIP_ITEM(0, "Destruction", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 804);
                    break;
                case CLASS_DRUID:
                    player->ADD_GOSSIP_ITEM(0, "Balance", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 901);
                    player->ADD_GOSSIP_ITEM(0, "Feral Combat", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 902);
                    player->ADD_GOSSIP_ITEM(0, "Restoration", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 904);
                    player->ADD_GOSSIP_ITEM(0, "Restokin", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 905);
                    break;
            }
            player->SEND_GOSSIP_MENU(60, creature->GetGUID());
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 101: // Warrior - Arms (Axe - 100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {30488, 33923, 30490, 33484, 30486, 33813, 30487, 33331, 30489, 33812, 33919, 33057, 29383, 31966, 32054}; // item ids
            uint32 itemsCount = 15; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3003, 0, 2986, 0, 2933, 0, 3012, 2658, 2647, 684, 2931, 2931, 0, 0, 368, 3225, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2829, 3139, 0 },
                { 3139, 0 , 0},
                { 3115, 3139, 0},
                { 0, 0, 0 },
                { 3115, 3115, 3139},
                { 3115, 3115, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3139, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {16466, 12962, 12963, 12867, 12712, 16494, 12292, 12785, 29889, 12668, 29859, 12294, 29838, 12856, 12838, 12322, 12323, 16492, 13048, 12328, 20505, 12677};
            talentsCount = 22; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 102: // Warrior - Arms (Mace - 100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {30488, 33923, 30490, 33484, 30486, 33813, 30487, 33331, 30489, 33812, 33919, 33057, 29383, 31959, 32054}; // item ids
            uint32 itemsCount = 15; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3003, 0, 2986, 0, 2933, 0, 3012, 2658, 2647, 684, 2931, 2931, 0, 0, 368, 3225, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2829, 3139, 0 },
                { 3139, 0 , 0},
                { 3115, 3139, 0},
                { 0, 0, 0 },
                { 3115, 3115, 3139},
                { 3115, 3115, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3139, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {16466, 12962, 12963, 12867, 12712, 16494, 12292, 12704, 29889, 12668, 29859, 12294, 29838, 12856, 12838, 12322, 12323, 16492, 13048, 12328, 20505, 12677};
            talentsCount = 22; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 103: // Warrior - Arms (Sword - 100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {30488, 33923, 30490, 33484, 30486, 33813, 30487, 33331, 30489, 33812, 33919, 33057, 29383, 31984, 32054}; // item ids
            uint32 itemsCount = 15; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3003, 0, 2986, 0, 2933, 0, 3012, 2658, 2647, 684, 2931, 2931, 0, 0, 368, 3225, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2829, 3139, 0 },
                { 3139, 0 , 0},
                { 3115, 3139, 0},
                { 0, 0, 0 },
                { 3115, 3115, 3139},
                { 3115, 3115, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3139, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {16466, 12962, 12963, 12867, 12712, 16494, 12292, 12815, 29889, 12668, 29859, 12294, 29838, 12856, 12838, 12322, 12323, 16492, 13048, 12328, 20505, 12677};
            talentsCount = 22; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 201: // Paladin - Holy (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32022, 33922, 32024, 33333, 32020, 33904, 32021, 33903, 33518, 33905, 33918, 33064, 34471, 30108, 33309, 33077}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3004, 0, 2980, 0, 2933, 0, 2746, 2940, 2617, 2322, 2930, 2930, 0, 0, 2664, 2343, 3229, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2835, 3138, 0 },
                { 3141, 0 , 0},
                { 3138, 3141, 0},
                { 0, 0, 0 },
                { 3138, 3138, 3141},
                { 0, 0, 0 },
                { 3138, 3141, 3138 },
                { 0, 0, 0 },
                { 3141, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {20261, 20209, 20224, 20239, 31821, 25836, 20215, 20216, 20361, 25829, 20473, 31830, 31833, 31841, 31842, 20137, 20175, 20146, 20217, 20470, 31845, 20256};
            talentsCount = 22; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 202: // Paladin - Shockadin (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31997, 33920, 31996, 33304, 31992, 33889, 31993, 30064, 31995, 33890, 33853, 33056, 29370, 32963, 33313, 33504}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3002, 0, 2982, 0, 2933, 0, 2748, 2649, 2650, 2937, 2928, 2928, 0, 0, 2938, 36, 2654, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3163, 3210, 0 },
                { 3282, 0 , 0},
                { 3282, 3140, 0},
                { 0, 0, 0 },
                { 3282, 3282, 3140},
                { 3282, 3282, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3140, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {20261, 20332, 20208, 20239, 25836, 20215, 20216, 25829, 20473, 31830, 31841, 20105, 25957, 20337, 26021, 44414, 25988, 31867, 20218};
            talentsCount = 19; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
                case GOSSIP_ACTION_INFO_DEF + 203: // Paladin - Retribution (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32041, 33923, 32043, 33484, 32039, 33910, 32040, 33909, 33501, 33911, 33919, 33057, 29383, 31984, 27484}; // item ids
            uint32 itemsCount = 15; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3096, 0, 2986, 0, 2933, 0, 3012, 2657, 2647, 684, 2931, 2931, 0, 0, 368, 2667, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2830, 3115, 0 },
                { 3139, 0 , 0},
                { 3208, 3139, 0},
                { 0, 0, 0 },
                { 3115, 3115, 3139},
                { 0, 0, 0 },
                { 3115, 3139, 3133 },
                { 0, 0, 0 },
                { 3139, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {20105, 25957, 20337, 26021, 20121, 20375, 44414, 25988, 20113, 20218, 20059, 31878, 20066, 35397, 35395, 20137, 20193, 20175, 20143, 20217, 20470, 31845, 20489};
            talentsCount = 23; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 301: // Hunter - Beastmastery (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31962, 31964, 33923, 33484, 31960, 33877, 31961, 33527, 33878, 34887, 33496, 34578, 31965, 31985, 31986, 33876}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3003, 0, 2986, 0, 2933, 0, 3012, 2658, 1593, 2564, 2931, 2931, 0, 0, 368, 2666, 2666, 2523, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2829, 3208, 0 },
                { 3219, 0 , 0},
                { 3281, 3144, 0},
                { 0, 0, 0 },
                { 3281, 3281, 3144},
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3144, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {19587, 35030, 19609, 19575, 19596, 19620, 19573, 19602, 19577, 19592, 19625, 34460, 19574, 34470, 34692, 19431, 19415, 34954, 19434, 34949, 19490};
            talentsCount = 21; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            CreatePet(player, creature, PET_RAVAGER);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 302: // Hunter - Marksman (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31962, 30017, 31964, 29994, 31960, 33876, 31965, 31985, 34892, 31961, 33877, 31963, 33878, 33496, 34887, 34163, }; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3003, 0, 2986, 0, 2933, 0, 3012, 2658, 1593, 2564, 2931, 2931, 0, 0, 368, 2666, 2666, 2523, 0 }; // enchant ids
            // GEM TEMPLATE ->         HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2829, 3208, 0 },         // HEAD
                { 0, 0, 0 },             // NECK
                { 3209, 3215, 0 },         // SHOULDER
                { 0, 0, 0 },             // BODY(SHIRT)
                { 3116, 3116, 3131 },     // CHEST
                { 0, 0, 0 },             // WAIST
                { 0, 0, 0 },            // LEGS
                { 0, 0, 0 },            // FEET
                { 3131, 0, 0 },            // WRISTS
                { 0, 0, 0 },              // HANDS
                { 0, 0, 0 },            // FINGER1
                { 0, 0, 0 },             // FINGER2
                { 0, 0, 0 },             // TRINKET1
                { 0, 0, 0 },             // TRINKET2
                { 0, 0, 0 },             // BACK
                { 0, 0, 0 },             // MAINHAND
                { 0, 0, 0 },             // OFFHAND
                { 0, 0, 0 },             // RANGE
                { 0, 0, 0 },             // TABARD
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {19587, 19575, 19415, 19431, 34954, 19434, 34949, 19468, 19490, 19503, 34476, 19511, 34484, 19506, 34489, 34490, 19152, 19500, 19387, 19233, 19263};
            talentsCount = 21; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            CreatePet(player, creature, PET_WIND_SERPENT);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 303: // Hunter - Survival (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31962, 31964, 33923, 33484, 31960, 33877, 31961, 33527, 33878, 34887, 33496, 34578, 31965, 31985, 31986, 33876}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3003, 0, 2986, 0, 2933, 0, 3012, 2658, 1593, 2564, 2931, 2931, 0, 0, 368, 2666, 2666, 2724, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2829, 3209, 0 },
                { 3144, 0 , 0},
                { 3116, 3144, 0},
                { 0, 0, 0 },
                { 3116, 3116, 3144},
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3144, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {19431, 19415, 34954, 19434, 19434, 34949, 19490, 19503, 19152, 19500, 19388, 19233, 19259, 19263, 24283, 34496, 19373, 24297, 34497, 19386, 34503, 34839};
            talentsCount = 22; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            CreatePet(player, creature, PET_WIND_SERPENT);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 401: // Rogue - Assassination (Mutilate) (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31999, 33923, 32001, 29994, 32002, 33881, 32044, 32044, 32054, 31998, 30040, 30148, 33892, 33496, 34887, 29383, }; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3003, 0, 2986, 0, 2933, 0, 3012, 2658, 1593, 2564, 2931, 2931, 0, 0, 368, 2673, 2673, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2830, 3208, 0 },         // HEAD
                { 3220, 0, 0 },         // NECK
                { 3209, 3219, 0 },         // SHOULDER
                { 0, 0, 0 },             // BODY(SHIRT)
                { 3116, 3116, 3142 },     // CHEST
                { 3116, 3116, 0 },         // WAIST
                { 3134, 0, 0 },            // LEGS
                { 0, 0, 0 },            // FEET
                { 3116, 0, 0 },            // WRISTS
                { 0, 0, 0 },              // HANDS
                { 0, 0, 0 },            // FINGER1
                { 0, 0, 0 },             // FINGER2
                { 0, 0, 0 },             // TRINKET1
                { 0, 0, 0 },             // TRINKET2
                { 0, 0, 0 },             // BACK
                { 0, 0, 0 },             // MAINHAND
                { 0, 0, 0 },             // OFFHAND
                { 0, 0, 0 },             // RANGE
                { 0, 0, 0 },             // TABARD
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {14142, 14161, 14159, 13866, 14179, 14137, 14117, 31209, 14177, 14176, 31245, 14195, 14983, 31242, 1329, 14075, 14094, 14065, 13980, 14066 };
            talentsCount = 20; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 403: // Rogue - Subtlety (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31999, 30017, 32001, 29994, 32002, 33881, 32028, 32046, 32054, 31998, 30040, 30148, 33892, 33496, 34887, 29383, }; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3003, 0, 2986, 0, 2933, 0, 3012, 2658, 1593, 2564, 2931, 2931, 0, 0, 368, 2673, 2673, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2829, 3208, 0 },         // HEAD
                { 0, 0, 0 },             // NECK
                { 3209, 3219, 0 },         // SHOULDER
                { 0, 0, 0 },             // BODY(SHIRT)
                { 3116, 3116, 3142 },     // CHEST
                { 3116, 3116, 0 },         // WAIST
                { 3134, 0, 0 },            // LEGS
                { 0, 0, 0 },            // FEET
                { 3116, 0, 0 },            // WRISTS
                { 0, 0, 0 },              // HANDS
                { 0, 0, 0 },            // FINGER1
                { 0, 0, 0 },             // FINGER2
                { 0, 0, 0 },             // TRINKET1
                { 0, 0, 0 },             // TRINKET2
                { 0, 0, 0 },             // BACK
                { 0, 0, 0 },             // MAINHAND
                { 0, 0, 0 },             // OFFHAND
                { 0, 0, 0 },             // RANGE
                { 0, 0, 0 },             // TABARD
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {14142, 14161, 14159, 14179, 14137, 16719, 13973, 14094, 14064, 13980, 14278, 14066, 14173, 30895, 14185, 14083, 16511, 30906, 31230, 14183, 31220, 36554 };
            talentsCount = 22; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 501: // Priest - Discipline / Holy (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32016, 33922, 32018, 29989, 32019, 33901, 32015, 33900, 32017, 33902, 33918, 30110, 30665, 32964, 32961, 30080}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3004, 0, 2980, 0, 2933, 0, 2746, 2940, 2617, 2322, 2930, 2930, 0, 0, 2938, 2343, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2835, 3318, 0 },
                { 3218, 0 , 0},
                { 3318, 3132, 0},
                { 0, 0, 0 },
                { 3318, 3215, 3131},
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3131, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {14791, 14769, 14774, 33172, 14751, 14777, 14783, 14772, 18555, 14752, 33190, 45244, 10060, 33205, 34912, 33206, 15012, 17191, 18535, 27901, 15237, 27811};
            talentsCount = 22; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 502: // Priest - Shadow (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32035, 33921, 32037, 29992, 32038, 33883, 32034, 30064, 32036, 33884, 33853, 33056, 34470, 32053, 31978, 32962}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3004, 0, 2982, 0, 2933, 0, 2748, 2940, 2650, 2937, 2928, 2928, 0, 0, 2938, 2672, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3163, 3210, 0 },
                { 3215, 0 , 0},
                { 3282, 3131, 0},
                { 0, 0, 0 },
                { 3282, 3131, 3131},
                { 3282, 3282, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3131, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {14791, 14769, 14774, 33172, 14751, 14521, 14783, 15326, 15317, 15328, 15448, 15312, 15407, 17323, 15334, 15487, 15286, 27840, 33215, 15310, 15473, 33195, 34914};
            talentsCount = 23; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 601: // Shaman - Elemental (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32011, 33921, 32013, 32009, 30044, 32012, 33899, 33897, 32010, 33853, 33056, 34579, 33304, 32963, 33313, 33506,};
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = {3002, 0, 2982, 0, 2933, 0, 2748, 2940, 2650, 2937, 2928, 2928, 0, 0, 2938, 2669, 2654, 0, 0};
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = { 
                { 3163, 3210, 0 }, 
                { 3140, 0, 0 },
                { 3282, 3140, 0 },
                { 0, 0, 0 },
                { 3282, 3140, 3140 },
                { 3137, 3140, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3140, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {16111, 16108, 28998, 16164, 16120, 29065, 29000, 16089, 30665, 16582, 30671, 16166, 30681, 16217, 16240, 16222, 16233, 16189, 16221, 16188};
            talentsCount = 20; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 602: // Shaman - Enhancement (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32006, 33923, 32008, 33484, 32004, 33894, 32005, 33895, 33527, 33896, 33919, 33057, 29383, 31965, 31965, 33507}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3096, 0, 2986, 0, 2933, 0, 3012, 2658, 2647, 684, 2931, 2931, 0, 0, 2938, 2668, 2668, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2829, 3208, 0 },
                { 3139, 0 , 0},
                { 3115, 3139, 0},
                { 0, 0, 0 },
                { 3115, 3115, 3139},
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3139, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {16301, 16305, 16287, 16290, 43338, 16284, 16309, 16268, 29080, 30814, 29084, 30819, 30798, 17364, 30811, 30823, 16108, 16130, 28998, 16164, 16116};
            talentsCount = 21; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 603: // Shaman - Restoration (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32031, 33922, 32033, 33333, 32029, 33906, 32030, 33907, 32032, 33908, 33918, 33064, 34471, 30108, 33309, 24413}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3004, 0, 2980, 0, 2933, 0, 2746, 2940, 2617, 2322, 2930, 2930, 0, 0, 2938, 2343, 3229, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2835, 3138, 0 },
                { 3141, 0 , 0},
                { 3138, 3141, 0},
                { 0, 0, 0 },
                { 3138, 3141, 3141},
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3141, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {17489, 16253, 16293, 16287, 16274, 16309, 16217, 16240, 16222, 16198, 16234, 16189, 16208, 16188, 30866, 16212, 16190, 30885, 30869, 974};
            talentsCount = 20; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 701: // Mage - Arcane/Fire (Pom/Pyro) (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32048, 33921, 32047, 32050, 33912, 32051, 33914, 33913, 33853, 32049, 30109, 29370, 33304, 32055, 32962}; // item ids
            uint32 itemsCount = 19; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3002, 0, 2721, 0, 2661, 0, 2748, 2940, 2650, 2935, 2928, 2928, 0, 0, 2938, 2669, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3261, 3210, 0 },   //HEAD
                { 3282, 0 , 0},      //NECK
                { 3212, 3215, 0},    //SHOULDER    
                { 0, 0, 0},          //SHIRT
                { 3282, 3284, 3218}, //CHEST
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3282, 0, 0 },      //WRISTS
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {12464, 12840, 12592, 29446, 12577, 28574, 12598, 12043, 12502, 15060, 31572, 31582, 12042, 35581, 31588, 12360, 12848, 12353, 11080, 11366, 18460, 12873, 11113};
            talentsCount = 23; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 702: // Mage - Fire (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32048, 33921, 32047, 32050, 33912, 32051, 33914, 33913, 33853, 32049, 30109, 28785, 33304, 32055, 32962}; // item ids
            uint32 itemsCount = 19; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3002, 0, 2721, 0, 2661, 0, 2748, 2940, 2650, 2935, 2928, 2928, 0, 0, 2938, 2671, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3261, 3210, 0 },   //HEAD
                { 3282, 0 , 0},      //NECK
                { 3212, 3215, 0},    //SHOULDER    
                { 0, 0, 0},          //SHIRT
                { 3282, 3284, 3218}, //CHEST
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3282, 0, 0 },      //WRISTS
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {12341, 12360, 12848, 12353, 18460, 11366, 12351, 12873, 13043, 29075, 11368, 11113, 31642, 12400, 11129, 31680, 31661, 12592, 16770, 12839, 12577, 28574, 12598};
            talentsCount = 23; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 703: // Mage - Frost (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32047, 32048, 32049, 32050, 33584, 35319, 35321, 33913, 30064, 33914, 35320, 33497, 29370, 33467, 33334, 32962}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3002, 0, 2982, 0, 2933, 0, 2748, 2940, 2650, 2937, 2928, 2928, 0, 0, 2938, 2669, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3163, 3210, 0 },
                { 3287, 0 , 0},
                { 3285, 3287, 0},
                { 0, 0, 0 },
                { 3287, 3287, 3287},
                { 3287, 3287, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3287, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {12592, 12840, 29446, 12577, 28574, 12598, 16766, 15053, 12497, 12475, 12571, 12953, 12472, 12488, 16758, 12985, 11958, 31672, 28594, 11426, 31676, 31687};
            talentsCount = 22; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 801: // Warlock - Affliction (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31974, 33921, 31976, 35321, 31977, 33883, 31973, 30064, 31975, 33884, 33853, 33056, 34470, 32053, 31978, 32962}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3002, 0, 2982, 0, 2933, 0, 2748, 2940, 2650, 2937, 2928, 2928, 0, 0, 2938, 2672, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3163, 3210, 0 },
                { 3215, 0 , 0},
                { 3125, 3131, 0},
                { 0, 0, 0 },
                { 3282, 3131, 3131},
                { 3282, 3282, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3131, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {17814, 18174, 18183, 17805, 18829, 17787, 18288, 18219, 18095, 32383, 32385, 18265, 18223, 18275, 30064, 30057, 30108, 18701, 18693, 18704, 17803, 17792, 17877, 17877};
            talentsCount = 24; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 802: // Warlock - Demonology (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {30212, 33921, 30215, 35321, 31977, 33883, 31973, 30064, 31975, 33884, 33853, 33056, 29370, 32053, 31978, 32962}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3004, 0, 2982, 0, 2933, 0, 2748, 2940, 2650, 2937, 2928, 2928, 0, 0, 2938, 2669, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3163, 3125, 0 },
                { 3215, 0 , 0},
                { 3286, 3286, 0},
                { 0, 0, 0 },
                { 3210, 3286, 3286},
                { 3282, 3282, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3286, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {17814, 18693, 18744, 18708, 18750, 30145, 18710, 18773, 18788, 30327, 23825, 30321, 19028, 35693, 30248, 30146, 17803, 17792, 17877, 18701};
            talentsCount = 20; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 803: // Warlock - SL/SL (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31980, 33921, 31979, 35321, 31977, 33883, 31973, 30064, 31975, 33357, 33853, 33056, 34470, 32053, 31978, 32962}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3002, 0, 2982, 0, 2933, 0, 2748, 2940, 2650, 2937, 2928, 2928, 0, 0, 2938, 2672, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3163, 3210, 0 },
                { 3282, 0 , 0},
                { 3125, 3215, 0},
                { 0, 0, 0 },
                { 3282, 3131, 3131},
                { 3282, 3282, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3131, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {18701, 18693, 18744, 18708, 18710, 18750, 30145, 18773, 18788, 23825, 30326, 30321, 19028, 17814, 18174, 18183, 17805, 18829, 17784, 18288, 18219, 18095, 32383, 32385, 18265, 18265, 18223, 35691};
            talentsCount = 28; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 804: // Warlock - Destruction (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31980, 33920, 31979, 33304, 31982, 33913, 31981, 30064, 31983, 33914, 33853, 33056, 34577, 32053,31978, 32962}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3002, 0, 2982, 0, 2933, 0, 2748, 2940, 2650, 2937, 2928, 2928, 0, 0, 2938, 2669, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3163, 3210, 0 },
                { 3215, 0 , 0},
                { 3125, 3140, 0},
                { 0, 0, 0 },
                { 3282, 3140, 3140},
                { 3140, 3140, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3140, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {17814, 18701, 18693, 17782, 17792, 18183, 18134, 17877, 18136, 17918, 17836, 17959, 30302, 17958, 34939, 17962, 17877, 30296, 30292, 30296, 30283};
            talentsCount = 21; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 901: // Druid - Balance (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {32057, 35319, 32059, 35321, 32060, 33917, 32056, 33915, 33584, 33916, 33497, 33853, 35327, 32053, 33334, 33510}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3002, 0, 2982, 0, 2933, 0, 2748, 2940, 2650, 2937, 2928, 2928, 0, 0, 2938, 2669, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 3163, 3287, 0 },
                { 3287, 0 , 0},
                { 3210, 3287, 0},
                { 0, 0, 0 },
                { 3282, 3282, 3287},
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3282, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {16818, 16689, 16689, 16920, 35364, 16822, 5570, 16820, 16913, 16924, 33591, 16880, 16847, 16901, 33956, 24858, 33607, 16862, 16941, 16931, 16979, 17061};
            talentsCount = 22; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 902: // Druid - Feral Combat (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31968, 33923, 31971, 33484, 31972, 33881, 31967, 33879, 30229, 33880, 33919, 34887, 30627, 34898, 0, 33509}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3003, 0, 2986, 0, 2661, 0, 3012, 2657, 1891, 2564, 2931, 2931, 0, 0, 368, 2670, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2829, 3142, 0 },
                { 3142, 0 , 0},
                { 3142, 3142, 0},
                { 0, 0, 0 },
                { 3208, 3209, 3219},
                { 0, 0, 0 },
                { 3134, 0, 0 },
                { 0, 0, 0 },
                { 3142, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {16938, 16941, 16931, 24866, 16979, 16944, 16968, 16975, 37117, 16999, 16857, 33873, 24894, 33853, 33957, 17007, 34300, 33869, 33917, 33876, 33878, 16689, 16689, 17061, 17073, 16835, 16864};
            talentsCount = 27; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 904: // Druid - Restoration (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31988, 33922, 32059, 29989, 31991, 33887, 32056, 33885, 31989, 33886, 33918, 30110, 34050, 32964, 32961, 33508}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3004, 0, 2980, 0, 2933, 0, 2746, 2940, 2617, 2322, 2930, 2930, 0, 0, 2938, 2343, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2835, 3215, 0 },
                { 3218, 0 , 0},
                { 3318, 3132, 0},
                { 0, 0, 0 },
                { 3318, 3318, 3131},
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 3318, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {16818, 16689, 17245, 16920, 5570, 16862, 16941, 16931, 16979, 17061, 17061, 17051, 16835, 17108, 17122, 17113, 17116, 24946, 17076, 33883, 18562, 34151, 33889 };
            talentsCount = 23; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
        case GOSSIP_ACTION_INFO_DEF + 905: // Druid - Restokin (100%)
        {
            // ITEM TEMPLATE -> just fill in item ids, no required order
            uint32 items[] = {31988, 33922, 32059, 29989, 31991, 33887, 32056, 33885, 33552, 33886, 33918, 30110, 34050, 32964, 32961, 33510}; // item ids
            uint32 itemsCount = 16; // item count above
            // ENCHANT TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            uint32 enchants[19] = { 3004, 0, 2980, 0, 2933, 0, 2746, 2940, 2617, 2322, 2930, 2930, 0, 0, 2938, 2343, 0, 0, 0 }; // enchant ids
            // GEM TEMPLATE -> HEAD, NECK, SHOULDER, BODY(SHIRT), CHEST, WAIST, LEGS, FEET, WRISTS, HANDS, FINGER1, FINGER2, TRINKET1, TRINKET2, BACK, MAINHAND, OFFHAND, RANGE, TABARD
            // If Item has 1 gem slot { enchantId, 0 , 0},
            // If Item has 2 gem slot { enchantId, enchantId, 0},
            // If Item has 3 gem slot { enchantId, enchantId, enchantId},
            uint32 sockets[19][3] = {
                { 2835, 3215, 0 },
                { 3131, 0 , 0},
                { 3318, 3131, 0},
                { 0, 0, 0 },
                { 3318, 3318, 3131},
                { 0, 0, 0 },
                { 3318, 3131, 3318 },
                { 0, 0, 0 },
                { 3318, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
                { 0, 0, 0 },
            };
            // add all talents spells (max rank which should be learned) here, no order necessary
            uint32 talents[] = {16818, 16689, 17249, 16920, 16822, 5570, 16820, 16924, 33591, 16880, 16847, 33596, 33956, 24858, 24905, 17061, 17051, 16835, 17108, 17122, 17113, 17116, 24946};
            talentsCount = 23; // talent spell count from above

            AddItemsEnchantsGemsTalents(player, items, sockets, enchants, talents, itemsCount, talentsCount);
            break;
        }
    }
    if (action != (GOSSIP_ACTION_INFO_DEF + 1))
        player->CLOSE_GOSSIP_MENU();

    return true;
}

void AddSC_npc_template()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_template";
    newscript->pGossipHello =  &GossipHello_npc_template;
    newscript->pGossipSelect = &GossipSelect_npc_template;
    newscript->RegisterSelf();
}