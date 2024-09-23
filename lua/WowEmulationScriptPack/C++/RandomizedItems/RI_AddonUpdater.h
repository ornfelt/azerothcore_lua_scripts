#pragma once

#include "RI_ApplyStatScripts.h"
#include "Itemtemplate.h"

class Player;
#define PACK_RGB(R,G,B) (R|(G<<8)|(B<<16))
#define RGB_DEFENSE PACK_RGB(64,255,64)
#define RGB_ATTACK PACK_RGB(255,64,64)
#define RGB_UTIL PACK_RGB(128,128,255)
#define RGB_ATTACK_DEFENSE PACK_RGB(255,165,0)
#define RGB_TALENT PACK_RGB(128,128,0)
#define RGB_PROC PACK_RGB(128,128,128)

#define RGB_R_Float(RGB) ( (RGB & 255 ) / 255.0f)
#define RGB_G_Float(RGB) ( ((RGB >> 8 ) & 255 ) / 255.0f)
#define RGB_B_Float(RGB) ( ((RGB >> 16) & 255 ) / 255.0f)

#define SERVER_ADDON_VERSION 2

enum RIStatTypes;

//this has to be the same as on client side
struct PossibleRandomStatRolls
{
    int     FormatStrParamCount;      // number of parameters we need to send to the client in order to populate the formated string
    const char *FormatStr;            // LUA will use this format string to generate a tooltip line
    const char *Tooltip;              // in case additional explanation is required for the stat
    float   MaxValAt100;              // at 100 difficulty, this can increase to X value
    float   MinValue;                 // do not generate this stat if value is too small
    float   RollChance;               // by default it would be 100% chance to roll, but we can decrease the chance
    char    PushUpdateClientDB;       // in case we made a last minute format string update and want to push it to our client addon
    char    ParamCount;               // i hope this is always one :P
    int     RGB;                      // color of the text it should be shown client side
    int     ClassFilterMask;          // only drop to these classes
    unsigned char NegativeRollChance; // chance for this mod to become negative. Not sure all mods will support this
    bool    FixedValue;               // confirms that param does not use dynamic values. ParamCount should be 0
    char    LearnAsSpell;             // some spells need to get applied before the item is loaded or else the item is never loaded. We learn these
    float   InverseGenerated;         // some values get smaller and smaller to get stronger
    char    IsIntValue;               // not a floating point value
    int     LearnSkill;               // when learning some spells, you also need to learn skill
    int     AdditionalParam1;         // type of Aura/SpellId/Item....

    int     SchoolMask;               // used as filter
    int     TickPeriod;               // used by proc function
    int     ProcChance;               // used by proc function 
    int     SpellFamilyName;          // used by proc function

    RIStatTypes     StatIndex;

    ItemModType ItemMod;              // there is already an apply function for these. Reuse them
    UnitMods UnitMod;                 // there is already an apply function for these. Reuse them
    char SpellMod;                     // there is already an apply function for these. Reuse them
    RI_ApplyStatFunc    ApplyScript;  // run this function when player equips this item
};

extern PossibleRandomStatRolls *RI_PickableStats;

PossibleRandomStatRolls *GetPickableStatStore();
PossibleRandomStatRolls *GetPickableStatStoreClassOnly(int Class, int &ValueCount);
//in case we want to update our addon DB
void GenerateRandomRollFormatStrings();
//for manual updating of our addon DB
void PrintPossibleRandomStats();
//push updates if we have any
void OnPlayerLoginWithAddon(Player *p);
//
void OnAddonVersionReport(Player *p, const char *msg);
void RequestClientAddon(Player *p);
//void SendMessageToClient(Player *p, const char *msg, const char *chnl = NULL);
