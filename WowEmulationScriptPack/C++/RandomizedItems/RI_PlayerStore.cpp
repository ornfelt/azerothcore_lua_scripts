#include "Player.h"
#include "Bag.h"
#include "Map.h"
#include "DatabaseEnv.h"
#include "RI_PlayerStore.h"
#include "RI_ItemStore.h"
#include "ObjectExtension.cpp"
#include "GameTime.h"
#include "World.h"
#include "RI_AddonUpdater.h"
#include "ScriptSettings/ScriptSettingsAPI.h"
#include "TradeData.h"
#include "AddonCommunication/AddonCommunication.h"

RI_PlayerStore *GetPlayerRIStore(Player *p)
{
    RI_PlayerStore *rip = p->GetExtension<RI_PlayerStore>(OE_PLAYER_EXTENDED_ITEM_STATS);
    if (rip == NULL)
    {
        rip = new RI_PlayerStore(p);
        p->SetExtension<RI_PlayerStore>(OE_PLAYER_EXTENDED_ITEM_STATS, rip);
    }
    return rip;
}

RI_PlayerStore::RI_PlayerStore(Player *p)
{
    Owner = p;
    PrevQueryStamp = 0;
    ClientAddonConfirmed = 0;
    MagicDust = 0;
    SaveMagicDust = false;
    memset(StatMods,0,sizeof(StatMods));
    memset(StatModsBuff, 0, sizeof(StatModsBuff));
    memset(StatModsBuffExpire, 0, sizeof(StatModsBuffExpire));
    ItemsSacrificed = 0;
    SaveSacrificeStatus = false;
}

bool RI_PlayerStore::AntiSpamCanReplyQuery()
{
    if (PrevQueryStamp < GameTime::GetGameTimeMS())
    {
        PrevQueryStamp = GameTime::GetGameTimeMS() + QUERY_ANTISPAM_TIMEOUT;
        return true;
    }
    return false;
}

void RI_PlayerStore::PushClientDBUpdatePush(Player *p, RIStatTypes stt)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    if (RI_PickableStats[stt].PushUpdateClientDB == 0 || RI_PickableStats[stt].FormatStr == NULL)
        return;

    //did we already update cleint with this stat ?
    for (std::list<RIStatTypes>::iterator itr = SentDBUpdatesToClient.begin(); itr != SentDBUpdatesToClient.end(); itr++)
        if ((*itr) == stt)
            return;

    //send push update
    char PushUpdate[MAX_MESSAGE_LENGTH];
    sprintf_s(PushUpdate, sizeof(PushUpdate), "%d %d %s", stt, RI_PickableStats[stt].RGB, RI_PickableStats[stt].FormatStr);
    AddonComm::SendMessageToClient(p, "RIDB", PushUpdate);

    //mark this stat type as known by client
    SentDBUpdatesToClient.push_front(stt);
}

char *GetQueryReply(Player *p, int InventoryIndex, int BagIndex, int BagSlotIndex, int InspectedIndex, int TransactionID, int TradeIndex, bool SkipSpamCheck)
{
    // store this whole "server addon" on each character
    RI_PlayerStore *ri = GetPlayerRIStore(p);

    // you can never know who will try to abuse this feature
    if (SkipSpamCheck == false && ri->AntiSpamCanReplyQuery() == false)
        return NULL;

    //does the player have this item ?
    Item *it = ri->GetItem(InventoryIndex, BagIndex, BagSlotIndex, InspectedIndex, TradeIndex);
    if (it == NULL)
        return NULL;

    //is the item randomized ?
    RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii == NULL)
    {
#ifdef FORCE_GEN_STATS_ON_ITEMS
        rii = new RI_ItemStore(it);
        it->SetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS, rii);
#else
        return FormatQueryResponseEmpty(TransactionID);
#endif
    }
    //format the stats into string format
    return rii->FormatQueryResponse(ri, p, TransactionID);
}

//local function for below case
void PushStatsForItem(Player *p, int Bag, int Slot)
{
    Item *it = p->GetItemByPos(Bag, Slot);
    if (!it)
        return;
    RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii == NULL)
        return;
    rii->PushClientAddonUpdate();
}

