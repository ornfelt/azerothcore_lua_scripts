#include "RI_ItemStore.h"
#include "Item.h"
#include "Random.h" //can be deleted later
#include "ObjectExtension.cpp"
#include "DatabaseEnv.h"
#include "RI_AddonUpdater.h"
#include "GameEventCallbacks.h"
#include "RI_PlayerStore.h"
#include "Player.h"
#include "AddonCommunication/AddonCommunication.h"

bool RI_StatStore::RollStatType(PossibleRandomStatRolls *RI_PickableStats, RI_PlayerStore *rip, int MaxStatCount, bool UpdateRollChance)
{
    Type = RI_STAT_TYPE_NOT_USED;
    int RollRetryCount = MAX_RANDOMIZER_COUNT * 3;
    //pick a stat that has not yet been picked
    int SelectedIndex = rand32() % MaxStatCount;
    ASSERT(RI_PickableStats[SelectedIndex].FormatStr != NULL);
    //sanity check
    while (RI_PickableStats[SelectedIndex].FormatStr == NULL
        //(|| (RI_PickableStats[SelectedIndex].ClassFilterMask & ClassFilterMask ) == 0 )
        || RollRetryCount > 0)
    {
        int RollChanceMod = 0;
        if (UpdateRollChance == true)
            RollChanceMod = rip->GetStatRollChance(RI_PickableStats[SelectedIndex].StatIndex);
        if ((RI_PickableStats[SelectedIndex].RollChance + RollChanceMod) > ((rand32() % 1000) / 10.0f))
            break;
        SelectedIndex = rand32() % MaxStatCount;
        RollRetryCount--;
        ASSERT(RI_PickableStats[SelectedIndex].FormatStr != NULL);
    }
    if (RollRetryCount <= 0)
        return false;
    Type = RI_PickableStats[SelectedIndex].StatIndex;
    return true;
}

bool RI_StatStore::RollStatPower(float RIPowerScaler)
{
    //scale it to current instance difficulty
    Power = 0.0f;
    if (Type == RI_STAT_TYPE_NOT_USED || Type >= RI_MAX_STAT_TYPES)
        return false;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    //no need to roll on these
    if (RI_PickableStats[Type].FixedValue != 0)
        Power = RI_PickableStats[Type].MaxValAt100;
    else
    {
        Power = RI_PickableStats[Type].MaxValAt100 * RIPowerScaler;
        //randomize it
        float MaxRoll = Power * 10000.0f;
        float FixedPartPower8 = MaxRoll / 8; // part of the struggle is guaranteed
        float RandomPart = MaxRoll - FixedPartPower8;
        if (RandomPart < 1)
            RandomPart = 1;
        RandomPart = (float)(rand32() % (uint32)(RandomPart));
        Power = FixedPartPower8 + RandomPart;
        Power = Power / 10000.0f; //to be able to generate sub 1 values

                                                  //some values should not roll as decimal. It should generate integer
        if (RI_PickableStats[Type].IsIntValue != 1)
            Power = (float)((int)Power);
        else
            Power = ((int)(Power * 100)) / 100.0f; // truncate to 2 decimal precision

        if (RI_PickableStats[Type].InverseGenerated != 0)
        {
            Power = RI_PickableStats[Type].InverseGenerated - Power;
            if (Power < RI_PickableStats[Type].MinValue)
                Power = RI_PickableStats[Type].MinValue;
        }

        //difficulty too small to generate this stat
        if (Power < RI_PickableStats[Type].MinValue)
            return false;

        // small chance to roll this as a negative stat
        if (rand32() % 100 < RI_PickableStats[Type].NegativeRollChance)
            Power = -Power;
    }
    return true;
}

RI_StatStore::~RI_StatStore()
{
    if (ProcDataStore != NULL)
    {
        DebugCheckDoubleDelete(ProcDataStore);
        ProcDataStore = NULL;
    }
}

