#include "ScriptPCH.h" 
#include "Language.h"

enum Enchant
{
    ENCHANT_OPTION_HEAD,
    ENCHANT_OPTION_SHOULDERS,
    ENCHANT_OPTION_CHEST,
    ENCHANT_OPTION_GLOVES,
    ENCHANT_OPTION_LEGS,
    ENCHANT_OPTION_BRACERS,
    ENCHANT_OPTION_BELT,
    ENCHANT_OPTION_BOOTS,
    ENCHANT_OPTION_CLOAK,
    ENCHANT_OPTION_RING1,
    ENCHANT_OPTION_RING2,
    ENCHANT_OPTION_MAIN_HAND,
    ENCHANT_OPTION_OFF_HAND,
    ENCHANT_OPTION_RANGED,

    MENU_ENCHANTS
};

enum EnchantId
{
    ENCHANT_HEAD_ARCANUM_OF_TRIUMPH = 3795,
    ENCHANT_HEAD_ARCANUM_OF_DOMINANCE = 3796,
    ENCHANT_HEAD_ARCANUM_OF_TORMENT = 3817,
    ENCHANT_HEAD_ARCANUM_OF_BURNING_MYSTERIES = 3820,
    ENCHANT_HEAD_ARCANUM_OF_BLISSFUL_MENDING = 3819,
    ENCHANT_HEAD_ARCANUM_OF_THE_STALWART_PROTECTOR = 3818,
    ENCHANT_HEAD_ARCANUM_OF_THE_SAVAGE_GLADIATOR = 3842,

    ENCHANT_SHOULDER_INSCRIPTION_OF_TRIUMPH = 3793,
    ENCHANT_SHOULDER_INSCRIPTION_OF_DOMINANCE = 3794,
    ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_AXE = 3808,
    ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_STORM = 3810,
    ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_CRAG = 3809,
    ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_PINNACLE = 3811,
    ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_GLADIATOR = 3852,

    ENCHANT_CHEST_EXCEPTIONAL_RESILIENCE = 3245,
    ENCHANT_CHEST_POWERFUL_STATS = 3832,
    ENCHANT_CHEST_SUPER_HEALTH = 3297,

    ENCHANT_GLOVES_CRUSHER = 1603,
    ENCHANT_GLOVES_EXCEPTIONAL_SPELLPOWER = 3246,
    ENCHANT_GLOVES_MAJOR_AGILITY = 3222,
    ENCHANT_GLOVES_PERCISION = 3234,

    ENCHANT_LEGS_ICESCALE_LEG_ARMOR = 3823,
    ENCHANT_LEGS_SAPPHIRE_SPELLTHREAD = 3721,
    ENCHANT_LEGS_BRILLIANT_SPELLTHREAD = 3719,
    ENCHANT_LEGS_FROSTHIDE_LEG_ARMOR = 3822,
    ENCHANT_LEGS_EARTHEN_LEG_ARMOR = 3853,

    ENCHANT_BRACERS_GREATER_ASSAULT = 3845,
    ENCHANT_BRACERS_SUPERIOR_SPELLPOWER = 2332,
    ENCHANT_BRACERS_EXCEPTIONAL_INTELLECT = 1119,
    ENCHANT_BRACERS_MAJOR_SPIRIT = 1147,
    ENCHANT_BRACERS_MAJOR_STAMINA = 3850,

    ENCHANT_BELT_ETERNAL_BELT_BUCKLE = 3729,

    ENCHANT_BOOTS_GREATER_ASSULT = 1597,
    ENCHANT_BOOTS_SUPERIOR_AGILITY = 983,
    ENCHANT_BOOTS_ICEWALKER = 3826,
    ENCHANT_BOOTS_TUSKARR_VITALITY = 3232,
    ENCHANT_BOOTS_GREATER_VITALITY = 3244,
    ENCHANT_BOOTS_GREATER_FORTITUDE = 1075,

    ENCHANT_CLOAK_SPELL_PIERCING = 3243,
    ENCHANT_CLOAK_MAJOR_AGILITY = 1099,
    ENCHANT_CLOAK_GREATER_SPEED = 3831,
    ENCHANT_CLOAK_SHADOW_ARMOR = 3256,

    ENCHANT_2H_WEAPON_MASSACRE = 3827,
    ENCHANT_STAFF_GREATER_SPELLPOWER = 3854,

    ENCHANT_WEAPON_BERSERKING = 3789,
    ENCHANT_WEAPON_BLACK_MAGIC = 3790,
    ENCHANT_WEAPON_BLOOD_DRAINING = 3870,
    ENCHANT_WEAPON_BLADE_WARDING = 3869,
    ENCHANT_WEAPON_TITANIUM_WEAPON_CHAIN = 3731,
    ENCHANT_WEAPON_SUPERIOR_POTENCY = 3833,
    ENCHANT_WEAPON_MIGHTY_SPELLPOWER = 3834,
    ENCHANT_WEAPON_EXCEPTIONAL_AGILITY = 1103,
    ENCHANT_WEAPON_EXCEPTIONAL_SPIRIT = 3844,
    ENCHANT_WEAPON_TITANGUARD = 3851,
    ENCHANT_WEAPON_ACCURACY = 3788,
    ENCHANT_WEAPON_MONGOOSE = 2673,
    ENCHANT_WEAPON_EXECUTIONER = 3225,
    ENCHANT_WEAPON_DEATHFROST = 3273,

    ENCHANT_RANGED_HEARTSEEKER_SCOPE = 3608,
    ENCHANT_RANGED_SUN_SCOPE = 3607,
    ENCHANT_RANGED_DIAMOND_CUT_REFRACTOR_SCOPE = 3843,

    ENCHANT_SHIELD_TITANIUM_PLATING = 3849,
    ENCHANT_SHIELD_GREATER_INTELLECT = 1128,
    ENCHANT_SHIELD_RESILIENCE = 3229,

    // Death Knight Enchants
    ENCHANT_WEAPON_FALLEN_CRUSADER = 3368,
    ENCHANT_WEAPON_CINDERGLACIER = 3369,
    ENCHANT_WEAPON_RAZORICE = 3370,
    ENCHANT_WEAPON_LICHBANE = 3366,
    ENCHANT_WEAPON_SPELLBREAKING = 3595,
    ENCHANT_WEAPON_SPELLSHATTERING = 3367,
    ENCHANT_WEAPON_SWORDBREAKING = 3594,
    ENCHANT_WEAPON_SWORDSHATTERING = 3365,
    ENCHANT_WEAPON_NERUBIAN_CARAPACE = 3883,
    ENCHANT_WEAPON_STONESKIN_GARGOYLE = 3847,