void HandleQuery(Player *p, int InventoryIndex, int BagIndex, int BagSlotIndex, int InspectedIndex, int TransactionID, int TradeIndex)
{
    // store this whole "server addon" on each character
    RI_PlayerStore *ri = GetPlayerRIStore(p);

    // you can never know who will try to abuse this feature
    if (ri->AntiSpamCanReplyQuery() == false)
        return;

    //format the stats into string format
    char *repl = GetQueryReply(p, InventoryIndex, BagIndex, BagSlotIndex, InspectedIndex, TransactionID, TradeIndex, true);
    if (repl != NULL)
    {
        AddonComm::SendMessageToClient(p, "RI  ", repl);
        free(repl);//no need to leak memory
        repl = NULL;
    }
    Item *it = ri->GetItem(InventoryIndex, BagIndex, BagSlotIndex, -1, TradeIndex); // investigated items should NOT be marked for caching
    if (it)
    {
        RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
        if (rii != NULL)
            rii->MarkClientIsUpdated();
    }

   if (InspectedIndex >= 0)
    {
        uint64 *LastInspectedGUID = p->GetExtension<uint64>(OE_PLAYER_LAST_INSPECTED);
        if (LastInspectedGUID != NULL)
        {
            Player *InspectedPlayer= sWorld->GetOnlinePlayer(ObjectGuid(*LastInspectedGUID));
            if (InspectedPlayer != NULL)
            {
                for (int i = EQUIPMENT_SLOT_START; i != EQUIPMENT_SLOT_END; i++)
                {
                    if (i == InspectedIndex)
                        continue;
                    Item *it = InspectedPlayer->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
                    if (it == NULL)
                        continue;
                    RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
                    if (rii == NULL)
                        continue;
                    rii->PushClientAddonUpdate(p);
                }
            }
        }
    }

    //send all inventory items
    if (InventoryIndex != -1)
    {
        if(InventoryIndex >= EQUIPMENT_SLOT_START && InventoryIndex <= EQUIPMENT_SLOT_END)
            for (int i = EQUIPMENT_SLOT_START; i != EQUIPMENT_SLOT_END; i++)
                PushStatsForItem(p, INVENTORY_SLOT_BAG_0, i);
        if (InventoryIndex >= BANK_SLOT_ITEM_START && InventoryIndex <= BANK_SLOT_ITEM_END)
            for (int i = BANK_SLOT_ITEM_START; i != BANK_SLOT_ITEM_END; i++)
                PushStatsForItem(p, INVENTORY_SLOT_BAG_0, i);
    }
    if (BagIndex == 0)
    {
        for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
            PushStatsForItem(p, INVENTORY_SLOT_BAG_0, i);
    }
    if (BagIndex > 0)
    {
        for (int i = 0; i < MAX_BAG_SIZE; i++)
            PushStatsForItem(p, INVENTORY_SLOT_BAG_START + BagIndex - 1, i);
    }
}

Item *RI_PlayerStore::GetItem(int InventoryIndex, int BagIndex, int BagSlotIndex, int InspectedIndex, int TradeIndex)
{
    // no point of sending queries unles client actually has the addon
    if (IsClientAddonConfirmed() == false)
        return NULL;
    //get the item in the slot
    Item *it = NULL;
    if (InventoryIndex >= EQUIPMENT_SLOT_START && InventoryIndex < EQUIPMENT_SLOT_END)
        it = Owner->GetItemByPos(INVENTORY_SLOT_BAG_0, InventoryIndex);
    else if (InventoryIndex >= BANK_SLOT_ITEM_START && InventoryIndex < BANK_SLOT_ITEM_END)
        it = Owner->GetItemByPos(INVENTORY_SLOT_BAG_0, InventoryIndex);
    else if(BagIndex==0)
        it = Owner->GetItemByPos(INVENTORY_SLOT_BAG_0, INVENTORY_SLOT_ITEM_START + BagSlotIndex - 1);
    else if(BagIndex > 0)
        it = Owner->GetItemByPos(INVENTORY_SLOT_BAG_START + BagIndex - 1, BagSlotIndex - 1);
    else if (InspectedIndex >= 0)
    {
        uint64 *LastInspectedGUID = Owner->GetExtension<uint64>(OE_PLAYER_LAST_INSPECTED);
        if (LastInspectedGUID == NULL)
            return NULL;
        Player *p = sWorld->GetOnlinePlayer(ObjectGuid(*LastInspectedGUID));
        if (p == NULL)
            return NULL;
        it = p->GetItemByPos(INVENTORY_SLOT_BAG_0, InspectedIndex);
    }
    else if (TradeIndex >= 0)
    {
        Player* TradeTarget = Owner->GetTrader();
        if (TradeTarget == NULL)
            return NULL;
        if (TradeTarget->GetTradeData() == NULL)
            return NULL;
        TradeData *TargtePlayerItems = TradeTarget->GetTradeData();
         return TargtePlayerItems->GetItem(TradeSlots(TradeIndex));
    }
    return it;
}

