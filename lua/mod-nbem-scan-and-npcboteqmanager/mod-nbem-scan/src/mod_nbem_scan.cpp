#include "bot_ai.h"
#include "botcommon.h"
#include "botgossip.h"
#include "Chat.h"
#include "ChatCommand.h"
#include "Creature.h"
#include "GossipDef.h"
#include "Item.h"
#include "ItemTemplate.h"
#include "Player.h"
#include "RBAC.h"
#include "ScriptMgr.h"
#include "World.h"

#include <array>
#include <iomanip>
#include <sstream>
#include <string>
#include <string_view>

using namespace Bcore::ChatCommands;

namespace
{
constexpr uint32 NBEM_GOSSIP_ACTION_INFO_DEF = 1000;
struct NbemSlotInfo
{
    uint8 BotSlot;
    char const* Key;
    char const* Label;
};

constexpr std::array<NbemSlotInfo, BOT_INVENTORY_SIZE> NBEM_SLOTS = {{
    { BOT_SLOT_MAINHAND, "MAINHAND", "Main Hand" },
    { BOT_SLOT_OFFHAND, "OFFHAND", "Off Hand" },
    { BOT_SLOT_RANGED, "RANGED", "Ranged" },
    { BOT_SLOT_HEAD, "HEAD", "Head" },
    { BOT_SLOT_SHOULDERS, "SHOULDER", "Shoulder" },
    { BOT_SLOT_CHEST, "CHEST", "Chest" },
    { BOT_SLOT_WAIST, "WAIST", "Waist" },
    { BOT_SLOT_LEGS, "LEGS", "Legs" },
    { BOT_SLOT_FEET, "FEET", "Feet" },
    { BOT_SLOT_WRIST, "WRIST", "Wrist" },
    { BOT_SLOT_HANDS, "HANDS", "Hands" },
    { BOT_SLOT_BACK, "BACK", "Back" },
    { BOT_SLOT_BODY, "SHIRT", "Shirt" },
    { BOT_SLOT_FINGER1, "FINGER1", "Finger 1" },
    { BOT_SLOT_FINGER2, "FINGER2", "Finger 2" },
    { BOT_SLOT_TRINKET1, "TRINKET1", "Trinket 1" },
    { BOT_SLOT_TRINKET2, "TRINKET2", "Trinket 2" },
    { BOT_SLOT_NECK, "NECK", "Neck" },
}};

bool IsManagedSlot(NbemSlotInfo const& slot)
{
    return std::string_view(slot.Key) != "SHIRT" && std::string_view(slot.Key) != "TABARD";
}

NbemSlotInfo const* FindSlot(std::string_view key)
{
    for (NbemSlotInfo const& slot : NBEM_SLOTS)
        if (IsManagedSlot(slot) && key == slot.Key)
            return &slot;

    return nullptr;
}

bool ResolveClientContainerPos(uint32 clientBag, uint32 clientSlot, uint8& serverBag, uint8& serverSlot)
{
    if (clientSlot == 0 || clientSlot > 255)
        return false;

    if (clientBag == 0)
    {
        uint32 backpackSlots = INVENTORY_SLOT_ITEM_END - INVENTORY_SLOT_ITEM_START;
        if (clientSlot > backpackSlots)
            return false;

        serverBag = INVENTORY_SLOT_BAG_0;
        serverSlot = uint8(INVENTORY_SLOT_ITEM_START + clientSlot - 1);
        return true;
    }

    if (clientBag >= 1 && clientBag <= 4)
    {
        serverBag = uint8(INVENTORY_SLOT_BAG_START + clientBag - 1);
        serverSlot = uint8(clientSlot - 1);
        return true;
    }



    return false;
}

bool IsAllowedArmor(uint8 botClass, uint32 subClass)
{
    switch (subClass)
    {
        case ITEM_SUBCLASS_ARMOR_MISC:
            return true;
        case ITEM_SUBCLASS_ARMOR_CLOTH:
            return true;
        case ITEM_SUBCLASS_ARMOR_LEATHER:
            return botClass == CLASS_WARRIOR || botClass == CLASS_PALADIN || botClass == CLASS_HUNTER || botClass == CLASS_ROGUE || botClass == CLASS_DEATH_KNIGHT || botClass == CLASS_SHAMAN || botClass == CLASS_DRUID;
        case ITEM_SUBCLASS_ARMOR_MAIL:
            return botClass == CLASS_WARRIOR || botClass == CLASS_PALADIN || botClass == CLASS_HUNTER || botClass == CLASS_DEATH_KNIGHT || botClass == CLASS_SHAMAN;
        case ITEM_SUBCLASS_ARMOR_PLATE:
            return botClass == CLASS_WARRIOR || botClass == CLASS_PALADIN || botClass == CLASS_DEATH_KNIGHT;
        case ITEM_SUBCLASS_ARMOR_SHIELD:
            return botClass == CLASS_WARRIOR || botClass == CLASS_PALADIN || botClass == CLASS_SHAMAN;
        case ITEM_SUBCLASS_ARMOR_LIBRAM:
            return botClass == CLASS_PALADIN;
        case ITEM_SUBCLASS_ARMOR_IDOL:
            return botClass == CLASS_DRUID;
        case ITEM_SUBCLASS_ARMOR_TOTEM:
            return botClass == CLASS_SHAMAN;
        case ITEM_SUBCLASS_ARMOR_SIGIL:
            return botClass == CLASS_DEATH_KNIGHT;
        default:
            return false;
    }
}

bool IsAllowedWeapon(uint8 botClass, uint32 subClass)
{
    switch (botClass)
    {
        case CLASS_WARRIOR:
            return subClass == ITEM_SUBCLASS_WEAPON_AXE || subClass == ITEM_SUBCLASS_WEAPON_AXE2 || subClass == ITEM_SUBCLASS_WEAPON_BOW || subClass == ITEM_SUBCLASS_WEAPON_GUN || subClass == ITEM_SUBCLASS_WEAPON_MACE || subClass == ITEM_SUBCLASS_WEAPON_MACE2 || subClass == ITEM_SUBCLASS_WEAPON_POLEARM || subClass == ITEM_SUBCLASS_WEAPON_SWORD || subClass == ITEM_SUBCLASS_WEAPON_SWORD2 || subClass == ITEM_SUBCLASS_WEAPON_STAFF || subClass == ITEM_SUBCLASS_WEAPON_FIST || subClass == ITEM_SUBCLASS_WEAPON_DAGGER || subClass == ITEM_SUBCLASS_WEAPON_THROWN || subClass == ITEM_SUBCLASS_WEAPON_CROSSBOW;
        case CLASS_PALADIN:
            return subClass == ITEM_SUBCLASS_WEAPON_AXE || subClass == ITEM_SUBCLASS_WEAPON_AXE2 || subClass == ITEM_SUBCLASS_WEAPON_MACE || subClass == ITEM_SUBCLASS_WEAPON_MACE2 || subClass == ITEM_SUBCLASS_WEAPON_POLEARM || subClass == ITEM_SUBCLASS_WEAPON_SWORD || subClass == ITEM_SUBCLASS_WEAPON_SWORD2;
        case CLASS_HUNTER:
            return subClass == ITEM_SUBCLASS_WEAPON_AXE || subClass == ITEM_SUBCLASS_WEAPON_AXE2 || subClass == ITEM_SUBCLASS_WEAPON_BOW || subClass == ITEM_SUBCLASS_WEAPON_GUN || subClass == ITEM_SUBCLASS_WEAPON_POLEARM || subClass == ITEM_SUBCLASS_WEAPON_SWORD || subClass == ITEM_SUBCLASS_WEAPON_SWORD2 || subClass == ITEM_SUBCLASS_WEAPON_STAFF || subClass == ITEM_SUBCLASS_WEAPON_FIST || subClass == ITEM_SUBCLASS_WEAPON_DAGGER || subClass == ITEM_SUBCLASS_WEAPON_THROWN || subClass == ITEM_SUBCLASS_WEAPON_CROSSBOW;
        case CLASS_ROGUE:
            return subClass == ITEM_SUBCLASS_WEAPON_AXE || subClass == ITEM_SUBCLASS_WEAPON_BOW || subClass == ITEM_SUBCLASS_WEAPON_GUN || subClass == ITEM_SUBCLASS_WEAPON_MACE || subClass == ITEM_SUBCLASS_WEAPON_SWORD || subClass == ITEM_SUBCLASS_WEAPON_FIST || subClass == ITEM_SUBCLASS_WEAPON_DAGGER || subClass == ITEM_SUBCLASS_WEAPON_THROWN || subClass == ITEM_SUBCLASS_WEAPON_CROSSBOW;
        case CLASS_PRIEST:
            return subClass == ITEM_SUBCLASS_WEAPON_MACE || subClass == ITEM_SUBCLASS_WEAPON_STAFF || subClass == ITEM_SUBCLASS_WEAPON_DAGGER || subClass == ITEM_SUBCLASS_WEAPON_WAND;
        case CLASS_DEATH_KNIGHT:
            return subClass == ITEM_SUBCLASS_WEAPON_AXE || subClass == ITEM_SUBCLASS_WEAPON_AXE2 || subClass == ITEM_SUBCLASS_WEAPON_MACE || subClass == ITEM_SUBCLASS_WEAPON_MACE2 || subClass == ITEM_SUBCLASS_WEAPON_POLEARM || subClass == ITEM_SUBCLASS_WEAPON_SWORD || subClass == ITEM_SUBCLASS_WEAPON_SWORD2;
        case CLASS_SHAMAN:
            return subClass == ITEM_SUBCLASS_WEAPON_AXE || subClass == ITEM_SUBCLASS_WEAPON_AXE2 || subClass == ITEM_SUBCLASS_WEAPON_MACE || subClass == ITEM_SUBCLASS_WEAPON_MACE2 || subClass == ITEM_SUBCLASS_WEAPON_STAFF || subClass == ITEM_SUBCLASS_WEAPON_FIST || subClass == ITEM_SUBCLASS_WEAPON_DAGGER;
        case CLASS_MAGE:
            return subClass == ITEM_SUBCLASS_WEAPON_SWORD || subClass == ITEM_SUBCLASS_WEAPON_STAFF || subClass == ITEM_SUBCLASS_WEAPON_DAGGER || subClass == ITEM_SUBCLASS_WEAPON_WAND;
        case CLASS_WARLOCK:
            return subClass == ITEM_SUBCLASS_WEAPON_SWORD || subClass == ITEM_SUBCLASS_WEAPON_STAFF || subClass == ITEM_SUBCLASS_WEAPON_DAGGER || subClass == ITEM_SUBCLASS_WEAPON_WAND;
        case CLASS_DRUID:
            return subClass == ITEM_SUBCLASS_WEAPON_MACE || subClass == ITEM_SUBCLASS_WEAPON_MACE2 || subClass == ITEM_SUBCLASS_WEAPON_POLEARM || subClass == ITEM_SUBCLASS_WEAPON_STAFF || subClass == ITEM_SUBCLASS_WEAPON_FIST || subClass == ITEM_SUBCLASS_WEAPON_DAGGER;
        default:
            return false;
    }
}

bool IsAllowedForBotClass(Creature const* bot, ItemTemplate const* proto)
{
    if (!bot || !proto)
        return false;

    switch (proto->InventoryType)
    {
        case INVTYPE_NON_EQUIP:
        case INVTYPE_BODY:
        case INVTYPE_TABARD:
            return false;
        case INVTYPE_NECK:
        case INVTYPE_CLOAK:
        case INVTYPE_FINGER:
        case INVTYPE_TRINKET:
            return true;
        default:
            break;
    }

    if (proto->Class == ITEM_CLASS_ARMOR)
        return IsAllowedArmor(bot->GetBotClass(), proto->SubClass);

    if (proto->Class == ITEM_CLASS_WEAPON)
        return IsAllowedWeapon(bot->GetBotClass(), proto->SubClass);

    return false;
}
bool IsAllowedForBotSlot(NbemSlotInfo const& slot, ItemTemplate const* proto)
{
    if (!proto)
        return false;

    switch (proto->InventoryType)
    {
        case INVTYPE_HEAD: return slot.BotSlot == BOT_SLOT_HEAD;
        case INVTYPE_NECK: return slot.BotSlot == BOT_SLOT_NECK;
        case INVTYPE_SHOULDERS: return slot.BotSlot == BOT_SLOT_SHOULDERS;
        case INVTYPE_CLOAK: return slot.BotSlot == BOT_SLOT_BACK;
        case INVTYPE_CHEST:
        case INVTYPE_ROBE: return slot.BotSlot == BOT_SLOT_CHEST;
        case INVTYPE_WRISTS: return slot.BotSlot == BOT_SLOT_WRIST;
        case INVTYPE_HANDS: return slot.BotSlot == BOT_SLOT_HANDS;
        case INVTYPE_WAIST: return slot.BotSlot == BOT_SLOT_WAIST;
        case INVTYPE_LEGS: return slot.BotSlot == BOT_SLOT_LEGS;
        case INVTYPE_FEET: return slot.BotSlot == BOT_SLOT_FEET;
        case INVTYPE_FINGER: return slot.BotSlot == BOT_SLOT_FINGER1 || slot.BotSlot == BOT_SLOT_FINGER2;
        case INVTYPE_TRINKET: return slot.BotSlot == BOT_SLOT_TRINKET1 || slot.BotSlot == BOT_SLOT_TRINKET2;
        case INVTYPE_WEAPONMAINHAND:
        case INVTYPE_2HWEAPON:
        case INVTYPE_WEAPON: return slot.BotSlot == BOT_SLOT_MAINHAND;
        case INVTYPE_WEAPONOFFHAND:
        case INVTYPE_SHIELD:
        case INVTYPE_HOLDABLE: return slot.BotSlot == BOT_SLOT_OFFHAND;
        case INVTYPE_RANGED:
        case INVTYPE_THROWN:
        case INVTYPE_RANGEDRIGHT:
        case INVTYPE_RELIC: return slot.BotSlot == BOT_SLOT_RANGED;
        default: return false;
    }
}

bool IsAllowedForBotLevel(Creature const* bot, ItemTemplate const* proto)
{
    if (!bot || !proto)
        return false;

    return proto->RequiredLevel == 0 || bot->GetLevel() >= proto->RequiredLevel;
}
char const* QualityColor(uint32 quality)
{
    switch (quality)
    {
        case ITEM_QUALITY_POOR: return "ff9d9d9d";
        case ITEM_QUALITY_NORMAL: return "ffffffff";
        case ITEM_QUALITY_UNCOMMON: return "ff1eff00";
        case ITEM_QUALITY_RARE: return "ff0070dd";
        case ITEM_QUALITY_EPIC: return "ffa335ee";
        case ITEM_QUALITY_LEGENDARY: return "ffff8000";
        case ITEM_QUALITY_ARTIFACT: return "ffe6cc80";
        case ITEM_QUALITY_HEIRLOOM: return "ffe6cc80";
        default: return "ffffffff";
    }
}

std::string BuildItemLink(Item const* item)
{
    ItemTemplate const* proto = item ? item->GetTemplate() : nullptr;
    if (!proto)
        return "NONE";

    uint32 enchantId = item->GetEnchantmentId(PERM_ENCHANTMENT_SLOT);
    uint32 gem1 = item->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT);
    uint32 gem2 = item->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2);
    uint32 gem3 = item->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3);
    uint32 gem4 = item->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT);

    std::ostringstream link;
    link << "|c" << QualityColor(proto->Quality)
         << "|Hitem:" << proto->ItemId
         << ":" << enchantId
         << ":" << gem1
         << ":" << gem2
         << ":" << gem3
         << ":" << gem4
         << ":0:0:0|h[" << proto->Name1 << "]|h|r";
    return link.str();
}