    // Blacksmithing
    ENCHANT_GLOVES_SOCKET = 3723,
    ENCHANT_BRACER_SOCKET = 3717,

    // Enchanting
    ENCHANT_RING_ASSAULT = 3839,
    ENCHANT_RING_GREATER_SPELLPOWER = 3840,
    ENCHANT_RING_STAMINA = 3791,

    // Engineering
    ENCHANT_HEAD_MIND_AMPLIFICATION_DISH = 3878,
    ENCHANT_GLOVES_HAND_MOUNTED_PRYO_ROCKET = 3603,
    ENCHANT_GLOVES_HYPERSPEED_ACCELERATORS = 3604,
    ENCHANT_BELT_FRAG_BELT = 3601,
    ENCHANT_BOOTS_NITRO_BOOSTS = 3606,
    ENCHANT_CLOAK_FLEXWEAVE_UNDERLAY = 3605,
    ENCHANT_CLOAK_SPRINGY_ARACHNOWEAVE = 3859,

    // Inscription
    ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_AXE = 3835,
    ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_STORM = 3838,
    ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_CRAG = 3836,
    ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_PINNACLE = 3837,

    // Leatherworking
    ENCHANT_BRACER_FUR_LINING_ATTACKPOWER = 3756,
    ENCHANT_BRACER_FUR_LINING_SPELLPOWER = 3758,
    ENCHANT_BRACER_FUR_LINING_AGILITY = 4873,
    ENCHANT_BRACER_FUR_LINING_STAMINA = 3757,

    // Tailoring
    ENCHANT_CLOAK_SWORDGUARD_EMBROIDERY = 3730,
    ENCHANT_CLOAK_LIGHTWEAVE_EMBROIDERY = 3722,
    ENCHANT_CLOAK_DARKGLOW_EMBROIDERY = 3728,
};

class npc_enchantment : public CreatureScript
{
public:
    npc_enchantment() : CreatureScript("npc_enchantment") { }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
                return false;

            return HandleEnchants(player, creature, MENU_ENCHANTS);
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();