void RI_PlayerStore::OnPlayerStoredItem(Player *p, Item *it, int Difficulty)
{
    //if it already has random stats, skip creating new ones
    RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii != NULL)
        return;
    //create a new item randomization
    rii = new RI_ItemStore(it);
    it->SetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS, rii);
    UpdateBuffStatuses(); //update rollchance mod buffs
    if(p->GetMap()->IsDungeon() == false)
        rii->GenerateRandomStats(it, 0, GetMagicFindOutOfInstance(), GetMagicFindStrengthOutOfInstance(), p->getClass(), this);
    else
        rii->GenerateRandomStats(it, Difficulty, GetMagicFind(), GetMagicFindStrength(), p->getClass(), this);
    //client will know about the stats as soon as you hower over it the mouse
    rii->PushClientAddonUpdate();
}

void RI_AnyItemReceived(void *p, void *)
{
    CP_ITEM_STORED *params = PointerCast(CP_ITEM_STORED, p);
    if (params->Owner == NULL || params->ItemTemplate == NULL || params->Owner->GetSession() == NULL)
        return;
    //player is logging in
    if (params->Owner->IsInWorld() == false)
        return;
    if (params->Owner->FindMap() == NULL)
        return;

    RI_PlayerStore *ris = GetPlayerRIStore(params->Owner);
    if (ris->IsClientAddonConfirmed() == false)
    {
        params->Owner->BroadcastMessage("This realm requires a special addon to see additional item stats. Please make sure you enabled it");
        if(ris->ShouldQueryClientAddon())
            RequestClientAddon(params->Owner);
        return;
    }

    //if this is an instance, we will handle the loot trigger later
    if (params->Owner->GetMap()->GetInstanceId())
    {
        RI_ItemStore *rii = params->ItemObject->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
        if (rii != NULL)
            rii->PushClientAddonUpdate(); // force a client update. This is required when item is put in a new slot where an item with same Entry. Client will not be able to make a difference
        return;
    }

    ris->OnPlayerStoredItem(params->Owner, params->ItemObject, 0); // difficulty is set to something high as 
}

void RI_ItemLooted(void *p, void *)
{
    CP_ITEM_LOOTED *params = PointerCast(CP_ITEM_LOOTED, p);

    //sanity check
    if (params->Owner == NULL || params->Owner->FindMap() == NULL)
        return;

    //is this a scaled map ?
    if (params->Owner->GetMap()->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER) == NULL)
        return;

    //only doing randomizations inside scaled instances
    int64 *InstanceScalePlayer = params->Owner->GetMap()->GetExtension<int64>(OE_MAP_MOB_DIFFICULTY_SCALER);
    uint32 Difficulty = 0;
    if(InstanceScalePlayer != NULL)
        Difficulty += (int32)*InstanceScalePlayer;

    //create an item randomization
    RI_PlayerStore *ris = GetPlayerRIStore(params->Owner);
    ris->OnPlayerStoredItem(params->Owner, params->Item, Difficulty);
}

void RI_PlayerStore::AddDust(int Amt)
{
    if (Owner == NULL)
        return;

    float *DustMod = Owner->GetExtension<float>(OE_PLAYER_DUST_GAIN_PCT);
    if(DustMod == NULL)
        MagicDust += Amt;
    else
        MagicDust += (int)(Amt * DustMod[0]);
    if (MagicDust < 0)
        MagicDust = 0;

    Owner->BroadcastMessage("Randomized Items : Got %d MagicDust. Have Total %d", Amt, MagicDust);
    SaveMagicDust = true;
}