bool GetPlayerBot(ChatHandler* handler, Player*& player, Creature*& bot, bot_ai*& ai)
{
    player = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;
    if (!player)
        return false;

    bot = handler->getSelectedCreature();
    if (!bot || !bot->IsNPCBot() || !bot->GetBotAI())
    {
        handler->SendSysMessage("NBEM_ERROR Select one of your NPCBots first.");
        return false;
    }

    ai = bot->GetBotAI();
    ObjectGuid::LowType playerGuid = player->GetGUID().GetCounter();
    if (!ai->HasOwner(playerGuid) && !ai->HasSharedOwner(playerGuid))
    {
        handler->SendSysMessage("NBEM_ERROR You do not have access to this NPCBot.");
        return false;
    }

    return true;
}

void CloseBotGossip(Player* player)
{
    if (player && player->PlayerTalkClass)
        player->PlayerTalkClass->SendCloseGossip();
}

char const* BotClassName(uint8 botClass)
{
    switch (botClass)
    {
        case CLASS_WARRIOR: return "Warrior";
        case CLASS_PALADIN: return "Paladin";
        case CLASS_HUNTER: return "Hunter";
        case CLASS_ROGUE: return "Rogue";
        case CLASS_PRIEST: return "Priest";
        case CLASS_DEATH_KNIGHT: return "Death Knight";
        case CLASS_SHAMAN: return "Shaman";
        case CLASS_MAGE: return "Mage";
        case CLASS_WARLOCK: return "Warlock";
        case CLASS_DRUID: return "Druid";
        default: return "Unknown";
    }
}

