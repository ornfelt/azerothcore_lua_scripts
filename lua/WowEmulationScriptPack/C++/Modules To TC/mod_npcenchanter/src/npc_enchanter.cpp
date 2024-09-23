/*

# Enchanter NPC #

#### A module for AzerothCore by [StygianTheBest](https://github.com/StygianTheBest/AzerothCore-Content/tree/master/Modules)
------------------------------------------------------------------------------------------------------------------


### Description ###
------------------------------------------------------------------------------------------------------------------
Creates an NPC that enchants the player's gear


### Data ###
------------------------------------------------------------------------------------------------------------------
- Type: NPC
- Script: npc_enchantment
- Config: Yes
    - Enable Module Announce
- SQL: Yes
    - NPC ID: 601015


### Version ###
------------------------------------------------------------------------------------------------------------------
- v2017-08-08 - Release


### Credits ###
------------------------------------------------------------------------------------------------------------------
- [LordPsyan](https://bitbucket.org/lordpsyan/lordpsyan-patches)
- [Blizzard Entertainment](http://blizzard.com)
- [TrinityCore](https://github.com/TrinityCore/TrinityCore/blob/3.3.5/THANKS)
- [SunwellCore](http://www.azerothcore.org/pages/sunwell.pl/)
- [AzerothCore](https://github.com/AzerothCore/azerothcore-wotlk/graphs/contributors)
- [AzerothCore Discord](https://discord.gg/gkt4y2x)
- [EMUDevs](https://youtube.com/user/EmuDevs)
- [AC-Web](http://ac-web.org/)
- [ModCraft.io](http://modcraft.io/)
- [OwnedCore](http://ownedcore.com/)
- [OregonCore](https://wiki.oregon-core.net/)
- [Wowhead.com](http://wowhead.com)
- [AoWoW](https://wotlk.evowow.com/)


### License ###
------------------------------------------------------------------------------------------------------------------
- This code and content is released under the [GNU AGPL v3](https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3).

*/

#include "ScriptMgr.h"
#include "Configuration/Config.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GameEventMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Unit.h"
#include "GameObject.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "InstanceScript.h"
#include "CombatAI.h"
#include "PassiveAI.h"
#include "Chat.h"
#include "Item.h"
#include "DBCStructure.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "ScriptPCH.h"


enum Enchants
{
    ENCHANT_WEP_BERSERKING = 3789,
    ENCHANT_WEP_BLADE_WARD = 3869,
    ENCHANT_WEP_BLOOD_DRAINING = 3870,
    ENCHANT_WEP_ACCURACY = 3788,
    ENCHANT_WEP_AGILITY_1H = 1103,
    ENCHANT_WEP_SPIRIT = 3844,
    ENCHANT_WEP_BATTLEMASTER = 2675,
    ENCHANT_WEP_BLACK_MAGIC = 3790,
    ENCHANT_WEP_ICEBREAKER = 3239,
    ENCHANT_WEP_LIFEWARD = 3241,
    ENCHANT_WEP_MIGHTY_SPELL_POWER = 3834, // One-hand
    ENCHANT_WEP_EXECUTIONER = 3225,
    ENCHANT_WEP_POTENCY = 3833,
    ENCHANT_WEP_TITANGUARD = 3851,
    ENCHANT_2WEP_MASSACRE = 3827,
    ENCHANT_2WEP_SCOURGEBANE = 3247,
    ENCHANT_2WEP_GIANT_SLAYER = 3251,
    ENCHANT_2WEP_GREATER_SPELL_POWER = 3854,
    ENCHANT_2WEP_AGILITY = 2670,
    ENCHANT_2WEP_MONGOOSE = 2673,

    ENCHANT_SHIELD_DEFENSE = 1952,
    ENCHANT_SHIELD_INTELLECT = 1128,
    ENCHANT_SHIELD_RESILIENCE = 3229,
    ENCHANT_SHIELD_BLOCK = 2655,
    ENCHANT_SHIELD_STAMINA = 1071,
    ENCHANT_SHIELD_TOUGHSHIELD = 2653,
    ENCHANT_SHIELD_TITANIUM_PLATING = 3849,

    ENCHANT_HEAD_BLISSFUL_MENDING = 3819,
    ENCHANT_HEAD_BURNING_MYSTERIES = 3820,
    ENCHANT_HEAD_DOMINANCE = 3796,
    ENCHANT_HEAD_SAVAGE_GLADIATOR = 3842,
    ENCHANT_HEAD_STALWART_PROTECTOR = 3818,
    ENCHANT_HEAD_TORMENT = 3817,
    ENCHANT_HEAD_TRIUMPH = 3795,
    ENCHANT_HEAD_ECLIPSED_MOON = 3815,
    ENCHANT_HEAD_FLAME_SOUL = 3816,
    ENCHANT_HEAD_FLEEING_SHADOW = 3814,
    ENCHANT_HEAD_FROSTY_SOUL = 3812,
    ENCHANT_HEAD_TOXIC_WARDING = 3813,