            switch (sender)
            {
                case MENU_ENCHANTS:
                    HandleEnchants(player, creature, action);
                    break;
                case ENCHANT_OPTION_HEAD:
                case ENCHANT_OPTION_SHOULDERS:
                case ENCHANT_OPTION_CHEST:
                case ENCHANT_OPTION_GLOVES:
                case ENCHANT_OPTION_LEGS:
                case ENCHANT_OPTION_BRACERS:
                case ENCHANT_OPTION_BELT:
                case ENCHANT_OPTION_BOOTS:
                case ENCHANT_OPTION_CLOAK:
                case ENCHANT_OPTION_RING1:
                case ENCHANT_OPTION_RING2:
                case ENCHANT_OPTION_MAIN_HAND:
                case ENCHANT_OPTION_OFF_HAND:
                case ENCHANT_OPTION_RANGED:
                {
                    EnchantItem(player, creature, action, sender);
                    break;
                }
            }
            return true;
        }

        bool EnchantItem(Player* player, Creature* creature, uint16 enchantId, uint8 enchantOption)
        {
            uint8 slot = GetItemSlotByEnchantOption(enchantOption);
            if (slot > EQUIPMENT_SLOT_RANGED)
            {
                player->GetSession()->SendNotification("Unable to find item slot based on enchant option: %u", enchantOption);
                player->CLOSE_GOSSIP_MENU();
                return false;
            }

            Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
            if (!pItem)
            {
                player->GetSession()->SendNotification("You have no item equipped in your %s slot", SlotToSlotString(slot).c_str());
                player->CLOSE_GOSSIP_MENU();
                return false;
            }

            const ItemTemplate* pItemTemplate = pItem->GetTemplate();
            if (!pItemTemplate)
            {
                player->GetSession()->SendNotification("Unable to get template data for the item in your %s slot", SlotToSlotString(slot).c_str());
                player->CLOSE_GOSSIP_MENU();
                return false;
            }

            const SpellItemEnchantmentEntry* enchantEntry = sSpellItemEnchantmentStore.LookupEntry(enchantId);
            if (!enchantEntry)
            {
                player->GetSession()->SendNotification("Unable to get data for enchant: %u", enchantId);
                player->CLOSE_GOSSIP_MENU();
                return false;
            }

            if (!CheckEnchantItem(player, pItemTemplate, enchantId, slot))
            {
                player->CLOSE_GOSSIP_MENU();
                return false;
            }

            switch (enchantId)
            {
                case ENCHANT_BELT_ETERNAL_BELT_BUCKLE:
                case ENCHANT_GLOVES_SOCKET:
                case ENCHANT_BRACER_SOCKET:
                {
                    bool addSocket = false;

                    for (uint8 i = 0; i < MAX_ITEM_ENCHANTMENT_EFFECTS; ++i)
                        if (enchantEntry->type[i] == ITEM_ENCHANTMENT_TYPE_PRISMATIC_SOCKET)
                        {
                            addSocket = true;
                            break;
                        }

                    if (!addSocket)
                    {
                        player->GetSession()->SendNotification("Unable to add socket to %s because enchant: %u doesn't have enchant entry type: ITEM_ENCHANTMENT_TYPE_PRISMATIC_SOCKET",
                        pItemTemplate->Name1.c_str(), enchantId);
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    pItem->SetEnchantment(PRISMATIC_ENCHANTMENT_SLOT, enchantId, 0, 0);
                    player->ApplyEnchantment(pItem, PRISMATIC_ENCHANTMENT_SLOT, true);
                    pItem->ClearSoulboundTradeable(player);
                    break;
                }
                default:
                {
                    player->ApplyEnchantment(pItem, PERM_ENCHANTMENT_SLOT);
                    pItem->SetEnchantment(PERM_ENCHANTMENT_SLOT, enchantId, 0, 0);
                    player->ApplyEnchantment(pItem, PERM_ENCHANTMENT_SLOT, true);
                    pItem->ClearSoulboundTradeable(player);
                    break;
                }
            }

            player->CastSpell(player, 61335); // Disenchant Visual
            player->PlayerTalkClass->ClearMenus();
            HandleEnchants(player, creature, MENU_ENCHANTS);
            return true;
        }

        uint8 GetItemSlotByEnchantOption(uint8 invType)
        {
            switch (invType)
            {
                case ENCHANT_OPTION_HEAD:      return EQUIPMENT_SLOT_HEAD;
                case ENCHANT_OPTION_SHOULDERS: return EQUIPMENT_SLOT_SHOULDERS;
                case ENCHANT_OPTION_CHEST:     return EQUIPMENT_SLOT_CHEST;
                case ENCHANT_OPTION_GLOVES:    return EQUIPMENT_SLOT_HANDS;
                case ENCHANT_OPTION_LEGS:      return EQUIPMENT_SLOT_LEGS;
                case ENCHANT_OPTION_BRACERS:   return EQUIPMENT_SLOT_WRISTS;
                case ENCHANT_OPTION_BELT:      return EQUIPMENT_SLOT_WAIST;
                case ENCHANT_OPTION_BOOTS:     return EQUIPMENT_SLOT_FEET;
                case ENCHANT_OPTION_CLOAK:     return EQUIPMENT_SLOT_BACK;
                case ENCHANT_OPTION_RING1:     return EQUIPMENT_SLOT_FINGER1;
                case ENCHANT_OPTION_RING2:     return EQUIPMENT_SLOT_FINGER2;
                case ENCHANT_OPTION_MAIN_HAND: return EQUIPMENT_SLOT_MAINHAND;
                case ENCHANT_OPTION_OFF_HAND:  return EQUIPMENT_SLOT_OFFHAND;
                case ENCHANT_OPTION_RANGED:    return EQUIPMENT_SLOT_RANGED;
                default:                       return EQUIPMENT_SLOT_END;
            }
        }

        std::string SlotToSlotString(uint8 slot)
        {
            switch (slot)
            {
                case EQUIPMENT_SLOT_HEAD:      return "head";
                case EQUIPMENT_SLOT_SHOULDERS: return "shoulders";
                case EQUIPMENT_SLOT_CHEST:     return "chest";
                case EQUIPMENT_SLOT_HANDS:     return "hands";
                case EQUIPMENT_SLOT_LEGS:      return "legs";
                case EQUIPMENT_SLOT_WRISTS:    return "wrists";
                case EQUIPMENT_SLOT_WAIST:     return "waist";
                case EQUIPMENT_SLOT_FEET:      return "feet";
                case EQUIPMENT_SLOT_BACK:      return "Back";
                case EQUIPMENT_SLOT_FINGER1:   return "finger1";
                case EQUIPMENT_SLOT_FINGER2:   return "finger2";
                case EQUIPMENT_SLOT_MAINHAND:  return "main hand";
                case EQUIPMENT_SLOT_OFFHAND:   return "off hand";
                case EQUIPMENT_SLOT_RANGED:    return "ranged";
                default:                       return "error";
            }
        }

        bool CheckEnchantItem(Player* player, const ItemTemplate* pItemTemplate, uint16 enchantId, uint8 slot)
        {
            switch (enchantId)
            {
                case ENCHANT_HEAD_ARCANUM_OF_TRIUMPH:
                case ENCHANT_HEAD_ARCANUM_OF_DOMINANCE:
                case ENCHANT_HEAD_ARCANUM_OF_TORMENT:
                case ENCHANT_HEAD_ARCANUM_OF_BURNING_MYSTERIES:
                case ENCHANT_HEAD_ARCANUM_OF_BLISSFUL_MENDING:
                case ENCHANT_HEAD_ARCANUM_OF_THE_STALWART_PROTECTOR:
                case ENCHANT_HEAD_ARCANUM_OF_THE_SAVAGE_GLADIATOR:
                case ENCHANT_HEAD_MIND_AMPLIFICATION_DISH:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MAIL &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_HEAD)
                        return false;

                    break;
                }
                case ENCHANT_SHOULDER_INSCRIPTION_OF_TRIUMPH:
                case ENCHANT_SHOULDER_INSCRIPTION_OF_DOMINANCE:
                case ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_AXE:
                case ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_STORM:
                case ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_CRAG:
                case ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_PINNACLE:
                case ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_AXE:
                case ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_STORM:
                case ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_CRAG:
                case ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_PINNACLE:
                case ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_GLADIATOR:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MAIL &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_SHOULDERS)
                        return false;

                    break;
                }
                case ENCHANT_CHEST_EXCEPTIONAL_RESILIENCE:
                case ENCHANT_CHEST_POWERFUL_STATS:
                case ENCHANT_CHEST_SUPER_HEALTH:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MAIL &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_CHEST &&
                        pItemTemplate->InventoryType != INVTYPE_ROBE)
                        return false;

                    break;
                }
                case ENCHANT_GLOVES_CRUSHER:
                case ENCHANT_GLOVES_EXCEPTIONAL_SPELLPOWER:
                case ENCHANT_GLOVES_MAJOR_AGILITY:
                case ENCHANT_GLOVES_PERCISION:
                case ENCHANT_GLOVES_SOCKET:
                case ENCHANT_GLOVES_HAND_MOUNTED_PRYO_ROCKET:
                case ENCHANT_GLOVES_HYPERSPEED_ACCELERATORS:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MAIL &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_HANDS)
                        return false;

                    break;
                }
                case ENCHANT_LEGS_ICESCALE_LEG_ARMOR:
                case ENCHANT_LEGS_SAPPHIRE_SPELLTHREAD:
                case ENCHANT_LEGS_BRILLIANT_SPELLTHREAD:
                case ENCHANT_LEGS_FROSTHIDE_LEG_ARMOR:
                case ENCHANT_LEGS_EARTHEN_LEG_ARMOR:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MAIL &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_LEGS)
                        return false;

                    break;
                }
                case ENCHANT_BRACERS_GREATER_ASSAULT:
                case ENCHANT_BRACERS_SUPERIOR_SPELLPOWER:
                case ENCHANT_BRACERS_EXCEPTIONAL_INTELLECT:
                case ENCHANT_BRACERS_MAJOR_SPIRIT:
                case ENCHANT_BRACERS_MAJOR_STAMINA:
                case ENCHANT_BRACER_SOCKET:
                case ENCHANT_BRACER_FUR_LINING_ATTACKPOWER:
                case ENCHANT_BRACER_FUR_LINING_SPELLPOWER:
                case ENCHANT_BRACER_FUR_LINING_AGILITY:
                case ENCHANT_BRACER_FUR_LINING_STAMINA:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MAIL &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_WRISTS)
                        return false;

                    break;
                }
                case ENCHANT_BELT_ETERNAL_BELT_BUCKLE:
                case ENCHANT_BELT_FRAG_BELT:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MAIL &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_WAIST)
                        return false;

                    break;
                }
                case ENCHANT_BOOTS_GREATER_ASSULT:
                case ENCHANT_BOOTS_SUPERIOR_AGILITY:
                case ENCHANT_BOOTS_ICEWALKER:
                case ENCHANT_BOOTS_TUSKARR_VITALITY:
                case ENCHANT_BOOTS_GREATER_VITALITY:
                case ENCHANT_BOOTS_GREATER_FORTITUDE:
                case ENCHANT_BOOTS_NITRO_BOOSTS:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MAIL &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_FEET)
                        return false;

                    break;
                }
                case ENCHANT_CLOAK_SPELL_PIERCING:
                case ENCHANT_CLOAK_MAJOR_AGILITY:
                case ENCHANT_CLOAK_GREATER_SPEED:
                case ENCHANT_CLOAK_SHADOW_ARMOR:
                case ENCHANT_CLOAK_FLEXWEAVE_UNDERLAY:
                case ENCHANT_CLOAK_SPRINGY_ARACHNOWEAVE:
                case ENCHANT_CLOAK_SWORDGUARD_EMBROIDERY:
                case ENCHANT_CLOAK_LIGHTWEAVE_EMBROIDERY:
                case ENCHANT_CLOAK_DARKGLOW_EMBROIDERY:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_CLOAK)
                        return false;

                    break;
                }
                case ENCHANT_2H_WEAPON_MASSACRE:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_WEAPON)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_AXE2 &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_MACE2 &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_SWORD2 &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_POLEARM &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_STAFF)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_2HWEAPON)
                        return false;

                    break;
                }
                case ENCHANT_STAFF_GREATER_SPELLPOWER:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_WEAPON)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_STAFF)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_2HWEAPON)
                        return false;

                    break;
                }
                case ENCHANT_WEAPON_BERSERKING:
                case ENCHANT_WEAPON_BLACK_MAGIC:
                case ENCHANT_WEAPON_BLOOD_DRAINING:
                case ENCHANT_WEAPON_BLADE_WARDING:
                case ENCHANT_WEAPON_TITANIUM_WEAPON_CHAIN:
                case ENCHANT_WEAPON_SUPERIOR_POTENCY:
                case ENCHANT_WEAPON_MIGHTY_SPELLPOWER:
                case ENCHANT_WEAPON_EXCEPTIONAL_AGILITY:
                case ENCHANT_WEAPON_EXCEPTIONAL_SPIRIT:
                case ENCHANT_WEAPON_TITANGUARD:
                case ENCHANT_WEAPON_ACCURACY:
                case ENCHANT_WEAPON_MONGOOSE:
                case ENCHANT_WEAPON_EXECUTIONER:
                case ENCHANT_WEAPON_DEATHFROST:
                case ENCHANT_WEAPON_FALLEN_CRUSADER:
                case ENCHANT_WEAPON_CINDERGLACIER:
                case ENCHANT_WEAPON_RAZORICE:
                case ENCHANT_WEAPON_LICHBANE:
                case ENCHANT_WEAPON_SPELLBREAKING:
                case ENCHANT_WEAPON_SPELLSHATTERING:
                case ENCHANT_WEAPON_SWORDBREAKING:
                case ENCHANT_WEAPON_SWORDSHATTERING:
                case ENCHANT_WEAPON_NERUBIAN_CARAPACE:
                case ENCHANT_WEAPON_STONESKIN_GARGOYLE:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_WEAPON)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_AXE &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_AXE2 &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_MACE &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_MACE2 &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_POLEARM &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_SWORD &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_SWORD2 &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_STAFF &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_FIST &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_DAGGER)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_2HWEAPON &&
                        pItemTemplate->InventoryType != INVTYPE_WEAPON &&
                        pItemTemplate->InventoryType != INVTYPE_WEAPONMAINHAND &&
                        pItemTemplate->InventoryType != INVTYPE_WEAPONOFFHAND)
                        return false;

                    break;
                }
                case ENCHANT_RANGED_HEARTSEEKER_SCOPE:
                case ENCHANT_RANGED_SUN_SCOPE:
                case ENCHANT_RANGED_DIAMOND_CUT_REFRACTOR_SCOPE:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_WEAPON)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_BOW &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_GUN &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_CROSSBOW)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_RANGED &&
                        pItemTemplate->InventoryType != INVTYPE_RANGEDRIGHT)
                        return false;

                    break;
                }
                case ENCHANT_SHIELD_TITANIUM_PLATING:
                case ENCHANT_SHIELD_GREATER_INTELLECT:
                case ENCHANT_SHIELD_RESILIENCE:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_SHIELD)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_SHIELD)
                        return false;

                    break;
                }
                case ENCHANT_RING_ASSAULT:
                case ENCHANT_RING_GREATER_SPELLPOWER:
                case ENCHANT_RING_STAMINA:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MISC)
                        return false;

                    if (pItemTemplate->InventoryType != INVTYPE_FINGER)
                        return false;

                    break;
                }
            }

            switch (slot)
            {
                case EQUIPMENT_SLOT_HEAD:
                case EQUIPMENT_SLOT_SHOULDERS:
                case EQUIPMENT_SLOT_CHEST:
                case EQUIPMENT_SLOT_HANDS:
                case EQUIPMENT_SLOT_LEGS:
                case EQUIPMENT_SLOT_WRISTS:
                case EQUIPMENT_SLOT_WAIST:
                case EQUIPMENT_SLOT_FEET:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->Class == ITEM_CLASS_ARMOR)
                        if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_LEATHER &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MAIL &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_PLATE)
                            return false;

                    if (pItemTemplate->InventoryType != INVTYPE_HEAD &&
                        pItemTemplate->InventoryType != INVTYPE_SHOULDERS &&
                        pItemTemplate->InventoryType != INVTYPE_CHEST &&
                        pItemTemplate->InventoryType != INVTYPE_ROBE &&
                        pItemTemplate->InventoryType != INVTYPE_HANDS &&
                        pItemTemplate->InventoryType != INVTYPE_LEGS &&
                        pItemTemplate->InventoryType != INVTYPE_WRISTS &&
                        pItemTemplate->InventoryType != INVTYPE_WAIST &&
                        pItemTemplate->InventoryType != INVTYPE_FEET)
                        return false;

                    break;
                }
                case EQUIPMENT_SLOT_BACK:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->Class == ITEM_CLASS_ARMOR)
                        if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_CLOTH)
                            return false;

                    if (pItemTemplate->InventoryType != INVTYPE_CLOAK)
                        return false;

                    break;
                }
                case EQUIPMENT_SLOT_FINGER1:
                case EQUIPMENT_SLOT_FINGER2:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->Class == ITEM_CLASS_ARMOR)
                        if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_MISC)
                            return false;

                    if (pItemTemplate->InventoryType != INVTYPE_FINGER)
                        return false;

                    break;
                }
                case EQUIPMENT_SLOT_MAINHAND:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_WEAPON)
                        return false;

                    if (pItemTemplate->Class == ITEM_CLASS_WEAPON)
                        if (pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_AXE &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_AXE2 &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_MACE &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_MACE2 &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_SWORD &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_SWORD2 &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_POLEARM &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_STAFF &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_FIST &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_DAGGER)
                            return false;

                    if (pItemTemplate->InventoryType != INVTYPE_WEAPON &&
                        pItemTemplate->InventoryType != INVTYPE_WEAPONMAINHAND &&
                        pItemTemplate->InventoryType != INVTYPE_WEAPONOFFHAND &&
                        pItemTemplate->InventoryType != INVTYPE_2HWEAPON)
                        return false;

                    break;
                }
                case EQUIPMENT_SLOT_OFFHAND:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_WEAPON && pItemTemplate->Class != ITEM_CLASS_ARMOR)
                        return false;

                    if (pItemTemplate->Class == ITEM_CLASS_WEAPON)
                        if (pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_AXE &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_AXE2 &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_MACE &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_MACE2 &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_SWORD &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_SWORD2 &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_POLEARM &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_STAFF &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_FIST &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_DAGGER)
                            return false;

                    if (pItemTemplate->Class == ITEM_CLASS_ARMOR)
                        if (pItemTemplate->SubClass != ITEM_SUBCLASS_ARMOR_SHIELD)
                            return false;

                    if (pItemTemplate->InventoryType != INVTYPE_WEAPON &&
                        pItemTemplate->InventoryType != INVTYPE_WEAPONMAINHAND &&
                        pItemTemplate->InventoryType != INVTYPE_WEAPONOFFHAND &&
                        pItemTemplate->InventoryType != INVTYPE_2HWEAPON &&
                        pItemTemplate->InventoryType != INVTYPE_SHIELD)
                        return false;

                    break;
                }
                case EQUIPMENT_SLOT_RANGED:
                {
                    if (pItemTemplate->Class != ITEM_CLASS_WEAPON)
                        return false;

                    if (pItemTemplate->Class == ITEM_CLASS_WEAPON)
                        if (pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_BOW &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_GUN &&
                            pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_CROSSBOW)
                            return false;

                    if (pItemTemplate->InventoryType != INVTYPE_RANGED &&
                        pItemTemplate->InventoryType != INVTYPE_RANGEDRIGHT)
                        return false;

                    break;
                }
            }

            switch (enchantId)
            {
                case ENCHANT_2H_WEAPON_MASSACRE:
                {
                    if (pItemTemplate->Class == ITEM_CLASS_WEAPON && pItemTemplate->InventoryType != INVTYPE_2HWEAPON)
                        return false;

                    break;
                }
                case ENCHANT_STAFF_GREATER_SPELLPOWER:
                {
                    if (pItemTemplate->Class == ITEM_CLASS_WEAPON && pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_STAFF)
                        return false;

                    break;
                }
                case ENCHANT_RANGED_HEARTSEEKER_SCOPE:
                case ENCHANT_RANGED_SUN_SCOPE:
                case ENCHANT_RANGED_DIAMOND_CUT_REFRACTOR_SCOPE:
                {
                    if (pItemTemplate->Class == ITEM_CLASS_WEAPON && (pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_BOW &&
                        pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_GUN && pItemTemplate->SubClass != ITEM_SUBCLASS_WEAPON_CROSSBOW))
                        return false;

                    break;
                }
                case ENCHANT_SHIELD_TITANIUM_PLATING:
                case ENCHANT_SHIELD_GREATER_INTELLECT:
                case ENCHANT_SHIELD_RESILIENCE:
                {
                    if (pItemTemplate->InventoryType != INVTYPE_SHIELD)
                        return false;

                    break;
                }
                case ENCHANT_WEAPON_FALLEN_CRUSADER:
                case ENCHANT_WEAPON_CINDERGLACIER:
                case ENCHANT_WEAPON_RAZORICE:
                case ENCHANT_WEAPON_LICHBANE:
                case ENCHANT_WEAPON_SPELLBREAKING:
                case ENCHANT_WEAPON_SPELLSHATTERING:
                case ENCHANT_WEAPON_SWORDBREAKING:
                case ENCHANT_WEAPON_SWORDSHATTERING:
                case ENCHANT_WEAPON_NERUBIAN_CARAPACE:
                case ENCHANT_WEAPON_STONESKIN_GARGOYLE:
                {
                    if (pItemTemplate->Class == ITEM_CLASS_WEAPON && player->getClass() != CLASS_DEATH_KNIGHT)
                        return false;

                    break;
                }
                case ENCHANT_GLOVES_SOCKET:
                case ENCHANT_BRACER_SOCKET:
                {
                    if (player->GetSkillValue(SKILL_BLACKSMITHING) < 450)
                        return false;

                    break;
                }
                case ENCHANT_RING_ASSAULT:
                case ENCHANT_RING_GREATER_SPELLPOWER:
                case ENCHANT_RING_STAMINA:
                {
                    if (player->GetSkillValue(SKILL_ENCHANTING) < 450)
                        return false;

                    break;
                }
                case ENCHANT_HEAD_MIND_AMPLIFICATION_DISH:
                case ENCHANT_GLOVES_HAND_MOUNTED_PRYO_ROCKET:
                case ENCHANT_GLOVES_HYPERSPEED_ACCELERATORS:
                case ENCHANT_BELT_FRAG_BELT:
                case ENCHANT_BOOTS_NITRO_BOOSTS:
                case ENCHANT_CLOAK_FLEXWEAVE_UNDERLAY:
                case ENCHANT_CLOAK_SPRINGY_ARACHNOWEAVE:
                {
                    if (player->GetSkillValue(SKILL_ENGINEERING) < 450)
                        return false;

                    for (uint8 i = 0; i < MAX_ITEM_SPELLS; ++i)
                        if (pItemTemplate->Spells[i].SpellId && !pItemTemplate->Spells[i].SpellTrigger)
                            return false;

                    break;
                }
                case ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_AXE:
                case ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_STORM:
                case ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_CRAG:
                case ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_PINNACLE:
                {
                    if (player->GetSkillValue(SKILL_INSCRIPTION) < 450)
                        return false;

                    break;
                }
                case ENCHANT_BRACER_FUR_LINING_ATTACKPOWER:
                case ENCHANT_BRACER_FUR_LINING_SPELLPOWER:
                case ENCHANT_BRACER_FUR_LINING_AGILITY:
                case ENCHANT_BRACER_FUR_LINING_STAMINA:
                {
                    if (player->GetSkillValue(SKILL_LEATHERWORKING) < 450)
                        return false;

                    break;
                }
                case ENCHANT_CLOAK_SWORDGUARD_EMBROIDERY:
                case ENCHANT_CLOAK_LIGHTWEAVE_EMBROIDERY:
                case ENCHANT_CLOAK_DARKGLOW_EMBROIDERY:
                {
                    if (player->GetSkillValue(SKILL_TAILORING) < 450)
                        return false;

                    break;
                }
            }

            return true;
        }

        bool HandleEnchants(Player* player, Creature* creature, uint32 enchantOption)
        {
            switch (enchantOption)
            {
                case MENU_ENCHANTS:
                {
                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Head", MENU_ENCHANTS, ENCHANT_OPTION_HEAD);

                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Shoulders", MENU_ENCHANTS, ENCHANT_OPTION_SHOULDERS);

                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Chest", MENU_ENCHANTS, ENCHANT_OPTION_CHEST);

                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Gloves", MENU_ENCHANTS, ENCHANT_OPTION_GLOVES);

                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Legs", MENU_ENCHANTS, ENCHANT_OPTION_LEGS);

                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Bracers", MENU_ENCHANTS, ENCHANT_OPTION_BRACERS);

                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Belt", MENU_ENCHANTS, ENCHANT_OPTION_BELT);

                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Boots", MENU_ENCHANTS, ENCHANT_OPTION_BOOTS);

                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Cloak", MENU_ENCHANTS, ENCHANT_OPTION_CLOAK);

                    if (player->GetSkillValue(SKILL_ENCHANTING) >= 450)
                    {
                        if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Ring 1", MENU_ENCHANTS, ENCHANT_OPTION_RING1);

                        if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Ring 2", MENU_ENCHANTS, ENCHANT_OPTION_RING2);
                    }

                    if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Main Hand", MENU_ENCHANTS, ENCHANT_OPTION_MAIN_HAND);

                    if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND))
                        if (item->GetTemplate()->InventoryType != INVTYPE_HOLDABLE)
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Off Hand", MENU_ENCHANTS, ENCHANT_OPTION_OFF_HAND);

                    if (Item* item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED))
                        if (item->GetTemplate()->InventoryType != INVTYPE_RELIC && item->GetTemplate()->SubClass != ITEM_SUBCLASS_WEAPON_WAND)
                            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Ranged", MENU_ENCHANTS, ENCHANT_OPTION_RANGED);

                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_HEAD:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your head slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+50 Attack Power & +20 Resilience", ENCHANT_OPTION_HEAD, ENCHANT_HEAD_ARCANUM_OF_TRIUMPH);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+29 Spell Power & +20 Resilience", ENCHANT_OPTION_HEAD, ENCHANT_HEAD_ARCANUM_OF_DOMINANCE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+50 Attack Power & +20 Crit", ENCHANT_OPTION_HEAD, ENCHANT_HEAD_ARCANUM_OF_TORMENT);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+30 Spell Power & +20 Crit", ENCHANT_OPTION_HEAD, ENCHANT_HEAD_ARCANUM_OF_BURNING_MYSTERIES);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+30 Spell Power & +10 MP5", ENCHANT_OPTION_HEAD, ENCHANT_HEAD_ARCANUM_OF_BLISSFUL_MENDING);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+37 Stamina & +20 Dodge", ENCHANT_OPTION_HEAD, ENCHANT_HEAD_ARCANUM_OF_THE_STALWART_PROTECTOR);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+30 Stamina & +25 Resilience", ENCHANT_OPTION_HEAD, ENCHANT_HEAD_ARCANUM_OF_THE_SAVAGE_GLADIATOR);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_SHOULDERS:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your shoulder slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+40 Attack Power & +15 Resilience", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDER_INSCRIPTION_OF_TRIUMPH);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+23 Spell Power & +15 Resilience", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDER_INSCRIPTION_OF_DOMINANCE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+40 Attack Power & +15 Crit", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_AXE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+24 Spell Power & +15 Crit", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_STORM);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+24 Spell Power & +8 MP5", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_CRAG);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+20 Dodge & +22 Stamina", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_PINNACLE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+30 Stamina & +15 Resilience", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDER_GREATER_INSCRIPTION_OF_THE_GLADIATOR);

                    if (player->GetSkillValue(SKILL_INSCRIPTION) >= 450)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+120 Attack Power & +15 Crit", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_AXE);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+70 Spell Power & +15 Crit", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_STORM);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+70 Spell Power & +8 MP5", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_CRAG);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+60 Dodge & +15 Parry", ENCHANT_OPTION_SHOULDERS, ENCHANT_SHOULDERS_MASTERS_INSCRIPTION_OF_THE_PINNACLE);
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_CHEST:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your chest slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+20 Resilience", ENCHANT_OPTION_CHEST, ENCHANT_CHEST_EXCEPTIONAL_RESILIENCE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+10 Stats", ENCHANT_OPTION_CHEST, ENCHANT_CHEST_POWERFUL_STATS);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+275 Health", ENCHANT_OPTION_CHEST, ENCHANT_CHEST_SUPER_HEALTH);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_GLOVES:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your hands slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+44 Attack Power", ENCHANT_OPTION_GLOVES, ENCHANT_GLOVES_CRUSHER);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+28 Spell Power", ENCHANT_OPTION_GLOVES, ENCHANT_GLOVES_EXCEPTIONAL_SPELLPOWER);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+20 Agility", ENCHANT_OPTION_GLOVES, ENCHANT_GLOVES_MAJOR_AGILITY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+20 Hit Rating", ENCHANT_OPTION_GLOVES, ENCHANT_GLOVES_PERCISION);

                    if (player->GetSkillValue(SKILL_BLACKSMITHING) >= 450)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Socket Gloves [|cffFF0000Requires Engineering|r]", ENCHANT_OPTION_GLOVES, ENCHANT_GLOVES_SOCKET);

                    if (player->GetSkillValue(SKILL_ENGINEERING) >= 450)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Hand-Mounted Pyro Rocket", ENCHANT_OPTION_GLOVES, ENCHANT_GLOVES_HAND_MOUNTED_PRYO_ROCKET);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Hyperspeed Accelerators", ENCHANT_OPTION_GLOVES, ENCHANT_GLOVES_HYPERSPEED_ACCELERATORS);
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_LEGS:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your legs slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+75 Attack Power & +22 Crit", ENCHANT_OPTION_LEGS, ENCHANT_LEGS_ICESCALE_LEG_ARMOR);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+50 Spell Power & +30 Stamina", ENCHANT_OPTION_LEGS, ENCHANT_LEGS_SAPPHIRE_SPELLTHREAD);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+50 Spell Power & +20 Spirit", ENCHANT_OPTION_LEGS, ENCHANT_LEGS_BRILLIANT_SPELLTHREAD);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+55 Stamina & +22 Agility", ENCHANT_OPTION_LEGS, ENCHANT_LEGS_FROSTHIDE_LEG_ARMOR);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+40 Resilience & +28 Stamina", ENCHANT_OPTION_LEGS, ENCHANT_LEGS_EARTHEN_LEG_ARMOR);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_BRACERS:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your wrists slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+50 Attack Power", ENCHANT_OPTION_BRACERS, ENCHANT_BRACERS_GREATER_ASSAULT);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+30 Spell Power", ENCHANT_OPTION_BRACERS, ENCHANT_BRACERS_SUPERIOR_SPELLPOWER);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+16 Intellect", ENCHANT_OPTION_BRACERS, ENCHANT_BRACERS_EXCEPTIONAL_INTELLECT);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+18 Spirit", ENCHANT_OPTION_BRACERS, ENCHANT_BRACERS_MAJOR_SPIRIT);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+40 Stamina", ENCHANT_OPTION_BRACERS, ENCHANT_BRACERS_MAJOR_STAMINA);

                    if (player->GetSkillValue(SKILL_BLACKSMITHING) >= 450)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Socket Bracer [|cffFF0000Requires Leatherworking / Blacksmithing|r]", ENCHANT_OPTION_BRACERS, ENCHANT_BRACER_SOCKET);

                    if (player->GetSkillValue(SKILL_LEATHERWORKING) >= 450)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+130 Attack Power", ENCHANT_OPTION_BRACERS, ENCHANT_BRACER_FUR_LINING_ATTACKPOWER);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+76 Spell Power", ENCHANT_OPTION_BRACERS, ENCHANT_BRACER_FUR_LINING_SPELLPOWER);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+57 Agility", ENCHANT_OPTION_BRACERS, ENCHANT_BRACER_FUR_LINING_AGILITY);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+102 Stamina", ENCHANT_OPTION_BRACERS, ENCHANT_BRACER_FUR_LINING_STAMINA);
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_BELT:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WAIST);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your waist slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    if (player->GetSkillValue(SKILL_ENGINEERING) >= 450)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Frag Belt [|cffFF0000Requires Engineering|r]", ENCHANT_OPTION_BELT, ENCHANT_BELT_FRAG_BELT);

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Eternal Belt Buckle", ENCHANT_OPTION_BELT, ENCHANT_BELT_ETERNAL_BELT_BUCKLE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_BOOTS:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your feet slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+32 Attack Power", ENCHANT_OPTION_BOOTS, ENCHANT_BOOTS_GREATER_ASSULT);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+22 Stamina", ENCHANT_OPTION_BOOTS, ENCHANT_BOOTS_GREATER_FORTITUDE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+16 Agility", ENCHANT_OPTION_BOOTS, ENCHANT_BOOTS_SUPERIOR_AGILITY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+12 Hit Rating & +12 Critical", ENCHANT_OPTION_BOOTS, ENCHANT_BOOTS_ICEWALKER);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+15 Stamina & +8% Movement Speed", ENCHANT_OPTION_BOOTS, ENCHANT_BOOTS_TUSKARR_VITALITY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+7 MP5 & +7 Health every 5 seconds", ENCHANT_OPTION_BOOTS, ENCHANT_BOOTS_GREATER_VITALITY);

                    if (player->GetSkillValue(SKILL_ENGINEERING) >= 450)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Nitro Boosts [|cffFF0000Requires Engineering|r]", ENCHANT_OPTION_BOOTS, ENCHANT_BOOTS_NITRO_BOOSTS);

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_CLOAK:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your back slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+35 Spell Penetration", ENCHANT_OPTION_CLOAK, ENCHANT_CLOAK_SPELL_PIERCING);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+22 Agility", ENCHANT_OPTION_CLOAK, ENCHANT_CLOAK_MAJOR_AGILITY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+22 Haste", ENCHANT_OPTION_CLOAK, ENCHANT_CLOAK_GREATER_SPEED);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+10 Agility & +1 Steath Level", ENCHANT_OPTION_CLOAK, ENCHANT_CLOAK_SHADOW_ARMOR);

                    if (player->GetSkillValue(SKILL_ENGINEERING) >= 450)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Flexweave Underlay", ENCHANT_OPTION_CLOAK, ENCHANT_CLOAK_FLEXWEAVE_UNDERLAY);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Springy Arachnoweave [|cffFF0000Requires Tailoring|r]", ENCHANT_OPTION_CLOAK, ENCHANT_CLOAK_SPRINGY_ARACHNOWEAVE);
                    }

                    if (player->GetSkillValue(SKILL_TAILORING) >= 450)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Swordguard Embroidery", ENCHANT_OPTION_CLOAK, ENCHANT_CLOAK_SWORDGUARD_EMBROIDERY);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Lightweave Embroidery", ENCHANT_OPTION_CLOAK, ENCHANT_CLOAK_LIGHTWEAVE_EMBROIDERY);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Darkglow Embroidery", ENCHANT_OPTION_CLOAK, ENCHANT_CLOAK_DARKGLOW_EMBROIDERY);
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_RING1:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your finger slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    if (player->GetSkillValue(SKILL_ENCHANTING) >= 450)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+40 Attack Power", ENCHANT_OPTION_RING1, ENCHANT_RING_ASSAULT);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+23 Spell Power", ENCHANT_OPTION_RING1, ENCHANT_RING_GREATER_SPELLPOWER);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+30 Stamina", ENCHANT_OPTION_RING1, ENCHANT_RING_STAMINA);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                        player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    }
                    break;
                }
                case ENCHANT_OPTION_RING2:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your finger slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    if (player->GetSkillValue(SKILL_ENCHANTING) >= 450)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+40 Attack Power", ENCHANT_OPTION_RING2, ENCHANT_RING_ASSAULT);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+23 Spell Power", ENCHANT_OPTION_RING2, ENCHANT_RING_GREATER_SPELLPOWER);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+30 Stamina", ENCHANT_OPTION_RING2, ENCHANT_RING_STAMINA);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                        player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    }
                    break;
                }
                case ENCHANT_OPTION_MAIN_HAND:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your main hand slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    const ItemTemplate* pItemTemplate = pItem->GetTemplate();
                    if (!pItemTemplate)
                    {
                        player->GetSession()->SendNotification("Unable to get template data for the item in your main hand slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    if (pItemTemplate->InventoryType == INVTYPE_2HWEAPON)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+110 Attack Power", ENCHANT_OPTION_MAIN_HAND, ENCHANT_2H_WEAPON_MASSACRE);

                    if (pItemTemplate->SubClass == ITEM_SUBCLASS_WEAPON_STAFF)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+81 Spell Power", ENCHANT_OPTION_MAIN_HAND, ENCHANT_STAFF_GREATER_SPELLPOWER);

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Berserking", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_BERSERKING);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Black Magic", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_BLACK_MAGIC);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Blood Draining", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_BLOOD_DRAINING);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Blade Warding", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_BLADE_WARDING);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Titanium Weapon Chain", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_TITANIUM_WEAPON_CHAIN);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+65 Attack Power", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_SUPERIOR_POTENCY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+63 Spell Power", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_MIGHTY_SPELLPOWER);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+26 Agility", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_EXCEPTIONAL_AGILITY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+45 Spirit", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_EXCEPTIONAL_SPIRIT);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+50 Stamina", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_TITANGUARD);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+25 Hit Rating & +25 Crit", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_ACCURACY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Mongoose", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_MONGOOSE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Executioner", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_EXECUTIONER);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Deathfrost", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_DEATHFROST);

                    if (player->getClass() == CLASS_DEATH_KNIGHT)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Fallen Crusader", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_FALLEN_CRUSADER);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Cinderglacier", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_CINDERGLACIER);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Razorice", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_RAZORICE);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Lichbane", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_LICHBANE);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Spellbreaking", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_SPELLBREAKING);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Spellshattering", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_SPELLSHATTERING);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Swordbreaking", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_SWORDBREAKING);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Swordshattering", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_SWORDSHATTERING);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Nerubian Carapace", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_NERUBIAN_CARAPACE);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Stoneskin Gargoyle", ENCHANT_OPTION_MAIN_HAND, ENCHANT_WEAPON_STONESKIN_GARGOYLE);
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_OFF_HAND:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your off hand slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    const ItemTemplate* pItemTemplate = pItem->GetTemplate();
                    if (!pItemTemplate)
                    {
                        player->GetSession()->SendNotification("Unable to get template data for the item in your off hand slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    if (pItemTemplate->InventoryType == INVTYPE_HOLDABLE)
                    {
                        player->GetSession()->SendNotification("Incorrect weapon type equipped");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    if (pItemTemplate->InventoryType == INVTYPE_2HWEAPON)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+110 Attack Power", ENCHANT_OPTION_MAIN_HAND, ENCHANT_2H_WEAPON_MASSACRE);

                    if (pItemTemplate->SubClass == ITEM_SUBCLASS_WEAPON_STAFF)
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+81 Spell Power", ENCHANT_OPTION_MAIN_HAND, ENCHANT_STAFF_GREATER_SPELLPOWER);

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Berserking", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_BERSERKING);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Black Magic", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_BLACK_MAGIC);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Blood Draining", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_BLOOD_DRAINING);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Blade Warding", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_BLADE_WARDING);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Titanium Weapon Chain", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_TITANIUM_WEAPON_CHAIN);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+65 Attack Power", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_SUPERIOR_POTENCY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+63 Spell Power", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_MIGHTY_SPELLPOWER);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+26 Agility", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_EXCEPTIONAL_AGILITY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+45 Spirit", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_EXCEPTIONAL_SPIRIT);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+50 Stamina", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_TITANGUARD);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+25 Hit Rating & +25 Crit", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_ACCURACY);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Mongoose", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_MONGOOSE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Executioner", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_EXECUTIONER);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Deathfrost", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_DEATHFROST);

                    if (player->getClass() == CLASS_DEATH_KNIGHT)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Fallen Crusader", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_FALLEN_CRUSADER);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Cinderglacier", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_CINDERGLACIER);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Razorice", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_RAZORICE);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Lichbane", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_LICHBANE);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Spellbreaking", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_SPELLBREAKING);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Spellshattering", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_SPELLSHATTERING);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Swordbreaking", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_SWORDBREAKING);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Swordshattering", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_SWORDSHATTERING);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Nerubian Carapace", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_NERUBIAN_CARAPACE);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Stoneskin Gargoyle", ENCHANT_OPTION_OFF_HAND, ENCHANT_WEAPON_STONESKIN_GARGOYLE);
                    }

                    if (pItemTemplate->InventoryType == INVTYPE_SHIELD)
                    {
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Titanium Plating", ENCHANT_OPTION_OFF_HAND, ENCHANT_SHIELD_TITANIUM_PLATING);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+25 Intellect", ENCHANT_OPTION_OFF_HAND, ENCHANT_SHIELD_GREATER_INTELLECT);
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+12 Resilience", ENCHANT_OPTION_OFF_HAND, ENCHANT_SHIELD_RESILIENCE);
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
                case ENCHANT_OPTION_RANGED:
                {
                    Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_RANGED);
                    if (!pItem)
                    {
                        player->GetSession()->SendNotification("You have no item equipped in your ranged slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    const ItemTemplate* pItemTemplate = pItem->GetTemplate();
                    if (!pItemTemplate)
                    {
                        player->GetSession()->SendNotification("Unable to get template data for the item in your off hand slot");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    if (pItemTemplate->InventoryType == INVTYPE_RELIC || pItemTemplate->SubClass == ITEM_SUBCLASS_WEAPON_WAND)
                    {
                        player->GetSession()->SendNotification("Incorrect weapon type equipped");
                        player->CLOSE_GOSSIP_MENU();
                        return false;
                    }

                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+40 Ranged Crit", ENCHANT_OPTION_RANGED, ENCHANT_RANGED_HEARTSEEKER_SCOPE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+40 Ranged Haste", ENCHANT_OPTION_RANGED, ENCHANT_RANGED_SUN_SCOPE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "+15 Ranged Weapon Damage", ENCHANT_OPTION_RANGED, ENCHANT_RANGED_DIAMOND_CUT_REFRACTOR_SCOPE);
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TABARD, "Back", MENU_ENCHANTS, MENU_ENCHANTS);
                    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
                    break;
                }
            }
            return true;
        }
};

void AddSC_EnchantsNPC()
{
    new npc_enchantment; 
}