void RI_PlayerStore::SaveMagicFind()
{
    if (SaveSacrificeStatus == true)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_IR_sacrifice where PlayerGUID = %u", Owner->GetGUID().GetCounter());
        CharacterDatabase.Execute(Query);
        sprintf_s(Query, sizeof(Query), "insert into character_IR_sacrifice values(%u,%u,%u)", Owner->GetGUID().GetCounter(), RI_STAT_ITEMS_SACRIFICED, ItemsSacrificed);
        CharacterDatabase.Execute(Query);
        for (auto itr = StatRollChanceMods.begin(); itr != StatRollChanceMods.end(); itr++)
        {
            sprintf_s(Query, sizeof(Query), "insert into character_IR_sacrifice values(%u,%u,%u)", Owner->GetGUID().GetCounter(), itr->first, itr->second);
            CharacterDatabase.Execute(Query);
        }
    }

    bool PerformSave = SaveMagicDust;

    UpdateBuffStatuses();

    if (PerformSave == false)
    {
        for (int i = 0; i < RI_STTG_MAX_TYPES; i++)
            if (StatModsBuff[i] != 0)
                PerformSave = true;
    }

    if (PerformSave == true)
    {
        char Query[5000];
        int BytesWritten = 0;
        BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, "replace into character_IR_params values(%u,%d", Owner->GetGUID().GetCounter(), MagicDust);
        for (int i = 0; i < RI_STTG_MAX_TYPES; i++)
            if (StatModsBuff[i] != 0 && StatModsBuffExpire[i] > GameTime::GetGameTimeMS())
            {
                int TimeRemain = (StatModsBuffExpire[i] - GameTime::GetGameTimeMS()) / 1000;
                BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, ",%d,%u", StatModsBuff[i], TimeRemain);
            }
            else
                BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, ",0,0");
        BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, ")");

        CharacterDatabase.Execute(Query);
    }
}

void RI_PlayerStore::OnPlayerLogout(Player *p)
{
    //save magic dust on logout
    SaveMagicFind();
}

int RI_PlayerStore::GetMagicFind()
{
    return StatMods[RI_STTG_MF];
}

int RI_PlayerStore::GetMagicFindStrength()
{
    int ret = StatMods[RI_STTG_MFP];
    //suffer diminishing returns
    ret = (350 * ret) / (ret + 150);
    return ret;
}

int RI_PlayerStore::GetMagicFindStrengthOutOfInstance()
{
    int ret = StatMods[RI_STTG_MFP_NO_INSTANCE];
    //suffer diminishing returns
    ret = (1200 * ret) / (ret + 600);
    return ret;
}

int ShouldReallyDeleteRandomizations(Player *p, uint32 ItemGUID)
{
    //check if indeed this item is deleted in DB also
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "SELECT count(*) from character_inventory where guid = %u and item=%u", p->GetGUID().GetCounter(), ItemGUID);
    QueryResult result = CharacterDatabase.Query(Query);
    if (result)
    {
        Field* fields = result->Fetch();
        uint32 FoundIt = fields[0].GetUInt32();
        if (FoundIt == 1)
        {
            FILE *f = fopen("RI_DELETE_BUGS.txt", "at");
            if (f)
            {
                fprintf(f, "RI: wants to delete item %u, for player %u but it still exists in DB", ItemGUID, p->GetGUID().GetCounter());
                fclose(f);
                return 0;
            }
        }
    }
    return 1;
}