    ENCHANT_SHOULDER_MASTERS_AXE = 3835,
    ENCHANT_SHOULDER_MASTERS_CRAG = 3836,
    ENCHANT_SHOULDER_MASTERS_PINNACLE = 3837,
    ENCHANT_SHOULDER_MASTERS_STORM = 3838,
    ENCHANT_SHOULDER_GREATER_AXE = 3808,
    ENCHANT_SHOULDER_GREATER_CRAG = 3809,
    ENCHANT_SHOULDER_GREATER_GLADIATOR = 3852,
    ENCHANT_SHOULDER_GREATER_PINNACLE = 3811,
    ENCHANT_SHOULDER_GREATER_STORM = 3810,
    ENCHANT_SHOULDER_DOMINANCE = 3794,
    ENCHANT_SHOULDER_TRIUMPH = 3793,

    ENCHANT_CLOAK_DARKGLOW_EMBROIDERY = 3728,
    ENCHANT_CLOAK_SWORDGUARD_EMBROIDERY = 3730,
    ENCHANT_CLOAK_LIGHTWEAVE_EMBROIDERY = 3722,
    ENCHANT_CLOAK_SPRINGY_ARACHNOWEAVE = 3859,
    ENCHANT_CLOAK_WISDOM = 3296,
    ENCHANT_CLOAK_TITANWEAVE = 1951,
    ENCHANT_CLOAK_SPELL_PIERCING = 3243,
    ENCHANT_CLOAK_SHADOW_ARMOR = 3256,
    ENCHANT_CLOAK_MIGHTY_ARMOR = 3294,
    ENCHANT_CLOAK_MAJOR_AGILITY = 1099,
    ENCHANT_CLOAK_GREATER_SPEED = 3831,

    ENCHANT_LEG_EARTHEN = 3853,
    ENCHANT_LEG_FROSTHIDE = 3822,
    ENCHANT_LEG_ICESCALE = 3823,
    ENCHANT_LEG_BRILLIANT_SPELLTHREAD = 3719,
    ENCHANT_LEG_SAPPHIRE_SPELLTHREAD = 3721,
    ENCHANT_LEG_DRAGONSCALE = 3331,
    ENCHANT_LEG_WYRMSCALE = 3332,

    ENCHANT_GLOVES_GREATER_BLASTING = 3249,
    ENCHANT_GLOVES_ARMSMAN = 3253,
    ENCHANT_GLOVES_CRUSHER = 1603,
    ENCHANT_GLOVES_AGILITY = 3222,
    ENCHANT_GLOVES_PRECISION = 3234,
    ENCHANT_GLOVES_EXPERTISE = 3231,

    ENCHANT_BRACERS_MAJOR_STAMINA = 3850,
    ENCHANT_BRACERS_SUPERIOR_SP = 2332,
    ENCHANT_BRACERS_GREATER_ASSUALT = 3845,
    ENCHANT_BRACERS_MAJOR_SPIRT = 1147,
    ENCHANT_BRACERS_EXPERTISE = 3231,
    ENCHANT_BRACERS_GREATER_STATS = 2661,
    ENCHANT_BRACERS_INTELLECT = 1119,
    ENCHANT_BRACERS_FURL_ARCANE = 3763,
    ENCHANT_BRACERS_FURL_FIRE = 3759,
    ENCHANT_BRACERS_FURL_FROST = 3760,
    ENCHANT_BRACERS_FURL_NATURE = 3762,
    ENCHANT_BRACERS_FURL_SHADOW = 3761,
    ENCHANT_BRACERS_FURL_ATTACK = 3756,
    ENCHANT_BRACERS_FURL_STAMINA = 3757,
    ENCHANT_BRACERS_FURL_SPELLPOWER = 3758,

    ENCHANT_CHEST_POWERFUL_STATS = 3832,
    ENCHANT_CHEST_SUPER_HEALTH = 3297,
    ENCHANT_CHEST_GREATER_MAINA_REST = 2381,
    ENCHANT_CHEST_EXCEPTIONAL_RESIL = 3245,
    ENCHANT_CHEST_GREATER_DEFENSE = 1953,

    ENCHANT_BOOTS_GREATER_ASSULT = 1597,
    ENCHANT_BOOTS_TUSKARS_VITLIATY = 3232,
    ENCHANT_BOOTS_SUPERIOR_AGILITY = 983,
    ENCHANT_BOOTS_GREATER_SPIRIT = 1147,
    ENCHANT_BOOTS_GREATER_VITALITY = 3244,
    ENCHANT_BOOTS_ICEWALKER = 3826,
    ENCHANT_BOOTS_GREATER_FORTITUDE = 1075,
    ENCHANT_BOOTS_NITRO_BOOTS = 3606,
    ENCHANT_BOOTS_PYRO_ROCKET = 3603,
    ENCHANT_BOOTS_HYPERSPEED = 3604,
    ENCHANT_BOOTS_ARMOR_WEBBING = 3860,