RI_ItemStore::RI_ItemStore(Item *it)
{
    Owner = it;
    LoadedForPlayer = it->GetOwner()->GetGUID();
    LoadedFromDatabase = 0;
    HasEffectsApplied = false;
    LastUpdatedClientSlot = 0xFFFF;
}

RI_ItemStore::~RI_ItemStore()
{
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
        DebugCheckDoubleDelete( *itr );
    ItemExtraStats.clear();
}

char *FormatQueryResponseEmpty(int TransactionID)
{
    char *resp = (char*)malloc(MAX_MESSAGE_LENGTH);
    sprintf_s(resp, MAX_MESSAGE_LENGTH, "%d", TransactionID);
    return resp;
}

char *RI_ItemStore::FormatQueryResponse(RI_PlayerStore *ps, Player *p, int TransactionID, char *AppendTo)
{
    char *resp;
    if(AppendTo != NULL)
        resp = AppendTo;
    else
        resp = FormatQueryResponseEmpty(TransactionID);
#ifdef FORCE_GEN_STATS_ON_ITEMS
    if (ItemExtraStats.empty() == true)
        GenerateRandomStats(NULL, 300 + rand32() % 300, rand32() % 300, rand32() % 300, p->GetClass());
#endif
    int BytesWritten = (int)strlen(resp);
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
    {
        //probably a simple string we want to show
        if(RI_PickableStats[(*itr)->Type].ParamCount == 0)
            BytesWritten += sprintf_s(resp + BytesWritten, MAX_MESSAGE_LENGTH - BytesWritten, " %d", (*itr)->Type);
        // is it an int ?
        else if((*itr)->Power - (int)(*itr)->Power == 0)
            BytesWritten += sprintf_s(resp + BytesWritten, MAX_MESSAGE_LENGTH - BytesWritten, " %d %d", (*itr)->Type, (int)(*itr)->Power);
        else
            BytesWritten += sprintf_s(resp + BytesWritten, MAX_MESSAGE_LENGTH - BytesWritten, " %d %.02f", (*itr)->Type, (*itr)->Power);

        //make sure client knows about this stat
        if( ps && p )
            ps->PushClientDBUpdatePush(p, (*itr)->Type);
    }
    int Dust = GetDestroyDustAmount();
    if(Dust > 0)
        BytesWritten += sprintf_s(resp + BytesWritten, MAX_MESSAGE_LENGTH - BytesWritten, " %d %d", RI_STAT_DUST_GAIN_ON_SALE, Dust);
    /*
    float StatStr = GetRollStrength(RGB_ATTACK, RGB_ATTACK_DEFENSE);
    if(StatStr!=0.f)
        BytesWritten += sprintf_s(resp + BytesWritten, MAX_MESSAGE_LENGTH - BytesWritten, " %d %.01f", RI_STAT_ATK_SCORE, StatStr);
    StatStr = GetRollStrength(RGB_DEFENSE, RGB_ATTACK_DEFENSE);
    if (StatStr != 0.f)
        BytesWritten += sprintf_s(resp + BytesWritten, MAX_MESSAGE_LENGTH - BytesWritten, " %d %.01f", RI_STAT_DEF_SCORE, StatStr);
    */

    return resp;
}