char const* PowerName(Powers power)
{
    switch (power)
    {
        case POWER_MANA: return "Mana";
        case POWER_RAGE: return "Rage";
        case POWER_FOCUS: return "Focus";
        case POWER_ENERGY: return "Energy";
        case POWER_RUNIC_POWER: return "Runic Power";
        default: return "Power";
    }
}

uint32 DisplayPowerValue(Creature const* bot, Powers power, bool max)
{
    uint32 value = max ? bot->GetMaxPower(power) : bot->GetPower(power);
    return (power == POWER_RAGE || power == POWER_RUNIC_POWER) ? value / 10 : value;
}

std::string FormatFloat(float value)
{
    std::ostringstream stream;
    stream << std::fixed << std::setprecision(2) << value;
    return stream.str();
}

void SendStat(ChatHandler* handler, char const* key, char const* label, std::string const& value)
{
    std::ostringstream msg;
    msg << "NBEM_STAT " << key << " " << label << ": " << value;
    handler->SendSysMessage(msg.view());
}

void SendStat(ChatHandler* handler, char const* key, char const* label, uint32 value)
{
    SendStat(handler, key, label, std::to_string(value));
}

void SendOffenseStat(ChatHandler* handler, Creature* bot, bot_ai* ai)
{
    uint8 botClass = bot->GetBotClass();

    if (botClass == CLASS_HUNTER)
    {
        SendStat(handler, "DMG", "RAP", std::to_string(int32(bot->GetTotalAttackPowerValue(RANGED_ATTACK))));
        return;
    }

    bool physicalHybrid = botClass == CLASS_PALADIN || botClass == CLASS_DRUID || botClass == CLASS_SHAMAN;
    bool physicalClass = botClass == CLASS_WARRIOR || botClass == CLASS_ROGUE || botClass == CLASS_DEATH_KNIGHT;
    bool physicalRole = ai->HasRole(BOT_ROLE_TANK) || (physicalHybrid && !ai->HasRole(BOT_ROLE_HEAL) && !ai->HasRole(BOT_ROLE_RANGED));

    if (physicalClass || physicalRole)
    {
        SendStat(handler, "DMG", "AP", std::to_string(int32(bot->GetTotalAttackPowerValue(BASE_ATTACK))));
        return;
    }

    SendStat(handler, "DMG", "SP", std::to_string(int32(ai->GetBotSpellPower())));
}
void SendBotStats(ChatHandler* handler, Creature* bot, bot_ai* ai)
{
    Powers power = bot->GetPowerType();
    std::ostringstream powerValue;
    powerValue << DisplayPowerValue(bot, power, false) << "/" << DisplayPowerValue(bot, power, true);

    SendStat(handler, "LEVEL", "Level", uint32(bot->GetLevel()));
    SendStat(handler, "CLASS", "Class", BotClassName(bot->GetBotClass()));
    SendStat(handler, "HEALTH", "Health", bot->GetMaxHealth());
    SendStat(handler, "POWER", PowerName(power), powerValue.str());
    SendStat(handler, "ARMOR", "Armor", bot->GetArmor());
    SendStat(handler, "STR", "Str", uint32(0.5f + ai->GetTotalBotStat(BOT_STAT_MOD_STRENGTH)));
    SendStat(handler, "AGI", "Agi", uint32(0.5f + ai->GetTotalBotStat(BOT_STAT_MOD_AGILITY)));
    SendStat(handler, "STA", "Sta", uint32(0.5f + ai->GetTotalBotStat(BOT_STAT_MOD_STAMINA)));
    SendStat(handler, "INT", "Int", uint32(0.5f + ai->GetTotalBotStat(BOT_STAT_MOD_INTELLECT)));
    SendStat(handler, "SPI", "Spi", uint32(0.5f + ai->GetTotalBotStat(BOT_STAT_MOD_SPIRIT)));
    SendStat(handler, "CRIT", "Crit", FormatFloat(ai->GetBotCritChance()) + "%");
    SendStat(handler, "HASTE", "Haste", FormatFloat(float(ai->GetHaste())) + "%");
    SendStat(handler, "HIT", "Hit", FormatFloat(-ai->GetBotMissChance()) + "%");
    if (bot->GetMaxPower(POWER_MANA) > 1)
        SendStat(handler, "MP5", "MP5", FormatFloat(bot->GetFloatValue(UNIT_FIELD_POWER_REGEN_FLAT_MODIFIER) * sWorld->getRate(RATE_POWER_MANA) * 5.0f));
    else
        SendStat(handler, "MP5", "MP5", "-");
    SendOffenseStat(handler, bot, ai);
    SendStat(handler, "HEAL", "Heal", std::to_string(bot->SpellBaseHealingBonusDone(SPELL_SCHOOL_MASK_MAGIC)));
    SendStat(handler, "EXP", "Exp", std::to_string(ai->GetBotExpertise() + bot->GetTotalAuraModifier(SPELL_AURA_MOD_EXPERTISE)));
    SendStat(handler, "DODGE", "Dodge", FormatFloat(ai->GetBotDodgeChance()) + "%");
    SendStat(handler, "DEF", "Def", ai->GetBotDefense());
    SendStat(handler, "BLOCK", "Block", FormatFloat(ai->GetBotBlockChance()) + "%");
    SendStat(handler, "PARRY", "Parry", FormatFloat(ai->GetBotParryChance()) + "%");
}
void SendScan(ChatHandler* handler, Creature* bot, bot_ai* ai)
{
    std::ostringstream beginMsg;
    beginMsg << "NBEM_SCAN_BEGIN " << bot->GetName();
    handler->SendSysMessage(beginMsg.view());
    SendBotStats(handler, bot, ai);

    for (NbemSlotInfo const& slot : NBEM_SLOTS)
    {
        if (!IsManagedSlot(slot))
            continue;

        std::string link = BuildItemLink(ai->GetEquips(slot.BotSlot));
        std::ostringstream slotMsg;
        slotMsg << "NBEM_SLOT " << slot.Key << " " << slot.Label << ": " << link;
        handler->SendSysMessage(slotMsg.view());
    }

    std::ostringstream endMsg;
    endMsg << "NBEM_SCAN_END " << bot->GetName();
    handler->SendSysMessage(endMsg.view());
}
}

