#include "SpellAuraDefines.h"
#include "RI_AddonUpdater.h"
#include "RI_ItemStore.h"
#include "Player.h"
#include "Chat.h"
#include "WorldSession.h"
#include "RI_PlayerStore.h"
#include "ObjectExtension.cpp"
#include "RI_ApplyStatScripts.h"
#include "worldSession.h"
#include "DBCStores.h"
#include "SpellMgr.h"
#include "AddonCommunication/AddonCommunication.h"

void RI_GenerateClassBasedLists();
static PossibleRandomStatRolls *RI_PickableStats = NULL;
static PossibleRandomStatRolls *LastInitedStat = NULL;

PossibleRandomStatRolls *GetPickableStatStore()
{
    return RI_PickableStats;
}

void OnPlayerLoginWithAddon(Player *p)
{
    for (int i = 0; i < RI_MAX_STAT_TYPES; i++)
        if(RI_PickableStats[i].PushUpdateClientDB!=0)
        {
            char repl[MAX_MESSAGE_LENGTH];
            sprintf_s(repl, sizeof(repl), "%d %s", i, RI_PickableStats[i].FormatStr);
            AddonComm::SendMessageToClient(p, "RIAS", repl);
        }
}

int GetParamCount(const char *str)
{
    if (str == NULL)
        return 0;
    int Ret = 0;
    int Ind = 0;
    while (str[Ind] != 0)
    {
        if (str[Ind] == '%')
        {
            if (str[Ind + 1] == 'd' || str[Ind + 1] == 'D')
                Ret++;
            else if (str[Ind + 1] == 'i' || str[Ind + 1] == 'I')
                Ret++;
            else if (str[Ind + 1] == 'f' || str[Ind + 1] == 'F')
                Ret++;
            else if (str[Ind + 1] == 'l' || str[Ind + 1] == 'L')
                Ret++;
            else if (str[Ind + 1] == '.' && str[Ind + 2] == '0' && str[Ind + 3] == '2' && str[Ind + 4] == 'f')
                Ret++;
        }
        Ind++;
    }
    return Ret;
}

#define ITEM_MOD_NONE (ItemModType)MAX_ITEM_MOD
#define UNIT_MOD_NONE (UNIT_MOD_END)
//#define BuildClassFilterMask6(a,b,c,d,e,f) ((1<<a)|(1<<b)|(1<<c)|(1<<d)|(1<<e)|(1<<f))

int BCFM(int Class1, ...)
{
    va_list ap;
    va_start(ap, Class1);
    int ret = 1 << Class1;
    for (int i = 0; i < 12; i++)
    {
        int a = va_arg(ap, int);
        if (a == 0 || a > 12)
            break;
        ret |= (1<<a);
    }
    va_end(ap);
    return ret;
}

void InitStatRollParams(int i, float Min, float Max, ItemModType IM, UnitMods UM, RI_ApplyStatFunc AS, const char * FS, int RGB, int ClassFilterMask)
{
    ASSERT(RI_PickableStats[i].FormatStr == NULL);// maybe we made a typo and try to init the same index more than once
    RI_PickableStats[i].MinValue = Min;
    RI_PickableStats[i].MaxValAt100 = Max;
    RI_PickableStats[i].FormatStr = FS;
    RI_PickableStats[i].RGB = RGB;
    RI_PickableStats[i].ClassFilterMask = ClassFilterMask;
    if (UM == UnitMods::UNIT_MOD_END && IM != ITEM_MOD_NONE)
        RI_PickableStats[i].ItemMod = IM;
    else if (IM == ITEM_MOD_NONE && UM != UnitMods::UNIT_MOD_END)
        RI_PickableStats[i].UnitMod = UM;
    else if(RI_PickableStats[i].ApplyScript == RI_AS_ItemMod || RI_PickableStats[i].ApplyScript == RI_AS_UnitModFlat)
        ASSERT(false); //missing item or unit mod ? This must be scripted or something
    RI_PickableStats[i].ApplyScript = AS;
    LastInitedStat = &RI_PickableStats[i];
}