    ENCHANT_RING_ASSULT = 3839,
    ENCHANT_RING_GREATER_SP = 3840,
    ENCHANT_RING_STAMINA = 3791,
};

void Enchant(Player* player, Item* item, uint32 enchantid)
{
    if (!item)
    {
        player->GetSession()->SendNotification("You must first equip the item you are trying to enchant in order to enchant it!");
        return;
    }

    if (!enchantid)
    {
        player->GetSession()->SendNotification("Something went wrong in the code. It has been logged for developers and will be looked into, sorry for the inconvenience.");
        return;
    }

    item->ClearEnchantment(PERM_ENCHANTMENT_SLOT);
    item->SetEnchantment(PERM_ENCHANTMENT_SLOT, enchantid, 0, 0);
    player->GetSession()->SendNotification("|cff0000FF%s |cffFF0000succesfully enchanted!", item->GetTemplate()->Name1.c_str());
}

class EnchanterAnnounce : public PlayerScript
{

public:

    EnchanterAnnounce() : PlayerScript("EnchanterAnnounce") {}

    void OnLogin(Player* player, bool firstLogin)
    {
        if (firstLogin) {
            // Announce Module
            if (sConfigMgr->GetBoolDefault("EnchanterNPC.Announce", true))
            {
                ChatHandler(player->GetSession()).SendSysMessage("This server is running the |cff4CFF00EnchanterNPC |rmodule.");
            }
        }
    }
};


class npc_enchantment : public CreatureScript
{

public:

    npc_enchantment() : CreatureScript("npc_enchantment") { }

    // Passive Emotes
    struct NPC_PassiveAI : public ScriptedAI
    {
        NPC_PassiveAI(Creature* creature) : ScriptedAI(creature) { }

