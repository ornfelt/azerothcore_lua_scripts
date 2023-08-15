#include "Item.h"
#include "Player.h"
#include "RI_ItemStore.h"
#include "ObjectExtension.cpp"
#include "RI_PlayerStore.h"
#include "Random.h"
#include "ObjectMgr.h"

#define MAX_CUBE_ITEMS 9
#ifndef MAX
    #define MAX(a,b) (a)>(b)?(a):(b)
#endif

int ConvertClientBagToServerBagIndex(int BagIndex)
{
    if (BagIndex == 0)
        return INVENTORY_SLOT_BAG_0;
    if (BagIndex <= INVENTORY_SLOT_BAG_END - INVENTORY_SLOT_BAG_START)
        return INVENTORY_SLOT_BAG_START + BagIndex - 1;
    return INVENTORY_SLOT_BAG_0;
}

int ConvertClientBagSlotToServerBagSlotIndex(int BagIndex, int BagSlotIndex)
{
    if (BagIndex == 0 || BagIndex == INVENTORY_SLOT_BAG_0)
        return INVENTORY_SLOT_ITEM_START + BagSlotIndex;
    return BagSlotIndex;
}

void RemoveCubeItems(Player *p, Item **CubeItems, int *CubeBagIndexes, int *CubeBagSlotIndexes, int CubeItemsCount)
{
    uint32 CubeEntries[MAX_CUBE_ITEMS];
    for (int i = 0; i < CubeItemsCount; i++)
        CubeEntries[i] = CubeItems[i]->GetEntry();
    for (int i = 0; i < CubeItemsCount; i++)
    {
        Item *it = p->GetItemByPos(CubeBagIndexes[i], CubeBagSlotIndexes[i]);
        if (it == NULL)
        {
            p->DestroyItemCount(CubeEntries[i], 1, true);
            continue;
        }
        if (it->GetCount() <= 1)
            p->DestroyItem(CubeBagIndexes[i], CubeBagSlotIndexes[i], true);
        else
            p->DestroyItemCount(CubeItems[i]->GetEntry(), 1, true);
    }
}

bool CheckRecipe_DoubleDust(Item **CubeItems, int CubeItemsCount)
{
    //if 2 items contain the same stat list
    if (CubeItemsCount != 2)
        return false;

    //are the items randomized ?
    RI_ItemStore *rii1 = CubeItems[0]->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii1 == NULL)
        return false;
    RI_ItemStore *rii2 = CubeItems[1]->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
    if (rii2 == NULL)
        return false;

    //compare the list of stats
    std::list<RI_StatStore*> *stats1 = rii1->GetStats();
    std::list<RI_StatStore*> *stats2 = rii2->GetStats();
    //we want the same list of stats
    if (stats1 == NULL || stats2 == NULL || stats1->size() != stats2->size())
        return false;
    for (auto i1 = stats1->begin(); i1 != stats1->end(); i1++)
    {
        bool FoundIt = false;
        for (auto i2 = stats2->begin(); i2 != stats2->end(); i2++)
            if ((*i2)->Type == (*i1)->Type)
            {
                FoundIt = true;
                break;
            }
        //the list of the stats is not the same
        if (FoundIt == false)
            return false;
    }

    return false;
}

bool Apply_DoubleDust(Item **CubeItems, int CubeItemsCount, Player *p, int *CubeBagIndexes, int *CubeBagSlotIndexes)
{
    if (CheckRecipe_DoubleDust(CubeItems, CubeItemsCount) == true)
    {
        //get dust value of items
        int Dust1 = CubeItems[0]->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS)->GetDestroyDustAmount();
        int Dust2 = CubeItems[1]->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS)->GetDestroyDustAmount();
        int DustToAdd = MAX(Dust1, Dust2) * 2;
        RI_PlayerStore *ri = GetPlayerRIStore(p);
        ri->AddDust(DustToAdd);
        //destroy the used items
        RemoveCubeItems(p, CubeItems, CubeBagIndexes, CubeBagSlotIndexes, CubeItemsCount);
        return true;
    }
    return false;
}

bool CheckRecipe_StatsReroll(Item **CubeItems, int CubeItemsCount)
{
    //if 3 items of same entry -> create new items with random rolls based on out of instance MF
    if (CubeItemsCount != 3)
        return false;

    //are the items randomized ?
    for(int i=0;i<3;i++)
        if( CubeItems[i]->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS) == NULL )
            return false;

    if (CubeItems[0]->GetEntry() == CubeItems[1]->GetEntry() && CubeItems[1]->GetEntry() == CubeItems[2]->GetEntry())
        return true;

    return false;
}

