#include "Player.h""
#include "Creature.h"
#include "ReputationMgr.h"
#include "ObjectMgr.h"
#include "DatabaseEnv.h"
#include "ScriptMgr.h"
#include "ObjectExtension.cpp"
#include "DBCStores.h"

class MonsterHuntStore
{
public:
    MonsterHuntStore()
    {
        LastShownEntryInHelp = 0;
    }
    void Load(Player *p);
    void OnPlayerKilledMonster(Player *p, unsigned int Entry);
    void SuggestNextKills(Player *p);
private:
    std::set<uint32> HuntStatus;
    uint32           LastShownEntryInHelp;
};

void MonsterHuntStore::Load(Player *p)
{
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "SELECT Entry FROM character_MonstersKilled where GUID=%d", (uint32)p->GetGUID().GetRawValue());
    QueryResult result = CharacterDatabase.Query(Query);
    if (result && result->GetRowCount() > 0)
    {
        do {
            Field* fields = result->Fetch();
            uint32 KilledEntry = fields[0].GetUInt32();
            HuntStatus.insert(KilledEntry);
        } while (result->NextRow());
    }
    size_t UnqiueKillCount = HuntStatus.size();
    *p->GetCreateIn64Extension(OE_PLAYER_MONSTER_HUNT_UNIQUE_KILLS, false, UnqiueKillCount) = UnqiueKillCount;
}

void MonsterHuntStore::OnPlayerKilledMonster(Player *p, unsigned int Entry)
{
    //first time use ? Load it from DB
    if (HuntStatus.empty())
        Load(p);
    //search in our store
    std::set<uint32>::iterator i = HuntStatus.find(Entry);
    if (i == HuntStatus.end())
    {
        HuntStatus.insert(Entry);
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "Insert into character_MonstersKilled values (%d,%d)", (uint32)p->GetGUID().GetRawValue(), Entry);
        QueryResult result = CharacterDatabase.Query(Query);

        int64 *UniqueKills = p->GetCreateIn64Extension(OE_PLAYER_MONSTER_HUNT_UNIQUE_KILLS);
        *UniqueKills = *UniqueKills + 1;
    }
}

void MonsterHuntStore::SuggestNextKills(Player *p)
{
    //first time use ? Load it from DB
    if (HuntStatus.empty())
        Load(p);
    uint32 AbortAfterXLines = 10;

    CreatureTemplateContainer const& ctc = sObjectMgr->GetCreatureTemplates();
    for(auto ctci = ctc.begin(); ctci != ctc.end(); ctci++)
    {
        const CreatureTemplate &cInfo = ctci->second;
        if (LastShownEntryInHelp > cInfo.Entry)
            continue;
        std::set<uint32>::iterator i = HuntStatus.find(cInfo.Entry);
        if (i != HuntStatus.end())
            continue;
        FactionEntry const* factionEntry = sFactionStore.LookupEntry(cInfo.faction);
        if (factionEntry == NULL)
            continue;
        ReputationRank repRank = p->GetReputationMgr().GetRank(factionEntry);
        if(repRank <= REP_HOSTILE)
        {
            p->BroadcastMessage("MonsterHunter: Possible next target %s (%d)", cInfo.Name.c_str(), cInfo.Entry);
            LastShownEntryInHelp = cInfo.Entry;
            AbortAfterXLines--;
            if (AbortAfterXLines == 0)
                break;
        }
    }
}

class TC_GAME_API MonsterHuntRegisterScript : public PlayerScript
{
public:
    MonsterHuntRegisterScript() : PlayerScript("MonsterHuntRegisterScript") {}

    void OnLogin(Player* player, bool firstLogin)
    {
        MonsterHuntStore *HS = player->GetCreateExtension<MonsterHuntStore>(OE_PLAYER_MONSTER_HUNT_STORE);
        HS->Load(player);
    }

    void OnCreatureKill(Player* killer, Creature* killed)
    {
        if (killer == NULL || killed == NULL)
            return;
        MonsterHuntStore *HS = killer->GetCreateExtension<MonsterHuntStore>(OE_PLAYER_MONSTER_HUNT_STORE);
        HS->OnPlayerKilledMonster(killer, killed->GetEntry());
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_MonstersKilled where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);
void MHParseClientUserCommand(Player* player, uint32 type, const char *cmsg)
{
    //        printf("got command %s\n",cmsg);
    if (CheckValidClientCommand(cmsg, type, NULL) == false)
        return;
    //do we want to set the difficulty ?
    if (strstr(cmsg, "#csNextHuntTarget") == cmsg)
    {
        MonsterHuntStore *HS = player->GetCreateExtension<MonsterHuntStore>(OE_PLAYER_MONSTER_HUNT_STORE);
        HS->SuggestNextKills(player);
    }
}

void MHOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    MHParseClientUserCommand(params->SenderPlayer, params->MsgType, params->Msg->c_str());
}

void AddMonsterHuntScoresScripts()
{
/*
CREATE TABLE `character_MonstersKilled` (
`GUID` INT NULL,
`Entry` INT NULL,
INDEX `Index1` (`GUID`),
UNIQUE KEY `relation` (`GUID`,`Entry`),
KEY `RowId` (`GUID`) USING BTREE
)ENGINE=InnoDB;
*/
    new MonsterHuntRegisterScript();
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, MHOnChatMessageReceived, NULL);
}