        bool OnGossipHello(Player* player)
        {
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Welcome to the enchanting NPC!]", GOSSIP_SENDER_MAIN, 0);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Weapon]", GOSSIP_SENDER_MAIN, 1);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant 2H Weapon]", GOSSIP_SENDER_MAIN, 2);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Shield]", GOSSIP_SENDER_MAIN, 3);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Head]", GOSSIP_SENDER_MAIN, 4);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Shoulders]", GOSSIP_SENDER_MAIN, 5);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Cloak]", GOSSIP_SENDER_MAIN, 6);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Chest]", GOSSIP_SENDER_MAIN, 7);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Bracers]", GOSSIP_SENDER_MAIN, 8);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Gloves]", GOSSIP_SENDER_MAIN, 9);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Legs]", GOSSIP_SENDER_MAIN, 10);
            AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Feet]", GOSSIP_SENDER_MAIN, 11);

            if (player->HasSkill(SKILL_ENCHANTING) && player->GetSkillValue(SKILL_ENCHANTING) == 450)
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Rings]", GOSSIP_SENDER_MAIN, 12);
            SendGossipMenuFor(player, 601015, me);
            return true;
        }

        bool OnGossipSelect(Player* player, uint32 menuId, uint32 gossipListId)
        {
            uint32 const sender = player->PlayerTalkClass->GetGossipOptionSender(gossipListId);
            uint32 const action = player->PlayerTalkClass->GetGossipOptionAction(gossipListId);
            Item* item;
            ClearGossipMenuFor(player);

            switch (action)
            {
            case 0: //Welcome message on click
                player->GetSession()->SendAreaTriggerMessage("|cffFF0000Hello there, I will be enchanting your gear!");

                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Welcome to the enchanting NPC!]", GOSSIP_SENDER_MAIN, 0);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Weapon]", GOSSIP_SENDER_MAIN, 1);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant 2H Weapon]", GOSSIP_SENDER_MAIN, 2);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Shield]", GOSSIP_SENDER_MAIN, 3);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Head]", GOSSIP_SENDER_MAIN, 4);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Shoulders]", GOSSIP_SENDER_MAIN, 5);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Cloak]", GOSSIP_SENDER_MAIN, 6);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Chest]", GOSSIP_SENDER_MAIN, 7);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Bracers]", GOSSIP_SENDER_MAIN, 8);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Gloves]", GOSSIP_SENDER_MAIN, 9);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Legs]", GOSSIP_SENDER_MAIN, 10);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Feet]", GOSSIP_SENDER_MAIN, 11);

                    if (player->HasSkill(SKILL_ENCHANTING) && player->GetSkillValue(SKILL_ENCHANTING) == 450)
                        AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Rings]", GOSSIP_SENDER_MAIN, 12);

                    SendGossipMenuFor(player, 100001, me);

                    return true;
                    break;
                }


            case 1: // Enchant Weapon
                if (player->HasSkill(SKILL_ENCHANTING) && player->GetSkillValue(SKILL_ENCHANTING) == 450)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Blade Ward", GOSSIP_SENDER_MAIN, 102);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Blood Draining", GOSSIP_SENDER_MAIN, 103);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Exceptional Agility", GOSSIP_SENDER_MAIN, 100);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Exceptional Spirit", GOSSIP_SENDER_MAIN, 101);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Accuracy", GOSSIP_SENDER_MAIN, 104);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Black Magic", GOSSIP_SENDER_MAIN, 105);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Berserking", GOSSIP_SENDER_MAIN, 106);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Battlemaster", GOSSIP_SENDER_MAIN, 107);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Icebreaker", GOSSIP_SENDER_MAIN, 108);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Lifeward", GOSSIP_SENDER_MAIN, 109);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Titanguard", GOSSIP_SENDER_MAIN, 110);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Superior Potency", GOSSIP_SENDER_MAIN, 111);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Mighty Spellpower", GOSSIP_SENDER_MAIN, 112);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Mongoose", GOSSIP_SENDER_MAIN, 113);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Executioner", GOSSIP_SENDER_MAIN, 114);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100002, me);
                return true;
                break;

            case 2: // Enchant 2H Weapon
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND);
                if (!item)
                {
                    me->Whisper("This enchant needs a 2H weapon equipped.", LANG_UNIVERSAL, player);
                    CloseGossipMenuFor(player);
                    return false;
                }
                if (item->GetTemplate()->InventoryType == INVTYPE_2HWEAPON)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Berserking", GOSSIP_SENDER_MAIN, 104);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Mongoose", GOSSIP_SENDER_MAIN, 113);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Executioner", GOSSIP_SENDER_MAIN, 114);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Spellpower", GOSSIP_SENDER_MAIN, 115);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Major Agility", GOSSIP_SENDER_MAIN, 116);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Massacre", GOSSIP_SENDER_MAIN, 117);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                }
                else
                {
                    me->Whisper("This enchant needs a 2H weapon equipped.", LANG_UNIVERSAL, player);
                    CloseGossipMenuFor(player);
                }
                SendGossipMenuFor(player, 100003, me);
                return true;
                break;

            case 3: // Enchant Shield
                item = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND);
                if (!item)
                {
                    me->Whisper("This enchant needs a shield equipped.", LANG_UNIVERSAL, player);
                    CloseGossipMenuFor(player);
                    return false;
                }
                if (item->GetTemplate()->InventoryType == INVTYPE_SHIELD)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Defense", GOSSIP_SENDER_MAIN, 118);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Intellect", GOSSIP_SENDER_MAIN, 119);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Resilience", GOSSIP_SENDER_MAIN, 120);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Titanium Plating", GOSSIP_SENDER_MAIN, 121);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Major Stamina", GOSSIP_SENDER_MAIN, 122);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Tough Shield", GOSSIP_SENDER_MAIN, 123);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                }
                else
                {
                    me->Whisper("This enchant needs a shield equipped.", LANG_UNIVERSAL, player);
                    CloseGossipMenuFor(player);

                }
                SendGossipMenuFor(player, 100004, me);
                return true;
                break;

            case 4: // Enchant Head
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of Blissful Mending", GOSSIP_SENDER_MAIN, 124);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of Burning Mysteries", GOSSIP_SENDER_MAIN, 125);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of Dominance", GOSSIP_SENDER_MAIN, 126);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of The Savage Gladiator", GOSSIP_SENDER_MAIN, 127);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of The Stalwart Protector", GOSSIP_SENDER_MAIN, 128);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of Torment", GOSSIP_SENDER_MAIN, 129);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of Triumph", GOSSIP_SENDER_MAIN, 130);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of Eclipsed Moon", GOSSIP_SENDER_MAIN, 131);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of the Flame's Soul", GOSSIP_SENDER_MAIN, 132);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of the Fleeing Shadow", GOSSIP_SENDER_MAIN, 133);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of the Frosty Soul", GOSSIP_SENDER_MAIN, 134);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Arcanum of Toxic Warding", GOSSIP_SENDER_MAIN, 135);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100005, me);
                return true;
                break;

            case 5: // Enchant Shoulders
                if (player->HasSkill(SKILL_INSCRIPTION) && player->GetSkillValue(SKILL_INSCRIPTION) == 450)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Master's Inscription of the Axe", GOSSIP_SENDER_MAIN, 136);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Master's Inscription of the Crag", GOSSIP_SENDER_MAIN, 137);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Master's Inscription of the Pinnacle", GOSSIP_SENDER_MAIN, 138);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Master's Inscription of the Storm", GOSSIP_SENDER_MAIN, 139);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Inscription of the Axe", GOSSIP_SENDER_MAIN, 140);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Inscription of the Crag", GOSSIP_SENDER_MAIN, 141);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Inscription of the Pinnacle", GOSSIP_SENDER_MAIN, 142);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Inscription of the Gladiator", GOSSIP_SENDER_MAIN, 143);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Inscription of the Storm", GOSSIP_SENDER_MAIN, 144);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Inscription of Dominance", GOSSIP_SENDER_MAIN, 145);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Inscription of Triumph", GOSSIP_SENDER_MAIN, 146);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100006, me);
                return true;
                break;

            case 6: // Enchant Cloak
                if (player->HasSkill(SKILL_TAILORING) && player->GetSkillValue(SKILL_TAILORING) == 450)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Darkglow Embroidery", GOSSIP_SENDER_MAIN, 149);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Lightweave Embroidery", GOSSIP_SENDER_MAIN, 150);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Swordguard Embroidery", GOSSIP_SENDER_MAIN, 151);
                }
                if (player->HasSkill(SKILL_ENGINEERING) && player->GetSkillValue(SKILL_ENGINEERING) == 450)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Springy Arachnoweave", GOSSIP_SENDER_MAIN, 147);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Shadow Armor", GOSSIP_SENDER_MAIN, 148);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Wisdom", GOSSIP_SENDER_MAIN, 152);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Titanweave", GOSSIP_SENDER_MAIN, 153);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Spell Piercing", GOSSIP_SENDER_MAIN, 154);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Mighty Armor", GOSSIP_SENDER_MAIN, 155);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Major Agility", GOSSIP_SENDER_MAIN, 156);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Speed", GOSSIP_SENDER_MAIN, 157);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100007, me);
                return true;
                break;

            case 7: //Enchant chest
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Powerful Stats", GOSSIP_SENDER_MAIN, 158);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Super Health", GOSSIP_SENDER_MAIN, 159);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Mana Restoration", GOSSIP_SENDER_MAIN, 160);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Exceptional Resilience", GOSSIP_SENDER_MAIN, 161);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Defense", GOSSIP_SENDER_MAIN, 162);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100008, me);
                return true;
                break;

            case 8: //Enchant Bracers
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Major Stamina", GOSSIP_SENDER_MAIN, 163);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Superior Spell Power", GOSSIP_SENDER_MAIN, 164);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Assult", GOSSIP_SENDER_MAIN, 165);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Major Spirit", GOSSIP_SENDER_MAIN, 166);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Expertise", GOSSIP_SENDER_MAIN, 167);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Stats", GOSSIP_SENDER_MAIN, 168);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Exceptional Intellect", GOSSIP_SENDER_MAIN, 169);
                if (player->HasSkill(SKILL_LEATHERWORKING) && player->GetSkillValue(SKILL_LEATHERWORKING) == 450)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Fur Lining - Arcane Resist", GOSSIP_SENDER_MAIN, 170);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Fur Lining - Fire Resist", GOSSIP_SENDER_MAIN, 171);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Fur Lining - Frost Resist", GOSSIP_SENDER_MAIN, 172);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Fur Lining - Nature Resist", GOSSIP_SENDER_MAIN, 173);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Fur Lining - Shadow Resist", GOSSIP_SENDER_MAIN, 174);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Fur Lining - Attack power", GOSSIP_SENDER_MAIN, 175);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Fur Lining - Stamina", GOSSIP_SENDER_MAIN, 176);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Fur Lining - Spellpower", GOSSIP_SENDER_MAIN, 177);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100009, me);
                return true;
                break;

            case 9: //Enchant Gloves
                if (player->HasSkill(SKILL_ENGINEERING) && player->GetSkillValue(SKILL_ENGINEERING) == 450)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Blasting", GOSSIP_SENDER_MAIN, 178);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Armsman", GOSSIP_SENDER_MAIN, 179);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Crusher", GOSSIP_SENDER_MAIN, 180);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Agility", GOSSIP_SENDER_MAIN, 181);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Precision", GOSSIP_SENDER_MAIN, 182);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Expertise", GOSSIP_SENDER_MAIN, 183);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100010, me);
                return true;
                break;

            case 10: //Enchant legs
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Earthen Leg Armor", GOSSIP_SENDER_MAIN, 184);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Frosthide Leg Armor", GOSSIP_SENDER_MAIN, 185);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Icescale Leg Armor", GOSSIP_SENDER_MAIN, 186);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Brilliant Spellthread", GOSSIP_SENDER_MAIN, 187);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Sapphire Spellthread", GOSSIP_SENDER_MAIN, 188);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Dragonscale Leg Armor", GOSSIP_SENDER_MAIN, 189);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Wyrmscale Leg Armor", GOSSIP_SENDER_MAIN, 190);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100011, me);
                return true;
                break;

            case 11: //Enchant feet
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Assult", GOSSIP_SENDER_MAIN, 191);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Tuskars Vitliaty", GOSSIP_SENDER_MAIN, 192);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Superior Agility", GOSSIP_SENDER_MAIN, 193);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Spirit", GOSSIP_SENDER_MAIN, 194);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Vitality", GOSSIP_SENDER_MAIN, 195);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Icewalker", GOSSIP_SENDER_MAIN, 196);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Fortitude", GOSSIP_SENDER_MAIN, 197);
                if (player->HasSkill(SKILL_ENGINEERING) && player->GetSkillValue(SKILL_ENGINEERING) == 450)
                {
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Nitro Boots", GOSSIP_SENDER_MAIN, 198);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Hand-Mounted Pyro Rocket", GOSSIP_SENDER_MAIN, 199);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Hyperspeed Accedlerators", GOSSIP_SENDER_MAIN, 200);
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Reticulated Armor Webbing", GOSSIP_SENDER_MAIN, 201);
                }
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100012, me);
                return true;
                break;

            case 12: //Enchant rings
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Assult", GOSSIP_SENDER_MAIN, 202);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Greater Spell Power", GOSSIP_SENDER_MAIN, 203);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "Stamina", GOSSIP_SENDER_MAIN, 204);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "<-Back", GOSSIP_SENDER_MAIN, 300);
                SendGossipMenuFor(player, 100013, me);
                return true;
                break;

            case 100:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_AGILITY_1H);
                CloseGossipMenuFor(player);
                break;

            case 101:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_SPIRIT);
                CloseGossipMenuFor(player);
                break;

            case 102:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_BLADE_WARD);
                CloseGossipMenuFor(player);
                break;

            case 103:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_BLOOD_DRAINING);
                CloseGossipMenuFor(player);
                break;

            case 104:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_BERSERKING);
                CloseGossipMenuFor(player);
                break;

            case 105:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_ACCURACY);
                CloseGossipMenuFor(player);
                break;

            case 106:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_BLACK_MAGIC);
                CloseGossipMenuFor(player);
                break;

            case 107:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_BATTLEMASTER);
                CloseGossipMenuFor(player);
                break;

            case 108:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_ICEBREAKER);
                CloseGossipMenuFor(player);
                break;

            case 109:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_LIFEWARD);
                CloseGossipMenuFor(player);
                break;

            case 110:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_TITANGUARD);
                CloseGossipMenuFor(player);
                break;

            case 111:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_POTENCY);
                CloseGossipMenuFor(player);
                break;

            case 112:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_MIGHTY_SPELL_POWER);
                CloseGossipMenuFor(player);
                break;

            case 113:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_2WEP_MONGOOSE);
                CloseGossipMenuFor(player);
                break;

            case 114:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_WEP_EXECUTIONER);
                CloseGossipMenuFor(player);
                break;

            case 115:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_2WEP_GREATER_SPELL_POWER);
                CloseGossipMenuFor(player);
                break;

            case 116:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_2WEP_AGILITY);
                CloseGossipMenuFor(player);
                break;

            case 117:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND), ENCHANT_2WEP_MASSACRE);
                CloseGossipMenuFor(player);
                break;

            case 118:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND), ENCHANT_SHIELD_DEFENSE);
                CloseGossipMenuFor(player);
                break;

            case 119:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND), ENCHANT_SHIELD_INTELLECT);
                CloseGossipMenuFor(player);
                break;

            case 120:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND), ENCHANT_SHIELD_RESILIENCE);
                CloseGossipMenuFor(player);
                break;

            case 121:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND), ENCHANT_SHIELD_TITANIUM_PLATING);
                CloseGossipMenuFor(player);
                break;

            case 122:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND), ENCHANT_SHIELD_STAMINA);
                CloseGossipMenuFor(player);
                break;

            case 123:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_OFFHAND), ENCHANT_SHIELD_TOUGHSHIELD);
                CloseGossipMenuFor(player);
                break;

            case 124:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_BLISSFUL_MENDING);
                CloseGossipMenuFor(player);
                break;

            case 125:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_BURNING_MYSTERIES);
                CloseGossipMenuFor(player);
                break;

            case 126:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_DOMINANCE);
                CloseGossipMenuFor(player);
                break;

            case 127:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_SAVAGE_GLADIATOR);
                CloseGossipMenuFor(player);
                break;

            case 128:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_STALWART_PROTECTOR);
                CloseGossipMenuFor(player);
                break;

            case 129:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_TORMENT);
                CloseGossipMenuFor(player);
                break;

            case 130:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_TRIUMPH);
                CloseGossipMenuFor(player);
                break;

            case 131:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_ECLIPSED_MOON);
                CloseGossipMenuFor(player);
                break;

            case 132:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_FLAME_SOUL);
                CloseGossipMenuFor(player);
                break;

            case 133:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_FLEEING_SHADOW);
                CloseGossipMenuFor(player);
                break;

            case 134:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_FROSTY_SOUL);
                CloseGossipMenuFor(player);
                break;

            case 135:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HEAD), ENCHANT_HEAD_TOXIC_WARDING);
                CloseGossipMenuFor(player);
                break;

            case 136:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_MASTERS_AXE);
                CloseGossipMenuFor(player);
                break;

            case 137:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_MASTERS_CRAG);
                CloseGossipMenuFor(player);
                break;

            case 138:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_MASTERS_PINNACLE);
                CloseGossipMenuFor(player);
                break;

            case 139:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_MASTERS_STORM);
                CloseGossipMenuFor(player);
                break;

            case 140:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_GREATER_AXE);
                CloseGossipMenuFor(player);
                break;

            case 141:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_GREATER_CRAG);
                CloseGossipMenuFor(player);
                break;

            case 142:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_GREATER_GLADIATOR);
                CloseGossipMenuFor(player);
                break;

            case 143:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_GREATER_PINNACLE);
                CloseGossipMenuFor(player);
                break;

            case 144:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_GREATER_STORM);
                CloseGossipMenuFor(player);
                break;

            case 145:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_DOMINANCE);
                CloseGossipMenuFor(player);
                break;

            case 146:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_SHOULDERS), ENCHANT_SHOULDER_TRIUMPH);
                CloseGossipMenuFor(player);
                break;

            case 147:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_SPRINGY_ARACHNOWEAVE);
                CloseGossipMenuFor(player);
                break;

            case 148:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_SHADOW_ARMOR);
                CloseGossipMenuFor(player);
                break;

            case 149:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_DARKGLOW_EMBROIDERY);
                CloseGossipMenuFor(player);
                break;

            case 150:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_LIGHTWEAVE_EMBROIDERY);
                CloseGossipMenuFor(player);
                break;

            case 151:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_SWORDGUARD_EMBROIDERY);
                CloseGossipMenuFor(player);
                break;

            case 152:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_WISDOM);
                CloseGossipMenuFor(player);
                break;

            case 153:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_TITANWEAVE);
                CloseGossipMenuFor(player);
                break;

            case 154:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_SPELL_PIERCING);
                CloseGossipMenuFor(player);
                break;

            case 155:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_MIGHTY_ARMOR);
                CloseGossipMenuFor(player);
                break;

            case 156:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_MAJOR_AGILITY);
                CloseGossipMenuFor(player);
                break;

            case 157:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_BACK), ENCHANT_CLOAK_GREATER_SPEED);
                CloseGossipMenuFor(player);
                break;

            case 158:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST), ENCHANT_CHEST_POWERFUL_STATS);
                CloseGossipMenuFor(player);
                break;

            case 159:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST), ENCHANT_CHEST_SUPER_HEALTH);
                CloseGossipMenuFor(player);
                break;

            case 160:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST), ENCHANT_CHEST_GREATER_MAINA_REST);
                CloseGossipMenuFor(player);
                break;

            case 161:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST), ENCHANT_CHEST_EXCEPTIONAL_RESIL);
                CloseGossipMenuFor(player);
                break;

            case 162:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_CHEST), ENCHANT_CHEST_GREATER_DEFENSE);
                CloseGossipMenuFor(player);
                break;

            case 163:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_MAJOR_STAMINA);
                CloseGossipMenuFor(player);
                break;

            case 164:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_SUPERIOR_SP);
                CloseGossipMenuFor(player);
                break;

            case 165:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_GREATER_ASSUALT);
                CloseGossipMenuFor(player);
                break;

            case 166:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_MAJOR_SPIRT);
                CloseGossipMenuFor(player);
                break;

            case 167:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_EXPERTISE);
                CloseGossipMenuFor(player);
                break;

            case 168:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_GREATER_STATS);
                CloseGossipMenuFor(player);
                break;

            case 169:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_INTELLECT);
                CloseGossipMenuFor(player);
                break;

            case 170:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_FURL_ARCANE);
                CloseGossipMenuFor(player);
                break;

            case 171:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_FURL_FIRE);
                CloseGossipMenuFor(player);
                break;

            case 172:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_FURL_FROST);
                CloseGossipMenuFor(player);
                break;

            case 173:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_FURL_NATURE);
                CloseGossipMenuFor(player);
                break;

            case 174:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_FURL_SHADOW);
                CloseGossipMenuFor(player);
                break;

            case 175:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_FURL_ATTACK);
                CloseGossipMenuFor(player);
                break;

            case 176:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_FURL_STAMINA);
                CloseGossipMenuFor(player);
                break;

            case 177:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_WRISTS), ENCHANT_BRACERS_FURL_SPELLPOWER);
                CloseGossipMenuFor(player);
                break;

            case 178:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS), ENCHANT_GLOVES_GREATER_BLASTING);
                CloseGossipMenuFor(player);
                break;

            case 179:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS), ENCHANT_GLOVES_ARMSMAN);
                CloseGossipMenuFor(player);
                break;

            case 180:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS), ENCHANT_GLOVES_CRUSHER);
                CloseGossipMenuFor(player);
                break;

            case 181:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS), ENCHANT_GLOVES_AGILITY);
                CloseGossipMenuFor(player);
                break;

            case 182:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS), ENCHANT_GLOVES_PRECISION);
                CloseGossipMenuFor(player);
                break;

            case 183:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_HANDS), ENCHANT_GLOVES_EXPERTISE);
                CloseGossipMenuFor(player);
                break;

            case 184:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS), ENCHANT_LEG_EARTHEN);
                CloseGossipMenuFor(player);
                break;

            case 185:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS), ENCHANT_LEG_FROSTHIDE);
                CloseGossipMenuFor(player);
                break;

            case 186:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS), ENCHANT_LEG_ICESCALE);
                CloseGossipMenuFor(player);
                break;

            case 187:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS), ENCHANT_LEG_BRILLIANT_SPELLTHREAD);
                CloseGossipMenuFor(player);
                break;

            case 188:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS), ENCHANT_LEG_SAPPHIRE_SPELLTHREAD);
                CloseGossipMenuFor(player);
                break;

            case 189:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS), ENCHANT_LEG_DRAGONSCALE);
                CloseGossipMenuFor(player);
                break;

            case 190:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_LEGS), ENCHANT_LEG_WYRMSCALE);
                CloseGossipMenuFor(player);
                break;

            case 191:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_GREATER_ASSULT);
                CloseGossipMenuFor(player);
                break;

            case 192:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_TUSKARS_VITLIATY);
                CloseGossipMenuFor(player);
                break;

            case 193:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_SUPERIOR_AGILITY);
                CloseGossipMenuFor(player);
                break;

            case 194:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_GREATER_SPIRIT);
                CloseGossipMenuFor(player);
                break;

            case 195:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_GREATER_VITALITY);
                CloseGossipMenuFor(player);
                break;

            case 196:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_ICEWALKER);
                CloseGossipMenuFor(player);
                break;

            case 197:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_GREATER_FORTITUDE);
                CloseGossipMenuFor(player);
                break;

            case 198:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_NITRO_BOOTS);
                CloseGossipMenuFor(player);
                break;

            case 199:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_PYRO_ROCKET);
                CloseGossipMenuFor(player);
                break;

            case 200:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_HYPERSPEED);
                CloseGossipMenuFor(player);
                break;

            case 201:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FEET), ENCHANT_BOOTS_ARMOR_WEBBING);
                CloseGossipMenuFor(player);
                break;

            case 202:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1), ENCHANT_RING_ASSULT);
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2), ENCHANT_RING_ASSULT);
                CloseGossipMenuFor(player);
                break;

            case 203:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1), ENCHANT_RING_GREATER_SP);
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2), ENCHANT_RING_GREATER_SP);
                CloseGossipMenuFor(player);
                break;

            case 204:
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER1), ENCHANT_RING_STAMINA);
                Enchant(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_FINGER2), ENCHANT_RING_STAMINA);
                CloseGossipMenuFor(player);
                break;

            case 300:
            {
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Welcome to the enchanting NPC!]", GOSSIP_SENDER_MAIN, 0);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Weapon]", GOSSIP_SENDER_MAIN, 1);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant 2H Weapon]", GOSSIP_SENDER_MAIN, 2);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Shield]", GOSSIP_SENDER_MAIN, 3);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Head]", GOSSIP_SENDER_MAIN, 4);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Shoulders]", GOSSIP_SENDER_MAIN, 5);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Cloak]", GOSSIP_SENDER_MAIN, 6);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Chest]", GOSSIP_SENDER_MAIN, 7);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Bracers]", GOSSIP_SENDER_MAIN, 8);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Gloves]", GOSSIP_SENDER_MAIN, 9);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Legs]", GOSSIP_SENDER_MAIN, 10);
                AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Feet]", GOSSIP_SENDER_MAIN, 11);

                if (player->HasSkill(SKILL_ENCHANTING) && player->GetSkillValue(SKILL_ENCHANTING) == 450)
                    AddGossipItemFor(player, GOSSIP_ICON_CHAT, "[Enchant Rings]", GOSSIP_SENDER_MAIN, 12);

                SendGossipMenuFor(player, 100001, me);
                return true;
                break;
            }
            }
            return true;
        }
    };

    // CREATURE AI
    CreatureAI* GetAI(Creature* creature) const override
    {
        return new NPC_PassiveAI(creature);
    }
};

void AddNPCEnchanterScripts()
{
    new EnchanterAnnounce();
    new npc_enchantment();
}