void RI_PlayerStore::OnPlayerLoginFinished(Player *p)
{
    // add hook to randomize looted item
    Owner->RegisterCallbackFunc(CALLBACK_TYPE_LOOT_ITEM, RI_ItemLooted, NULL);

    //check if this player has the addon installed. If not, periodically remind him that he should have it
    char Query[5000];

    //load magic Dust amount
    sprintf_s(Query, sizeof(Query), "SELECT * from character_IR_params where PlayerGUID = %u", Owner->GetGUID().GetCounter());
    QueryResult result = CharacterDatabase.Query(Query);
    if (result)
    {
        Field* fields = result->Fetch();
        MagicDust = (uint32)fields[1].GetUInt32();
        for (int i = 0; i < RI_STTG_MAX_TYPES; i++)
            BuySRCMBuff(fields[2 + i * 2].GetUInt32(), fields[3 + i * 2].GetUInt32(), 0, (RI_Stat_Type_Groups)i);
    }

    //load sacrifice status
    sprintf_s(Query, sizeof(Query), "SELECT * from character_IR_sacrifice where PlayerGUID = %u", Owner->GetGUID().GetCounter());
    result = CharacterDatabase.Query(Query);
    if (result)
    {
        do {
            Field* fields = result->Fetch();
            RIStatTypes Stat = (RIStatTypes)fields[1].GetUInt32();
            uint32 RollChanceMod = fields[2].GetUInt32();
            if (Stat == RI_STAT_ITEMS_SACRIFICED)
                ItemsSacrificed = RollChanceMod;
            else
                StatRollChanceMods[Stat] = RollChanceMod;

        } while (result->NextRow());
    }

    // load all item customizations
    sprintf_s(Query, sizeof(Query), "SELECT * from character_item_randomizations where PlayerGUID = %u", Owner->GetGUID().GetCounter());
    result = CharacterDatabase.Query(Query);
    if (result)
    {
        //this is only for the sake of cleaning up bugs
        char ToDeleteGUIDS[31000];
        int BytesWritten = 0;
        int ItemsToDeleteCount = 0;
        BytesWritten += sprintf_s(ToDeleteGUIDS + BytesWritten, sizeof(ToDeleteGUIDS) - BytesWritten, "delete from character_item_randomizations where PlayerGUID=%u and ItemGUID in (", Owner->GetGUID().GetCounter());

        int32 MaxManaPreLoad = p->GetMaxPower(POWER_MANA);

        //iterate through item randomizations 
        do
        {
            Field* fields = result->Fetch();
            uint32 ItemGUIDLow = fields[1].GetUInt32();
            ObjectGuid ItemGUID = ObjectGuid(HighGuid::Item, ItemGUIDLow);
            //maybe something went wrong and player no longer owns this item
            Item *it = Owner->GetItemByGuid(ItemGUID);
            if (it == NULL)
            {
//                if (ShouldReallyDeleteRandomizations(p, ItemGUIDLow))
                {
                    BytesWritten += sprintf_s(ToDeleteGUIDS + BytesWritten, sizeof(ToDeleteGUIDS) - BytesWritten, "%u,", ItemGUIDLow);
                    ItemsToDeleteCount++;
                    continue;
                }
            }
            //wow, somehow this item saved it's randomization more than once
            RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
            if (rii != NULL && rii->IsLoadedFromDB() == true)
            {
                if (ShouldReallyDeleteRandomizations(p, ItemGUIDLow))
                {
                    BytesWritten += sprintf_s(ToDeleteGUIDS + BytesWritten, sizeof(ToDeleteGUIDS) - BytesWritten, "%u,", ItemGUIDLow);
                    ItemsToDeleteCount++;
                    continue;
                }
            }
            //create a new store for this item
            if( rii == NULL)
                rii = new RI_ItemStore(it);
            rii->LoadFromDB(p, it, fields);
            //fetch next randomization
        } while (result->NextRow());

        //if for some reason the player no longer owns these items, we can delete the randomizations
        if (ItemsToDeleteCount > 0)
        {
            ToDeleteGUIDS[BytesWritten - 1] = 0; //delete the last ,
            BytesWritten--;
            BytesWritten += sprintf_s(ToDeleteGUIDS + BytesWritten, sizeof(ToDeleteGUIDS) - BytesWritten, ")");
            CharacterDatabase.Execute(ToDeleteGUIDS);
        }

        //items add mana as mana not only as possible mana
        p->ModifyPower(POWER_MANA, p->GetMaxPower(POWER_MANA) - MaxManaPreLoad);
    }
}

void RI_PlayerStore::OnClientAddonConfirmed()
{
    ClientAddonConfirmed = 100;
}