class nbem_scan_commandscript : public CommandScript
{
public:
    nbem_scan_commandscript() : CommandScript("nbem_scan_commandscript") { }

    ChatCommandTable GetCommands() const override
    {
        static ChatCommandTable commandTable =
        {
            { "nbem scan", HandleNbemScanCommand, rbac::RBAC_PERM_COMMAND_NPCBOT_INFO, Console::No },
            { "nbem equip", HandleNbemEquipCommand, rbac::RBAC_PERM_COMMAND_NPCBOT_INFO, Console::No },
            { "nbem unequip", HandleNbemUnequipCommand, rbac::RBAC_PERM_COMMAND_NPCBOT_INFO, Console::No }
        };
        return commandTable;
    }

    static bool HandleNbemScanCommand(ChatHandler* handler)
    {
        Player* player = nullptr;
        Creature* bot = nullptr;
        bot_ai* ai = nullptr;
        if (!GetPlayerBot(handler, player, bot, ai))
            return true;

        SendScan(handler, bot, ai);
        return true;
    }

    static bool HandleNbemUnequipCommand(ChatHandler* handler, char const* args)
    {
        Player* player = nullptr;
        Creature* bot = nullptr;
        bot_ai* ai = nullptr;
        if (!GetPlayerBot(handler, player, bot, ai))
            return true;

        std::string argsString(args ? args : "");
        std::istringstream iss(argsString);
        std::string slotKey;
        iss >> slotKey;

        NbemSlotInfo const* slot = FindSlot(slotKey);
        if (!slot)
        {
            handler->SendSysMessage("NBEM_ERROR Usage: .nbem unequip SLOT");
            return true;
        }

        ai->OnGossipSelect(player, bot, GOSSIP_SENDER_UNEQUIP, NBEM_GOSSIP_ACTION_INFO_DEF + slot->BotSlot);
        CloseBotGossip(player);
        SendScan(handler, bot, ai);
        return true;
    }

