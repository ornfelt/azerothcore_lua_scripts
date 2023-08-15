#include "SharedDefines.h"
#include "ScriptMgr.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "Player.h"
#include "DatabaseEnv.h"
#include "Creature.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "worldSession.h"
#include <string.h>
#include "Group.h"
#include "Item.h"

// only IronMan players will have this event handler. We can say to all of them that we do not allow buy items
void IronManHardcoreVendorBuyItem(void *p, void *)
{
    CP_VENDOR_BUY_ITEM *params = PointerCast(CP_VENDOR_BUY_ITEM, p);

    //can use normal vendors
    if (params->Vendor->GetEntry() < 200000)
        return;

    params->DenyDefaultParsing = 1;
    params->Player->BroadcastMessage("Vendor usage is disabled");
}

// only IronMan players will have this event handler. We can say to all of them that we do not allow buy items
void IronManHardcoreMailTakeItem(void *p, void *)
{
    CP_ASK_DISABLED_FEATURE_MAIL *params = PointerCast(CP_ASK_DISABLED_FEATURE_MAIL, p);
    //maybe this is a system mail ?
    if (params->Sender == 0)
        return;
    //allow GM emails ?
    Player* pSender = ObjectAccessor::FindPlayerByLowGUID(params->Sender);
    if (pSender != NULL && ( pSender->IsGameMaster() || params->Player == pSender))
        return;

    params->DenyDefaultParsing = 1;
    params->Player->BroadcastMessage("Mail usage is disabled");
}

// only IronMan players will have this event handler. We can say to all of them that we do not allow buy items
void IronManHardcoreTradeAccept(void *p, void *)
{
    CP_ASK_DISABLED_FEATURE *params = PointerCast(CP_ASK_DISABLED_FEATURE, p);
    params->DenyDefaultParsing = 1;
    params->Player->BroadcastMessage("Trading is disabled");
}

// only IronMan players will have this event handler. We can say to all of them that we do not allow buy items
void IronManHardcoreGuildJoin(void *p, void *)
{
    CP_ASK_DISABLED_FEATURE *params = PointerCast(CP_ASK_DISABLED_FEATURE, p);
    params->DenyDefaultParsing = 1;
    params->Player->BroadcastMessage("Guilding is disabled");
}

// only IronMan players will have this event handler. We can say to all of them that we do not allow buy items
void IronManHardcoreGroupJoin(void *p, void *)
{
    CP_ASK_DISABLED_FEATURE *params = PointerCast(CP_ASK_DISABLED_FEATURE, p);
    params->DenyDefaultParsing = 1;
    params->Player->BroadcastMessage("Grouping is disabled");
}

void PeriodicMonitorPlayerStaysDead(void *p, void *);
class IronManHardcoreStore
{
public:
    //zero all
    IronManHardcoreStore()
    {
        IsIronMan = IsHardcore = NeedsDBSave = false;
        TimesDied = KillerEntry = 0;
    }
    // mark player as IronMan player
    void EnableIronMan(Player *p)
    {
        if (IsIronMan == false)
        {
            IsIronMan = true;
            p->BroadcastMessage("You can never go back to from ironman mode! There is a special place in hell for you");
            p->BroadcastMessage("You no longer can buy items from vendors");
            p->BroadcastMessage("You no longer pick items from mails");
            p->BroadcastMessage("You no longer buy items from auction");
            p->BroadcastMessage("You no longer can join guilds");
            p->BroadcastMessage("You no longer can join groups");
            p->BroadcastMessage("When you die you lose half of your gold");
            NeedsDBSave = true;
            SavePlayerData(p);
            RegisterIronManScripts(p);
        }
    }
    // mark player as Hardcore player
    void EnableHardcore(Player *p)
    {
        //every hardcore player is an ironman player also
        EnableIronMan(p);

        //also add hardcore restrictions
        if (IsHardcore == false)
        {
            IsHardcore = true;
            p->BroadcastMessage("You can never go back to from hardcore mode!");
            p->BroadcastMessage("Once you die, you die forever. Step carefully");
            NeedsDBSave = true;
            SavePlayerData(p);
            RegisterHardcoreScripts(p);
        }
    }
    //register handlers to disable specific game features
    void    RegisterIronManScripts(Player *p)
    {
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_VENDOR_BUY_ITEM, IronManHardcoreVendorBuyItem);
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_TAKE_MAIL_ITEM, IronManHardcoreMailTakeItem);
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_TRADE_ACCEPT, IronManHardcoreTradeAccept);
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_GUILD_JOIN, IronManHardcoreGuildJoin);
    }
    //register handlers to disable specific game features
    void    RegisterHardcoreScripts(Player *p)
    {
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_GROUP_INVITE, IronManHardcoreGroupJoin);
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_GROUP_ACCEPT, IronManHardcoreGroupJoin);
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, PeriodicMonitorPlayerStaysDead);
    }
    //check if we are Hardcore or not
    void LoadPlayerData(Player *p)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "SELECT IsHardCore,TimesDied from character_IronManHardCore where GUID = %d", (uint32)p->GetGUID().GetRawValue());
        QueryResult result = CharacterDatabase.Query(Query);
        if (!result || result->GetRowCount() != 1)
            return;

        Field* fields = result->Fetch();
        IsHardcore = (fields[0].GetUInt32() != 0);
        TimesDied = fields[1].GetUInt32();
        IsIronMan = true;
        RegisterIronManScripts(p);
        if(IsHardcore==true)
            RegisterHardcoreScripts(p);
    }
    //register player as rionman, or mark him dead if is in hardcore mode
    void SavePlayerData(Player *p)
    {
        if (NeedsDBSave == false)
            return;
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "Replace into character_IronManHardCore values(%d,%d,%d,%d)", (uint32)p->GetGUID().GetRawValue(), (uint32)IsHardcore, TimesDied, KillerEntry);
        CharacterDatabase.Execute(Query);
        NeedsDBSave = false;
    }
    void OnDied(Player *p, uint32 pKillerEntry)
    {
        TimesDied++;
        NeedsDBSave = true;
        if (IsHardcore == true)
        {
            KillerEntry = pKillerEntry;
            p->BroadcastMessage("You died forever. May your highscores be remembered forever");
            SavePlayerData(p);
        }
        //death takes it's toll. Half money lost
        p->SetMoney(p->GetMoney() / 2);
    }
    //can delete this store if there is no use of it
    bool IsIronManChar()  { return IsIronMan; }
    bool IsHardcoreChar() { return IsHardcore; }
    bool NoMoreLivesLeft() { return TimesDied > 0; }