float RI_PlayerStore::GetTotalStat(int Type)
{
    if (Type == RI_MAGIC_FIND_INSTANCES)
        return (float)GetMagicFind();
    if (Type == RI_MAGIC_FIND_POWER_INSTANCES)
        return (float)GetMagicFindStrength();
    if (Type == RI_MAGIC_FIND_NON_INSTANCE)
        return (float)StatMods[RI_STTG_MF_NO_INSTANCE];
    if (Type == RI_MAGIC_FIND_POWER_NON_INSTANCE)
        return (float)GetMagicFindStrengthOutOfInstance();

    float ret = 0.0f;
    for (int i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
    {
        Item *it = GetItem(i, 0, 0, 0, 0);
        if (it == NULL)
            continue;
        RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
        if (rii == NULL)
            continue;
        ret += rii->GetStatSum(Type);
    }
    return ret;
}

void RI_PlayerStore::ResetSacrificeStatus()
{
    SaveSacrificeStatus = true;
    ItemsSacrificed = 0;
    StatRollChanceMods.clear();
}

int GetSacrificeDRChance(int Value)
{
    return (60 * Value) / (Value + 40);
}

void RI_PlayerStore::SacrificeItem(std::list<RI_StatStore*> *StatList)
{
    if (StatList->size() == 0)
        return;

    SaveSacrificeStatus = true;

    ItemsSacrificed++;
    // sacrificed item stats will strengthen the list by 1. Other stats will loose 1 charge
    //decrease the list of mods by 1. Loose mods that are already at the edge
    for (auto itr = StatRollChanceMods.begin(); itr != StatRollChanceMods.end();)
    {
        auto itr2 = itr;
        itr++;
        //will we strengthen this stat ?
        bool WillStrengthen = false;
        for (auto itr_stats = StatList->begin(); itr_stats != StatList->end(); itr_stats++)
            if ((*itr_stats)->Type == itr2->first)
            {
                WillStrengthen = true;
                break;
            }

        if (WillStrengthen == false)
        {
            if (itr2->second > 1)
                itr2->second--;
            else
                StatRollChanceMods.erase(itr2);
        }
    }
    //increse or add mods from this item
    for (auto itr_stats = StatList->begin(); itr_stats != StatList->end(); itr_stats++)
    {
        auto itr_rollMod = StatRollChanceMods.find((*itr_stats)->Type);
        if (itr_rollMod == StatRollChanceMods.end())
            StatRollChanceMods[(*itr_stats)->Type] = 1;
        else
            itr_rollMod->second += 1;
    }
    //let the player know how things go
    PrintSacrificeStatus();
}

void RI_PlayerStore::PrintSacrificeStatus()
{
    int TSacrificeCount = GetSacrificeDRChance( ItemsSacrificed );
    Owner->BroadcastMessage("RandomizedItems : Non hunted stats will receive -%d%% dropchance", TSacrificeCount);
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    for (auto itr = StatRollChanceMods.begin(); itr != StatRollChanceMods.end(); itr++)
        Owner->BroadcastMessage("RandomizedItems : %d%% dropchance for %s", GetSacrificeDRChance( itr->second ), RI_PickableStats[itr->first].FormatStr);
}

void RI_ItemSold(void *p, void *)
{
    CP_ITEM_USE_DENY *params = PointerCast(CP_ITEM_USE_DENY, p);
    if (params->Owner == NULL)
        return;

    RI_ItemStore *rii = params->item->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii == NULL)
        return;

    //if this is a special vendor, we will convert it into roll chance mod. Else, it will become dust
    if (params->creature && params->creature->GetEntry() == 123470) // display 33118
    {
        GetPlayerRIStore(params->Owner)->SacrificeItem(rii->GetStats());
    }
    else
    {
        int Dust = rii->GetDestroyDustAmount();
        RI_PlayerStore *ris = GetPlayerRIStore(params->Owner);
        ris->AddDust(Dust);
    }

    rii->DeleteFromDB();
}

void RI_PrintStatBuffStatus(Player *Owner, int Mod, uint32 Expire, const char *Name)
{
    if (Mod != 0)
    {
        int32 SecRemain = ((int32)Expire - (int32)GameTime::GetGameTimeMS()) / 1000;
        Owner->BroadcastMessage("RandomizedItems : Active %s buff %d will expire in %d:%d", Name, Mod, SecRemain / 60 / 60, (SecRemain / 60) % 60);
    }
//    else
//        Owner->BroadcastMessage("RandomizedItems : No Active %s buff", Name);
}

void RI_PlayerStore::PrintMFStats()
{
    Owner->BroadcastMessage("RandomizedItems : You have %d Magic dust", MagicDust);

    RI_PrintStatBuffStatus(Owner, StatModsBuff[RI_STTG_MF], StatModsBuffExpire[RI_STTG_MF], "Magic Find");
    RI_PrintStatBuffStatus(Owner, StatModsBuff[RI_STTG_MFP], StatModsBuffExpire[RI_STTG_MFP], "Magic Find Power");
    RI_PrintStatBuffStatus(Owner, StatModsBuff[RI_STTG_ATTACK], StatModsBuffExpire[RI_STTG_ATTACK], "Attack Stat Roll Chance");
    RI_PrintStatBuffStatus(Owner, StatModsBuff[RI_STTG_DEFENSE], StatModsBuffExpire[RI_STTG_DEFENSE], "Defense Stat Roll Chance");
    RI_PrintStatBuffStatus(Owner, StatModsBuff[RI_STTG_UTIL], StatModsBuffExpire[RI_STTG_UTIL], "Util Stat Roll Chance");
    RI_PrintStatBuffStatus(Owner, StatModsBuff[RI_STTG_ANY], StatModsBuffExpire[RI_STTG_ANY], "Stat Roll Chance");
}