void RI_ItemStore::LoadFromDB(Player *p, Item *it, Field *f)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();

    it->SetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS, this);
    LoadedForPlayer = p->GetGUID();
    ItemExtraStats.clear(); // because somehow items can get pushed and randomized before this load gets called
    for (int i = 0; i < MAX_RANDOMIZER_COUNT; i++)
    {
        int Index = 2 + i * 2; // number of fields / struct
        //sanity checks
        RIStatTypes LoadedStatType = (RIStatTypes)f[Index].GetInt32();
        if (LoadedStatType >= RI_MAX_STAT_TYPES || LoadedStatType == RI_STAT_TYPE_NOT_USED || RI_PickableStats[LoadedStatType].FormatStr == NULL )
            continue;
        float Power = f[Index + 1].GetFloat();
        if (Power == 0.0f)
            continue; // in case there was some generation error and we wanted to reset the DB...
        RI_StatStore *ss = new RI_StatStore();
        ss->Type = LoadedStatType;
        //there was a bug where items rolled for insane values. This is capping them to a reasonable bug
        if (RI_PickableStats[LoadedStatType].InverseGenerated == 0)
        {
            if (Power > RI_PickableStats[LoadedStatType].MaxValAt100 * 15 )
                Power = RI_PickableStats[LoadedStatType].MaxValAt100 * 15;
        }
        ss->Power = Power;
        ItemExtraStats.push_front(ss);
    }

    //if item is equipped, apply the stats on the character
    if (it->IsEquipped() && it->IsBroken() == false)
        ApplyEffects(p, it, true);

    //mark items as loaded from db to not double save it
    LoadedFromDatabase = 1;
}

float GetRollPowerScaler(const Item *BaseItem, int Difficulty, int MagicStrength)
{
    if (Difficulty < 0)
        Difficulty = 0;
    if (MagicStrength < 0)
        MagicStrength = 0;
    float ItemLevel = 1;
    float ItemQuality = 1;
    if (BaseItem != NULL)
    {
        ItemLevel = BaseItem->GetTemplate()->ItemLevel + 1.0f;
        ItemQuality = BaseItem->GetTemplate()->Quality + 1.0f;
    }
    float ItemLevelCoeff = ItemLevel / MAX_ITEM_LEVEL;
    if (2 * ItemLevelCoeff > 1.0f) // i want item level to be less relevant. Low level dungeons have small chance to give valuable rewards
        ItemLevelCoeff = 1.0f;
    float ItemQualityCoeff = ItemQuality / ITEM_QUALITY_EPIC; //[0..2]
    float PowerScalerInstance = (float)Difficulty / 100.0f; // expected value 0-10
    float PowerScaleItemStrength = ItemLevelCoeff * ItemQualityCoeff; // Expected [0-1] .bad items generate smaller stats because we can do higher instance levels there
    float PowerScaleItemSuffix = MagicStrength / 100.0f; // Expected [0-20] . As time goes on, this can help you redo instances at the same difficulty
    float RIPowerScaler = (PowerScalerInstance + PowerScaleItemSuffix) * PowerScaleItemStrength;//[0-10]
    float RIPowerScalerDiminishingLimit = 15.f; // should be very hard to reach this value
    RIPowerScaler = RIPowerScalerDiminishingLimit * RIPowerScaler / (RIPowerScaler + RIPowerScalerDiminishingLimit);
    if (RIPowerScaler > 15.f)
        RIPowerScaler = 15.f;
    if (RIPowerScaler <= 0.0f)
        RIPowerScaler = 0.01f;
    return RIPowerScaler;
}

bool RI_ItemStore::ReRollStat(RI_StatStore *riss, RI_PlayerStore *rip, PossibleRandomStatRolls *RI_PickableStats, int MaxStatCount, bool UsePlayerRollChanceMods, float RIPowerScaler)
{
    if (RI_PickableStats == NULL)
    {
        RI_PickableStats = GetPickableStatStore();
        MaxStatCount = RI_MAX_STAT_TYPES;
        UsePlayerRollChanceMods = true;
    }
    bool DeleteOnFail = false;
    if (riss == NULL)
    {
        riss = new RI_StatStore();
        DeleteOnFail = true;
    }

    //roll stat type
    riss->RollStatType(RI_PickableStats, rip, MaxStatCount, UsePlayerRollChanceMods);
    //if unable to roll for it. Abandon generation
    if (riss->Type == RI_STAT_TYPE_NOT_USED)
    {
        if(DeleteOnFail)
            delete riss;
        return false;
    }

    //if power is too small to consider, ignore this stat
    if (riss->RollStatPower(RIPowerScaler) == false)
        return false;

    //do we have this stat already ? If so, just add the power to it
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
    {
        //already in the list. This is a reroll
        if ((*itr) == riss)
            return true;
        //not a reroll and same type ? Merge
        if ((*itr)->Type == riss->Type)
        {
            (*itr)->Power += riss->Power;
            if (DeleteOnFail)
                delete riss;
            riss->Type = RI_STAT_TYPE_NOT_USED;
            return true;
        }
    }

    //store it for the item
    ItemExtraStats.push_front(riss);

    return true;
}

