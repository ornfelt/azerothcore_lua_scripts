#include "Player.h""
#include "Item.h"
#include "ObjectMgr.h"
#include "DatabaseEnv.h"
#include "ScriptMgr.h"
#include "ObjectExtension.cpp"

class ItemConsumeStore
{
public:
    ItemConsumeStore()
    {
        LastShownEntryInHelp = 0;
    }
    void Load(Player *p)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "SELECT Entry FROM character_ItemsUsed where GUID=%d", (uint32)p->GetGUID().GetRawValue());
        QueryResult result = CharacterDatabase.Query(Query);
        if (result && result->GetRowCount() > 0)
        {
            do {
                Field* fields = result->Fetch();
                uint32 ItemEntry = fields[0].GetUInt32();
                ItemsUsed.insert(ItemEntry);
            } while (result->NextRow());
        }
        size_t UnqiueUseCount = ItemsUsed.size();
        *p->GetCreateIn64Extension(OE_PLAYER_CONSUME_ITEM_UNIQUE_COUNT, false, UnqiueUseCount) = UnqiueUseCount;
    }
    void OnPlayerUseItem(Player *p, unsigned int Entry)
    {
        //first time use ? Load it from DB
        if (ItemsUsed.empty())
            Load(p);
        //search in our store
        std::set<uint32>::iterator i = ItemsUsed.find(Entry);
        if (i == ItemsUsed.end())
        {
            ItemsUsed.insert(Entry);
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "Insert into character_ItemsUsed values (%d,%d)", (uint32)p->GetGUID().GetRawValue(), Entry);
            QueryResult result = CharacterDatabase.Query(Query);

            int64 *UniqueUses = p->GetCreateIn64Extension(OE_PLAYER_CONSUME_ITEM_UNIQUE_COUNT);
            *UniqueUses = *UniqueUses + 1;
        }
    }
    void SuggestNextItems(Player *p)
    {
        //first time use ? Load it from DB
        if (ItemsUsed.empty())
            Load(p);
        uint32 AbortAfterXLines = 10;
        ItemTemplateContainer const& its = sObjectMgr->GetItemTemplateStore();
        for (auto const& itemTemplatePair : its)
        {
            if (LastShownEntryInHelp > itemTemplatePair.second.ItemId)
                continue;
            if (itemTemplatePair.second.Spells[0].SpellId <= 0)
                continue;
            if (itemTemplatePair.second.Spells[0].SpellTrigger != ITEM_SPELLTRIGGER_ON_USE && itemTemplatePair.second.Spells[0].SpellTrigger != ITEM_SPELLTRIGGER_ON_NO_DELAY_USE)
                continue;
            std::set<uint32>::iterator i = ItemsUsed.find(itemTemplatePair.second.ItemId);
            if (i != ItemsUsed.end())
                continue;
            p->BroadcastMessage("ItemUse hunt suggestion : |cff1eff00|Hitem:%d:0:0:0:0:0:0:0:114|h[%s]|h|r", itemTemplatePair.second.ItemId, itemTemplatePair.second.Name1.c_str());
            LastShownEntryInHelp = itemTemplatePair.second.ItemId;
            AbortAfterXLines--;
            if (AbortAfterXLines == 0)
                break;
        }
    }
private:
    std::set<uint32> ItemsUsed;
    uint32           LastShownEntryInHelp;
};

void ICSOnPlayerUseItem(void *p, void *)
{
    CP_ITEM_USE_DENY *params = PointerCast(CP_ITEM_USE_DENY, p);
    if (params->Owner == NULL)
        return;
    //can we deny stack consume ?
    ItemConsumeStore *ICS = params->Owner->GetCreateExtension<ItemConsumeStore>(OE_PLAYER_CONSUME_ITEM_STORE);
    ICS->OnPlayerUseItem(params->Owner, params->item->GetEntry());
}

class TC_GAME_API ConsumeItemScoreRegisterScript : public PlayerScript
{
public:
    ConsumeItemScoreRegisterScript() : PlayerScript("ConsumeItemScoreRegisterScript") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        ItemConsumeStore *ICS = player->GetCreateExtension<ItemConsumeStore>(OE_PLAYER_CONSUME_ITEM_STORE);
        ICS->Load(player);
        player->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_ITEM_CONSUME, ICSOnPlayerUseItem);
    }
    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_ItemsUsed where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);
void ICSParseClientUserCommand(Player* player, uint32 type, const char *cmsg)
{
    //        printf("got command %s\n",cmsg);
    if (CheckValidClientCommand(cmsg, type, NULL) == false)
        return;
    //do we want to set the difficulty ?
    if (strstr(cmsg, "#csSuggestUseItem") == cmsg)
    {
        ItemConsumeStore *ICS = player->GetCreateExtension<ItemConsumeStore>(OE_PLAYER_CONSUME_ITEM_STORE);
        ICS->SuggestNextItems(player);
    }
}

void ICSOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    ICSParseClientUserCommand(params->SenderPlayer, params->MsgType, params->Msg->c_str());
}

void AddUniqueItemUseScoreScripts()
{
    /*
    CREATE TABLE `character_ItemsUsed` (
    `GUID` INT NULL,
    `Entry` INT NULL,
    INDEX `Index1` (`GUID`),
    UNIQUE KEY `relation` (`GUID`,`Entry`),
    KEY `RowId` (`GUID`) USING BTREE
    )ENGINE=InnoDB;
    */

    new ConsumeItemScoreRegisterScript();
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, ICSOnChatMessageReceived, NULL);
}