bool Apply_StatsReroll(Item **CubeItems, int CubeItemsCount, Player *p, int *CubeBagIndexes, int *CubeBagSlotIndexes)
{
    if (CheckRecipe_StatsReroll(CubeItems, CubeItemsCount) == true)
    {
        uint32 Entry = CubeItems[0]->GetEntry();
        ItemPosCountVec sDest;
        // store in main bag to simplify second pass (special bags can be not equipped yet at this moment)
        InventoryResult msg = p->CanStoreNewItem(INVENTORY_SLOT_BAG_0, NULL_SLOT, sDest, Entry, 1);
        if (msg == EQUIP_ERR_OK)
        {
            Item *NewItem = p->StoreNewItem(sDest, Entry, true, 0);
            if (NewItem != NULL)
            {
                RI_RollOutOfInstanceStats(p, NewItem);
                RemoveCubeItems(p, CubeItems, CubeBagIndexes, CubeBagSlotIndexes, CubeItemsCount);
            }
        }
        return true;
    }
    return false;
}

static const uint32 RequiredItemsStatReroll[30][6] = { { 17967,43562,34645,39527,42171,44996 },
{23854,43563,34647,41804,44852,44997 },
{20819,44852,34735,41811,44988,54469 },
{20822,5105,36914,42170,44989,1222 },
{20825,5330,37089,39527,44991,3168 },
{20829,5333,37090,41804,44992,5362 },
{20952,6216,37100,41811,44993,5364 },
{20953,6374,37161,42170,5364,5367 },
{20957,7681,37837,39527,42171,44996 },
{20962,8426,38270,41804,44852,44997 },
{20965,9443,38272,41811,44988,54469 },
{21772,17024,38625,42170,44989,1222 },
{21773,17195,39506,39527,44991,3168 },
{36915,19882,39526,41804,44992,5362 },
{43557,19911,34645,41811,44993,5364 },
{43558,43562,34647,42170,5364,5367 },
{43559,43563,34735,39527,42171,44996 },
{43560,44852,36914,41804,44852,44997 },
{43561,5105,37089,41811,44988,54469 },
{17967,5330,37090,42170,44989,1222 },
{23854,5333,37100,39527,44991,3168 },
{20819,6216,37161,41804,44992,5362 },
{20822,6374,37837,41811,44993,5364 },
{20825,7681,38270,42170,5364,5367 },
{20829,8426,38272,39527,42171,44996 },
{20952,9443,38625,41804,44852,44997 },
{20953,17024,39506,41811,44988,54469 },
{20957,17195,39526,42170,44989,1222 },
{20962,19882,34645,39527,44991,3168 },
{20965,19911,34647,41804,44992,5362 } };

int GetRecipeIndex(Item **CubeItems, int CubeItemsCount, Player *p, int *CubeBagIndexes, int *CubeBagSlotIndexes)
{
    int FoundRecipe = -1;
    for (int i = 0; i < 30; i++)
    {
        int MatchesFound = 0;
        for (int j = 0; j < 6; j++)
        {
            uint32 NeedEntry = RequiredItemsStatReroll[i][j];
            for (int ci = 0; ci < CubeItemsCount; ci++)
                if (CubeItems[ci]->GetEntry() == NeedEntry)
                {
                    MatchesFound++;
                    break;
                }
        }
        if (MatchesFound == 6)
        {
            FoundRecipe = i;
            break;
        }
    }
    return FoundRecipe;
}

bool IsRecipeItem(uint32 Recipe, uint32 Entry)
{
    for (int i = 0; i < 6; i++)
        if (RequiredItemsStatReroll[Recipe][i] == Entry)
            return true;
    return false;
}

bool Apply_StatTypeOrPowerReroll(Item **CubeItems, int CubeItemsCount, Player *p, int *CubeBagIndexes, int *CubeBagSlotIndexes)
{
    if (CubeItemsCount != 7)
        return false;
    //check if we have the recipe for any of the combinations
    int FoundRecipe = GetRecipeIndex(CubeItems, CubeItemsCount, p, CubeBagIndexes, CubeBagSlotIndexes);
    if (FoundRecipe == -1)
        return false;
    //find the non recepie Item
    bool ReRollResult;
    int ItemPos = -1;
    for (int ci = 0; ci < CubeItemsCount; ci++)
    {
        if (IsRecipeItem(FoundRecipe, CubeItems[ci]->GetEntry()) == true)
            continue;
        RI_ItemStore *rii = CubeItems[ci]->GetExtension<RI_ItemStore>(OE_ITEM_EXTENDED_STATS);
        if (rii == NULL)
            continue;
        if (rii->GetStats()->empty())
            continue;
        ItemPos = ci;
        if(FoundRecipe < 15)
            ReRollResult = RI_RerollStatTypeAtIndex(p, CubeItems[ci], FoundRecipe);
        else
            ReRollResult = RI_RerollStatValueAtIndex(p, CubeItems[ci], FoundRecipe - 15);
        break;
    }
    if (ReRollResult == false)
        return false;

    //remove reagents from Player
    for (int i = 0; i < 6; i++)
        p->DestroyItemCount(RequiredItemsStatReroll[FoundRecipe][i], 1, true);
    return true;
}

