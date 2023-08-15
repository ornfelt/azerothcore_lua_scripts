

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "Language.h"
#include "Player.h"
#include "DatabaseEnv.h"
#include "WorldSession.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "ServiceMgr.h"
#include "Chat.h"
#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Language.h"
#include "SpellMgr.h"
#include "SpellInfo.h"
#include "Player.h"
#include "Pet.h"
#include "ScriptMgr.h"
#include "Config.h"






class npc_promotion_blue_equip : public CreatureScript
{
public:
    npc_promotion_blue_equip() : CreatureScript("npc_promotion_blue_equip") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        ChatHandler handler(player);
        player->PlayerTalkClass->ClearMenus();
        
        if (player)
        if (player->getClass() == CLASS_DEATH_KNIGHT)
        {
            player->SEND_GOSSIP_MENU(100021, creature->GetGUID());
            return true;
        }

        if (player->getLevel() == 90)
        {
            if (!Profession(player))
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_ALCHEMY), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_SKINNING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_ENCHANTING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_HERBALISM), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_BLACKSMITHING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_ENGINEERING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_INSCRIPTION), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_JEWELCRAFTING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 15);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_MINING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 16);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_LEATHERWORKING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 17);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_TAILORING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 18);
            }
        }

        if (player->getLevel() != 1)
        {
            if (player && creature)
                player->SEND_GOSSIP_MENU(100022, creature->GetGUID());
            return true;
        }

        if (AccountRewarded(player))
        {
            if (player->getLevel() == 90)
            {
                if (player->GetTeamId() == TEAM_ALLIANCE)
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_TELEPORT_TO_SW), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                else
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_TELEPORT_TO_ORGRI), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            }

            player->SEND_GOSSIP_MENU(100023, creature->GetGUID());
            return true;
        }

        switch (player->getClass())
        {
        case CLASS_WARRIOR:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_WARRIOR_ARMS_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_WARRIOR_FURY_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_WARRIOR_PROTECT_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            break;

        case CLASS_PALADIN:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_PALADIN_RET_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_PALADIN_PROTECT_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_PALADIN_HOLY_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            break;

        case CLASS_PRIEST:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_PRIEST_HEAL_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            //player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_PRIEST_SHADOW_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            break;

        case CLASS_SHAMAN:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_SHAMAN_HEAL_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_SHAMAN_ELEMENTAL_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_SHAMAN_ENHANCEMENT_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            break;

        case CLASS_DRUID:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_DRUID_CASTER_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_DRUID_HEAL_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_DRUID_FERAL_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_DRUID_CASTER_PVE), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);
            break;

        case CLASS_MONK:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "DPS PvP", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "HEAL PvP", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            break;

        case CLASS_WARLOCK:
        case CLASS_HUNTER:
        case CLASS_MAGE:
        case CLASS_ROGUE:
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_GIVE_ME_MY_PROMO_PVP), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
            break;
        }

        player->SEND_GOSSIP_MENU(100019, creature->GetGUID());

        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();

        if (action > GOSSIP_ACTION_INFO_DEF && action < 1007)
        {
            // Level
            player->GiveLevel(90);

            // Equipment specs
            switch (player->getClass())
            {
                case CLASS_MAGE:
                    player->LearnSpell(193759, false);
                    break;
                case CLASS_MONK:
                    player->LearnSpell(126892, false);
                    break;
                case CLASS_DRUID:
                    player->LearnSpell(193753, false);
                    break;
                case CLASS_SHAMAN:
                case CLASS_HUNTER:
                    player->LearnSpell(8737, false);
                    break;

                case CLASS_WARRIOR:
                case CLASS_PALADIN:
                    player->LearnSpell(750, false);
                    break;

                default:
                    break;
            }

            // Bags
            for (int slot = INVENTORY_SLOT_BAG_START; slot < INVENTORY_SLOT_BAG_END; slot++)
                if (Item* bag = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                    player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);

            for (int slot = INVENTORY_SLOT_BAG_START; slot < INVENTORY_SLOT_BAG_END; slot++)
                player->EquipNewItem(slot, 10050, true);

            // Money
            player->ModifyMoney(100000000);

            // Ridding
            player->LearnSpell(33388, false);
            player->LearnSpell(33391, false);
            player->LearnSpell(34090, false);
            player->LearnSpell(34091, false);
            player->LearnSpell(90265, false);
            player->LearnSpell(54197, false);
            player->LearnSpell(90267, false);

            // Mounts
            player->LearnSpell(43688, false); // Amani War Bear
            player->LearnSpell(75614, false); // Celestial horse
            player->LearnSpell(46199, false); // X-51 Nether-Rocket X-TREME
			player->LearnSpell(46199, false); // X-51 Nether-Rocket X-TREME
            // Worgen misc
            if (player->getRace() == RACE_WORGEN)
            {
                player->LearnSpell(94293, false);
                player->LearnSpell(68978, false);
                player->LearnSpell(68996, false);
                player->LearnSpell(68976, false);
                player->LearnSpell(68992, false);
                player->CastSpell(player, 97709, true);
            }

            // Goblin misc
            if (player->getRace() == RACE_GOBLIN)
                player->LearnSpell(69046, false);

            // Equipment sets
            if (!Profession(player))
                for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; slot++)
                    if (Item* pItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                        player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);

            switch (player->GetTeam())
            {
            case HORDE:
            {
                switch (player->getClass())
                {
                case CLASS_WARLOCK:
                {
                    switch (action)
                    {
                    case 1001: // PvP
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98922, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98925, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98924, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98769, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98921, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98764, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98923, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98767, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61350, true);
                        break;
                    }
                    }
                    break;
                }

                case CLASS_HUNTER:
                {
                    switch (action)
                    {
                    case 1001: // PvP
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98822, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98824, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98820, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98818, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98821, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98814, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98823, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98817, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 77528, true);
                        break;
                    }
                    }
                    break;
                }

                case CLASS_MAGE:
                {
                    switch (action)
                    {
                    case 1001: // PvP
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98826, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98829, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98828, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98770, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98825, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98763, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98827, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98766, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61350, true);
                        break;
                    }
                    }
                    break;
                }

                case CLASS_ROGUE:
                {
                    switch (action)
                    {
                    case 1001: // PvP
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98886, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98888, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98884, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98832, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98885, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98881, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98887, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98882, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82967, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82967, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61348, true);
                        break;
                    }
                    }
                    break;
                }

                case CLASS_WARRIOR:
                {
                    switch (action)
                    {
                    case 1001: // Armas
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98928, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98930, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98926, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98927, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98929, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1002: // Furi
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98928, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98930, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98926, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98927, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98929, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1003: // Proteccion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98928, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98930, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98926, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98927, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98929, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }
                    }

                    break;
                }

                case CLASS_PALADIN:
                {
                    switch (action)
                    {
                    case 1001: // Represion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98845, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98847, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98843, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98844, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98846, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1002: // Proteccion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98845, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98847, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98843, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98844, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98846, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1003: // Sagrado
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98856, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98858, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98854, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98853, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98855, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98849, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98857, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98851, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82963, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82968, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70629, true);
                        break;
                    }
                    }

                    break;
                }

                case CLASS_PRIEST:
                {
                    switch (action)
                    {
                    case 1001: // HEAL
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98866, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98869, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98868, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98771, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98865, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98765, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98867, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98768, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61351, true);
                        break;
                    }

                    case 1002: // Sombras
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98871, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98874, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98873, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98770, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98870, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98763, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98872, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98766, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61350, true);
                        break;
                    }
                    }

                    break;
                }

                case CLASS_SHAMAN:
                {
                    switch (action)
                    {
                    case 1001: // Restauracion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98896, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98898, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98894, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98893, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98895, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98889, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98897, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98891, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82963, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82968, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70630, true);
                        break;
                    }

                    case 1002: // Elemental
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98907, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98909, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98905, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98892, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98906, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98904, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98908, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98890, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82963, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82968, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70629, true);
                        break;
                    }

                    case 1003: // Mejora
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98901, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98903, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98899, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98818, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98900, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98814, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98902, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98817, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 85183, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 85183, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70631, true);
                        break;
                    }
                    }

                    break;
                }

                case CLASS_DRUID:
                {
                    switch (action)
                    {
                    case 1001: // Equilibrio
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98809, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98808, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98804, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98807, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70629, true);
                        break;
                    }

                    case 1002: // Restauracion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98797, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98794, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98799, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98795, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70630, true);
                        break;
                    }

                    case 1003: // Feral
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98790, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98793, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98792, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98883, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98789, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98830, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98791, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98831, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79342, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70631, true);
                        break;
                    }

                    case 1004: // Feral
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98790, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98793, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98792, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98883, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98789, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98830, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98791, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98831, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79342, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70631, true);
                        break;
                    }

                    }

                    break;
                }

                case CLASS_MONK:
                {
                    switch (action)
                    {
                    case 1001: // DPS
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98834, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98836, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98837, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98883, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98833, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98830, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98835, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98831, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79342, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 61331, true);
                        break;
                    }

                    case 1002: // Heal
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98839, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98841, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98842, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98838, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98794, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98840, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98795, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        break;
                    }

                    }
                    break;
                }
                }
                break;
            }
            case ALLIANCE:
            {
                switch (player->getClass())
                {
                case CLASS_WARLOCK:
                {
                    switch (action)
                    {
                    case 1001: // PvP
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98922, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98925, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98924, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98769, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98921, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98764, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98923, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98767, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61350, true);
                        break;
                    }

                    case 1002: // PvE
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98922, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98925, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98924, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98769, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98921, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98764, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98923, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98767, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61350, true);
                        break;
                    }
                    }
                    break;
                }

                case CLASS_HUNTER:
                {
                    switch (action)
                    {
                    case 1001: // PvP
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98822, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98824, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98820, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98818, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98821, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98814, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98823, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98817, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 77528, true);
                        break;
                    }

                    case 1002: // PvE
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98822, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98824, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98820, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98818, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98821, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98814, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98823, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98817, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 77528, true);
                        break;
                    }
                    }
                    break;
                }

                case CLASS_MAGE:
                {
                    switch (action)
                    {
                    case 1001: // PvP
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98826, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98829, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98828, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98770, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98825, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98763, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98827, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98766, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61350, true);
                        break;
                    }

                    case 1002: // PvE
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98826, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98829, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98828, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98770, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98825, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98763, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98827, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98766, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61350, true);
                        break;
                    }
                    }
                    break;
                }

                case CLASS_ROGUE:
                {
                    switch (action)
                    {
                    case 1001: // PvP
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98886, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98888, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98884, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98832, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98885, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98881, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98887, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98882, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82967, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82967, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61348, true);
                        break;
                    }

                    case 1002: // PvE
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98886, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98888, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98884, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98832, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98885, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98881, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98887, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98882, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82967, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82967, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61348, true);
                        break;
                    }
                    }
                    break;
                }

                case CLASS_WARRIOR:
                {
                    switch (action)
                    {
                    case 1001: // Armas
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98928, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98930, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98926, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98927, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98929, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1002: // Furi
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98928, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98930, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98926, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98927, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98929, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1003: // Proteccion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98928, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98930, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98926, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98927, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98929, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1004: // Armas
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98928, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98930, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98926, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98927, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98929, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1005: // Furi
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98928, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98930, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98926, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98927, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98929, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1006: // Proteccion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98928, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98930, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98926, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98927, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98929, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }
                    }

                    break;
                }

                case CLASS_PALADIN:
                {
                    switch (action)
                    {
                    case 1001: // Represion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98845, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98847, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98843, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98844, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98846, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1002: // Proteccion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98845, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98847, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98913, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98843, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98864, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98844, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98860, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98846, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98862, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103989, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82966, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61347, true);
                        break;
                    }

                    case 1003: // Sagrado
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98856, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98858, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98854, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98853, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98855, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98849, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98857, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98851, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82963, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82968, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70629, true);
                        break;
                    }
                    }

                    break;
                }

                case CLASS_PRIEST:
                {
                    switch (action)
                    {
                    case 1001: // HEAL
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98866, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98869, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98868, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98771, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98865, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98765, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98867, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98768, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61351, true);
                        break;
                    }

                    case 1002: // Sombras
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 124823, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 70622, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 124826, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 70556, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 124825, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 70548, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 124822, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 124694, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 124824, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 124695, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 118306, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 118309, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 133596, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 125970, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 61342, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61351, true);
                        break;
                    }

                    case 1003: // Disciplina heal
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 124823, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 70622, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 124826, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 70556, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 124825, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 70548, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 124822, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 124694, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 124824, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 124695, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 118306, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 118309, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 133596, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 125970, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 61342, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61351, true);
                        break;
                    }

                    case 1004: // Sombras
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98871, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98874, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98873, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98770, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98870, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98763, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98872, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98766, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 61350, true);
                        break;
                    }
                    }

                    break;
                }

                case CLASS_SHAMAN:
                {
                    switch (action)
                    {
                    case 1001: // Restauracion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98896, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98898, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98894, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98893, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98895, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98889, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98897, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98891, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82963, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82968, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70630, true);
                        break;
                    }

                    case 1002: // Elemental
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98907, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98909, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98905, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98892, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98906, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98904, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98908, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98890, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82963, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82968, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70629, true);
                        break;
                    }

                    case 1003: // Mejora
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98901, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98903, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98899, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98818, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98900, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98814, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98902, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98817, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 85183, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 85183, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70631, true);
                        break;
                    }

                    case 1004: // Restauracion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98896, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98898, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98894, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98893, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98895, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98889, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98897, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98891, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82963, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82968, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70630, true);
                        break;
                    }

                    case 1005: // Elemental
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98907, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98909, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98905, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98892, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98906, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98904, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98908, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98890, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 82963, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 82968, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70629, true);
                        break;
                    }

                    case 1006: // Mejora
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98901, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98903, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98899, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98818, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98900, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98814, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98902, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98817, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 85183, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 85183, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70631, true);
                        break;
                    }
                    }

                    break;
                }

                case CLASS_DRUID:
                {
                    switch (action)
                    {
                    case 1001: // Equilibrio
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98809, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98808, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98804, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98807, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70629, true);
                        break;
                    }

                    case 1002: // Restauracion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98797, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98794, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98799, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98795, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70630, true);
                        break;
                    }

                    case 1003: // Feral
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98790, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98793, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98792, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98883, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98789, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98830, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98791, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98831, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79342, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70631, true);
                        break;
                    }

                    case 1004: // Equilibrio
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98809, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98772, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98808, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98804, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98805, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98802, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98807, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103987, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70629, true);
                        break;
                    }

                    case 1005: // Restauracion
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98800, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98797, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98794, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98799, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98795, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70630, true);
                        break;
                    }

                    case 1006: // Feral
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98790, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98793, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98792, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98883, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98789, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98830, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98791, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98831, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79342, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_RANGED, 70631, true);
                        break;
                    }

                    }

                    break;
                }

                case CLASS_MONK:
                {
                    switch (action)
                    {
                    case 1001: // DPS
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98834, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83803, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98836, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98756, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98837, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98883, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98833, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98830, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98835, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98831, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83798, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103986, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79342, true);
                        //player->EquipNewItem(EQUIPMENT_SLOT_OFFHAND, 61331, true);
                        break;
                    }

                    case 1002: // Heal
                    {
                        player->EquipNewItem(EQUIPMENT_SLOT_HEAD, 98839, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_NECK, 83806, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_SHOULDERS, 98841, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_BACK, 98774, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_CHEST, 98842, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WRISTS, 98796, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_HANDS, 98838, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_WAIST, 98794, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_LEGS, 98840, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FEET, 98795, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER1, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_FINGER2, 83801, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET1, 102483, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_TRINKET2, 103988, true);
                        player->EquipNewItem(EQUIPMENT_SLOT_MAINHAND, 79339, true);
                        break;
                    }

                    }
                    break;
                }
                }
                break;
            }
            }
            player->SaveToDB();
            player->CLOSE_GOSSIP_MENU();

            // Account protection
            std::string ip_address;
            QueryResult result = LoginDatabase.PQuery(
                "SELECT last_ip FROM account WHERE id = %u",
                player->GetSession()->GetAccountId());

            if (result)
            {
                Field* fields = result->Fetch();
                ip_address = fields[0].GetCString();

                CharacterDatabase.PExecute("INSERT INTO promotions_rewarded (account, ip) VALUES ( %u, '%s')", player->GetSession()->GetAccountId(), fields[0].GetCString());
            }

            if (!Profession(player))
            {
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_ALCHEMY), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 8);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_SKINNING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 9);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_ENCHANTING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 10);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_HERBALISM), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 11);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_BLACKSMITHING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 12);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_ENGINEERING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 13);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_INSCRIPTION), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 14);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_JEWELCRAFTING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 15);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_MINING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 16);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_LEATHERWORKING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 17);
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_TAILORING), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 18);

                player->CLOSE_GOSSIP_MENU();
            }

            if (Profession(player))
            {
                if (player->GetTeamId() == TEAM_ALLIANCE)
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_TELEPORT_TO_SW), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
                else
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_TELEPORT_TO_ORGRI), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            }

            player->SEND_GOSSIP_MENU(100020, creature->GetGUID());
        }

        if (action > 1007 && action < 1019)
        {
            player->PlayerTalkClass->ClearMenus();
            player->CLOSE_GOSSIP_MENU();

            uint32 skill = 0;
            uint32 spellid = 0;
            uint32 level = 600;
            uint32 max = 600;

            switch (action)
            {
            case 1008: // Alquimia
                skill = 171;
                spellid = 2259;
                break;
            case 1009: // Desuello
                skill = 393;
                spellid = 8613;
                break;
            case 1010: // Encantamiento
                level = 524;
                skill = 333;
                spellid = 7411;
                break;
            case 1011: // Herboristería
                skill = 182;
                spellid = 2366;
                break;
            case 1012: // Herrería
                skill = 164;
                spellid = 2018;
                break;
            case 1013: // Ingeniería
                skill = 202;
                spellid = 4036;
                break;
            case 1014: // Inscripción
                skill = 773;
                spellid = 45357;
                break;
            case 1015: // Joyería
                skill = 755;
                spellid = 25229;
                break;
            case 1016: // Minería
                skill = 186;
                spellid = 2575;
                break;
            case 1017: // Peletería
                skill = 165;
                spellid = 2108;
                break;
            case 1018: // Sastrería
                skill = 197;
                spellid = 3908;
                break;
            }

            std::string ip_address;
            QueryResult result = LoginDatabase.PQuery(
                "SELECT last_ip FROM account WHERE id = %u",
                player->GetSession()->GetAccountId());

            if (result)
            {
                Field* fields = result->Fetch();
                ip_address = fields[0].GetCString();

                uint16 targetHasSkill = player->GetSkillValue(skill);

                player->LearnSpell(spellid, false);

                if (targetHasSkill)
                    player->SetSkill(skill, player->GetSkillStep(skill), level, max);
                else
                    player->SetSkill(skill, 1, level, max);

                CharacterDatabase.PExecute("UPDATE `promotions_rewarded` SET `profession` = profession-1 WHERE `account` = %u OR `ip` = '%s'", player->GetSession()->GetAccountId(), fields[0].GetCString());
            }

            //player->SaveToDB();

            if (player->GetTeamId() == TEAM_ALLIANCE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_TELEPORT_TO_SW), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
            else
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, sObjectMgr->GetTrinityStringForDBCLocale(LANG_PROMOTION_TELEPORT_TO_ORGRI), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 7);
        }

        return true;
    }

    bool Profession(Player* player)
    {
        QueryResult result = CharacterDatabase.PQuery("SELECT `profession` FROM `promotions_rewarded` WHERE `account` = %u", player->GetSession()->GetAccountId());
        if (result)
        {
            Field * pField = result->Fetch();
            uint32 profession = pField[0].GetUInt32();
            if (profession < 1)
                return true;
        }
        return false;
    }

    bool AccountRewarded(Player* player)
    {
        std::string ip_address;
        QueryResult result = LoginDatabase.PQuery(
            "SELECT last_ip FROM account WHERE id = %u",
            player->GetSession()->GetAccountId());

        if (result)
        {
            Field* fields = result->Fetch();
            ip_address = fields[0].GetCString();

            QueryResult result1 = CharacterDatabase.PQuery("SELECT `account` FROM `promotions_rewarded` WHERE `account` = %u OR `ip` = '%s'", player->GetSession()->GetAccountId(), fields[0].GetCString());
            if (result1)
            {
                Field * pField = result1->Fetch();
                uint32 account = pField[0].GetUInt32();
                if (account)
                    return true;
            }
            return false;
        }
        return false;
    }
};