bool GetPlayerSpecificStatList(PossibleRandomStatRolls **RI_PickableStats_out, int &MaxStatCount, int PlayerClass, RI_PlayerStore *rip)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStoreClassOnly(PlayerClass, MaxStatCount);

    //roll chance mods can eliminate so many stats, we might end up not rolling for almost anything. Item might turn out to be empty
    PossibleRandomStatRolls *RI_PickableStats2 = NULL;
    int NegativeRollChance = rip->GetSacrificeCount();
    if (NegativeRollChance >= 10)
    {
        RI_PickableStats2 = new PossibleRandomStatRolls[RI_MAX_STAT_TYPES];
        int StatsCopied = 0;
        for (int i = 1; i < MaxStatCount; i++)
        {
            int RollChanceMod = rip->GetStatRollChance(RI_PickableStats[i].StatIndex);
            if (RI_PickableStats[i].RollChance + RollChanceMod <= 0)
                continue;
            memcpy(&RI_PickableStats2[StatsCopied], &RI_PickableStats[i], sizeof(PossibleRandomStatRolls));
            RI_PickableStats2[StatsCopied].RollChance += RollChanceMod;
            StatsCopied++;
        }
        MaxStatCount = StatsCopied;
        RI_PickableStats = RI_PickableStats2;
    }
    *RI_PickableStats_out = RI_PickableStats;
    return RI_PickableStats == RI_PickableStats2;
}

void RI_ItemStore::GenerateRandomStats(const Item *BaseItem, int Difficulty, int MagicFind, int MagicStrength, int PlayerClass, RI_PlayerStore *rip)
{
    if (Difficulty < 0)
        Difficulty = 0;
    if (MagicFind < 0)
        MagicFind = 0;
    int ClassFilterMask = 1 << PlayerClass;
    if (BaseItem != NULL)
    {
        //only randomize items that can be equipped
        if (BaseItem->GetTemplate()->InventoryType == INVTYPE_NON_EQUIP)
            return;
        //do not randomize stackable items
        if (BaseItem->GetTemplate()->Stackable != 0 && BaseItem->GetTemplate()->Stackable != 1)
            return;
        if (BaseItem->GetTemplate()->ContainerSlots > 0)
            return;
    }
    float RIPowerScaler = GetRollPowerScaler( BaseItem, Difficulty, MagicStrength );//[0-10]

    int RICountScaler = (int)((1 + MagicFind + Difficulty) / 100);
    if (RICountScaler < 1)
        return;
    if (RICountScaler > MAX_RANDOMIZER_COUNT)
        RICountScaler = MAX_RANDOMIZER_COUNT;

    //make sure we do not keep extending the stat list
    if (HasEffectsApplied)
        ApplyEffects(Owner->GetOwner(), Owner, false);
    ItemExtraStats.clear();

    int MaxStatCount = RI_MAX_STAT_TYPES;
    PossibleRandomStatRolls *RI_PickableStats;
    bool DeleteList = GetPlayerSpecificStatList(&RI_PickableStats, MaxStatCount, PlayerClass, rip);

    if (MaxStatCount <= 0)
        return;

    for (; RICountScaler > 0; RICountScaler--)
        ReRollStat(NULL, rip, RI_PickableStats, MaxStatCount, DeleteList == false, RIPowerScaler);

    if (DeleteList == true)
        delete RI_PickableStats;

    //make sure we save the new stats to DB
    LoadedFromDatabase = 0;
}