    static bool HandleNbemEquipCommand(ChatHandler* handler, char const* args)
    {
        Player* player = nullptr;
        Creature* bot = nullptr;
        bot_ai* ai = nullptr;
        if (!GetPlayerBot(handler, player, bot, ai))
            return true;

        std::string argsString(args ? args : "");
        std::istringstream iss(argsString);
        std::string slotKey;
        uint32 bag = 0;
        uint32 bagSlot = 0;
        iss >> slotKey >> bag >> bagSlot;

        NbemSlotInfo const* slot = FindSlot(slotKey);
        if (!slot || iss.fail() || bag > 255 || bagSlot > 255)
        {
            handler->SendSysMessage("NBEM_ERROR Usage: .nbem equip SLOT BAG BAGSLOT");
            return true;
        }

        uint8 serverBag = 0;
        uint8 serverSlot = 0;
        if (!ResolveClientContainerPos(bag, bagSlot, serverBag, serverSlot))
        {
            handler->SendSysMessage("NBEM_ERROR Invalid bag position.");
            return true;
        }

        Item* item = player->GetItemByPos(serverBag, serverSlot);
        if (!item)
        {
            handler->SendSysMessage("NBEM_ERROR Item was not found in that bag slot.");
            return true;
        }

        ItemTemplate const* proto = item->GetTemplate();
        if (!IsAllowedForBotClass(bot, proto))
        {
            handler->SendSysMessage("NBEM_ERROR Bot class cannot use that item.");
            return true;
        }

        if (!IsAllowedForBotSlot(*slot, proto))
        {
            handler->SendSysMessage("NBEM_ERROR Item does not belong in that slot.");
            return true;
        }

        if (!IsAllowedForBotLevel(bot, proto))
        {
            handler->SendSysMessage("NBEM_ERROR Item requires a higher bot level.");
            return true;
        }

        ai->OnGossipSelect(player, bot, GOSSIP_SENDER_EQUIP + slot->BotSlot, NBEM_GOSSIP_ACTION_INFO_DEF + item->GetGUID().GetCounter());
        CloseBotGossip(player);
        SendScan(handler, bot, ai);
        return true;
    }
};

void Addmod_nbem_scanScripts()
{
    new nbem_scan_commandscript();
}