//class PlayerScript_reward_mount : public PlayerScript
//{
//public:
	//PlayerScript_reward_mount() : PlayerScript("PlayerScript_reward_mount") { }

	//void OnLogin(Player* player, bool firstLogin)
	//{
		//if (player->HasSpell(136505) || player->GetItemByEntry(93671))
			//return;

		//if (firstLogin)
			//player->AddItem(79771, 1);

	//	player->AddItem(93671, 1);
	//}
//};

class PlayerScript_Loyalty_System : public PlayerScript
{
public:
    PlayerScript_Loyalty_System() : PlayerScript("PlayerScript_Loyalty_System") { }

    uint32 rewardTimer = 450000; // 15 min playing

    void OnLevelChanged(Player* player, uint8 oldLevel) override
    {
        for (uint8 i = 1; i < 12; ++i)
        {
            uint64 money = ((20000 * (i*(10 + i)))*0.153f);

            if (oldLevel > 80)
                money *= i;

            if (player->getLevel() == uint8(i * 10))
                player->ModifyMoney(round(money));
        }
    }

    void OnPlayerUpdate(Player* player, uint32 diff) override
    {
        if (rewardTimer <= diff)
        {
            if (player)
                LoginDatabase.PExecute("UPDATE account SET loyalty_points = loyalty_points+10 WHERE id = %u", player->GetSession()->GetAccountId());

            rewardTimer = 900000; // 15 min playing
        }
        else
            rewardTimer -= diff;
    }
};

void AddSC_promotions_and_rewards()
{
   //new PlayerScript_reward_mount();
    new npc_promotion_blue_equip();
    new PlayerScript_Loyalty_System();
    
}