bool RI_ItemStore::SkipSave()
{
    if (Owner->GetOwner() == NULL)
        return true;
    if(LoadedFromDatabase != 0 && Owner->GetOwner()->GetGUID() == LoadedForPlayer)
        return true;
    return false;
};

void RI_ItemStore::SaveToDB()
{
    // if it got loaded from DB, it was not traded... no point of saving again
    if (SkipSave())
        return;
    // this is a normal item, no need to save it again
    if (ItemExtraStats.empty() == true)
        return;
    //did the owner change ? Update owner
    if (LoadedFromDatabase != 0 && Owner->GetOwner()->GetGUID() != LoadedForPlayer)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "update character_item_randomizations set PlayerGUID=%u where PlayerGUID=%u and ItemGUID=%u", Owner->GetOwner()->GetGUID().GetCounter(), LoadedForPlayer.GetCounter(), Owner->GetGUID().GetCounter());
        CharacterDatabase.Execute(Query);
        LoadedForPlayer = Owner->GetOwner()->GetGUID();
    }
    if (LoadedFromDatabase == 0)
    {
        //only save it once
        LoadedFromDatabase = 1;
        char Query[5000];
        int BytesWritten = 0;
        BytesWritten += sprintf_s(Query, sizeof(Query), "replace into character_item_randomizations values(%u,%u", Owner->GetOwner()->GetGUID().GetCounter(), Owner->GetGUID().GetCounter());
        //now write all the possible randomizations
        int ColumnsUsed = 0;
        for (std::list<RI_StatStore*>::reverse_iterator itr = ItemExtraStats.rbegin(); itr != ItemExtraStats.rend(); itr++)
        {
            BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, ",%d,%.02f", (*itr)->Type, (*itr)->Power);
            ColumnsUsed++;
        }
        for(int i= ColumnsUsed;i< MAX_RANDOMIZER_COUNT;i++)
            BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, ",'0','0'");
        BytesWritten += sprintf_s(Query + BytesWritten, sizeof(Query) - BytesWritten, ")");

        CharacterDatabase.Execute(Query);
    }
}

void RI_ItemStore::DeleteFromDB()
{
    //maybe we just sold this item. It can still be bought back, but we no longer need stats for it
    ItemExtraStats.clear();
    //no need to delete it if it was never saved to the DB
    if (LoadedFromDatabase == 0)
        return;
    //build query and delete
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "delete from character_item_randomizations where PlayerGUID=%u and ItemGUID=%u", LoadedForPlayer.GetCounter(), Owner->GetGUID().GetCounter());
    CharacterDatabase.Execute(Query);
}

void RI_ItemStore::ApplyEffects(Player *p, Item *it, bool Apply)
{
    //avoid adding or removing effects more than once
    if (HasEffectsApplied == (char)Apply)
        return;
    HasEffectsApplied = Apply;

    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    //iterate through every randomizer and call it's apply function
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
    {
        RIStatTypes s = (*itr)->Type;
        //no idea how to apply this randomizations. No script has been defined for it
        if (RI_PickableStats[s].ApplyScript == NULL)
            continue;
        //run the apply script
        RI_PickableStats[s].ApplyScript(Apply, p, (*itr));
    }
}

int RI_ItemStore::GetDestroyDustAmount()
{
    float ret = 0;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
    {
        if ((*itr)->Type >= RI_MAX_STAT_TYPES)
            continue; // should never happen
        if (RI_PickableStats[(*itr)->Type].FixedValue != 0)
            ret += 1;
        else
            ret += abs((*itr)->Power / RI_PickableStats[(*itr)->Type].MaxValAt100);
    }

    return (int)(ret + 0.999f);
}