private:
    bool    IsIronMan;
    bool    IsHardcore;
    uint32  TimesDied;
    bool    NeedsDBSave;
    uint32  KillerEntry;
};

void PeriodicMonitorPlayerStaysDead(void *p, void *)
{
    Player *player = (Player*)p;
    if (player->isDead())
        return;
    IronManHardcoreStore *HCIM = player->GetExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
    //sanity check, should never happen
    if (HCIM == NULL)
        return;
    //suicide if we are allive
    if (HCIM->NoMoreLivesLeft())
    {
        Unit::Kill(player, player);
        player->BroadcastMessage("All lives have been consumed. There is no more room for you to walk on this earth");
    }
}

bool IsIronManPlayer(Player *p);
bool CheckPlayerCanTurnIronManHardcore(Player *player, int type)
{
    //already is ironman
    if (IsIronManPlayer(player) == true)
        return false;

    //if player is in group, disband
    if (type == 1 && player->GetGroup())
        player->GetGroup()->RemoveMember(player->GetGUID());

    //no bags
    for (int i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; i++)
    {
        Item *it = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it == NULL)
            continue;
        if (it->GetTemplate()->Class == ITEM_CLASS_QUIVER || it->GetTemplate()->Class == ITEM_CLASS_PROJECTILE)
            continue;
        return false;
    }

    //if we have items in inventory, deny
    for (int i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; i++)
    {
        Item *it = player->GetItemByPos(INVENTORY_SLOT_BAG_0, i);
        if (it == NULL)
            continue;
        if (it->GetTemplate()->Class == ITEM_CLASS_QUIVER || it->GetTemplate()->Class == ITEM_CLASS_PROJECTILE)
            continue;
        if (it->GetTemplate()->Quality == ITEM_QUALITY_HEIRLOOM)
            return false;
        if (it->GetTemplate()->RequiredLevel > player->getLevel())
            return false;
    }

    //only new players
    if (player->getLevel() > 1)
        return false;

    //too much time has passed
    if (player->GetTotalPlayedTime() > 60)
        return false;

    // you should not have money on yourself
    if (player->GetMoney() != 0)
        return false;

    return true;
}

void SetIronmanHardcoreMode(Player *player, int type)
{

    if (CheckPlayerCanTurnIronManHardcore(player, type) == false )
    {
        player->BroadcastMessage("Please use a new character for chossing hardcore or ironman modes");
        return;
    }

    IronManHardcoreStore *HCIM = player->GetCreateExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
    if(type == 0)
        HCIM->EnableIronMan(player);
    else
        HCIM->EnableHardcore(player);
}

bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);
bool IsIronManPlayer(Player *p)
{
    IronManHardcoreStore *HCIM = p->GetExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
    return (HCIM != NULL);
}
bool IsIronmanPlr(Player *p)
{
    IronManHardcoreStore *HCIM = p->GetExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
    if (HCIM != NULL) {
        if (HCIM->IsIronManChar() && !HCIM->IsHardcoreChar())
            return true;
    }
    return false;
}
bool IsHardcorePlr(Player *p)
{
    IronManHardcoreStore *HCIM = p->GetExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
    if (HCIM != NULL) {
        if (HCIM->IsHardcoreChar())
            return true;
    }
    return false;
}
class TC_GAME_API IronManHardCoreRegisterScript : public PlayerScript
{
public:
    IronManHardCoreRegisterScript() : PlayerScript("IronManHardCoreRegisterScript") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        IronManHardcoreStore *HCIM = player->GetCreateExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
        HCIM->LoadPlayerData(player);
        if (HCIM->IsIronManChar() == false)
        {
            player->DeleteExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
            return;
        }
    }

    // Called when a player logs out.
    void OnLogout(Player* player)
    {
        IronManHardcoreStore *HCIM = player->GetExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
        if (HCIM == NULL)
            return;
        HCIM->SavePlayerData(player);
    }

    //hardcore characters can only die once
    void OnPlayerKilledByCreature(Creature* killer, Player* killed)
    {
        //sanity checks
        if (killer == NULL || killed == NULL)
            return;
        //do not register PVP kills
        if (killer->GetCharmerOrOwnerGUID() != ObjectGuid::Empty)
            return;
        //skip arenas and battelgrounds
        if (killer->FindMap() && (killer->GetMap()->IsBattleground() || killer->GetMap()->IsBattleArena() || killer->GetMap()->GetId() == 37))
            return;
        //allow gurubashi arena
        if (killer->IsFFAPvP())
            return;
        //mark him dead if he is a hardcore char
        IronManHardcoreStore *HCIM = killed->GetExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
        if (HCIM == NULL)
            return;
        HCIM->OnDied(killed,killer->GetEntry());
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_IronManHardCore where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void IronManHardcoreWho(void *p, void *)
{
    CP_NAME_QUERY *params = PointerCast(CP_NAME_QUERY, p);

    //sanity checks
    if (params->Player == NULL)
        return;

    Player* player = ObjectAccessor::FindConnectedPlayer(ObjectGuid( params->GUID) );
    if (player == NULL)
        return;

    //is this a hardcore char at all ?
    IronManHardcoreStore *HCIM = player->GetExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
    if (HCIM == NULL)
        return;

    std::string Difficulty;
    if (HCIM->IsHardcoreChar())
        //Difficulty = "|cFFFF0000Hardcore|r";
        Difficulty = "Hardcore";
    else
        //Difficulty = "|cFFFF9900IronMan|r";
        Difficulty = "IronMan";

    WorldPacket data(SMSG_NAME_QUERY_RESPONSE, (8 + 1 + 1 + 1 + 1 + 1 + 10));
    data << ObjectGuid(params->GUID).WriteAsPacked();
    data << uint8(0);                         // name known
    data << player->GetName();                // played name
    data << Difficulty;                        // realm name - only set for cross realm interaction (such as Battlegrounds)
    data << uint8(player->getRace());
    data << uint8(player->getGender());     //sex
    data << uint8(player->getClass());
    data << uint8(0);                           // Name is not declined

    params->Player->GetSession()->SendPacket(&data);

    //do not send real name of the player
    params->DenyDefaultParsing = 1;
}

void IParseClientUserCommand(Player* player, uint32 type, std::string& msg)
{
    if (CheckValidClientCommand(msg.c_str(), type, NULL) == false)
    {
        return;
    }

#define CHECK_IRONMAN_PREREQUISITS  if (player->getLevel() != 1) \
        {\
            player->BroadcastMessage("You can only use this command on level 1 charcters"); \
            return;\
        }\
        if (player->GetTotalPlayedTime() > 3 * MINUTE)\
        {\
            player->BroadcastMessage("You can only use this command on a new charcters");\
            return;\
        }

    if (strstr(msg.c_str(), "#csEnableIronMan") == msg.c_str())
    {
        CHECK_IRONMAN_PREREQUISITS
            IronManHardcoreStore *HCIM = player->GetCreateExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
        HCIM->EnableIronMan(player);
    }

    if (strstr(msg.c_str(), "#csEnableHardcore") == msg.c_str())
    {
        CHECK_IRONMAN_PREREQUISITS
            IronManHardcoreStore *HCIM = player->GetCreateExtension<IronManHardcoreStore>(OE_PLAYER_IRONMAN_STORE);
        HCIM->EnableHardcore(player);
    }
}

void IOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    IParseClientUserCommand(params->SenderPlayer, params->MsgType, *params->Msg);
}

void AddIronManScripts()
{
    //CREATE TABLE `character_IronManHardCore` ( `GUID` INT NULL, `IsHardCore` INT NULL, `TimesDied` INT NULL, `KillerEntry` INT NULL );
    //ALTER TABLE `character_IronManHardCore` ADD INDEX `GUID` (`GUID`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON character_IronManHardCore (GUID);
    RegisterCallbackFunction(CALLBACK_TYPE_NAME_QUERY, IronManHardcoreWho, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, IOnChatMessageReceived, NULL);

    new IronManHardCoreRegisterScript();
}
