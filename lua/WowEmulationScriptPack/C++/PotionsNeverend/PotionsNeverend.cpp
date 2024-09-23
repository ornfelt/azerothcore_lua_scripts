#include "ScriptMgr.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "DatabaseEnv.h"
#include "Player.h"
#include "Item.h"

class PotionsNeverEndStore
{
public:
    void LoadPlayerData(Player *player)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "SELECT ItemId from character_PotionsNeverEnd where GUID = %d", (uint32)player->GetGUID().GetRawValue());
        QueryResult result = CharacterDatabase.Query(Query);
        if (!result || result->GetRowCount() == 0)
            return;
        //fetch all rows
        do
        {
            Field* fields = result->Fetch();
            ItemEntries.insert( fields[0].GetUInt32());
        } while (result->NextRow());

    }
    bool HasEntries()
    {
        return !ItemEntries.empty();
    }
    bool IsItemNeverEnding(uint32 Entry)
    {
        //in case we want to have a list of items that are consumable, treat them here
        return ItemEntries.find(Entry) != ItemEntries.end();
    }
private:
    std::set<uint32> ItemEntries;
};

void PNEOnPlayerUseItem(void *p, void *)
{
    CP_ITEM_USE_DENY *params = PointerCast(CP_ITEM_USE_DENY, p);
    if (params->Owner == NULL)
        return;
    //can we deny stack consume ?
    PotionsNeverEndStore *PNE = params->Owner->GetExtension<PotionsNeverEndStore>(OE_PLAYER_POTIONS_NEVER_END_STORE);
    if (PNE == NULL || PNE->IsItemNeverEnding(params->item->GetTemplate()->ItemId) == false)
        return;
    //deny using a stack of this item
    params->DenyDefaultParsing = 1;
}

class TC_GAME_API PotionsNeverEndRegisterScript : public PlayerScript
{
public:
    PotionsNeverEndRegisterScript() : PlayerScript("PotionsNeverEndRegisterScript") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        PotionsNeverEndStore *PNE = player->GetCreateExtension<PotionsNeverEndStore>(OE_PLAYER_POTIONS_NEVER_END_STORE);
        PNE->LoadPlayerData(player);
        if (PNE->HasEntries() == false)
        {
            player->DeleteExtension<PotionsNeverEndStore>(OE_PLAYER_POTIONS_NEVER_END_STORE);
            return;
        }
        player->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_ITEM_CONSUME, PNEOnPlayerUseItem);
    }
    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_PotionsNeverEnd where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void AddPotionsNeverendScripts()
{
    /*
    CREATE TABLE IF NOT EXISTS `character_PotionsNeverEnd` (
    `GUID` int(11) NOT NULL,
    `ItemId` int(11) DEFAULT NULL,
    UNIQUE KEY `relation` (`GUID`),
    KEY `RowUniqueId` (`GUID`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
    */
    new PotionsNeverEndRegisterScript();
}