float RI_ItemStore::GetRollStrength(int RGB1, int RGB2)
{
    float ret = 0;
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
    {
        if ((*itr)->Type >= RI_MAX_STAT_TYPES)
            continue; // should never happen
        if (RI_PickableStats[(*itr)->Type].RGB != RGB1 && RI_PickableStats[(*itr)->Type].RGB != RGB2)
            continue;
        ret += (*itr)->Power / RI_PickableStats[(*itr)->Type].MaxValAt100;
    }

    //round to 2 decimals
    ret = ((int)(ret * 10.f) / 10.f);
    return ret;
}

float RI_ItemStore::GetStatSum(int Type)
{
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
    {
        if ((*itr)->Type != Type)
            continue;
        if (RI_PickableStats[(*itr)->Type].FixedValue != 0)
            return 1.0f;
        return (*itr)->Power;
    }
    return 0.0f;
}

void RI_ItemStore::MarkClientIsUpdated(bool Updated)
{
    if (Updated == true)
    {
        uint16 Pos = Owner->GetPos();
        LastUpdatedClientSlot = Pos;
    }
    else
        LastUpdatedClientSlot = 0xFFFF;
}

void RI_ItemStore::PushClientAddonUpdate(Player *SendToPlayer)
{
    uint16 Pos = Owner->GetPos();
    // do not spam updates
    if (LastUpdatedClientSlot == Pos)
        return;
    // inspected items are not cached !
    if(SendToPlayer == NULL)
        MarkClientIsUpdated();
    uint8 BagPos = Pos >> 8;
    uint8 ItemPos = Pos & 0xFF;
    int InventoryPos = -1;
    int BagId = -1;
    int BagSlot = -1;
    if (BagPos == INVENTORY_SLOT_BAG_0 && ItemPos < EQUIPMENT_SLOT_END)
        InventoryPos = ItemPos;
    else if (BagPos == INVENTORY_SLOT_BAG_0 && InventoryPos < INVENTORY_SLOT_ITEM_END)
    {
        BagId = 0;
        BagSlot = ItemPos - INVENTORY_SLOT_ITEM_START + 1;
    }
    else
    {
        BagId = BagPos - INVENTORY_SLOT_BAG_START + 1;
        BagSlot = ItemPos + 1;
    }
    char RIUPD[250];
    sprintf_s(RIUPD, sizeof(RIUPD), "%d %d %d -1 %d", InventoryPos, BagId, BagSlot, Owner->GetEntry());
    FormatQueryResponse(NULL, NULL, 0, RIUPD);
    if (SendToPlayer == NULL)
        SendToPlayer = Owner->GetOwner();
    AddonComm::SendMessageToClient(SendToPlayer, "RIPU", RIUPD);
}

void RI_ItemSaved(void *p, void *)
{
    CP_ITEM_SAVED *params = PointerCast(CP_ITEM_SAVED, p);
    //sanity checks
    if (params->ItemObject == NULL)
        return;
    //is the item randomized ?
    RI_ItemStore *rii = params->ItemObject->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii == NULL)
        return;
    //save to DB
    rii->SaveToDB();
}

void RI_ItemDeleted(void *p, void *)
{
    CP_ITEM_SAVED *params = PointerCast(CP_ITEM_SAVED, p);
    //sanity checks
    if (params->ItemObject == NULL)
        return;
    //is the item randomized ?
    RI_ItemStore *rii = params->ItemObject->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii == NULL)
        return;
    //delete it from DB
    //rii->DeleteFromDB();
    //SUICIDE
    params->ItemObject->DeleteExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    rii = NULL;
}

void RI_ApplyRandomStatsOnItemChange(void *p, void *)
{
    CP_ITEM_EQUIPPED *params = PointerCast(CP_ITEM_EQUIPPED, p);
    //sanity checks. Should never happen
    if (params->Owner == NULL || params->ItemObject == NULL)
        return;
    // is this item randomized at all ?
    RI_ItemStore *rii = params->ItemObject->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii == NULL)
        return;
    // apply randomizations
    rii->ApplyEffects(params->Owner,params->ItemObject,params->Apply);
}

