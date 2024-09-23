#pragma once

#include <list>
#include <map>

class RI_ItemStore;
class RI_StatStore;
class Item;
class Player;
enum RIStatTypes;

#define QUERY_ANTISPAM_TIMEOUT  200 // only allowed to issue 1 query every 200 ms

enum RI_Stat_Type_Groups
{
    RI_STTG_MF,
    RI_STTG_MFP,
    RI_STTG_MF_NO_INSTANCE,
    RI_STTG_MFP_NO_INSTANCE,
    RI_STTG_ATTACK,
    RI_STTG_DEFENSE,
    RI_STTG_UTIL,
    RI_STTG_ANY,
    RI_STTG_MAX_TYPES,
};

class RI_PlayerStore
{
public:
    RI_PlayerStore(Player *p);
    Item *GetItem(int InventorySlot, int BagIndex, int BagSlot, int InvestigatedSlot, int TradeIndex);
    void OnPlayerStoredItem(Player *p, Item *it, int Difficulty);
    void OnPlayerLoginFinished(Player *p);   // load custom stat data for items
    void OnPlayerLogout(Player *p);   // save
    void OnPlayerRevive();
    void OnClientAddonConfirmed();  // can accept item queries
    bool AntiSpamCanReplyQuery();
    void PushClientDBUpdatePush(Player *p,RIStatTypes stt);
    bool IsClientAddonConfirmed() { return ClientAddonConfirmed >= 4; }
    bool ShouldQueryClientAddon() { if (IsClientAddonConfirmed() == false) ClientAddonConfirmed++;  return ClientAddonConfirmed < 2; }
    void AddDust(int Amt);
    int GetMagicFind();
    int GetMagicFindOutOfInstance() { return StatMods[RI_STTG_MF_NO_INSTANCE]; }
    int GetMagicFindStrength();
    int GetMagicFindStrengthOutOfInstance();
    int* GetStatMods() { return StatMods; }
    float GetTotalStat(int Type);
    void PrintMFStats();
    void BuySRCMBuff(int MFP, int MFPDur, int Price, RI_Stat_Type_Groups Type);
    void ModStat(RI_Stat_Type_Groups Stat, int val, bool Apply);
    void UpdateBuffStatuses();
    int GetStatRollChance(RIStatTypes stat);
    void SacrificeItem(std::list<RI_StatStore*> *StatList);
    void PrintSacrificeStatus();
    void ResetSacrificeStatus();
    int GetSacrificeCount() { return ItemsSacrificed; }
private:
    void SaveMagicFind();
    std::list<RIStatTypes> SentDBUpdatesToClient; // if client is missing specific stats, we can push them to it;
    uint32  PrevQueryStamp;     // do not allow client to flood us with queries. Kinda like an anti-spam protection
    Player *Owner;
    char ClientAddonConfirmed; // do not reply to queries if client addon has not signed in
    int RemindClientOfMissingAddon;
    int MagicDust;
    int StatMods[RI_STTG_MAX_TYPES];
    int StatModsBuff[RI_STTG_MAX_TYPES];
    uint32 StatModsBuffExpire[RI_STTG_MAX_TYPES];
    bool SaveMagicDust;
    std::map<RIStatTypes,int> StatRollChanceMods;
    int ItemsSacrificed;
    bool SaveSacrificeStatus;
};

RI_PlayerStore *GetPlayerRIStore(Player *p);
void HandleQuery(Player *p, int InventoryIndex, int BagIndex, int BagSlotIndex, int InvetigatedIndex, int TransactionID, int TradeIndex);
void RI_AnyItemReceived(void *p, void *);
void RI_ItemSold(void *p, void *);
void RI_RollOutOfInstanceStats(Player *p, Item *i);

void ShowMagicDustStatus(Player *p);
void BuySRCMBuff(Player *p, int Amt, int Price, RI_Stat_Type_Groups StatType);
void ResetSacrifice(Player *p);
void ShowSacrifice(Player *p);