void RI_PlayerStore::BuySRCMBuff(int MFP, int MFPDur, int Price, RI_Stat_Type_Groups Type)
{
    if (Price > MagicDust)
        return;
    if (Type > RI_STTG_MAX_TYPES || Type < 0)
        return;
    if (Price != 0)
    {
        MagicDust -= Price;
        SaveMagicDust = true;
    }
    StatMods[Type] -= StatModsBuff[Type]; // remove previous mod
    //start counting next mod
    StatModsBuffExpire[Type] = GameTime::GetGameTimeMS() + MFPDur * 1000;
    StatModsBuff[Type] = MFP;
    //activate the buff
    StatMods[Type] += MFP;
}

void RI_PlayerStore::ModStat(RI_Stat_Type_Groups StatType, int val, bool Apply)
{
    if (StatType > RI_STTG_MAX_TYPES || StatType < 0)
        return;
    if (Apply == true)
        StatMods[StatType] += val;
    else
        StatMods[StatType] -= val;
}

void RI_PlayerStore::UpdateBuffStatuses()
{
    for(int i=0;i< RI_STTG_MAX_TYPES;i++)
        if (StatModsBuff[i] != 0 && StatModsBuffExpire[i] <= GameTime::GetGameTimeMS())
        {
            StatMods[i] -= StatModsBuff[i];
            StatModsBuff[i] = 0;
        }
}

void ShowMagicDustStatus(Player *p)
{
    GetPlayerRIStore(p)->PrintMFStats();
}

void BuySRCMBuff(Player *p, int Amt, int Price, RI_Stat_Type_Groups StatType)
{
    GetPlayerRIStore(p)->BuySRCMBuff(Amt, 4 * 60 * 60, Price, StatType);
}

int RI_PlayerStore::GetStatRollChance(RIStatTypes stat)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    // mod any stat drop chance
    int ret = StatMods[RI_STTG_ANY]; 
    //group based roll chances
    if (RI_PickableStats[stat].RGB == RGB_UTIL)
        ret += StatMods[RI_STTG_UTIL];
    if (RI_PickableStats[stat].RGB == RGB_ATTACK)
        ret += StatMods[RI_STTG_ATTACK];
    if (RI_PickableStats[stat].RGB == RGB_DEFENSE)
        ret += StatMods[RI_STTG_DEFENSE];
    //specific stat roll chance mods
    auto itr = StatRollChanceMods.find(stat);
    if (itr != StatRollChanceMods.end())
    {
        ret += GetSacrificeDRChance(itr->second);
    }
    else
    {
        ret -= GetSacrificeDRChance(ItemsSacrificed);
    }
    return ret;
}

void ResetSacrifice(Player *p)
{
    GetPlayerRIStore(p)->ResetSacrificeStatus();
}

void ShowSacrifice(Player *p)
{
    GetPlayerRIStore(p)->PrintSacrificeStatus();
}

void RI_RollOutOfInstanceStats(Player *p, Item *i)
{
    if (i == NULL)
        return;
    RI_ItemStore *rii = i->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii == NULL)
    {
        rii = new RI_ItemStore(i);
        i->SetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS, rii);
    }
    RI_PlayerStore *ri = GetPlayerRIStore(p);
    rii->GenerateRandomStats(i, 0, ri->GetMagicFindOutOfInstance(), ri->GetMagicFindStrengthOutOfInstance(), p->getClass(), ri);
    rii->SaveToDB();
}

void RI_PlayerStore::OnPlayerRevive()
{
    for (int i = EQUIPMENT_SLOT_START; i != EQUIPMENT_SLOT_END; i++)
    {
        Item *it = Owner->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it == NULL)
            continue;
        RI_ItemStore *rii = it->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
        if (rii == NULL)
            continue;
        rii->OnPlayerRevive();
    }
}