bool RI_ItemStore::ReRollStatTypeAtIndex(int pIndex)
{
    int Index = 0;
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
    {
        if (Index == pIndex)
        {
            RI_StatStore *ss = *itr;
            Player *p = Owner->GetOwner();
            RI_PlayerStore *rip = GetPlayerRIStore(p);
            float RIPowerScaler = GetRollPowerScaler(Owner, 0, rip->GetMagicFindStrengthOutOfInstance());
            int MaxStatCount = RI_MAX_STAT_TYPES;
            PossibleRandomStatRolls *RI_PickableStats;
            bool DeleteList = GetPlayerSpecificStatList(&RI_PickableStats, MaxStatCount, p->getClass(), rip);

            bool ManagedToRoll = ReRollStat(ss, rip, RI_PickableStats, MaxStatCount, DeleteList == false, RIPowerScaler);

            if (ss->Type == RI_STAT_TYPE_NOT_USED) //if stat got merged into another one
            {
                ItemExtraStats.remove(*itr);
                delete ss;
                ss = NULL;
            }
            else if (ManagedToRoll == false)
            {
                PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
                ss->Power = RI_PickableStats[ss->Type].MinValue;
            }

            if (DeleteList == true)
            {
                delete RI_PickableStats;
                RI_PickableStats = NULL;
            }


            LoadedFromDatabase = 0;
            SaveToDB();
            MarkClientIsUpdated(false);
            PushClientAddonUpdate(Owner->GetOwner());
            return true;
        }
        Index++; // cause right now stats are shown in reverse order client side
    }
    return false;
}

bool RI_ItemStore::ReRollStatValueAtIndex(int pIndex)
{
    int Index = 0;
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
    {
        if (Index == pIndex)
        {
            RI_StatStore *ss = *itr;
            Player *p = Owner->GetOwner();
            RI_PlayerStore *rip = GetPlayerRIStore(p);
            float RIPowerScaler = GetRollPowerScaler(Owner, 0, rip->GetMagicFindStrengthOutOfInstance());
            ss->RollStatPower(RIPowerScaler);
            LoadedFromDatabase = 0;
            SaveToDB();
            MarkClientIsUpdated(false);
            PushClientAddonUpdate(Owner->GetOwner());
            return true;
        }
        Index++; // cause right now stats are shown in reverse order client side
    }
    return false;
}

bool RI_RerollStatTypeAtIndex(Player *p, Item *i, int Index)
{
    RI_ItemStore *rii = i->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii == NULL)
        return false;
    std::list<RI_StatStore*> *stats = rii->GetStats();
    if (stats == NULL || stats->size() <= Index)
        return false;
    return rii->ReRollStatTypeAtIndex(Index);
}

bool RI_RerollStatValueAtIndex(Player *p, Item *i, int Index)
{
    RI_ItemStore *rii = i->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii == NULL)
        return false;
    std::list<RI_StatStore*> *stats = rii->GetStats();
    if (stats == NULL || stats->size() <= Index)
        return false;
    return rii->ReRollStatValueAtIndex(Index);
}

void RI_ItemStore::OnPlayerRevive()
{
    // sanity checks
    if (Owner->IsEquipped() == false)
        return;
    //reapply stats that give you buffs
    PossibleRandomStatRolls *RI_PickableStats = GetPickableStatStore();
    for (std::list<RI_StatStore*>::iterator itr = ItemExtraStats.begin(); itr != ItemExtraStats.end(); itr++)
    {
        if (RI_PickableStats[(*itr)->Type].ApplyScript != RI_AS_GainPassiveBuff)
            continue;
        RI_PickableStats[(*itr)->Type].ApplyScript(true, Owner->GetOwner(), (*itr));
    }
}