void GenerateRandomRollFormatStrings()
{
    RI_PickableStats = (PossibleRandomStatRolls*)malloc(sizeof(PossibleRandomStatRolls) * RI_MAX_STAT_TYPES);
    memset(RI_PickableStats, 0, sizeof(PossibleRandomStatRolls) * RI_MAX_STAT_TYPES);
    for (int i = 0; i < RI_MAX_STAT_TYPES; i++)
    {
        RI_PickableStats[i].FormatStr = NULL;
        RI_PickableStats[i].MinValue = 0.01f;
        RI_PickableStats[i].StatIndex = (RIStatTypes)i;
        RI_PickableStats[i].RollChance = 100;
        RI_PickableStats[i].PushUpdateClientDB = 0;
        RI_PickableStats[i].RGB = RGB_PROC;
        RI_PickableStats[i].ItemMod = (ItemModType)0xFFFFFF;
        RI_PickableStats[i].UnitMod = (UnitMods)0xFFFFFF;
        RI_PickableStats[i].NegativeRollChance = 5;
        RI_PickableStats[i].ClassFilterMask = 0x7FFFFFFF;
    }

    InitStatRollParams(RI_Strength, 1, 45, ITEM_MOD_STRENGTH, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Strength", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_DEATH_KNIGHT, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Base damage modifier. Gets converted into attack power. Increases shield block value";

    InitStatRollParams(RI_Agility, 1, 60, ITEM_MOD_AGILITY, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Agility", RGB_ATTACK
        , BCFM(CLASS_HUNTER, CLASS_ROGUE, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Base damage modifier. Gets converted into attack power. Increases armor. Increases crit chance for some classes. Increases dodge chance.";

    InitStatRollParams(RI_Stamina, 1, 275, ITEM_MOD_STAMINA, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Stamina", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases max health";

    InitStatRollParams(RI_Intelect, 1, 25, ITEM_MOD_INTELLECT, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Intelect", RGB_ATTACK
        , BCFM( CLASS_PALADIN, CLASS_HUNTER, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases max mana. Increases mana regen. Increases crit chance for some classes.";

    InitStatRollParams(RI_SPIRIT, 1, 35, ITEM_MOD_SPIRIT, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Spirit", RGB_ATTACK
        , BCFM( CLASS_PRIEST, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases mana regen.";

    InitStatRollParams(RI_HEALTH, 1, 20000 / 4, ITEM_MOD_HEALTH, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Health", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "If this gets to 0, you die.";

    InitStatRollParams(RI_MANA, 1, 20000 / 4, ITEM_MOD_MANA, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Mana", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Resource for spells.";

    InitStatRollParams(RI_RAGE, 1, 10, ITEM_MOD_NONE, UNIT_MOD_RAGE, RI_AS_UnitModFlat, "%d Rage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, 0));
    LastInitedStat->Tooltip = "Resource for abilities.";

    InitStatRollParams(RI_FOCUS, 1, 10, ITEM_MOD_NONE, UNIT_MOD_FOCUS, RI_AS_UnitModFlat, "%d Focus", RGB_ATTACK
        , BCFM( CLASS_HUNTER, 0));
    LastInitedStat->Tooltip = "Resource for abilities.";

    InitStatRollParams(RI_ENERGY, 1, 10, ITEM_MOD_NONE, UNIT_MOD_ENERGY, RI_AS_UnitModFlat, "%d Energy", RGB_ATTACK
        , BCFM( CLASS_ROGUE, 0));
    LastInitedStat->Tooltip = "Resource for abilities.";

    InitStatRollParams(RI_RUNE, 1, 10, ITEM_MOD_NONE, UNIT_MOD_RUNE, RI_AS_UnitModFlat, "%d Rune", RGB_ATTACK
        , BCFM( CLASS_DEATH_KNIGHT, 0));
    LastInitedStat->Tooltip = "Resource for abilities.";

    InitStatRollParams(RI_RUNIC_POWER, 1, 10, ITEM_MOD_NONE, UNIT_MOD_RUNIC_POWER, RI_AS_UnitModFlat, "%d Runic Power", RGB_ATTACK
        , BCFM( CLASS_DEATH_KNIGHT, 0));
    LastInitedStat->Tooltip = "Resource for abilities.";

    InitStatRollParams(RI_ARMOR, 1, 30 * 10, ITEM_MOD_NONE, UNIT_MOD_ARMOR, RI_AS_UnitModFlat, "%d Armor", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_DRUID, 0)); // about 10k from item
    LastInitedStat->Tooltip = "Reduces physical damage taken.";

    InitStatRollParams(RI_RESISTANCE_HOLY, 1, 30, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_HOLY, RI_AS_UnitModFlat, "%d Resistance Holy", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces holy damage taken.";

    InitStatRollParams(RI_RESISTANCE_FIRE, 1, 30, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_FIRE, RI_AS_UnitModFlat, "%d Resistance Fire", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces fire damage taken.";

    InitStatRollParams(RI_RESISTANCE_NATURE, 1, 30, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_NATURE, RI_AS_UnitModFlat, "%d Resistance Nature", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces nature damage taken.";

    InitStatRollParams(RI_RESISTANCE_FROST, 1, 30, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_FROST, RI_AS_UnitModFlat, "%d Resistance Frost", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces frost damage taken.";

    InitStatRollParams(RI_RESISTANCE_SHADOW, 1, 30, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_SHADOW, RI_AS_UnitModFlat, "%d Resistance Shadow", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces shadow damage taken.";

    InitStatRollParams(RI_RESISTANCE_ARCANE, 1, 30, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_ARCANE, RI_AS_UnitModFlat, "%d Resistance Arcane", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces arcane damage taken.";

    InitStatRollParams(RI_ATTACK_POWER, 1, 150, ITEM_MOD_ATTACK_POWER, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases melee damage and ability damage";

    InitStatRollParams(RI_ATTACK_POWER_RANGED, 1, 180, ITEM_MOD_RANGED_ATTACK_POWER, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Ranged Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_HUNTER, CLASS_ROGUE, 0));
    LastInitedStat->Tooltip = "Increases ranged damage and ability damage";

    InitStatRollParams(RI_DAMAGE_MAINHAND, 1, 90, ITEM_MOD_NONE, UNIT_MOD_DAMAGE_MAINHAND, RI_AS_UnitModFlat, "%d Damage Mainhand", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases damage when using mainhand weapon( attack or ability )";

    InitStatRollParams(RI_DAMAGE_OFFHAND, 1, 100, ITEM_MOD_NONE, UNIT_MOD_DAMAGE_OFFHAND, RI_AS_UnitModFlat, "%d Damage Offhand", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_ROGUE, CLASS_SHAMAN, 0));
    LastInitedStat->Tooltip = "Increases damage when using offhand weapon( attack or ability )";

    InitStatRollParams(RI_DAMAGE_RANGED, 1, 90, ITEM_MOD_NONE, UNIT_MOD_DAMAGE_RANGED, RI_AS_UnitModFlat, "%d Damage Ranged", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_HUNTER, CLASS_ROGUE, 0));
    LastInitedStat->Tooltip = "Increases damage when using ranged weapon( attack or ability )";

    InitStatRollParams(RI_DODGE, 1, 172, ITEM_MOD_DODGE_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Dodge Rating", RGB_DEFENSE
        , BCFM(CLASS_HUNTER, CLASS_ROGUE, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduce the chance for an enemy attack to do damage";

    InitStatRollParams(RI_PARRY, 1, 112, ITEM_MOD_PARRY_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Parry Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_DEATH_KNIGHT, 0));
    LastInitedStat->Tooltip = "Reduce the chance for an enemy attack to do damage";

    InitStatRollParams(RI_BLOCK_RATING, 1, 74, ITEM_MOD_BLOCK_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Block Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_DEATH_KNIGHT, 0));
    LastInitedStat->Tooltip = "Chance for an enemy attack to be reduced by block amount";

    InitStatRollParams(RI_BLOCK, 1, 171, ITEM_MOD_BLOCK_VALUE, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Block", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_DEATH_KNIGHT, 0));
    LastInitedStat->Tooltip = "Chance for an enemy to do reduced damage";

    InitStatRollParams(RI_HIT_MELEE, 1, 178, ITEM_MOD_HIT_MELEE_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Melee Hit Rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases the chance you will hit an enemy with melee attack";

    InitStatRollParams(RI_HIT_RANGED, 1, 178, ITEM_MOD_HIT_RANGED_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Ranged Hit Rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_HUNTER, CLASS_ROGUE, 0));
    LastInitedStat->Tooltip = "Increases the chance you will hit an enemy with ranged attack";

    InitStatRollParams(RI_HIT_SPELL, 1, 178, ITEM_MOD_HIT_SPELL_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Spell Hit Rating", RGB_ATTACK
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases the chance you will hit an enemy with spells";

    InitStatRollParams(RI_CRIT_MELEE, 1, 40, ITEM_MOD_CRIT_MELEE_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Melee Crit Rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases the chance you will critically hit an enemy with melee attack";

    InitStatRollParams(RI_CRIT_RANGED, 1, 50, ITEM_MOD_CRIT_RANGED_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Ranged Crit Rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_HUNTER, CLASS_ROGUE, 0));
    LastInitedStat->Tooltip = "Increases the chance you will critically hit an enemy with ranged attack";

    InitStatRollParams(RI_CRIT_SPELL, 1, 60, ITEM_MOD_CRIT_SPELL_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Spell Crit Rating", RGB_ATTACK
        , BCFM( CLASS_PALADIN,  CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases the chance you will critically hit an enemy with spells";

    InitStatRollParams(RI_HIT_TAKEN_MELEE, 1, 178, ITEM_MOD_HIT_TAKEN_MELEE_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Melee Hit Taken Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the chance you will be hit by an enemy with melee attack";

    InitStatRollParams(RI_HIT_TAKEN_RANGED, 1, 178, ITEM_MOD_HIT_TAKEN_RANGED_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Ranged Hit Taken Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the chance you will be hit by an enemy with ranged attack";

    InitStatRollParams(RI_HIT_TAKEN_SPELL, 1, 178, ITEM_MOD_HIT_TAKEN_SPELL_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Spell Hit Taken Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the chance you will be hit by an enemy with spell attack";

    InitStatRollParams(RI_CRIT_TAKEN_MELEE, 1, 40, ITEM_MOD_CRIT_TAKEN_MELEE_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Melee Crit Taken Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the chance you will be critically hit by an enemy with melee attack";

    InitStatRollParams(RI_CRIT_TAKEN_RANGED, 1, 50, ITEM_MOD_CRIT_TAKEN_RANGED_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Ranged Crit Taken Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the chance you will be critically hit by an enemy with ranged attack";

    InitStatRollParams(RI_CRIT_TAKEN_SPELL, 1, 60, ITEM_MOD_CRIT_TAKEN_SPELL_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Spell Crit Taken Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the chance you will be critically hit by an enemy with spells";

    InitStatRollParams(RI_HASTE_MELEE, 1, 60, ITEM_MOD_HASTE_MELEE_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Melee Haste Rating", RGB_ATTACK
        , BCFM( CLASS_ROGUE, CLASS_SHAMAN, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the time between melee attacks";

    InitStatRollParams(RI_HASTE_RANGED, 1, 120, ITEM_MOD_HASTE_RANGED_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Ranged Haste Rating", RGB_ATTACK
        , BCFM( CLASS_HUNTER, CLASS_ROGUE, 0));
    LastInitedStat->Tooltip = "Reduces the time between ranged attacks";

    InitStatRollParams(RI_HASTE_SPELL, 1, 227, ITEM_MOD_HASTE_SPELL_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Spell Haste Rating", RGB_ATTACK_DEFENSE
        , BCFM( CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces cast time of spells";

    InitStatRollParams(RI_EXPERTISE, 1, 114, ITEM_MOD_EXPERTISE_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Expertise Rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the dodge chance of your target";

    InitStatRollParams(RI_ARMOR_PENETRATION, 1, 18, ITEM_MOD_ARMOR_PENETRATION_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Armor Penetration Rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the physical resistance of your target";

    InitStatRollParams(RI_HIT_RATING, 1, 172, ITEM_MOD_HIT_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Hit Rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increses the chance your attacks will deal damage ( melee/ranged/spell)";

    InitStatRollParams(RI_CRIT_RATING, 1, 18, ITEM_MOD_CRIT_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Crit Rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increses the chance your attacks will deal critical damage ( melee/ranged/spell)";

    InitStatRollParams(RI_HIT_TAKEN_RATING, 1, 50, ITEM_MOD_HIT_TAKEN_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Hit Taken Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the chance you will be hit by melee/ranged/spell damage";

    InitStatRollParams(RI_CRIT_TAKEN_RATING, 1, 50, ITEM_MOD_CRIT_TAKEN_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Crit Taken Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces the chance you will be hit by critical melee/ranged/spell damage";

    InitStatRollParams(RI_RESILIANCE_RATING, 1, 18, ITEM_MOD_RESILIENCE_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Resiliance Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces critcal damage taken from melee/ranged/spells";

    InitStatRollParams(RI_HASTE_RATING, 1, 60, ITEM_MOD_HASTE_RATING, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Haste Rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Reduces time between melee/ranged/spells attacks";

    //should be in sync with damage for mana to obtain a decent DPS
    InitStatRollParams(RI_MANA_REGEN, 1, 120, ITEM_MOD_MANA_REGENERATION, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Mana regen", RGB_DEFENSE
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases the amount of mana regenerated periodically";

    InitStatRollParams(RI_SPELL_POWER, 1, 75, ITEM_MOD_SPELL_POWER, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Spell Power", RGB_ATTACK_DEFENSE
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases the power of spells. Mostly damage and absorb";

    //should be in sync with health to damage
    InitStatRollParams(RI_HEALTH_REGEN, 1, 375, ITEM_MOD_HEALTH_REGEN, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Health Regen", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases the amount of health you regenrate while out of combat";

    InitStatRollParams(RI_SPELL_PENETRATION, 1, 18, ITEM_MOD_SPELL_PENETRATION, UNIT_MOD_NONE, RI_AS_ItemMod, "%d Spell Penetration", RGB_ATTACK
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Spell damage will ignore resistance";

    InitStatRollParams(RI_MAGIC_FIND_INSTANCES, 0.1f, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_MagicFind, "%d Magic Find", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Every 100 magic find will give you 1 extra item stat on looted items. Instance difficulty counts as Magic Find";

    InitStatRollParams(RI_MAGIC_FIND_POWER_INSTANCES, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_MagicStrength, "%d Magic Find Power Rating", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    LastInitedStat->Tooltip = "Increases the strength of randomly rolled stats";

    InitStatRollParams(RI_Move_Speed, 0.1f, 2, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%.02f%% Run speed", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_Move_Speed].AdditionalParam1 = SPELL_AURA_MOD_INCREASE_SPEED;
    LastInitedStat->Tooltip = "Increases movement speed ( not mounted )";

    InitStatRollParams(RI_Move_Mounted_Speed, 0.1f, 3, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%.02f%% Mounted speed", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_Move_Mounted_Speed].AdditionalParam1 = SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED;
    LastInitedStat->Tooltip = "Increases movement speed while mounted";

    InitStatRollParams(RI_Damage_Physical, 1, 500, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneSchool, "%d Physical Dmg", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_Damage_Physical].SchoolMask = SPELL_SCHOOL_NORMAL;
    LastInitedStat->Tooltip = "Increases physical damage. Base value";

    InitStatRollParams(RI_Damage_Holy, 1, 180, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneSchool, "%d Holy Dmg", RGB_ATTACK
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, 0));
   RI_PickableStats[RI_Damage_Holy].SchoolMask = SPELL_SCHOOL_HOLY;
   LastInitedStat->Tooltip = "Increases holy damage. Base value";

    InitStatRollParams(RI_Damage_Fire, 1, 77, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneSchool, "%d Fire Dmg", RGB_ATTACK
        , BCFM(CLASS_MAGE, CLASS_SHAMAN, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_Damage_Fire].SchoolMask = SPELL_SCHOOL_FIRE;
    LastInitedStat->Tooltip = "Increases fire damage. Base value";

    InitStatRollParams(RI_Damage_Nature, 1, 95, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneSchool, "%d Nature Dmg", RGB_ATTACK
        , BCFM( CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_Damage_Nature].SchoolMask = SPELL_SCHOOL_NATURE;
    LastInitedStat->Tooltip = "Increases nature damage. Base value";

    InitStatRollParams(RI_Damage_Frost, 1, 95, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneSchool, "%d Frost Dmg", RGB_ATTACK
        , BCFM( CLASS_SHAMAN, CLASS_MAGE, 0));
    RI_PickableStats[RI_Damage_Frost].SchoolMask = SPELL_SCHOOL_FROST;
    LastInitedStat->Tooltip = "Increases frost damage. Base value";

    InitStatRollParams(RI_Damage_Shadow, 1, 135, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneSchool, "%d Shadow Dmg", RGB_ATTACK
        , BCFM(CLASS_WARLOCK, 0));
    RI_PickableStats[RI_Damage_Shadow].SchoolMask = SPELL_SCHOOL_SHADOW;
    LastInitedStat->Tooltip = "Increases shadow damage. Base value";

    InitStatRollParams(RI_Damage_Arcane, 1, 117, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneSchool, "%d Arcane Dmg", RGB_ATTACK
        , BCFM(CLASS_MAGE, 0));
    RI_PickableStats[RI_Damage_Arcane].SchoolMask = SPELL_SCHOOL_ARCANE;
    LastInitedStat->Tooltip = "Increases arcane damage. Base value";

    InitStatRollParams(RI_SPELL_AURA_MOD_HEALING_TAKEN, 1, 110, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%d Spell Healing taken", RGB_DEFENSE
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_HEALING_TAKEN].AdditionalParam1 = SPELL_AURA_MOD_HEALING_DONE;
    LastInitedStat->Tooltip = "Increases healing taken. Periodic heals will split up this value between ticks";

    InitStatRollParams(RI_Damage_Target_HP_PCT, 0.01f, 0.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneTargetHPPCT, "%.02f%% Damage done target health based", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_Damage_Target_HP_PCT].RollChance = -10;
    LastInitedStat->Tooltip = "Base damage is increased based on target current health";

    InitStatRollParams(RI_Damage_Target_HP_MISSING_PCT, 0.01f, 0.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneTargetHPMissingPCT, "%.02f%% Damage done target health missing", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_Damage_Target_HP_MISSING_PCT].RollChance = -10;
    LastInitedStat->Tooltip = "Base damage is increased based on target missing health";

    InitStatRollParams(RI_HEAL_TARGET_HP_PCT, 0.01f, 0.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDoneTargetHPPCT, "%.02f%% Heal target health based", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_TARGET_HP_PCT].RollChance = 2;
    LastInitedStat->Tooltip = "Heal amount is increased based on target current health. Periodic heals will split up this value between ticks";

    InitStatRollParams(RI_HEAL_TARGET_MISSING_HP_PCT, 0.01f, 0.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDoneTargetHPMissingPCT, "%.02f%% Heal target missing health based", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_TARGET_MISSING_HP_PCT].RollChance = 2;
    LastInitedStat->Tooltip = "Heal amount is increased based on target missing health. Periodic heals will split up this value between ticks";

    InitStatRollParams(RI_AURA_DURATION_Flat, 1, 2, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModFlat, "%d seconds to spell duration", RGB_ATTACK_DEFENSE
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_AURA_DURATION_Flat].RollChance = 20;
    RI_PickableStats[RI_AURA_DURATION_Flat].SpellMod = SPELLMOD_DURATION;
    LastInitedStat->Tooltip = "Aura duration increase. Not all spells benefit from it";

    InitStatRollParams(RI_AURA_DURATION_PCT, 1.1f, 3.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModPCT, "%.02f%% longer spell duration", RGB_ATTACK_DEFENSE
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_AURA_DURATION_PCT].RollChance = 5;
    RI_PickableStats[RI_AURA_DURATION_PCT].SpellMod = SPELLMOD_DURATION;
    LastInitedStat->Tooltip = "Aura duration increase. Not all spells benefit from it";

    InitStatRollParams(RI_SPELL_DAMAGE_Flat, 1, 30, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModFlat, "%d spell damage", RGB_ATTACK
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_DAMAGE_Flat].SpellMod = SPELLMOD_DAMAGE;
    LastInitedStat->Tooltip = "Spell damage increase. Not all spells benefit from it";

    InitStatRollParams(RI_SPELL_DAMAGE_PCT, 0.1f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModPCT, "%.02f%% spell damage", RGB_ATTACK
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_DAMAGE_PCT].SpellMod = SPELLMOD_DAMAGE;
    RI_PickableStats[RI_SPELL_DAMAGE_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Spell damage increase. Not all spells benefit from it";

    InitStatRollParams(RI_SPELL_DOT_DAMAGE_Flat, 1, 60, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModFlat, "%d spell DOT damage", RGB_ATTACK
        , BCFM( CLASS_PRIEST, CLASS_MAGE, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_SPELL_DOT_DAMAGE_Flat].SpellMod = SPELLMOD_DOT;
    LastInitedStat->Tooltip = "Spell periodic damage increase. Not all spells benefit from it";

    InitStatRollParams(RI_SPELL_DOT_DAMAGE_PCT, 0.5f, 1.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModPCT, "%.02f%% spell DOT damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_DOT_DAMAGE_PCT].SpellMod = SPELLMOD_DOT;
    RI_PickableStats[RI_SPELL_DOT_DAMAGE_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Spell periodic damage increase. Not all spells benefit from it";

    InitStatRollParams(RI_SPELL_CRIT_DMG_Flat, 1, 40, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModFlat, "%d spell crit dmg", RGB_ATTACK
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_CRIT_DMG_Flat].SpellMod = SPELLMOD_CRIT_DAMAGE_BONUS;
    LastInitedStat->Tooltip = "When a spell crits, the damage will receive extra bonus. Not all spells benefit from it";

    InitStatRollParams(RI_SPELL_CRIT_DMG_PCT, 0.1f, 1.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModPCT, "%.02f%% spell crit dmg", RGB_ATTACK
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_CRIT_DMG_PCT].SpellMod = SPELLMOD_CRIT_DAMAGE_BONUS;
    RI_PickableStats[RI_SPELL_CRIT_DMG_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "When a spell crits, the damage will receive extra bonus. Not all spells benefit from it";

    InitStatRollParams(RI_SPELL_TREATH_REDUCTION, 1.1f, 50.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModPCTNegative, "%.02f%% Threat", RGB_ATTACK_DEFENSE
        , BCFM( CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_TREATH_REDUCTION].RollChance = 20;
//    RI_PickableStats[RI_SPELL_TREATH_REDUCTION].SpellMod = SPELLMOD_THREAT;
//    RI_PickableStats[RI_SPELL_TREATH_REDUCTION].NegativeRollChance = 0;
    RI_PickableStats[RI_SPELL_TREATH_REDUCTION].AdditionalParam1 = SPELL_AURA_MOD_THREAT;
    LastInitedStat->Tooltip = "Increases the threath you generate with abilities";

    InitStatRollParams(RI_DropChanceNoJunk, 1.1f, 5.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DropChanceNoJunk, "%.02f%% equip item dropchance", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DropChanceNoJunk].RollChance = 20;
    LastInitedStat->Tooltip = "Increases the chance you will only loot items that can be equipped";

    InitStatRollParams(RI_MELEE_CRIT_DMG_PCT, 1.1f, 30.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%.02f%% melee crit dmg", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_MELEE_CRIT_DMG_PCT].RollChance = 20;
    RI_PickableStats[RI_MELEE_CRIT_DMG_PCT].AdditionalParam1 = SPELL_AURA_MOD_ATTACKER_MELEE_CRIT_DAMAGE;
    LastInitedStat->Tooltip = "Increases bonus damage when you deal critical melee damage";

    InitStatRollParams(RI_RANGED_CRIT_DMG, 1.1f, 2.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%.02f%% ranged crit dmg", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_HUNTER, CLASS_ROGUE, 0));
    RI_PickableStats[RI_RANGED_CRIT_DMG].RollChance = 20;
    RI_PickableStats[RI_MELEE_CRIT_DMG_PCT].AdditionalParam1 = SPELL_AURA_MOD_ATTACKER_RANGED_CRIT_DAMAGE;
    LastInitedStat->Tooltip = "Increases bonus damage when you deal critical ranged damage";

    InitStatRollParams(RI_SPELL_THREATH_BOOST, 1.1f, 50.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModPCT, "%.02f%% Threat increase", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_THREATH_BOOST].RollChance = -1000;
    RI_PickableStats[RI_SPELL_THREATH_BOOST].SpellMod = SPELLMOD_THREAT;
    RI_PickableStats[RI_SPELL_THREATH_BOOST].NegativeRollChance = 0;
    LastInitedStat->Tooltip = "Increases the threath you generate with abilities";

    InitStatRollParams(RI_HEALTH_REGEN_ALWAYS, 1, 400, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealthRegenAlways, "%d continuous health regen", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEALTH_REGEN_ALWAYS].RollChance = 20;
    LastInitedStat->Tooltip = "Increases health you generate periodically, even while in combat";

    InitStatRollParams(RI_HEALTH_REGEN_ALWAYS_PCT, 0.01f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealthRegenAlways, "%.02f%% continuous health regen", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEALTH_REGEN_ALWAYS_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Increases health you generate periodically, even while in combat";

    InitStatRollParams(RI_HEALTH_REGEN_MISSING_PCT, 0.01f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealthRegenAlways, "%.02f%% continuous missing health regen", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEALTH_REGEN_MISSING_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Increases health you generate periodically, even while in combat. Amount is based on missing health";

    InitStatRollParams(RI_HEALTH_REGEN_EXISTING_PCT, 0.01f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealthRegenAlways, "%.02f%% continuous current health regen", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEALTH_REGEN_EXISTING_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Increases health you generate periodically, even while in combat. Amount is based on curent health";

    InitStatRollParams(RI_POWER_REGEN_PCT, 0.01f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerRegenAlways, "%.02f%% continuous current power regen", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_POWER_REGEN_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Increases mana you generate periodically, even while in combat";

    InitStatRollParams(RI_POWER_BURN_TARGET, 1, 2000, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerBurn, "%d target power burn", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_POWER_BURN_TARGET].RollChance = 20;
    RI_PickableStats[RI_POWER_BURN_TARGET].NegativeRollChance = 0;
    LastInitedStat->Tooltip = "Converts victim mana into damage you deal";

    InitStatRollParams(RI_POWER_BURN_TARGET_PCT, 0.01f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerBurn, "%.02f%% target power burn", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_POWER_BURN_TARGET_PCT].RollChance = 20;
    RI_PickableStats[RI_POWER_BURN_TARGET_PCT].NegativeRollChance = 0;
    LastInitedStat->Tooltip = "Converts victim mana into damage you deal";

    InitStatRollParams(RI_SPELL_TARGET_PLUS, 1, 2, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModFlatSpellTarget, "%d spell target", RGB_ATTACK
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_TARGET_PLUS].RollChance = 20;
    RI_PickableStats[RI_SPELL_TARGET_PLUS].SpellMod = SPELLMOD_JUMP_TARGETS;
    RI_PickableStats[RI_SPELL_TARGET_PLUS].NegativeRollChance = 0;
    LastInitedStat->Tooltip = "Spells will be casted on additional targets. Not all spells can benefit from it";

    InitStatRollParams(RI_GAIN_DUAL_WIELD, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Dual Wield", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_GAIN_DUAL_WIELD].NegativeRollChance = 0;
    RI_PickableStats[RI_GAIN_DUAL_WIELD].RollChance = 20;
    RI_PickableStats[RI_GAIN_DUAL_WIELD].AdditionalParam1 = 30798;
    RI_PickableStats[RI_GAIN_DUAL_WIELD].LearnAsSpell = 1;
    RI_PickableStats[RI_GAIN_DUAL_WIELD].LearnSkill = SKILL_DUAL_WIELD;
    RI_PickableStats[RI_GAIN_DUAL_WIELD].FixedValue = 1;
    LastInitedStat->Tooltip = "You can wield weapons in offhand";

    InitStatRollParams(RI_GAIN_TITAN_GRIP, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Titan's Grip", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_GAIN_TITAN_GRIP].NegativeRollChance = 0;
    RI_PickableStats[RI_GAIN_TITAN_GRIP].RollChance = 20;
    RI_PickableStats[RI_GAIN_TITAN_GRIP].AdditionalParam1 = 46917;
    RI_PickableStats[RI_GAIN_TITAN_GRIP].LearnAsSpell = 1;
    RI_PickableStats[RI_GAIN_TITAN_GRIP].FixedValue = 1;
    LastInitedStat->Tooltip = "You can wield 2 handed weapons in offhand. Does not give ability to dual wield";

    InitStatRollParams(RI_SPELL_KNOCKBACK, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_CastOnDamge, "Chance for knockdown on dmg", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_KNOCKBACK].NegativeRollChance = 0;
    RI_PickableStats[RI_SPELL_KNOCKBACK].RollChance = 2;
    RI_PickableStats[RI_SPELL_KNOCKBACK].AdditionalParam1 = 5164;
    RI_PickableStats[RI_SPELL_KNOCKBACK].FixedValue = 1;
    LastInitedStat->Tooltip = "Attacks have a chance to ckick back victim";

    InitStatRollParams(RI_SPELL_AURA_MOD_CRITICAL_HEALING_AMOUNT, 1, 15, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%d%% Critical heal amount", RGB_DEFENSE
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_CRITICAL_HEALING_AMOUNT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_CRITICAL_HEALING_AMOUNT].AdditionalParam1 = SPELL_AURA_MOD_CRITICAL_HEALING_AMOUNT;
    LastInitedStat->Tooltip = "Increases heal amount when you score a critical heal.";

    InitStatRollParams(RI_SPELL_AURA_MOD_HIT_CHANCE, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%d%% Hit chance", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_HIT_CHANCE].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_HIT_CHANCE].AdditionalParam1 = SPELL_AURA_MOD_HIT_CHANCE;
    LastInitedStat->Tooltip = "Increases the chance your mellee/ranged/spell attacks will deal damage.";

    InitStatRollParams(RI_SPELL_AURA_MOD_SPELL_HIT_CHANCE, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%d%% Spell Hit chance", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HIT_CHANCE].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HIT_CHANCE].AdditionalParam1 = SPELL_AURA_MOD_SPELL_HIT_CHANCE;
    LastInitedStat->Tooltip = "Increases the chance your spell attacks will deal damage.";

    InitStatRollParams(RI_SPELL_AURA_MANA_SHIELD_1, 0.1f, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ManaPCTShield, "%.02f%% Damage Taken from mana shield", RGB_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MANA_SHIELD_1].NegativeRollChance = 0;
    RI_PickableStats[RI_SPELL_AURA_MANA_SHIELD_1].RollChance = 20;
    LastInitedStat->Tooltip = "As long as you have mana, percent of the damage taken will be taken from mana instead. Value refers to percent of damage converted";

    InitStatRollParams(RI_SPELL_AURA_MANA_SHIELD_2, 0.1f, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ManaShield, "%.02f%% Damage taken from mana", RGB_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MANA_SHIELD_2].NegativeRollChance = 0;
    RI_PickableStats[RI_SPELL_AURA_MANA_SHIELD_2].RollChance = 20;
    LastInitedStat->Tooltip = "As long as you have mana, damage taken will be taken from mana instead. Value refers to damage to mana conversion ratio.";

    InitStatRollParams(RI_SPELL_AURA_WATER_WALK, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Water Walk", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_WATER_WALK].NegativeRollChance = 0;
    RI_PickableStats[RI_SPELL_AURA_WATER_WALK].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_WATER_WALK].AdditionalParam1 = 546;
    RI_PickableStats[RI_SPELL_AURA_WATER_WALK].FixedValue = 1;
    LastInitedStat->Tooltip = "Gain the ability to walk above water";

    InitStatRollParams(RI_SPELL_AURA_FEATHER_FALL, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Feather Fall", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_FEATHER_FALL].NegativeRollChance = 0;
    RI_PickableStats[RI_SPELL_AURA_FEATHER_FALL].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_FEATHER_FALL].AdditionalParam1 = 130;
    RI_PickableStats[RI_SPELL_AURA_FEATHER_FALL].FixedValue = 1;
    LastInitedStat->Tooltip = "Gain the ability to fall slowly to avoid damage taken";

    InitStatRollParams(RI_SPELL_AURA_HOVER, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Hover", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_HOVER].NegativeRollChance = 0;
    RI_PickableStats[RI_SPELL_AURA_HOVER].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_HOVER].AdditionalParam1 = 11010;
    RI_PickableStats[RI_SPELL_AURA_HOVER].FixedValue = 1;
    LastInitedStat->Tooltip = "Walk above the ground. Cause it looks special";

    InitStatRollParams(RI_TAKEN_SPELL_AURA_MOD_HEALING_PCT, 0.1f, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%.02f%% Spell Healing Taken", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_TAKEN_SPELL_AURA_MOD_HEALING_PCT].AdditionalParam1 = SPELL_AURA_MOD_HEALING_PCT;
    RI_PickableStats[RI_TAKEN_SPELL_AURA_MOD_HEALING_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Increase the amount of healing you take";

    InitStatRollParams(RI_SPELL_AURA_MOD_HEALING_DONE, 1, 110, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%.02f Spell Healing Done", RGB_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_HEALING_DONE].AdditionalParam1 = SPELL_AURA_MOD_HEALING_DONE;
    RI_PickableStats[RI_SPELL_AURA_MOD_HEALING_DONE].RollChance = 20;
    LastInitedStat->Tooltip = "Increase the amount of healing you do";

    InitStatRollParams(RI_SPELL_AURA_MOD_HEALING_DONE_PERCENT, 0.1f, 40, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%.02f%% Spell Healing Done", RGB_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_HEALING_DONE_PERCENT].AdditionalParam1 = SPELL_AURA_MOD_HEALING_DONE;
    RI_PickableStats[RI_SPELL_AURA_MOD_HEALING_DONE_PERCENT].RollChance = 20;
    LastInitedStat->Tooltip = "Increase the amount of healing you do";

    InitStatRollParams(RI_MAGIC_FIND_NON_INSTANCE, 1, 20, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_MagicFindNoInstance, "%d%% Magic Find Out Of Instance", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_MAGIC_FIND_NON_INSTANCE].RollChance = 20;
    LastInitedStat->Tooltip = "Every 100 Magic Find will give 1 additional item stat for crafted, bought items";

    InitStatRollParams(RI_MAGIC_FIND_POWER_NON_INSTANCE, 1, 20, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_MagicStrengthNoInstance, "%d%% Magic Find Strength Rating Out Of Instance", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_MAGIC_FIND_POWER_NON_INSTANCE].RollChance = 20;
    LastInitedStat->Tooltip = "Increases the strength of random stats on crafted or bought items";

    InitStatRollParams(RI_LIFE_STEAL_FLAT, 1, 200, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LifeSteal, "%d Damage Done To Health", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LIFE_STEAL_FLAT].NegativeRollChance = 0;
    RI_PickableStats[RI_LIFE_STEAL_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "Health is increased every time you deal damage";

    InitStatRollParams(RI_LIFE_STEAL_PCT, 0.01f, 2, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LifeSteal, "%.02f%% Damage Done To Health", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LIFE_STEAL_PCT].NegativeRollChance = 0;
    RI_PickableStats[RI_LIFE_STEAL_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Health is increased every time you deal damage";

    InitStatRollParams(RI_POWER_BURN_FLAT, 1, 150, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ManaToDamage, "%d Mana To Damage", RGB_ATTACK
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_POWER_BURN_FLAT].NegativeRollChance = 0;
    RI_PickableStats[RI_POWER_BURN_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "Burn your own mana to increase damage done. This is considered bonus damage";

    InitStatRollParams(RI_POWER_MISSING_TO_DMG_PCT, 0.1f, 1.9f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerMissingToDMGPCT, "PCT Power missing To %.02f%% Damage", RGB_ATTACK
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_POWER_MISSING_TO_DMG_PCT].NegativeRollChance = 0;
    RI_PickableStats[RI_POWER_MISSING_TO_DMG_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Increase damage done based on how low is your power bar. This is considered bonus damage";

    InitStatRollParams(RI_DAMAGE_RECEIVED_TO_MANA, 1, 200, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageToMana, "%d Damage taken To Mana", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_RECEIVED_TO_MANA].NegativeRollChance = 0;
    RI_PickableStats[RI_DAMAGE_RECEIVED_TO_MANA].RollChance = 20;
    LastInitedStat->Tooltip = "Increase mana based on damage taken";

    InitStatRollParams(RI_DAMAGE_RECEIVED_TO_MANA_PCT, 0.01f, 1, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageToMana, "%.02f%% Damage taken To Mana", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_RECEIVED_TO_MANA_PCT].NegativeRollChance = 0;
    RI_PickableStats[RI_DAMAGE_RECEIVED_TO_MANA_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Increase mana based on damage taken";

    InitStatRollParams(RI_Cloack_On_Deadly_Blow, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_CastOnDeadlyBlow, "Chance To Cloack on Deadly Blow", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_Cloack_On_Deadly_Blow].NegativeRollChance = 0;
    RI_PickableStats[RI_Cloack_On_Deadly_Blow].RollChance = 20;
    RI_PickableStats[RI_Cloack_On_Deadly_Blow].AdditionalParam1 = 1856;
    RI_PickableStats[RI_Cloack_On_Deadly_Blow].FixedValue = 1;
    LastInitedStat->Tooltip = "When some damage would kill you, cancel that damage, and cast spell on you instead";

    InitStatRollParams(RI_EXTRA_GOLD_PCT, 0.01f, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GoldRate, "%.02f%% Extra Gold", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_EXTRA_GOLD_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Extra gold you receive when you loot monsters";

    InitStatRollParams(RI_ICEBLOCK_On_Deadly_Blow, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_CastOnDeadlyBlow, "Chance To Ice Block on Deadly Blow", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_ICEBLOCK_On_Deadly_Blow].NegativeRollChance = 0;
    RI_PickableStats[RI_ICEBLOCK_On_Deadly_Blow].RollChance = 20;
    RI_PickableStats[RI_ICEBLOCK_On_Deadly_Blow].AdditionalParam1 = 45438;
    RI_PickableStats[RI_ICEBLOCK_On_Deadly_Blow].FixedValue = 1;
    LastInitedStat->Tooltip = "When some damage would kill you, cancel that damage, and cast spell on you instead";

    InitStatRollParams(RI_DivineShield_On_Deadly_Blow, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_CastOnDeadlyBlow, "Chance To Divine Shield on Deadly Blow", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DivineShield_On_Deadly_Blow].NegativeRollChance = 0;
    RI_PickableStats[RI_DivineShield_On_Deadly_Blow].RollChance = 20;
    RI_PickableStats[RI_DivineShield_On_Deadly_Blow].AdditionalParam1 = 642;
    RI_PickableStats[RI_DivineShield_On_Deadly_Blow].FixedValue = 1;
    LastInitedStat->Tooltip = "When some damage would kill you, cancel that damage, and cast spell on you instead";

    InitStatRollParams(RI_MIN_MAX_DMG, 0.01f, 1.8f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_MinMaxDamage, "%.02f%% to Min Max Damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_MIN_MAX_DMG].RollChance = 20;
    LastInitedStat->Tooltip = "You sometimes deal more damage, sometimes deal less damage. Made for caster rotations";

    InitStatRollParams(RI_SPELL_AURA_HASTE_SPELLS, 0.1f, 2.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_CastTimeMod, "%.02f%% Cast speed", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_HASTE_SPELLS].NegativeRollChance = 90;
    LastInitedStat->Tooltip = "Cast spells faster";

    InitStatRollParams(RI_EXPLODE_ON_TARGET_DIE, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ExplodeOnTargetDie, "Target Explodes On Kill", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_EXPLODE_ON_TARGET_DIE].NegativeRollChance = 0;
    RI_PickableStats[RI_EXPLODE_ON_TARGET_DIE].RollChance = 20;
    RI_PickableStats[RI_EXPLODE_ON_TARGET_DIE].FixedValue = 1;
    LastInitedStat->Tooltip = "When your victim dies because of your damage, it will explode and deal area damage based on he's maximum health";

    InitStatRollParams(RI_CHAIN_LIGHTNING_ON_STRUCK_1, 1, 2, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LightningOnStruck, "%.02f%% damage reflected as Chain Lightning 1 On Struck", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_STRUCK_1].NegativeRollChance = 0;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_STRUCK_1].RollChance = 20;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_STRUCK_1].AdditionalParam1 = 12058;
    LastInitedStat->Tooltip = "Damage received will charge up a chain lightning that will periodically get casted";

    InitStatRollParams(RI_DAMAGE_TAKEN_AGRO_COUNT_FLAT, 1, 200, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageTakenAttackerCount, "%d Damage reduction Based On Attacker Count", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_TAKEN_AGRO_COUNT_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "Damage reduction based on the number of agroed units. Made for tanks to pull half of the map";

    InitStatRollParams(RI_DAMAGE_TAKEN_TO_DONE_FLAT, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageTakenToDmgDone, "%d Damage Taken Converted to Damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_TAKEN_TO_DONE_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "Tanks can soak up a lot of damage. Teamwork can make them become a damage dealer";

    InitStatRollParams(RI_DAMAGE_TAKEN_TO_DONE_PCT, 0.1f, 3.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageTakenToDmgDone, "%.02f%% Damage Taken Converted to Damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_TAKEN_TO_DONE_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Tanks can soak up a lot of damage. Teamwork can make them become a damage dealer";

    InitStatRollParams(RI_Strength_PCT, 0.1f, 1.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatPCT, "%.02f%% Strength", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_DEATH_KNIGHT, CLASS_DRUID, 0));
    RI_PickableStats[RI_Strength_PCT].AdditionalParam1 = STAT_STRENGTH;
    LastInitedStat->Tooltip = "Incease strength based on a percent value. Strength increases attack power. Increases shield block value";

    InitStatRollParams(RI_Agility_PCT, 0.1f, 2.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatPCT, "%.02f%% Agility", RGB_ATTACK_DEFENSE
        , BCFM( CLASS_HUNTER, CLASS_ROGUE, CLASS_DRUID, 0));
    RI_PickableStats[RI_Agility_PCT].AdditionalParam1 = STAT_AGILITY;
    LastInitedStat->Tooltip = "Incease agility based on a percent value. Agility attack power.Increases armor.Increases crit chance for some classes.Increases dodge chance.";

    InitStatRollParams(RI_Stamina_PCT, 0.1f, 3.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatPCT, "%.02f%% Stamina", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_Stamina_PCT].AdditionalParam1 = STAT_STAMINA;
    LastInitedStat->Tooltip = "Incease stamina based on a percent value. Stamina increases max health.";

    InitStatRollParams(RI_Intelect_PCT, 0.1f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatPCT, "%.02f%% Intelect", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_Intelect_PCT].AdditionalParam1 = STAT_INTELLECT;
    LastInitedStat->Tooltip = "Increases max mana. Increases mana regen. Increases crit chance for some classes.";

    InitStatRollParams(RI_SPIRIT_PCT, 0.1f, 1.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatPCT, "%.02f%% Spirit", RGB_ATTACK_DEFENSE
        , BCFM( CLASS_PALADIN,  CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPIRIT_PCT].AdditionalParam1 = STAT_SPIRIT;
    LastInitedStat->Tooltip = "Increases mana regen.";

    InitStatRollParams(RI_STAT_ALL_PCT, 0.1f, 1.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatPCT, "%.02f%% Stats", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_STAT_ALL_PCT].AdditionalParam1 = -1;
    LastInitedStat->Tooltip = "Increases all base stats by a percent value.";

    InitStatRollParams(RI_SPELL_AURA_REDUCE_PUSHBACK, 1, 5, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModFlat, "-%d%% Casttime Pushback", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_REDUCE_PUSHBACK].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_REDUCE_PUSHBACK].SpellMod = SPELLMOD_NOT_LOSE_CASTING_TIME;
    LastInitedStat->Tooltip = "When you receive damage while casting, the amount of spell cast delay will be reduced.";

    InitStatRollParams(RI_SPELLMOD_GLOBAL_COOLDOWN, 1, 5, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModFlat, "-%d%% Global Cooldowns", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELLMOD_GLOBAL_COOLDOWN].RollChance = 20;
    RI_PickableStats[RI_SPELLMOD_GLOBAL_COOLDOWN].SpellMod = SPELLMOD_GLOBAL_COOLDOWN;
    LastInitedStat->Tooltip = "Decrease the global cooldown of some of the spells/abilities. Value is in milliseconds";

    InitStatRollParams(RI_DMG_TAKEN_RAID_SIZE_FLAT, 10, 200, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageTakenRaidSize, "%d Damage taken reduction based on raid size", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DMG_TAKEN_RAID_SIZE_FLAT].NegativeRollChance = 95;
    RI_PickableStats[RI_DMG_TAKEN_RAID_SIZE_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "The more players are in your raid group, the less damage you take";

    InitStatRollParams(RI_DMG_TAKEN_RAID_SIZE_PCT, 0.1f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageTakenRaidSize, "%.02f%% Damage taken reduction based on raid size", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DMG_TAKEN_RAID_SIZE_PCT].NegativeRollChance = 95;
    RI_PickableStats[RI_DMG_TAKEN_RAID_SIZE_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "The more players are in your raid group, the less damage you take";

    InitStatRollParams(RI_DMG_DONE_RAID_SIZE_FLAT, 1, 20, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneRaidSize, "%d Damage done based on raid size", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DMG_DONE_RAID_SIZE_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "The more players are in your raid group, the damage damage you deal";

    InitStatRollParams(RI_DMG_DONE_RAID_SIZE_PCT, 0.01f, 0.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDoneRaidSize, "%.02f%% Damage done based on raid size", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DMG_DONE_RAID_SIZE_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "The more players are in your raid group, the damage damage you deal";

    InitStatRollParams(RI_DMG_TAKEN_FROM_GOLD_FLAT, 1, 2000, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageTakenFromGold, "%d Damage taken as 10 silver", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DMG_TAKEN_FROM_GOLD_FLAT].RollChance = 20;
    RI_PickableStats[RI_DMG_TAKEN_FROM_GOLD_FLAT].NegativeRollChance = 0;
    LastInitedStat->Tooltip = "Part of the damage you would take, will be taken from money instead";

    InitStatRollParams(RI_Talent_Points, 1, 1, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_TalentPoints, "%d Talent points", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_Talent_Points].RollChance = 20;
    LastInitedStat->Tooltip = "Extra talent points you can spend. You should spend these as soon as possible to avoid bugouts";

    InitStatRollParams(RI_SHARED_HP_TANK_FLAT, 1, 2000, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageShareTank, "%d Damage taken Shared With Nearby Tanks", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_DEATH_KNIGHT, CLASS_DRUID, 0));
    RI_PickableStats[RI_SHARED_HP_TANK_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "Nearby tanks will also take part of the damage. Damage can not be mitigated";

    InitStatRollParams(RI_SHARED_HP_TANK_PCT, 0.01f, 5, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageShareTank, "%.02f%% Damage taken Shared With Nearby Tanks", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_DEATH_KNIGHT, CLASS_DRUID, 0));
    RI_PickableStats[RI_SHARED_HP_TANK_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Nearby tanks will also take part of the damage. Damage can not be mitigated";

    InitStatRollParams(RI_SHARED_HP_CASTER_FLAT, 1, 2000, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageShareCaster, "%d Damage taken Shared With Nearby Casters", RGB_DEFENSE
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SHARED_HP_CASTER_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "Nearby casters will also take part of the damage. Damage can not be mitigated";

    InitStatRollParams(RI_SHARED_HP_CASTER_PCT, 0.01f, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageShareCaster, "%.02f%% Damage taken Shared With Nearby Casters", RGB_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SHARED_HP_CASTER_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Nearby tanks will also take part of the damage. Damage can not be mitigated";

    InitStatRollParams(RI_CHANCE_TO_REDUCE_COOLDOWN_OF_PREVIOUS_SPELL_FLAT, 1, 2, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ReduceCooldownPrevSpell, "Chance to reduce cooldown of previous spell", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHANCE_TO_REDUCE_COOLDOWN_OF_PREVIOUS_SPELL_FLAT].RollChance = 20;
    RI_PickableStats[RI_CHANCE_TO_REDUCE_COOLDOWN_OF_PREVIOUS_SPELL_FLAT].NegativeRollChance = 0;
    RI_PickableStats[RI_CHANCE_TO_REDUCE_COOLDOWN_OF_PREVIOUS_SPELL_FLAT].AdditionalParam1 = -1;
    RI_PickableStats[RI_CHANCE_TO_REDUCE_COOLDOWN_OF_PREVIOUS_SPELL_FLAT].FixedValue = 1;
    LastInitedStat->Tooltip = "Cast a long cooldown spell, than spam some instant spells to reduce the large cooldown";

    InitStatRollParams(RI_LOW_HEALTH_EXTRA_DMG_FLAT, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ExtraDmgLowHealth, "%d Extra dmg while below 20%% HP", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LOW_HEALTH_EXTRA_DMG_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "As long as your health is below 20%, you will deal aditional damage";

    InitStatRollParams(RI_LOW_HEALTH_EXTRA_DMG_PCT, 0.1f, 3.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ExtraDmgLowHealth, "%.02f%% Extra dmg while below 20%% HP", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LOW_HEALTH_EXTRA_DMG_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "As long as your health is below 20%, you will deal aditional damage";

    InitStatRollParams(RI_LOW_HEALTH_EXTRA_DODGE, 1, 3, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ExtraEvadeLowHealth, "%d%% Evade while below 20%% HP", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LOW_HEALTH_EXTRA_DODGE].RollChance = 20;
    LastInitedStat->Tooltip = "As long as your health is below 20%, you have additional chance that attacks will not deal damage";

    InitStatRollParams(RI_LOW_HEALTH_EXTRA_ABSORB, 1, 5, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ExtraAbsorbLowHealth, "%d%% Absorb while below 20%% HP", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LOW_HEALTH_EXTRA_ABSORB].RollChance = 20;
    LastInitedStat->Tooltip = "As long as your health is below 20%, you will take reduced damage";

    InitStatRollParams(RI_STAT_DROPCHANCE, 1, 5, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatRollChance, "%d%% Stat Roll Chance", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_STAT_DROPCHANCE].RollChance = 20;
    LastInitedStat->Tooltip = "When you loot an item, each stat has a specific chance to be rolled on the item based on it's impact. Some roll chances are negative by default. Increases the roll chance of all stats";

    InitStatRollParams(RI_MAX_HP_DMG_TAKEN, 30, 2, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageTakenMaxHP, "Damage Taken Can't exceed %d%% Max HP", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_MAX_HP_DMG_TAKEN].RollChance = 10;
    RI_PickableStats[RI_MAX_HP_DMG_TAKEN].InverseGenerated = 100;
    RI_PickableStats[RI_MAX_HP_DMG_TAKEN].NegativeRollChance = 0;
    LastInitedStat->Tooltip = "When you take damage, if the damage is larger than x% of your health, it will be reduced to not exceed the trashold";

    InitStatRollParams(RI_AURA_ICE_ARMOR, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Ice Armor", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_AURA_ICE_ARMOR].NegativeRollChance = 0;
    RI_PickableStats[RI_AURA_ICE_ARMOR].AdditionalParam1 = 27124;
    RI_PickableStats[RI_AURA_ICE_ARMOR].FixedValue = 1;
    LastInitedStat->Tooltip = "Gain aura that does not have duration";

    InitStatRollParams(RI_AURA_METAMORPHOSIS, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Metamorphosis", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_AURA_METAMORPHOSIS].NegativeRollChance = 0;
    RI_PickableStats[RI_AURA_METAMORPHOSIS].AdditionalParam1 = 47241;
    RI_PickableStats[RI_AURA_METAMORPHOSIS].FixedValue = 1;
    LastInitedStat->Tooltip = "Gain cosmetic look";

    InitStatRollParams(RI_AURA_DEMON_ARMOR, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Demon Armor", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_AURA_DEMON_ARMOR].NegativeRollChance = 0;
    RI_PickableStats[RI_AURA_DEMON_ARMOR].AdditionalParam1 = 47889;
    RI_PickableStats[RI_AURA_DEMON_ARMOR].FixedValue = 1;
    LastInitedStat->Tooltip = "Gain aura that does not have duration";

    InitStatRollParams(RI_AURA_FEL_ARMOR, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Fel Armor", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_AURA_FEL_ARMOR].NegativeRollChance = 0;
    RI_PickableStats[RI_AURA_FEL_ARMOR].AdditionalParam1 = 44520;
    RI_PickableStats[RI_AURA_FEL_ARMOR].FixedValue = 1;
    LastInitedStat->Tooltip = "Gain aura that does not have duration";

    InitStatRollParams(RI_GAIN_REINCARNATION, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Reincarnation", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_GAIN_REINCARNATION].NegativeRollChance = 0;
    RI_PickableStats[RI_GAIN_REINCARNATION].AdditionalParam1 = 20608;
    RI_PickableStats[RI_GAIN_REINCARNATION].LearnAsSpell = 1;
    RI_PickableStats[RI_GAIN_REINCARNATION].FixedValue = 1;
    LastInitedStat->Tooltip = "Uppon death, if you own the reagent, you are able to revive yourself";

    InitStatRollParams(RI_DEBUFF_ON_HEAL, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_RemoveDebuffOnHeal, "Chance to loose debuff on direct heal", RGB_UTIL
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_DEBUFF_ON_HEAL].NegativeRollChance = 0;
    RI_PickableStats[RI_DEBUFF_ON_HEAL].FixedValue = 1;
    LastInitedStat->Tooltip = "Heal received has a chance to dispel/cure a debuff";

    InitStatRollParams(RI_CAST_DISPERSION_ON_DEADLY_BLOW, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_CastOnDeadlyBlow, "Chance To Dispersion on Deadly Blow", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CAST_DISPERSION_ON_DEADLY_BLOW].NegativeRollChance = 0;
    RI_PickableStats[RI_CAST_DISPERSION_ON_DEADLY_BLOW].RollChance = 20;
    RI_PickableStats[RI_CAST_DISPERSION_ON_DEADLY_BLOW].AdditionalParam1 = 65544;
    RI_PickableStats[RI_CAST_DISPERSION_ON_DEADLY_BLOW].FixedValue = 1;
    LastInitedStat->Tooltip = "When some damage would kill you, cancel that damage, and cast spell on you instead";

    InitStatRollParams(RI_CHANCE_TO_DISENGAGE_ON_DMG, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DisengageOnDmgVictim, "Chance To Disengage on Damage", RGB_UTIL
        , BCFM( CLASS_HUNTER, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHANCE_TO_DISENGAGE_ON_DMG].NegativeRollChance = 0;
    RI_PickableStats[RI_CHANCE_TO_DISENGAGE_ON_DMG].RollChance = 20;
    RI_PickableStats[RI_CHANCE_TO_DISENGAGE_ON_DMG].AdditionalParam1 = 781;
    RI_PickableStats[RI_CHANCE_TO_DISENGAGE_ON_DMG].FixedValue = 1;
    LastInitedStat->Tooltip = "When you receive damage, you have a chance to jump backwards automatically";

    InitStatRollParams(RI_TARGET_CAST_STORMSTRIKE_ON_HEAL, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StormStrikeOnHeal, "Chance to stormstrike on direct heal", RGB_UTIL
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_TARGET_CAST_STORMSTRIKE_ON_HEAL].NegativeRollChance = 0;
    RI_PickableStats[RI_TARGET_CAST_STORMSTRIKE_ON_HEAL].FixedValue = 1;
    RI_PickableStats[RI_TARGET_CAST_STORMSTRIKE_ON_HEAL].FixedValue = 1;
    LastInitedStat->Tooltip = "When you heal your target, he has a chance to cast stormstrike for free";

    InitStatRollParams(RI_POTION_COOLDOWN_CLEAR, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PotionCooldownOnDamageTaken, "Chance to clear potion cooldown on damage taken", RGB_UTIL
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_POTION_COOLDOWN_CLEAR].NegativeRollChance = 0;
    RI_PickableStats[RI_POTION_COOLDOWN_CLEAR].FixedValue = 1;
    RI_PickableStats[RI_POTION_COOLDOWN_CLEAR].FixedValue = 1;
    LastInitedStat->Tooltip = "When you take damage, you have a chance to clear the cooldown of your healing potions";

    InitStatRollParams(RI_OVERHEALS_ADD_TO_TARGET_DAMAGE, 0.01f, 2.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_OverhealsToDamage, "%.02f%% Of Overheal is added to your next damage", RGB_ATTACK
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_OVERHEALS_ADD_TO_TARGET_DAMAGE].RollChance = 20;
    LastInitedStat->Tooltip = "Healing taken while you are on maximum health, will increase your damage";

    InitStatRollParams(RI_PARTY_MIMICS_SELF_CASTS, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PartyMimic, "Party mimics some of self cast auras", RGB_UTIL
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_PARTY_MIMICS_SELF_CASTS].NegativeRollChance = 0;
    RI_PickableStats[RI_PARTY_MIMICS_SELF_CASTS].FixedValue = 1;
    RI_PickableStats[RI_PARTY_MIMICS_SELF_CASTS].RollChance = 5;
    LastInitedStat->Tooltip = "When you cast an aura that can only target yourself, party members have a chance to also cast that spell on themself";

    InitStatRollParams(RI_MY_HEALTH_BASED_HEAL, 0.01f, 2.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealthBasedHeal, "%.02f%% Of Current Health Is Added To Heals", RGB_UTIL
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_MY_HEALTH_BASED_HEAL].RollChance = 20;
    LastInitedStat->Tooltip = "The more health you have, the more healing you can do";

    InitStatRollParams(RI_CHANCE_DOUBLE_CAST, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_MirrorCast, "Chance to cast same spell for free", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHANCE_DOUBLE_CAST].NegativeRollChance = 0;
    RI_PickableStats[RI_CHANCE_DOUBLE_CAST].RollChance = 20;
    RI_PickableStats[RI_CHANCE_DOUBLE_CAST].FixedValue = 1;
    LastInitedStat->Tooltip = "Chance to repeat the spell cast instnatly and for free";

    InitStatRollParams(RI_UTIL_STAT_DROPCHANCE, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatRollChance, "%d%% chance to favor utility stats roll", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_UTIL_STAT_DROPCHANCE].NegativeRollChance = 50;
    RI_PickableStats[RI_UTIL_STAT_DROPCHANCE].RollChance = 20;
    LastInitedStat->Tooltip = "When you loot an item, each stat has a specific chance to be rolled on the item based on it's impact. Some roll chances are negative by default. Increases the roll chance of all utility stats";

    InitStatRollParams(RI_ATTACK_STAT_DROPCHANCE, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatRollChance, "%d%% chance to favor attack stats roll", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_ATTACK_STAT_DROPCHANCE].NegativeRollChance = 50;
    RI_PickableStats[RI_ATTACK_STAT_DROPCHANCE].RollChance = 20;
    LastInitedStat->Tooltip = "When you loot an item, each stat has a specific chance to be rolled on the item based on it's impact. Some roll chances are negative by default. Increases the roll chance of all attack stats";

    InitStatRollParams(RI_DEFENSE_STAT_DROPCHANCE, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatRollChance, "%d%% chance to favor defense stats roll", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DEFENSE_STAT_DROPCHANCE].RollChance = 20;
    LastInitedStat->Tooltip = "When you loot an item, each stat has a specific chance to be rolled on the item based on it's impact. Some roll chances are negative by default. Increases the roll chance of all defense stats";

    InitStatRollParams(RI_DAMAGE_FOR_UNIQUE_KILL, 0.01f, 4.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_UniqueKill, "%.02f Damage done for each unqiue monsters killed", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_FOR_UNIQUE_KILL].RollChance = 5; // about 30k max
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique monster kill will increase your damage forever";

    InitStatRollParams(RI_HEAL_FOR_UNIQUE_KILL, 0.01f, 4.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_UniqueKill, "%.02f Heal for each unqiue monsters killed", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_FOR_UNIQUE_KILL].RollChance = 20;
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique monster kill will increase your healing forever";

    InitStatRollParams(RI_DAMAGE_FOR_UNIQUE_USABLE_ITEM, 1.1f, 14, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_UniqueItemUse, "%.02f Damage done for each unqiue item used", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_FOR_UNIQUE_USABLE_ITEM].RollChance = 20;// about 7240 max
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique item used will increase your damage forever";

    InitStatRollParams(RI_HEAL_FOR_UNIQUE_USABLE_ITEM, 1.1f, 14, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_UniqueItemUse, "%.02f Heal for each unqiue item used", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_FOR_UNIQUE_USABLE_ITEM].RollChance = 20; 
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique item used will increase your heal forever";

    InitStatRollParams(RI_DAMAGE_FOR_ACHIEVEMENTS_EARNED, 1.1f, 62, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_Achievements, "%.02f Damage done for each achievement earned", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_FOR_ACHIEVEMENTS_EARNED].RollChance = 20; // about 1600 achievements max
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique achievement earned will increase your damage forever";

    InitStatRollParams(RI_HEAL_FOR_ACHIEVEMENTS_EARNED, 1.1f, 62, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_Achievements, "%.02f Heal for each achievement earned", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_FOR_ACHIEVEMENTS_EARNED].RollChance = 20;
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique achievement earned will increase your healing forever";

    InitStatRollParams(RI_DMG_FOR_QUESTS, 1.1f, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_Quests, "%.02f Damage done for each quest finished", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DMG_FOR_QUESTS].RollChance = 20; // about 9400 quests max
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique quest finished will increase your damage forever";

    InitStatRollParams(RI_HEAL_FOR_QUESTS, 1.1f, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_Quests, "%.02f Heal for each quest finished", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_FOR_QUESTS].RollChance = 20;
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique quest finished will increase your healing forever";

    InitStatRollParams(RI_DMG_FOR_HONORABLE_KILLS_RATING, 0.1f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_HonorableKills, "%.02f Damage done for honorable kill rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DMG_FOR_HONORABLE_KILLS_RATING].RollChance = 10; // about 2000
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique honorable kill will increase your damage forever. The damage stacking slows down after a while, but does not stop";

    InitStatRollParams(RI_HEAL_FOR_HONORABLE_KILLS_RATING, 0.1f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_HonorableKills, "%.02f Heal for honorable kill rating", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_FOR_HONORABLE_KILLS_RATING].RollChance = 20;
    LastInitedStat->Tooltip = "Based on yhe lifetime of this character, each unique honorable kill will increase your healing forever. The healing stacking slows down after a while, but does not stop";

    InitStatRollParams(RI_SPELLMOD_COST, 1.1f, 10.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModPCT, "%.02f%% Spell Cost Reduction", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELLMOD_COST].RollChance = 20;
    RI_PickableStats[RI_SPELLMOD_COST].SpellMod = SPELLMOD_COST;
    LastInitedStat->Tooltip = "Spell casting will cost less";

    InitStatRollParams(RI_LEATHER_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Leather proficiency", RGB_ATTACK_DEFENSE
        , BCFM(  CLASS_PRIEST, CLASS_MAGE, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_LEATHER_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_LEATHER_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_LEATHER_PROFICIENCY].AdditionalParam1 = 9077;
    RI_PickableStats[RI_LEATHER_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_LEATHER_PROFICIENCY].LearnSkill = SKILL_LEATHER;
    RI_PickableStats[RI_LEATHER_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_MAIL_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Mail proficiency", RGB_ATTACK_DEFENSE
        , BCFM( CLASS_ROGUE, CLASS_PRIEST, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_MAIL_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_MAIL_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_MAIL_PROFICIENCY].AdditionalParam1 = 8737;
    RI_PickableStats[RI_MAIL_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_MAIL_PROFICIENCY].LearnSkill = SKILL_MAIL;
    RI_PickableStats[RI_MAIL_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_PLATE_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Plate Mail proficiency", RGB_ATTACK_DEFENSE
        , BCFM( CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_PLATE_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_PLATE_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_PLATE_PROFICIENCY].AdditionalParam1 = 750;
    RI_PickableStats[RI_PLATE_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_PLATE_PROFICIENCY].LearnSkill = SKILL_PLATE_MAIL;
    RI_PickableStats[RI_PLATE_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_1H_AXE_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "One-Handed Axe proficiency", RGB_ATTACK
        , BCFM( CLASS_PRIEST, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_1H_AXE_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_1H_AXE_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_1H_AXE_PROFICIENCY].AdditionalParam1 = 196;
    RI_PickableStats[RI_1H_AXE_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_1H_AXE_PROFICIENCY].LearnSkill = SKILL_AXES;
    RI_PickableStats[RI_1H_AXE_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_1H_MACE_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "One-Handed Mace proficiency", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_1H_MACE_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_1H_MACE_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_1H_MACE_PROFICIENCY].AdditionalParam1 = 198;
    RI_PickableStats[RI_1H_MACE_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_1H_MACE_PROFICIENCY].LearnSkill = SKILL_MACES;
    RI_PickableStats[RI_1H_MACE_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_1H_SWORD_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "One-Handed Swords proficiency", RGB_ATTACK
        , BCFM( CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_1H_SWORD_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_1H_SWORD_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_1H_SWORD_PROFICIENCY].AdditionalParam1 = 201;
    RI_PickableStats[RI_1H_SWORD_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_1H_SWORD_PROFICIENCY].LearnSkill = SKILL_SWORDS;
    RI_PickableStats[RI_1H_SWORD_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_POLEARM_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Polearms proficiency", RGB_ATTACK
        , BCFM(CLASS_ROGUE, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_POLEARM_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_POLEARM_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_POLEARM_PROFICIENCY].AdditionalParam1 = 200;
    RI_PickableStats[RI_POLEARM_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_POLEARM_PROFICIENCY].LearnSkill = SKILL_POLEARMS;
    RI_PickableStats[RI_POLEARM_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_SHIELD_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Shield proficiency", RGB_DEFENSE
        , BCFM( CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SHIELD_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_SHIELD_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_SHIELD_PROFICIENCY].AdditionalParam1 = 9116;
    RI_PickableStats[RI_SHIELD_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_SHIELD_PROFICIENCY].LearnSkill = SKILL_SHIELD;
    RI_PickableStats[RI_SHIELD_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_STAFF_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Staves proficiency", RGB_ATTACK
        , BCFM(CLASS_PALADIN, CLASS_ROGUE, CLASS_DEATH_KNIGHT, 0));
    RI_PickableStats[RI_STAFF_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_STAFF_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_STAFF_PROFICIENCY].AdditionalParam1 = 227;
    RI_PickableStats[RI_STAFF_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_STAFF_PROFICIENCY].LearnSkill = SKILL_STAVES;
    RI_PickableStats[RI_STAFF_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_2H_AXE_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Two-Handed Axes proficiency", RGB_ATTACK
        , BCFM( CLASS_ROGUE, CLASS_PRIEST, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_2H_AXE_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_2H_AXE_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_2H_AXE_PROFICIENCY].AdditionalParam1 = 197;
    RI_PickableStats[RI_2H_AXE_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_2H_AXE_PROFICIENCY].LearnSkill = SKILL_2H_AXES;
    RI_PickableStats[RI_2H_AXE_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_2H_MACE_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Two-Handed Maces proficiency", RGB_ATTACK
        , BCFM( CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_MAGE, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_2H_MACE_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_2H_MACE_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_2H_MACE_PROFICIENCY].AdditionalParam1 = 199;
    RI_PickableStats[RI_2H_MACE_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_2H_MACE_PROFICIENCY].LearnSkill = SKILL_2H_MACES;
    RI_PickableStats[RI_2H_MACE_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_2H_SWORD_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Two-Handed Sword proficiency", RGB_ATTACK
        , BCFM( CLASS_ROGUE, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_2H_SWORD_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_2H_SWORD_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_2H_SWORD_PROFICIENCY].AdditionalParam1 = 202;
    RI_PickableStats[RI_2H_SWORD_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_2H_SWORD_PROFICIENCY].LearnSkill = SKILL_2H_SWORDS;
    RI_PickableStats[RI_2H_SWORD_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_LEARN_FROST_NOVA, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Frost Nova", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_FROST_NOVA].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_FROST_NOVA].RollChance = 20;
    RI_PickableStats[RI_LEARN_FROST_NOVA].AdditionalParam1 = 42917;
    RI_PickableStats[RI_LEARN_FROST_NOVA].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_FROST_NOVA].FixedValue = 1;
    LastInitedStat->Tooltip = "You will be able to use this item class";

    InitStatRollParams(RI_LEARN_SUMMON_SUCUBUS, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Summon Succubus", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_SUMMON_SUCUBUS].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_SUMMON_SUCUBUS].RollChance = 20;
    RI_PickableStats[RI_LEARN_SUMMON_SUCUBUS].AdditionalParam1 = 712;
    RI_PickableStats[RI_LEARN_SUMMON_SUCUBUS].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_SUMMON_SUCUBUS].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Succubus is a caster helper summon";

    InitStatRollParams(RI_LEARN_CHARGE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Charge", RGB_UTIL
        , BCFM( CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_CHARGE].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_CHARGE].RollChance = 20;
    RI_PickableStats[RI_LEARN_CHARGE].AdditionalParam1 = 52601;   
    RI_PickableStats[RI_LEARN_CHARGE].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_CHARGE].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. This is a gap closer spell before you engage combat";

    InitStatRollParams(RI_LEARN_INERVATE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Inervate", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_LEARN_INERVATE].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_INERVATE].RollChance = 20;
    RI_PickableStats[RI_LEARN_INERVATE].AdditionalParam1 = 29166;
    RI_PickableStats[RI_LEARN_INERVATE].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_INERVATE].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. You will generate mana after casting the spell";

    InitStatRollParams(RI_GAIN_MARK_OF_THE_WILD, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Gain Mark of the Wild", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_GAIN_MARK_OF_THE_WILD].NegativeRollChance = 0;
    RI_PickableStats[RI_GAIN_MARK_OF_THE_WILD].RollChance = 20;
    RI_PickableStats[RI_GAIN_MARK_OF_THE_WILD].AdditionalParam1 = 48469;
    RI_PickableStats[RI_GAIN_MARK_OF_THE_WILD].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Target armor will be increased";

    InitStatRollParams(RI_LEARN_NATURE_GRASP, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Nature's Grasp", RGB_UTIL
        , BCFM(CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_LEARN_NATURE_GRASP].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_NATURE_GRASP].RollChance = 20;
    RI_PickableStats[RI_LEARN_NATURE_GRASP].AdditionalParam1 = 27009;
    RI_PickableStats[RI_LEARN_NATURE_GRASP].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_NATURE_GRASP].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Attackers might become rooted";

    InitStatRollParams(RI_LEARN_REBIRTH, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Rebirth", RGB_UTIL
        , BCFM(CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_LEARN_REBIRTH].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_REBIRTH].RollChance = 20;
    RI_PickableStats[RI_LEARN_REBIRTH].AdditionalParam1 = 48477;
    RI_PickableStats[RI_LEARN_REBIRTH].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_REBIRTH].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. You will be able to revive dead players";

    InitStatRollParams(RI_LEARN_Deterrence, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Deterrence", RGB_UTIL
        , BCFM(CLASS_PALADIN, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_Deterrence].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_Deterrence].RollChance = 20;
    RI_PickableStats[RI_LEARN_Deterrence].AdditionalParam1 = 48477;
    RI_PickableStats[RI_LEARN_Deterrence].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_Deterrence].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Defensive spell to avoid combat";

    InitStatRollParams(RI_LEARN_RapidFire, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Rapid Fire", RGB_ATTACK
        , BCFM(CLASS_PALADIN, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_RapidFire].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_RapidFire].RollChance = 20;
    RI_PickableStats[RI_LEARN_RapidFire].AdditionalParam1 = 3045;
    RI_PickableStats[RI_LEARN_RapidFire].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_RapidFire].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Increases ranged attack speed";

    InitStatRollParams(RI_LEARN_ARCANE_POWER, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Arcane Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_ARCANE_POWER].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_ARCANE_POWER].RollChance = 20;
    RI_PickableStats[RI_LEARN_ARCANE_POWER].AdditionalParam1 = 12042;
    RI_PickableStats[RI_LEARN_ARCANE_POWER].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_ARCANE_POWER].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Spells deal more damage, but will also cost more mana";

    InitStatRollParams(RI_LEARN_COUNTERSPELL, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Counter Spell", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_COUNTERSPELL].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_COUNTERSPELL].RollChance = 20;
    RI_PickableStats[RI_LEARN_COUNTERSPELL].AdditionalParam1 = 2139;
    RI_PickableStats[RI_LEARN_COUNTERSPELL].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_COUNTERSPELL].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Interrupt spell casting of your target";

    InitStatRollParams(RI_LEARN_EVOCATION, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Evocation", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_EVOCATION].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_EVOCATION].RollChance = 20;
    RI_PickableStats[RI_LEARN_EVOCATION].AdditionalParam1 = 12051;
    RI_PickableStats[RI_LEARN_EVOCATION].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_EVOCATION].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. You will generate mana after casting the spell";

    InitStatRollParams(RI_LEARN_Focus_Magic, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Focus Magic", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_Focus_Magic].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_Focus_Magic].RollChance = 20;
    RI_PickableStats[RI_LEARN_Focus_Magic].AdditionalParam1 = 54646;
    RI_PickableStats[RI_LEARN_Focus_Magic].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_Focus_Magic].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Increases the chance that you will critically hit with spells";

    InitStatRollParams(RI_LEARN_ICY_VEINS, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Icy Veins", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_ICY_VEINS].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_ICY_VEINS].RollChance = 20;
    RI_PickableStats[RI_LEARN_ICY_VEINS].AdditionalParam1 = 12472;
    RI_PickableStats[RI_LEARN_ICY_VEINS].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_ICY_VEINS].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Increases spell casting speed";

    InitStatRollParams(RI_LEARN_DIVINE_STORM, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Divine Storm", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_DIVINE_STORM].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_DIVINE_STORM].RollChance = 20;
    RI_PickableStats[RI_LEARN_DIVINE_STORM].AdditionalParam1 = 53385;
    RI_PickableStats[RI_LEARN_DIVINE_STORM].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_DIVINE_STORM].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Area damage based on weapon damage. Costs talent point to learn";

    InitStatRollParams(RI_LEARN_SEAL_OF_LIGHT, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Seal of Light", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_SEAL_OF_LIGHT].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_SEAL_OF_LIGHT].RollChance = 20;
    RI_PickableStats[RI_LEARN_SEAL_OF_LIGHT].AdditionalParam1 = 20165;
    RI_PickableStats[RI_LEARN_SEAL_OF_LIGHT].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_SEAL_OF_LIGHT].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Your attacks will have a chance to heal you";

    InitStatRollParams(RI_LEARN_DIVINE_HYMN, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Divine Hymn", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_DIVINE_HYMN].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_DIVINE_HYMN].RollChance = 20;
    RI_PickableStats[RI_LEARN_DIVINE_HYMN].AdditionalParam1 = 64843;
    RI_PickableStats[RI_LEARN_DIVINE_HYMN].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_DIVINE_HYMN].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Channeled spell that heals and increases healing received of targeted party member";

    InitStatRollParams(RI_LEARN_HYMN_OF_HOPE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Hymn of Hope", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_HYMN_OF_HOPE].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_HYMN_OF_HOPE].RollChance = 20;
    RI_PickableStats[RI_LEARN_HYMN_OF_HOPE].AdditionalParam1 = 64901;
    RI_PickableStats[RI_LEARN_HYMN_OF_HOPE].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_HYMN_OF_HOPE].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Channeled spell that restores mana of targeted party member";

    InitStatRollParams(RI_LEARN_INNER_FOCUS, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Inner Focus", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_INNER_FOCUS].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_INNER_FOCUS].RollChance = -1000;
    RI_PickableStats[RI_LEARN_INNER_FOCUS].AdditionalParam1 = 14751;
    RI_PickableStats[RI_LEARN_INNER_FOCUS].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_INNER_FOCUS].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Increases critical chance and reduces spell cost of the next spell";

    InitStatRollParams(RI_LEARN_MANA_BURN, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Mana Burn", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_MANA_BURN].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_MANA_BURN].RollChance = 20;
    RI_PickableStats[RI_LEARN_MANA_BURN].AdditionalParam1 = 8129;
    RI_PickableStats[RI_LEARN_MANA_BURN].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_MANA_BURN].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Burn target mana for damage";

    InitStatRollParams(RI_LEARN_LAST_STAND, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Last Stand", RGB_UTIL
        , BCFM(CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_LAST_STAND].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_LAST_STAND].RollChance = 20;
    RI_PickableStats[RI_LEARN_LAST_STAND].AdditionalParam1 = 12975;
    RI_PickableStats[RI_LEARN_LAST_STAND].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_LAST_STAND].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Temporary increases health based on max health";

    InitStatRollParams(RI_LEARN_BLOODLUST, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn BloodLust", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_BLOODLUST].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_BLOODLUST].RollChance = 20;
    RI_PickableStats[RI_LEARN_BLOODLUST].AdditionalParam1 = 2825;
    RI_PickableStats[RI_LEARN_BLOODLUST].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_BLOODLUST].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Increases attack speed or party members";

    InitStatRollParams(RI_LEARN_SHAMANISTIC_RAGE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Shamanistic Rage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_SHAMANISTIC_RAGE].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_SHAMANISTIC_RAGE].RollChance = 20;
    RI_PickableStats[RI_LEARN_SHAMANISTIC_RAGE].AdditionalParam1 = 30823;
    RI_PickableStats[RI_LEARN_SHAMANISTIC_RAGE].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_SHAMANISTIC_RAGE].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Reduces damage taken";

    InitStatRollParams(RI_LEARN_BLADE_FURY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Blade Flurry", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_BLADE_FURY].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_BLADE_FURY].RollChance = 20;
    RI_PickableStats[RI_LEARN_BLADE_FURY].AdditionalParam1 = 13877;
    RI_PickableStats[RI_LEARN_BLADE_FURY].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_BLADE_FURY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Your attacks also hit an additional target";

    InitStatRollParams(RI_LEARN_COLD_BLOOD, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Cold Blood", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_COLD_BLOOD].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_COLD_BLOOD].RollChance = 20;
    RI_PickableStats[RI_LEARN_COLD_BLOOD].AdditionalParam1 = 14177;
    RI_PickableStats[RI_LEARN_COLD_BLOOD].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_COLD_BLOOD].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Your next ability will be a critical";

    InitStatRollParams(RI_LEARN_FAN_OF_KNIVES, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Fan of Knives", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_FAN_OF_KNIVES].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_FAN_OF_KNIVES].RollChance = 20;
    RI_PickableStats[RI_LEARN_FAN_OF_KNIVES].AdditionalParam1 = 51723;
    RI_PickableStats[RI_LEARN_FAN_OF_KNIVES].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_FAN_OF_KNIVES].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Attack nearby targets";

    InitStatRollParams(RI_LEARN_KILLING_SPREE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Killing Spree", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_KILLING_SPREE].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_KILLING_SPREE].RollChance = 20;
    RI_PickableStats[RI_LEARN_KILLING_SPREE].AdditionalParam1 = 51690;
    RI_PickableStats[RI_LEARN_KILLING_SPREE].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_KILLING_SPREE].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Randomly teleport and attack targets";

    InitStatRollParams(RI_LEARN_HYSTERIA, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Hysteria", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_HYSTERIA].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_HYSTERIA].RollChance = 20;
    RI_PickableStats[RI_LEARN_HYSTERIA].AdditionalParam1 = 49016;
    RI_PickableStats[RI_LEARN_HYSTERIA].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_HYSTERIA].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Increases physical damage, also loose health based on max health";

    InitStatRollParams(RI_WINDFURRY_WEAPON, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Windfury Weapon", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_WINDFURRY_WEAPON].NegativeRollChance = 0;
    RI_PickableStats[RI_WINDFURRY_WEAPON].RollChance = 10;
    RI_PickableStats[RI_WINDFURRY_WEAPON].AdditionalParam1 = 8232;
    RI_PickableStats[RI_WINDFURRY_WEAPON].LearnAsSpell = 1;
    RI_PickableStats[RI_WINDFURRY_WEAPON].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Weapon enchant that has a chance to trigger an additional attack";

    InitStatRollParams(RI_INCREASE_THREATH_FOR_PETS, 1, 50, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ThreathModPet, "%d%% Pet Threat", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_INCREASE_THREATH_FOR_PETS].RollChance = 20;
    RI_PickableStats[RI_INCREASE_THREATH_FOR_PETS].AdditionalParam1 = SPELL_AURA_MOD_THREAT;
    LastInitedStat->Tooltip = "Your pet will receive additional threath from abilities";

    InitStatRollParams(RI_PET_AURA_IMMOLATION, 1, 50, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PetAura, "Pet gains Immolation Aura", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_PET_AURA_IMMOLATION].RollChance = 5;
    RI_PickableStats[RI_PET_AURA_IMMOLATION].AdditionalParam1 = 50589;
    RI_PickableStats[RI_PET_AURA_IMMOLATION].NegativeRollChance = 0;
    RI_PickableStats[RI_PET_AURA_IMMOLATION].FixedValue = 1;
    LastInitedStat->Tooltip = "Your pet will deal damage to nearby targets";

    InitStatRollParams(RI_DMG_LOGIN_STREAK, 1, 12, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_LoginStreak, "%d Dmg for daily login streak", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DMG_LOGIN_STREAK].RollChance = 20; // 365 per year
    LastInitedStat->Tooltip = "Your damage will increase based on the number of consecutive daily logins";

    InitStatRollParams(RI_HEAL_LOGIN_STREAK, 1, 12, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealDmg_LoginStreak, "%d Heal for daily login streak", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_LOGIN_STREAK].RollChance = 20; // 365 per year
    LastInitedStat->Tooltip = "Your heal will increase based on the number of consecutive daily logins";

    InitStatRollParams(RI_CHANCE_TO_CHARGE_ON_TARGET_SWAP, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_AutoChargeOnTargetSwap, "Chance to auto charge on target swap", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHANCE_TO_CHARGE_ON_TARGET_SWAP].NegativeRollChance = 0;
    RI_PickableStats[RI_CHANCE_TO_CHARGE_ON_TARGET_SWAP].RollChance = 20;
    RI_PickableStats[RI_CHANCE_TO_CHARGE_ON_TARGET_SWAP].FixedValue = 1;
    LastInitedStat->Tooltip = "When you retarget, you have a chance to automatically cast charge even while in combat";

    InitStatRollParams(RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_STRENGTH_PERCENT, 0.01f, 2.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToSpellDmg, "%d%% Strength to spell damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_STRENGTH_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_STRENGTH_PERCENT].AdditionalParam1 = STAT_STRENGTH;
    LastInitedStat->Tooltip = "Convert base stat to spell damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_AGILITY_PERCENT, 1, 2.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToSpellDmg, "%d%% Agility to spell damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_AGILITY_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_AGILITY_PERCENT].AdditionalParam1 = STAT_AGILITY;
    LastInitedStat->Tooltip = "Convert base stat to spell damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_INTELECT_PERCENT, 1, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToSpellDmg, "%.02f%% Intelect to spell damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_INTELECT_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_INTELECT_PERCENT].AdditionalParam1 = STAT_INTELLECT;
    LastInitedStat->Tooltip = "Convert base stat to spell damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_SPIRIT_PERCENT, 1, 1.6f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToSpellDmg, "%.02f%% Spirit to spell damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_SPIRIT_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_DAMAGE_OF_SPIRIT_PERCENT].AdditionalParam1 = STAT_SPIRIT;
    LastInitedStat->Tooltip = "Convert base stat to spell damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_SPELL_HEAL_OF_STRENGTH_PERCENT, 1, 5, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToSpellHeal, "%d%% Strength to Heal", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HEAL_OF_STRENGTH_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HEAL_OF_STRENGTH_PERCENT].AdditionalParam1 = STAT_STRENGTH;
    LastInitedStat->Tooltip = "Convert base stat to heal power";

    InitStatRollParams(RI_SPELL_AURA_MOD_SPELL_HEAL_OF_AGILITY_PERCENT, 1, 5, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToSpellHeal, "%d%% Agility to Heal", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HEAL_OF_AGILITY_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HEAL_OF_AGILITY_PERCENT].AdditionalParam1 = STAT_AGILITY;
    LastInitedStat->Tooltip = "Convert base stat to heal power";

    InitStatRollParams(RI_SPELL_AURA_MOD_SPELL_HEAL_OF_INTELECT_PERCENT, 1, 20, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToSpellHeal, "%d%% Intelect to Heal", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HEAL_OF_INTELECT_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HEAL_OF_INTELECT_PERCENT].AdditionalParam1 = STAT_INTELLECT;
    LastInitedStat->Tooltip = "Convert base stat to heal power";

    InitStatRollParams(RI_SPELL_AURA_MOD_SPELL_HEAL_OF_SPIRIT_PERCENT, 1, 20, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToSpellHeal, "%d%% Spirit to Heal", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HEAL_OF_SPIRIT_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_SPELL_HEAL_OF_SPIRIT_PERCENT].AdditionalParam1 = STAT_SPIRIT;
    LastInitedStat->Tooltip = "Convert base stat to heal power";

    InitStatRollParams(RI_HEALS_RECHARGE_ABSORBS, 1, 3, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealAbsorbRecharge, "%d%% of Heals received recharges Absorb auras", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEALS_RECHARGE_ABSORBS].RollChance = 20;
    LastInitedStat->Tooltip = "Only works if you have an active damage abosb aura. You will also receive the healing effect";

    InitStatRollParams(RI_CHANCE_TO_DISCOVER_TRANSMOG_ON_KILL, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_TransmogDiscover, "Chance to discover transmog on kill", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHANCE_TO_DISCOVER_TRANSMOG_ON_KILL].RollChance = 1;
    RI_PickableStats[RI_CHANCE_TO_DISCOVER_TRANSMOG_ON_KILL].FixedValue = 1;
    LastInitedStat->Tooltip = "Chance to add a random item to the library of transmog items";

    InitStatRollParams(RI_RUN_BURNING_STEPS, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_CastOnMove_Location, "Your footsteps burn", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_RUN_BURNING_STEPS].NegativeRollChance = 0;
    RI_PickableStats[RI_RUN_BURNING_STEPS].RollChance = 5;
    RI_PickableStats[RI_RUN_BURNING_STEPS].FixedValue = 1;
    LastInitedStat->Tooltip = "As you move, you automatically cast a spell that damages players around you";

    InitStatRollParams(RI_RUN_CAST_PREV_SPELL, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_CastOnMove_FreeSpell, "Cast previous single target spell when moving", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_RUN_CAST_PREV_SPELL].NegativeRollChance = 0;
    RI_PickableStats[RI_RUN_CAST_PREV_SPELL].RollChance = 5;
    RI_PickableStats[RI_RUN_CAST_PREV_SPELL].FixedValue = 1;
    LastInitedStat->Tooltip = "As you move, you automatically cast the last spell you used on your target";

    InitStatRollParams(RI_SPELL_AURA_MOD_ATTACK_POWER_OF_ARMOR, 0.01f, 5.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%.02f%% Armor to Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_ARMOR].RollChance = 5;
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_ARMOR].AdditionalParam1 = SPELL_AURA_MOD_ATTACK_POWER_OF_ARMOR;
    LastInitedStat->Tooltip = "Convert the amount of armor into attack power. Attack power increases physical damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_ATTACK_POWER_OF_STRENGTH_PERCENT, 1, 4.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToAttackPower, "%.02f%% Strength to Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_STRENGTH_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_STRENGTH_PERCENT].AdditionalParam1 = STAT_STRENGTH;
    LastInitedStat->Tooltip = "Convert base stat into attack power. Attack power increases physical damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_ATTACK_POWER_OF_AGILITY_PERCENT, 1, 3.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToAttackPower, "%.02f%% Agility to Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_AGILITY_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_AGILITY_PERCENT].AdditionalParam1 = STAT_AGILITY;
    LastInitedStat->Tooltip = "Convert base stat into attack power. Attack power increases physical damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_ATTACK_POWER_OF_INTELECT_PERCENT, 1, 5.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToAttackPower, "%.02f%% Intelect to Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_INTELECT_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_INTELECT_PERCENT].AdditionalParam1 = STAT_INTELLECT;
    LastInitedStat->Tooltip = "Convert base stat into attack power. Attack power increases physical damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_ATTACK_POWER_OF_SPIRIT_PERCENT, 1, 5.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToAttackPower, "%.02f%% Spirit to Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_SPIRIT_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_ATTACK_POWER_OF_SPIRIT_PERCENT].AdditionalParam1 = STAT_SPIRIT;
    LastInitedStat->Tooltip = "Convert base stat into attack power. Attack power increases physical damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_STRENGTH_PERCENT, 1, 5.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToRangedAttackPower, "%.02f%% Strength to Ranged Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_STRENGTH_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_STRENGTH_PERCENT].AdditionalParam1 = STAT_STRENGTH;
    LastInitedStat->Tooltip = "Convert base stat into attack power. Attack power increases physical damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_AGILITY_PERCENT, 1, 4.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToRangedAttackPower, "%.02f%% Agility to Ranged Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_AGILITY_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_AGILITY_PERCENT].AdditionalParam1 = STAT_AGILITY;
    LastInitedStat->Tooltip = "Convert base stat into attack power. Attack power increases physical damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_INTELECT_PERCENT, 1, 8.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToRangedAttackPower, "%.02f%% Intelect to Ranged Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_INTELECT_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_INTELECT_PERCENT].AdditionalParam1 = STAT_INTELLECT;
    LastInitedStat->Tooltip = "Convert base stat into attack power. Attack power increases physical damage";

    InitStatRollParams(RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_SPIRIT_PERCENT, 1, 5.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_StatToRangedAttackPower, "%.02f%% Spirit to Ranged Attack Power", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_SPIRIT_PERCENT].RollChance = 20;
    RI_PickableStats[RI_SPELL_AURA_MOD_RANGED_ATTACK_POWER_OF_SPIRIT_PERCENT].AdditionalParam1 = STAT_SPIRIT;
    LastInitedStat->Tooltip = "Convert base stat into attack power. Attack power increases physical damage";

    InitStatRollParams(RI_CAST_WHILE_MOVE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_AllowCastWhileMove, "Allow casting while moving", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CAST_WHILE_MOVE].RollChance = 2;
    RI_PickableStats[RI_CAST_WHILE_MOVE].FixedValue = 1;
    LastInitedStat->Tooltip = "Character movement no longer interrupts spell casting";

    InitStatRollParams(RI_CAST_INSTANT_SPELLS_IN_PARALLEL, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_AllowCastWhileCast, "Can cast instant spells while casting", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CAST_INSTANT_SPELLS_IN_PARALLEL].RollChance = 2;
    RI_PickableStats[RI_CAST_INSTANT_SPELLS_IN_PARALLEL].FixedValue = 1;
    LastInitedStat->Tooltip = "You can cast more than one spell at once. While a spell with long casting time is casted, you can cast another spell that will not interrupt it";

    InitStatRollParams(RI_IGNORE_CAST_FACING, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_AllowCastNoFace, "Spells no longer need to face targets", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_IGNORE_CAST_FACING].RollChance = 2;
    RI_PickableStats[RI_IGNORE_CAST_FACING].FixedValue = 1;
    LastInitedStat->Tooltip = "You can cast spells even while not facing your target";

    InitStatRollParams(RI_NEGATIVE_MELEE_HASTE_TO_DMG, 100, 150, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_MeleeHasteToDMG, "%d%% Negative Melee haste to %% Damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_NEGATIVE_MELEE_HASTE_TO_DMG].RollChance = 20;
    LastInitedStat->Tooltip = "The slower you attack, the stronger you hit";

    InitStatRollParams(RI_NEGATIVE_RANGED_HASTE_TO_DMG, 100, 150, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_RangedHasteToDMG, "%d%% Negative Ranged haste to %% Damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_NEGATIVE_RANGED_HASTE_TO_DMG].RollChance = 20;
    LastInitedStat->Tooltip = "The slower you attack, the stronger you hit";

    InitStatRollParams(RI_NEGATIVE_SPELL_HASTE_TO_DMG, 100, 150, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellHasteToDMG, "%d%% Negative Spell haste to %% Damage", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_NEGATIVE_SPELL_HASTE_TO_DMG].RollChance = 20;
    LastInitedStat->Tooltip = "The slower you attack, the stronger you hit";

    InitStatRollParams(RI_NEGATIVE_SPELL_HASTE_TO_HEAL, 100, 150, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellHasteToHeal, "%d%% Negative Spell haste to %% Heal", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_NEGATIVE_SPELL_HASTE_TO_HEAL].RollChance = 20;
    LastInitedStat->Tooltip = "The slower you attack, the stronger you hit";

    InitStatRollParams(RI_DAMAGE_SCHOOL_CHANGE_TO_FIRE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ChangeDmgType, "You deal Fire damage", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_FIRE].RollChance = 20;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_FIRE].AdditionalParam1 = SPELL_SCHOOL_FIRE;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_FIRE].FixedValue = 1;
    LastInitedStat->Tooltip = "Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once";

    InitStatRollParams(RI_DAMAGE_SCHOOL_CHANGE_TO_NATURE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ChangeDmgType, "You deal Nature damage", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_NATURE].RollChance = 20;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_NATURE].AdditionalParam1 = SPELL_SCHOOL_NATURE;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_NATURE].FixedValue = 1;
    LastInitedStat->Tooltip = "Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once";

    InitStatRollParams(RI_DAMAGE_SCHOOL_CHANGE_TO_FROST, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ChangeDmgType, "You deal Frost damage", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_FROST].RollChance = 20;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_FROST].AdditionalParam1 = SPELL_SCHOOL_FROST;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_FROST].FixedValue = 1;
    LastInitedStat->Tooltip = "Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once";

    InitStatRollParams(RI_DAMAGE_SCHOOL_CHANGE_TO_SHADOW, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ChangeDmgType, "You deal Shadow damage", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_SHADOW].RollChance = 20;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_SHADOW].AdditionalParam1 = SPELL_SCHOOL_SHADOW;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_SHADOW].FixedValue = 1;
    LastInitedStat->Tooltip = "Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once";

    InitStatRollParams(RI_DAMAGE_SCHOOL_CHANGE_TO_ARCANE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ChangeDmgType, "You deal Arcane damage", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_ARCANE].RollChance = 20;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_ARCANE].AdditionalParam1 = SPELL_SCHOOL_ARCANE;
    RI_PickableStats[RI_DAMAGE_SCHOOL_CHANGE_TO_ARCANE].FixedValue = 1;
    LastInitedStat->Tooltip = "Your damage will check for lowest resistance of the target. Your attacks now also check for this type of resistance. You can combine multiple damage types at once";

    InitStatRollParams(RI_HELLFIRE_ON_JUMP, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SlamOnJump, "Chance to Slam Dunk at jump( health based )", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HELLFIRE_ON_JUMP].RollChance = 5;
    RI_PickableStats[RI_HELLFIRE_ON_JUMP].FixedValue = 1;
    LastInitedStat->Tooltip = "The more health you have, the more damage you will deal with your jump landings";

    InitStatRollParams(RI_ELECTROCUTE_WHILE_CASTING, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ElectrocuteWhileCast, "Electrocute while casting(based on highest stat)", RGB_ATTACK
        , BCFM(CLASS_PALADIN, CLASS_HUNTER, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_ELECTROCUTE_WHILE_CASTING].RollChance = 5;
    RI_PickableStats[RI_ELECTROCUTE_WHILE_CASTING].FixedValue = 1;
    LastInitedStat->Tooltip = "Automatically damage nearby enemies while casting a spell. Damage is based on the highest stat you have ( Except stamina )";

    InitStatRollParams(RI_DIABLO_WALKS_AMONG_US, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DiabloTransform, "Diablo tranformation", RGB_ATTACK
        , BCFM(CLASS_PALADIN, CLASS_HUNTER, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DIABLO_WALKS_AMONG_US].RollChance = 5;
    RI_PickableStats[RI_DIABLO_WALKS_AMONG_US].FixedValue = 1;
    LastInitedStat->Tooltip = "You will automatically cast firebreath. The extra damage you deal is based on your single target damge you deal";

    InitStatRollParams(RI_HEAL_DISTANCE_BASED, 1, 2.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DistanceHealBoost, "%d%% Extra heal the closer you are", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_DISTANCE_BASED].RollChance = 20;
    RI_PickableStats[RI_HEAL_DISTANCE_BASED].AdditionalParam1 = 1;
    LastInitedStat->Tooltip = "The closer you are to your target, the more healing you do";

    InitStatRollParams(RI_BLOOD_LUST_ON_DAMAGE_TAKEN, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_BloodLustOnDamageTaken, "Chance to gain BloodLust on damage taken", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_BLOOD_LUST_ON_DAMAGE_TAKEN].RollChance = 20;
    RI_PickableStats[RI_BLOOD_LUST_ON_DAMAGE_TAKEN].AdditionalParam1 = 2825;
    RI_PickableStats[RI_BLOOD_LUST_ON_DAMAGE_TAKEN].FixedValue = 1;
    LastInitedStat->Tooltip = "You can periodically gain BloodLust when you take damage";

    InitStatRollParams(RI_MOVE_EXPLODE, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_MoveExpode, "Moving charges an explosion", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_MOVE_EXPLODE].RollChance = 5;
    RI_PickableStats[RI_MOVE_EXPLODE].FixedValue = 1;
    LastInitedStat->Tooltip = "The more you move without stopping, the higher you will explode when you will stop";

    InitStatRollParams(RI_FIST_PROFICIENCY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, "Fist Weapon proficiency", RGB_ATTACK
        , BCFM( CLASS_PALADIN, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_MAGE, CLASS_WARLOCK, 0));
    RI_PickableStats[RI_FIST_PROFICIENCY].NegativeRollChance = 0;
    RI_PickableStats[RI_FIST_PROFICIENCY].RollChance = 20;
    RI_PickableStats[RI_FIST_PROFICIENCY].AdditionalParam1 = 15590;
    RI_PickableStats[RI_FIST_PROFICIENCY].LearnAsSpell = 1;
    RI_PickableStats[RI_FIST_PROFICIENCY].LearnSkill = SKILL_FIST_WEAPONS;
    RI_PickableStats[RI_FIST_PROFICIENCY].FixedValue = 1;
    LastInitedStat->Tooltip = "Ability to use this item class";

    InitStatRollParams(RI_SPELLMOD_RANGE, 1, 1, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellModFlatSpellRange, "%d Spell Range", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPELLMOD_RANGE].RollChance = 10;
    RI_PickableStats[RI_SPELLMOD_RANGE].SpellMod = SPELLMOD_RANGE;
    LastInitedStat->Tooltip = "Extend the range of your spells";

    InitStatRollParams(RI_INCREASE_AURA_MAX_STACK, 1, 1, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_AuraMaxStacks, "Some Auras can stack to 2", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_INCREASE_AURA_MAX_STACK].RollChance = -10;
    RI_PickableStats[RI_INCREASE_AURA_MAX_STACK].FixedValue = 1;
    RI_PickableStats[RI_INCREASE_AURA_MAX_STACK].NegativeRollChance = 0;
    LastInitedStat->Tooltip = "Some auras can stack up to X times";

    InitStatRollParams(RI_ARMOR_TO_RESISTANCE_HOLY, 0.01f, 0.05f, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_HOLY, RI_AS_ArmorToResistance, "%.02f%% Armor to Holy Resistance", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_ARMOR_TO_RESISTANCE_HOLY].RollChance = 20;
    LastInitedStat->Tooltip = "Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value";

    InitStatRollParams(RI_ARMOR_TO_RESISTANCE_FIRE, 0.01f, 0.05f, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_FIRE, RI_AS_ArmorToResistance, "%.02f%% Armor to Fire Resistance", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_ARMOR_TO_RESISTANCE_FIRE].RollChance = 20;
    LastInitedStat->Tooltip = "Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value";

    InitStatRollParams(RI_ARMOR_TO_RESISTANCE_NATURE, 0.01f, 0.05f, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_NATURE, RI_AS_ArmorToResistance, "%.02f%% Armor to Nature Resistance", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_ARMOR_TO_RESISTANCE_NATURE].RollChance = 20;
    LastInitedStat->Tooltip = "Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value";

    InitStatRollParams(RI_ARMOR_TO_RESISTANCE_FROST, 0.01f, 0.05f, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_FROST, RI_AS_ArmorToResistance, "%.02f%% Armor to Frost Resistance", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_ARMOR_TO_RESISTANCE_FROST].RollChance = 20;
    LastInitedStat->Tooltip = "Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value";

    InitStatRollParams(RI_ARMOR_TO_RESISTANCE_SHADOW, 0.01f, 0.05f, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_SHADOW, RI_AS_ArmorToResistance, "%.02f%% Armor to Shadow Resistance", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_ARMOR_TO_RESISTANCE_SHADOW].RollChance = 20;
    LastInitedStat->Tooltip = "Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value";

    InitStatRollParams(RI_ARMOR_TO_RESISTANCE_ARCANE, 0.01f, 0.05f, ITEM_MOD_NONE, UNIT_MOD_RESISTANCE_ARCANE, RI_AS_ArmorToResistance, "%.02f%% Armor to Arcane Resistance", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_ARMOR_TO_RESISTANCE_ARCANE].RollChance = 20;
    LastInitedStat->Tooltip = "Convert physical resistance to elemental resistance. Resistance will reduce damage by percent value";

    InitStatRollParams(RI_PCT_HEAL_NEARBY_PLAYER_COUNT, 0.1f, 2.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealNearbyPlayer, "%.02f%% Heal for each nearby player", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_PCT_HEAL_NEARBY_PLAYER_COUNT].RollChance = 20;
    LastInitedStat->Tooltip = "The more players are grouped in a small area, the more healing you do";

    InitStatRollParams(RI_PCT_DMG_NEARBY_PLAYER_COUNT, 0.1f, 2.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DmgNearbyPlayer, "%.02f%% Dmg for each nearby player", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_PCT_DMG_NEARBY_PLAYER_COUNT].RollChance = 20;
    LastInitedStat->Tooltip = "The more players are grouped in a small area, the more damage you do";

    InitStatRollParams(RI_PCT_DUST_GAIN_PCT, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DustGainPCT, "%d%% More Dust gained", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_PCT_DUST_GAIN_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Magic dust is used to buy magical effects. Like boost drop chance of stats. The more stats you get, the more dust you gain...";

    InitStatRollParams(RI_LEARN_TELEPORT, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Blink", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_TELEPORT].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_TELEPORT].RollChance = 20;
    RI_PickableStats[RI_LEARN_TELEPORT].AdditionalParam1 = 1953;
    RI_PickableStats[RI_LEARN_TELEPORT].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_TELEPORT].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. You will teleport forward";

    InitStatRollParams(RI_LEARN_RIGHTOUS_FURY, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Righteous Fury", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_HUNTER, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_RIGHTOUS_FURY].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_RIGHTOUS_FURY].RollChance = 20;
    RI_PickableStats[RI_LEARN_RIGHTOUS_FURY].AdditionalParam1 = 25780;
    RI_PickableStats[RI_LEARN_RIGHTOUS_FURY].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_RIGHTOUS_FURY].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Increases threath generated by holy spells";

    InitStatRollParams(RI_DMG_KILLSTREAK_BASED_FLAT, 1, 25, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_KillStreakDMG, "%d Dmg for Killstreak Rating", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DMG_KILLSTREAK_BASED_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "While continuesly killing enemies, your damage ramps up. Damage increase slows down after a while, but does not stop increasing";

    InitStatRollParams(RI_HEAL_LOWHEALTH_HEAL_STREAK_FLAT, 10, 1000, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LowHealthHealStreak, "%d Heal for consecutive low(50%%) target health heals", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_LOWHEALTH_HEAL_STREAK_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "If your target is continuesly low health, you will heal him more and more as you continue healing him";

    InitStatRollParams(RI_SMOOTH_DAMAGE_OVER_TIME, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SimilarDamageTaken, "You take similar damage", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SMOOTH_DAMAGE_OVER_TIME].RollChance = 20;
    RI_PickableStats[RI_SMOOTH_DAMAGE_OVER_TIME].FixedValue = 1;
    LastInitedStat->Tooltip = "Damage received is evened out over time. You no longer take very strong hits and very weak hits";

    InitStatRollParams(RI_DIVIDE_DAMAGE_OVER_TIME, 60, 120, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageTakenSplitOverTime, "Non lethal damage taken is split over %d seconds", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DIVIDE_DAMAGE_OVER_TIME].RollChance = 20;
    RI_PickableStats[RI_DIVIDE_DAMAGE_OVER_TIME].AdditionalParam1 = 1;
    LastInitedStat->Tooltip = "Damage received drains health over time. Damage drain can not be mitigated by resistance or shields";

    InitStatRollParams(RI_BLOOD_RUNE_REGEN_FLAT, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerRegenRune, "%d extra Blood Rune regen speed", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_DEATH_KNIGHT, 0));
    RI_PickableStats[RI_BLOOD_RUNE_REGEN_FLAT].RollChance = 50;
    RI_PickableStats[RI_BLOOD_RUNE_REGEN_FLAT].SpellMod = RUNE_BLOOD;
    LastInitedStat->Tooltip = "Regenerate power required for spells and abilities";

    InitStatRollParams(RI_UNHOLY_RUNE_REGEN_FLAT, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerRegenRune, "%d extra Unholy Rune regen speed", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_DEATH_KNIGHT, 0));
    RI_PickableStats[RI_UNHOLY_RUNE_REGEN_FLAT].RollChance = 50;
    RI_PickableStats[RI_UNHOLY_RUNE_REGEN_FLAT].SpellMod = RUNE_UNHOLY;
    LastInitedStat->Tooltip = "Regenerate power required for spells and abilities";

    InitStatRollParams(RI_FROST_RUNE_REGEN_FLAT, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerRegenRune, "%d extra Frost Rune regen speed", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_DEATH_KNIGHT, 0));
    RI_PickableStats[RI_FROST_RUNE_REGEN_FLAT].RollChance = 50;
    RI_PickableStats[RI_FROST_RUNE_REGEN_FLAT].SpellMod = RUNE_FROST;
    LastInitedStat->Tooltip = "Regenerate power required for spells and abilities";

    InitStatRollParams(RI_DEATH_RUNE_REGEN_FLAT, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerRegenRune, "%d extra Death Rune regen speed", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_DEATH_KNIGHT, 0));
    RI_PickableStats[RI_DEATH_RUNE_REGEN_FLAT].RollChance = 50;
    RI_PickableStats[RI_DEATH_RUNE_REGEN_FLAT].SpellMod = RUNE_DEATH;
    LastInitedStat->Tooltip = "Regenerate power required for spells and abilities";

    InitStatRollParams(RI_RUNIC_POWER_REGEN_PCT, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerRegenPCT, "%d%% Rune decrease reduction", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_DEATH_KNIGHT, 0));
    RI_PickableStats[RI_RUNIC_POWER_REGEN_PCT].RollChance = 50;
    RI_PickableStats[RI_RUNIC_POWER_REGEN_PCT].SpellMod = POWER_RUNIC_POWER;
    LastInitedStat->Tooltip = "Regenerate power required for spells and abilities";

    InitStatRollParams(RI_ENERGY_REGEN_PCT, 1, 21, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerRegenPCT, "%d%% extra Energy regen speed", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_ROGUE, 0));
    RI_PickableStats[RI_ENERGY_REGEN_PCT].RollChance = 50;
    RI_PickableStats[RI_ENERGY_REGEN_PCT].SpellMod = POWER_ENERGY;
    LastInitedStat->Tooltip = "Regenerate power required for spells and abilities";

    InitStatRollParams(RI_FOCUS_REGEN_FLAT, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerRegenPCT, "%d extra Focus regen at tick", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_HUNTER, 0));
    RI_PickableStats[RI_FOCUS_REGEN_FLAT].RollChance = 50;
    RI_PickableStats[RI_FOCUS_REGEN_FLAT].SpellMod = POWER_FOCUS;
    LastInitedStat->Tooltip = "Regenerate power required for spells and abilities";

    InitStatRollParams(RI_RAGE_POWER_REGEN_PCT, 16, 48, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_PowerRegenFlat, "%d Rage regen at tick", RGB_ATTACK_DEFENSE
        , BCFM(CLASS_WARRIOR, 0));
    RI_PickableStats[RI_RAGE_POWER_REGEN_PCT].RollChance = 50;
    RI_PickableStats[RI_RAGE_POWER_REGEN_PCT].SpellMod = POWER_RAGE;
    LastInitedStat->Tooltip = "Regenerate power required for spells and abilities";

    InitStatRollParams(RI_SPRINT_ON_KILL, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_CastOnKill, "Gain Sprint after a kill", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SPRINT_ON_KILL].RollChance = 10;
    RI_PickableStats[RI_SPRINT_ON_KILL].AdditionalParam1 = 48594;
    RI_PickableStats[RI_SPRINT_ON_KILL].FixedValue = 1;
    LastInitedStat->Tooltip = "Every time you kill something, you will gain sprint aura that increases your movement speed";

    InitStatRollParams(RI_EXTRA_DMG_WHILE_BEHIND_TARGET, 10, 150, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ExtraDmgWhileBehindTarget_Flat, "%d extra direct damage done while behind target", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_EXTRA_DMG_WHILE_BEHIND_TARGET].RollChance = 20;
    LastInitedStat->Tooltip = "Deal extra damage while behind your target";

    InitStatRollParams(RI_EXTRA_DEFENSE_WHILE_FACE_TARGET, 10, 300, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_ExtraDmgWhileBehindTarget_Flat, "%d damage taken reduction while facing attacker", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_EXTRA_DEFENSE_WHILE_FACE_TARGET].RollChance = 20;
    LastInitedStat->Tooltip = "Receive less damage while attacker is in front of you";

    InitStatRollParams(RI_HEAL_RESTORE_RECENT_DMG_TAKEN_PCT, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealsRestoreDamageTaken, "Direct Heals restore %d%% of last damage taken", RGB_DEFENSE
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEAL_RESTORE_RECENT_DMG_TAKEN_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "When you get healed, you also recover part of the damage you received previously";

    InitStatRollParams(RI_XP_GAIN, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellAuraOnCaster, "%.02f%% XP gained", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_XP_GAIN].AdditionalParam1 = SPELL_AURA_MOD_XP_PCT;
    LastInitedStat->Tooltip = "Increases experience gained. Experience contributes to paragon leveling";

    InitStatRollParams(RI_SINGLE_TARGET_TO_AOE_DMG, 0.05f, 1.1f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SingleTargetToAOE, "%.02f%% single target damage converted to AOE damage", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_SINGLE_TARGET_TO_AOE_DMG].NegativeRollChance = 0;
    RI_PickableStats[RI_SINGLE_TARGET_TO_AOE_DMG].RollChance = 5;
    LastInitedStat->Tooltip = "Single target damage is converted into an AOE explosion. This is done periodically. AOE damage does trigger procs and events";

    InitStatRollParams(RI_CHAIN_LIGHTNING_ON_HIT_1, 1, 5, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LightningOnHit, "%.02f%% damage as Chain Lightning 1 on direct hit", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_HIT_1].NegativeRollChance = 0;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_HIT_1].RollChance = 10;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_HIT_1].AdditionalParam1 = 12058;
    LastInitedStat->Tooltip = "Part of damage done is copied to a chain lightning effect";

    InitStatRollParams(RI_CHAIN_LIGHTNING_ON_HIT_2, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LightningOnHit, "%.02f%% damage as Chain Lightning 2 on direct hit", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_HIT_2].NegativeRollChance = 0;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_HIT_2].RollChance = 5;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_HIT_2].AdditionalParam1 = 15305;
    LastInitedStat->Tooltip = "Part of damage done is copied to a chain lightning effect";

    InitStatRollParams(RI_CHAIN_LIGHTNING_ON_HIT_3, 1, 15, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LightningOnHit, "%.02f%% damage as Chain Lightning 3 on direct hit", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_HIT_3].NegativeRollChance = 0;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_HIT_3].RollChance = -5;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_HIT_3].AdditionalParam1 = 16033;
    LastInitedStat->Tooltip = "Part of damage done is copied to a chain lightning effect";

    InitStatRollParams(RI_CHAIN_LIGHTNING_ON_STRUCK_2, 1, 5, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LightningOnStruck, "%.02f%% damage reflected as Chain Lightning 2 On Struck", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_STRUCK_2].NegativeRollChance = 0;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_STRUCK_2].RollChance = 5;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_STRUCK_2].AdditionalParam1 = 15305;
    LastInitedStat->Tooltip = "Part of damage taken is copied to a chain lightning effect";

    InitStatRollParams(RI_CHAIN_LIGHTNING_ON_STRUCK_3, 1, 10, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LightningOnStruck, "%.02f%% damage reflected as Chain Lightning 3 On Struck", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_STRUCK_3].NegativeRollChance = 0;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_STRUCK_3].RollChance = -5;
    RI_PickableStats[RI_CHAIN_LIGHTNING_ON_STRUCK_3].AdditionalParam1 = 16033;
    LastInitedStat->Tooltip = "Part of damage taken is copied to a chain lightning effect";

    InitStatRollParams(RI_LEARN_DEATH_GRIP, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_LearnSpell, "Learn Death Grip", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_LEARN_DEATH_GRIP].NegativeRollChance = 0;
    RI_PickableStats[RI_LEARN_DEATH_GRIP].RollChance = 20;
    RI_PickableStats[RI_LEARN_DEATH_GRIP].AdditionalParam1 = 49560;
    RI_PickableStats[RI_LEARN_DEATH_GRIP].LearnAsSpell = 1;
    RI_PickableStats[RI_LEARN_DEATH_GRIP].FixedValue = 1;
    LastInitedStat->Tooltip = "You will learn this spell. Pull enemies closer to yourself";

    // should convert Health regen to a decent DPS
    InitStatRollParams(RI_HEALTH_TO_DAMAGE, 1, 40, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_HealthToDamage, "%d Health converted to damage", RGB_UTIL
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_HEALTH_TO_DAMAGE].NegativeRollChance = 0;
    RI_PickableStats[RI_HEALTH_TO_DAMAGE].RollChance = 20;
    LastInitedStat->Tooltip = "Reduce your own health to increase your damage";

    InitStatRollParams(RI_DAMAGE_DONE_PCT, 0.1f, 0.8f, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDonePCT, "%.02f%% Damage Done", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_DONE_PCT].RollChance = 20;
    LastInitedStat->Tooltip = "Increases your damage by percent value";

    InitStatRollParams(RI_DAMAGE_DONE_FLAT, 1, 50, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_DamageDonePCT, "%d Damage Done", RGB_ATTACK
        , BCFM(CLASS_WARRIOR, CLASS_PALADIN, CLASS_HUNTER, CLASS_ROGUE, CLASS_PRIEST, CLASS_DEATH_KNIGHT, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
    RI_PickableStats[RI_DAMAGE_DONE_FLAT].RollChance = 20;
    LastInitedStat->Tooltip = "Increases your damage by flat value";

//    InitStatRollParams(RI_NONCLASS_SPELL_REGENS_POWER, 10, 30, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_SpellsRestoreMana, "Non self spells restore %d%% mana based on spell cost", RGB_DEFENSE
//        , BCFM( CLASS_PALADIN, CLASS_ROGUE, CLASS_PRIEST, CLASS_SHAMAN, CLASS_MAGE, CLASS_WARLOCK, CLASS_DRUID, 0));
//    RI_PickableStats[RI_NONCLASS_SPELL_REGENS_POWER].RollChance = 20;

    //sanity checks. Make sure we did not do anything obviously stupid
    for (int i = 1; i < RI_MAX_STAT_TYPES; i++)
        //if(RI_PickableStats[i].FormatStr != NULL)
        {
            if (RI_PickableStats[i].MinValue - (int)RI_PickableStats[i].MinValue == 0 && RI_PickableStats[i].MaxValAt100 - (int)RI_PickableStats[i].MaxValAt100 == 0)
                RI_PickableStats[i].IsIntValue = 1;
            ASSERT(RI_PickableStats[i].FormatStr != NULL);
            RI_PickableStats[i].ParamCount = GetParamCount(RI_PickableStats[i].FormatStr);
            if(RI_PickableStats[i].FixedValue == 0)
                ASSERT(RI_PickableStats[i].ParamCount == 1); //db is made to support only 1 power
            if (RI_PickableStats[i].FixedValue == 1)
                ASSERT(RI_PickableStats[i].ParamCount == 0); //db is made to support only 1 power
            ASSERT(RI_PickableStats[i].MaxValAt100 != 0);
            if (RI_PickableStats[i].ApplyScript == RI_AS_LearnSpell || RI_PickableStats[i].ApplyScript == RI_AS_GainPassiveBuff)
            {
                ASSERT(RI_PickableStats[i].AdditionalParam1 != 0);
                SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(RI_PickableStats[i].AdditionalParam1);
                ASSERT(spellInfo != NULL);
            }
        }

    // to avoid a lot of bad rolls, we split the list based on the classes we are rolling the stats for
    RI_GenerateClassBasedLists();

    //cause i need to port this to the LUA
    PrintPossibleRandomStats();
}

void PrintPossibleRandomStats()
{
    if (RI_PickableStats == NULL)
        return;
#ifndef _DEBUG
    return;
#endif
    FILE *f = fopen("StatText.txt", "wt");

    /*
    {
        char AllDefines[31000];
        int CharsWrittenAllDefines = 0;
        for (auto itr = sTalentStore.begin(); itr != sTalentStore.end(); itr++)
        {
            TalentEntry const* talentInfo = *itr;
            TalentTabEntry const* talentTabInfo = sTalentTabStore.LookupEntry(talentInfo->TalentTab);
            if (!talentTabInfo)
                return;

            uint32 LearnSpell = 0;
            for (uint8 rank = 0; rank < MAX_TALENT_RANK; rank++)
                if (talentInfo->RankID[rank] != 0)
                    LearnSpell = talentInfo->RankID[rank];

            if (LearnSpell == 0)
                continue;

            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(LearnSpell);
            if (spellInfo == NULL)
                continue;

            char StatName[500];
            sprintf_s(StatName, sizeof(StatName), "RI_GAIN_TALENT_%s", spellInfo->SpellName[0]);

            //replace spaces with _
            int i = 0;
            while (StatName[i] != 0)
            {
                if (StatName[i] == ' ' || StatName[i] == '\"' || StatName[i] == '\'')
                    StatName[i] = '_';
                i++;
            }

            //we will need all the names in the define list
            CharsWrittenAllDefines += sprintf_s(AllDefines + CharsWrittenAllDefines, sizeof(AllDefines) - CharsWrittenAllDefines, "%s,\n", StatName);

            char StatCPP[5000];
            sprintf_s(StatCPP, sizeof(StatCPP), "InitStatRollParams(%s, 1, 100, ITEM_MOD_NONE, UNIT_MOD_NONE, RI_AS_GainPassiveBuff, \"Gain %s\", RGB_TALENT, %d); \n\
RI_PickableStats[%s].NegativeRollChance = 0; \n\
RI_PickableStats[%s].RollChance = 20; \n\
RI_PickableStats[%s].AdditionalParam1 = %d; \n\
RI_PickableStats[%s].LearnAsSpell = 1;\n\n", StatName, spellInfo->SpellName[0], talentTabInfo->ClassMask, StatName, StatName, StatName, LearnSpell, StatName);
            fprintf(f, StatCPP);
        }
        fprintf(f, AllDefines);
    }
    /**/

    for (int i = 0; i < RI_MAX_STAT_TYPES; i++)
    {
        if (RI_PickableStats[i].FormatStr != NULL)
            fprintf(f, "IRS[%d]=\"%s\"\n", i, RI_PickableStats[i].FormatStr);
    }
    for (int i = 0; i < RI_MAX_STAT_TYPES; i++)
    {
        if (RI_PickableStats[i].FormatStr != NULL)
            fprintf(f, "IRSC[%d]={};IRSC[%d][0]=%.2f;IRSC[%d][1]=%.2f;IRSC[%d][2]=%.2f;\n", i, i, RGB_R_Float(RI_PickableStats[i].RGB), i, RGB_G_Float(RI_PickableStats[i].RGB), i, RGB_B_Float(RI_PickableStats[i].RGB));
    }
    for (int i = 0; i < RI_MAX_STAT_TYPES; i++)
    {
        if (RI_PickableStats[i].FormatStr != NULL)
            fprintf(f, "IRNRL[%d]=%.02f\n", i, RI_PickableStats[i].MaxValAt100);
    }
    for (int i = 0; i < RI_MAX_STAT_TYPES; i++)
    {
        if (RI_PickableStats[i].Tooltip != NULL)
            fprintf(f, "IRT[%d]=\"%s\"\n", i, RI_PickableStats[i].Tooltip);
    }

    //generate some SQl queries i can run to test all stats
    for (int i = 0; i < RI_MAX_STAT_TYPES;)
    {
        int StatsAdded = 0;
        char Query[500];
        strcpy_s(Query, sizeof(Query), "");
        char QueryReplace[500];
        strcpy_s(QueryReplace, sizeof(Query), "");
        while (StatsAdded < 15)
        {
            if (i >= RI_MAX_STAT_TYPES)
                break;
            if (RI_PickableStats[i].FormatStr == NULL || RI_PickableStats[i].RollChance < -50)
            {
                i++;
                continue;
            }
            sprintf_s(Query, sizeof(Query), "%st%d=%d,p%d=%.02f,", Query, StatsAdded, i, StatsAdded, RI_PickableStats[i].MaxValAt100);
            sprintf_s(QueryReplace, sizeof(QueryReplace), "%s%d,%.02f,", QueryReplace, i, RI_PickableStats[i].MaxValAt100);
            StatsAdded++;
            i++;
        }
        if (StatsAdded > 0)
        {
            for (int i = StatsAdded; i < 15; i++)
            {
                sprintf_s(Query, sizeof(Query), "%st%d=%d,p%d=%.02f,", Query, StatsAdded + i, 0, StatsAdded + i, 0.0);
                sprintf_s(QueryReplace, sizeof(QueryReplace), "%s%d,%.02f,", QueryReplace, 0, 0.0);
            }
            Query[strlen(Query) - 1] = 0;//cut the last , from the end
            QueryReplace[strlen(QueryReplace) - 1] = 0;//cut the last , from the end
//            printf("update character_item_randomizations set %s where PlayerGUID= and ItemGUID=;\n", Query);
            fprintf(f, "replace into character_item_randomizations values(%s);\n", QueryReplace);
        }
    }
    fclose(f);

    // print in PHP format for the sake of automated testing
    f = fopen("StatText_php.txt", "wt");
    fprintf(f, "\t$IRS[0] = \"%s\";\n", "%d None");
    fprintf(f, "\t$IRNRL[0] = 100;\n");
    for (int i = 0; i < RI_MAX_STAT_TYPES; i++)
    {
        if (RI_PickableStats[i].FormatStr == NULL)
            continue;
        fprintf(f, "\t$IRS[%d]=\"%s\";\n", i, RI_PickableStats[i].FormatStr);
        fprintf(f, "\t$IRNRL[%d]=%.02f;\n", i, RI_PickableStats[i].MaxValAt100);
    }   
    fclose(f);
}

PossibleRandomStatRolls *RI_PickableStatsClassBased[MAX_CLASSES];
int RI_PickableStatsClassCount[MAX_CLASSES];
PossibleRandomStatRolls *GetPickableStatStoreClassOnly(int Class, int &ValueCount)
{
    if (Class >= MAX_CLASSES)
    {
        ValueCount = 0;
        return NULL;
    }
    ValueCount = RI_PickableStatsClassCount[Class];
    return RI_PickableStatsClassBased[Class];
}

void RI_GenerateClassBasedLists()
{
    for (int PickedClass = 0; PickedClass < MAX_CLASSES; PickedClass++)
    {
        int PickedClassMask = 1 << PickedClass;

        RI_PickableStatsClassBased[PickedClass] = (PossibleRandomStatRolls*)malloc(sizeof(PossibleRandomStatRolls) * RI_MAX_STAT_TYPES);
        memset(RI_PickableStatsClassBased[PickedClass], 0, sizeof(PossibleRandomStatRolls) * RI_MAX_STAT_TYPES);

        RI_PickableStatsClassCount[PickedClass] = 0;
        for (int i = 1; i < RI_MAX_STAT_TYPES; i++)
            if (RI_PickableStats[i].ClassFilterMask & PickedClassMask)
            {
                RI_PickableStatsClassBased[PickedClass][RI_PickableStatsClassCount[PickedClass]] = RI_PickableStats[i];
                RI_PickableStatsClassCount[PickedClass]++;
            }
    }
}

void OnAddonVersionReport(Player *p, const char *msg)
{
    int ClientVersion = 0;
    sscanf(msg, "%d", &ClientVersion);
    if (ClientVersion < SERVER_ADDON_VERSION)
    {
        p->BroadcastMessage("Your addon seems to be outdated. Please make sure you update it!");
        return;
    }
    //all players should have this extension if we have the server side scripts
    RI_PlayerStore *rip = p->GetExtension<RI_PlayerStore>(OE_PLAYER_EXTENDED_ITEM_STATS);
    if (rip == NULL)
        return;
    rip->OnClientAddonConfirmed();
}

void RequestClientAddon(Player *p)
{
    AddonComm::SendMessageToClient(p, "RIQV", "");
}