bool Apply_CreateRandomItemForTest(Item **CubeItems, int CubeItemsCount, Player *p, int *CubeBagIndexes, int *CubeBagSlotIndexes)
{
    if (CubeItemsCount != 2)
        return false;
    if (CubeItems[0]->GetEntry() != CubeItems[1]->GetEntry())
        return false;
    //search for a new entry
    uint32 Entry;
    for (int i = 0; i < 1000; i++)
    {
        Entry = rand32() % 20000;
        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(Entry);
        if (proto != NULL && proto->Quality < ITEM_QUALITY_EPIC)
            break;
    }
    ItemPosCountVec sDest;
    // store in main bag to simplify second pass (special bags can be not equipped yet at this moment)
    InventoryResult msg = p->CanStoreNewItem(INVENTORY_SLOT_BAG_0, NULL_SLOT, sDest, Entry, 1);
    if (msg == EQUIP_ERR_OK)
    {
        Item *NewItem = p->StoreNewItem(sDest, Entry, true, 0);
        if (NewItem != NULL)
        {
            RI_RollOutOfInstanceStats(p, NewItem);
            RemoveCubeItems(p, CubeItems, CubeBagIndexes, CubeBagSlotIndexes, CubeItemsCount);
            return true;
        }
    }
    return false;
}

void ParseCubeMessage(Player *p, const char *ClientMessage)
{
    Item *CubeItems[MAX_CUBE_ITEMS];
    int CubeBagIndexes[MAX_CUBE_ITEMS];
    int CubeBagSlotIndexes[MAX_CUBE_ITEMS];
    memset(CubeItems, 0, sizeof(CubeItems));
    int CubeItemsCount = 0;
    //expected message is : A b1 s1 b2 s2 b3 s3
    if (ClientMessage[0] != '0' && ClientMessage[1] != ' ')
        return;
    int MessageParsedStart = 2;
    int MessageLength = (int)strlen(ClientMessage);
    int ValuesRead = 1;
    while (MessageParsedStart < MessageLength && ValuesRead > 0 && CubeItemsCount < MAX_CUBE_ITEMS)
    {
        int BagIndex = 0;
        int BadSlotIndex = 0;
        ValuesRead = sscanf(ClientMessage + MessageParsedStart, "%d %d", &BagIndex, &BadSlotIndex);
        //seek to the next value
        while (ClientMessage[MessageParsedStart] != ' ' && ClientMessage[MessageParsedStart] != 0)
            MessageParsedStart++;
        if (ClientMessage[MessageParsedStart] != 0)
            MessageParsedStart++;
        while (ClientMessage[MessageParsedStart] != ' ' && ClientMessage[MessageParsedStart] != 0)
            MessageParsedStart++;
        if (ClientMessage[MessageParsedStart] != 0)
            MessageParsedStart++;
        if (ValuesRead == 2)
        {
            BadSlotIndex = ConvertClientBagSlotToServerBagSlotIndex(BagIndex,BadSlotIndex);
            BagIndex = ConvertClientBagToServerBagIndex(BagIndex);
            Item *it = p->GetItemByPos(BagIndex, BadSlotIndex);
            if (it == NULL)
                continue;
            bool AlreadyUsed = false;
            for (int ci = 0; ci < CubeItemsCount; ci++)
                if (CubeItems[ci] == it)
                    AlreadyUsed = true;
            if (AlreadyUsed == true)
                continue;

            //check if this item is already in the cube list
            CubeBagIndexes[CubeItemsCount] = BagIndex;
            CubeBagSlotIndexes[CubeItemsCount] = BadSlotIndex;
            CubeItems[CubeItemsCount] = it;
            CubeItemsCount++;
        }
    }

    //check if our cube contains any items at all
    if (CubeItemsCount == 0)
        return;

    //long list of recipe handlers
    if (Apply_DoubleDust(CubeItems, CubeItemsCount, p, CubeBagIndexes, CubeBagSlotIndexes))
        return;

    if (Apply_StatsReroll(CubeItems, CubeItemsCount, p, CubeBagIndexes, CubeBagSlotIndexes))
        return;

    if (Apply_StatTypeOrPowerReroll(CubeItems, CubeItemsCount, p, CubeBagIndexes, CubeBagSlotIndexes))
        return;

//    if (Apply_CreateRandomItemForTest(CubeItems, CubeItemsCount, p, CubeBagIndexes, CubeBagSlotIndexes))
//        return;
}
