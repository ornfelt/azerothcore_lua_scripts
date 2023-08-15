#include "Player.h""
#include "Creature.h"
#include "ObjectMgr.h"
#include "DatabaseEnv.h"
#include "ScriptMgr.h"
#include "ObjectExtension.cpp"
#include "Map.h"
#include "Group.h"
#include "WorldSession.h"
#include "ObjectMgr.h"
#include "GameEventCallbacks.h"
#include "GameTime.h"

struct PingXY
{
    float x, y;
    const char *Name;
    uint32 SpawnId;
};

static std::map<uint32, std::set<uint32>> MapBosses; // first is map, second is a list of creature entries
static std::map<uint32, std::set<uint32>> MapBossesAlternativeEntries; // first is creature entry, second is a list of alternative entries
static std::map<uint32, PingXY*> MapBossLocations; // first is creature entry, second is the location on a specific map
static std::map<uint32, std::list<uint32>> MapClearRewards; // first is map, second is a list of item entries

bool IsCreatureMapBossSingleEntry(uint32 MapEntry, uint32 CreatureEntry)
{
    if (MapBosses[MapEntry].find(CreatureEntry) == MapBosses[MapEntry].end())
        return false;
    return true;
}

bool IsCreatureMapBoss(uint32 MapEntry, uint32 CreatureEntry)
{
    if (MapBosses.find(MapEntry) == MapBosses.end())
        return false;
    if (IsCreatureMapBossSingleEntry(MapEntry, CreatureEntry) == true)
        return true;
    if (MapBossesAlternativeEntries.find(CreatureEntry) == MapBossesAlternativeEntries.end())
        return false;
    for (auto itr = MapBossesAlternativeEntries[CreatureEntry].begin(); itr != MapBossesAlternativeEntries[CreatureEntry].end(); itr++)
        if (IsCreatureMapBossSingleEntry(MapEntry, *itr) == true)
            return true;
    return false;
}

bool IsInstanceFullCleared(Player *p, bool BroadCastStatus)
{
    Map *m = p->GetMap();
    //sanity check
    if (m == NULL)
        return false;
    //do we even track kills for this map ?
    uint32 MapEntry = m->GetId();
    if (MapBosses.find(MapEntry) == MapBosses.end() || MapBosses[MapEntry].empty() == true)
        return false;
    //check if all bosses are killed
    std::set<uint32> *BossesKilledSoFar = m->GetCreateExtension<std::set<uint32>>(OE_MAP_BOSS_KILLED_STORE);
    for (auto i = MapBosses[MapEntry].begin(); i != MapBosses[MapEntry].end(); i++)
        if (BossesKilledSoFar->find(*i) == BossesKilledSoFar->end())
        {
            if (BroadCastStatus)
            {
                const CreatureTemplate *ci = sObjectMgr->GetCreatureTemplate(*i);
                if (ci == NULL)
                    p->BroadcastMessage("InstanceClear bug. Report this to a dec %d", *i);
                else
                    p->BroadcastMessage("InstanceClear needs kill : %s - %d", ci->Name.c_str(), ci->Entry);
            }
            else
                return false;
        }
    return true;
}

void PingBossLocationsForPlayer(Player *player)
{
    if (player == NULL || player->FindMap() == NULL || player->GetSession() == NULL)
        return;
    uint32 MapEntry = player->GetMap()->GetId();
    if (MapBosses.find(MapEntry) == MapBosses.end())
        return;

    std::set<uint32> *BossesKilledSoFar = player->GetMap()->GetCreateExtension<std::set<uint32>>(OE_MAP_BOSS_KILLED_STORE);

    //try to send mob locations as interest points
    float ClosestLocDist = 0x00FFFFFF;
    PingXY *Closestxy = NULL;
    for (auto itr = MapBosses[MapEntry].begin(); itr != MapBosses[MapEntry].end(); itr++)
    {
        //wow, this boss is not spawned on this map ?
        if (MapBossLocations.find(*itr) == MapBossLocations.end())
            continue;
        //this boss is already kill, no need to show it on minimap
        if (BossesKilledSoFar->find(*itr) != BossesKilledSoFar->end())
            continue;
        // the distance to this boss
        PingXY *xy = MapBossLocations[*itr];
        float DistX = player->GetPositionX() - xy->x;
        float DistY = player->GetPositionY() - xy->y;
        float Dist = DistX * DistX + DistY * DistY;
        if (Dist < ClosestLocDist)
        {
            ClosestLocDist = Dist;
            Closestxy = xy;
        }
    }
    //let the player know where the closest boss is
    if (Closestxy != NULL)
    {
        //try to get the mob itself. Just in case it moved
        Creature *c = player->GetMap()->GetCreatureBySpawnId(Closestxy->SpawnId);
        float x = Closestxy->x;
        if (c != NULL)
            x = c->GetPositionX();
        float y = Closestxy->y;
        if (c != NULL)
            y = c->GetPositionY();

        WorldPacket data(SMSG_GOSSIP_POI, 4 + 4 + 4 + 4 + 4 + 20);  // guess size
        data << uint32(99); // flags
        data << float(x);
        data << float(y);
        data << uint32(7); // icon
        data << uint32(0); // importance
        data << Closestxy->Name;
        player->GetSession()->SendPacket(&data);
    }
}

void ICSOnPlayerKilledMonster(Player *p, unsigned int Entry)
{
    if (p == NULL || p->FindMap() == NULL)
        return;

    //only register boss kills
    uint32 MapEntry = p->GetMap()->GetId();
    if (IsCreatureMapBoss(MapEntry, Entry) == false)
        return;
    //get the store
    std::set<uint32> *BossesKilledSoFar = p->GetMap()->GetCreateExtension<std::set<uint32>>(OE_MAP_BOSS_KILLED_STORE);

    bool ResetPlayerStats = BossesKilledSoFar->empty();
    //for some reason this boss was spawned more than once. Do not register as
    if (BossesKilledSoFar->find(Entry) != BossesKilledSoFar->end())
        return;
    //register this kill
    BossesKilledSoFar->insert(Entry);

    Map::PlayerList const &plrs = p->GetMap()->GetPlayers();
    for (Map::PlayerList::const_iterator itr = plrs.begin(); itr != plrs.end(); ++itr)
    {
        Player *p1 = itr->GetSource();             
        if (p1 == NULL)
            continue;
        std::map<uint32, uint32> *MapKillCounts = p1->GetCreateExtension<std::map<uint32, uint32>>(OE_MAP_BOSS_KILLED_STORE);
        if(ResetPlayerStats == true)
            (*MapKillCounts)[MapEntry] = 0;     //if this is first boss killed, than we should initialize players also

        PingXY *xy = MapBossLocations[Entry];
        p1->BroadcastMessage("InstanceClear : Kill credit awarded for %s. Progress %d/%d", xy->Name, (int)((*MapKillCounts)[MapEntry] + 1),(int)(MapBosses[MapEntry].size()));
        (*MapKillCounts)[MapEntry] += 1;     // Player Gets a Kill Credit

        //show the next location for the player
        PingBossLocationsForPlayer(p1);
    }

    //check if all bosses have been killed
    if (IsInstanceFullCleared(p,false) == false)
        return;

    //at what difficulty was the instance cleared ?
    uint32 Difficulty = 100;
    int64 *InstanceScalePlayer = p->GetMap()->GetCreateIn64Extension(OE_MAP_MOB_DIFFICULTY_SCALER, true);
    if (InstanceScalePlayer != NULL)
        Difficulty = 100 + (int32)*InstanceScalePlayer;

    //now that the instance is fully cleared, register
    int BossKillCount = (int)BossesKilledSoFar->size();
    for (Map::PlayerList::const_iterator itr = plrs.begin(); itr != plrs.end(); ++itr)
    {
        Player* player = itr->GetSource();
        if (player == NULL)
            continue;
        //did this player participate at all kills ?
        std::map<uint32, uint32> *MapKillCounts = player->GetCreateExtension<std::map<uint32, uint32>>(OE_MAP_BOSS_KILLED_STORE);
        int PlayerKillCount = (*MapKillCounts)[MapEntry];
        if (PlayerKillCount < BossKillCount)
        {
            player->BroadcastMessage("InstanceClear : Bosses got killed %d. You only participated %d", BossKillCount, PlayerKillCount);
            continue;
        }

        //add items to players if there are any rewards
        if (MapClearRewards.find(MapEntry) != MapClearRewards.end())
            for (auto itr2 = MapClearRewards[MapEntry].begin(); itr2 != MapClearRewards[MapEntry].end(); ++itr2)
            {
                uint32 RollChance = Difficulty / 10;
                uint32 DiceRoll = rand32() % 100;
                if (RollChance < DiceRoll)
                {
                    player->BroadcastMessage("InstanceClear : You had %d chance for clear reward, but you missed it", RollChance);
                    continue;
                }
                player->AddItem(*itr2, 5);
            }

        uint32 PlayerSmallGuid = (uint32)player->GetGUID().GetCounter();
        char Query[15000];
        if (sprintf_s(Query, sizeof(Query), "INSERT INTO character_InstanceClearScores VALUES(%d, %d, %d) ON DUPLICATE KEY UPDATE Score = IF(Score>%d,Score,%d)", PlayerSmallGuid, (uint32)MapEntry, Difficulty, Difficulty, Difficulty))
            CharacterDatabase.Execute(Query);
    }
}

void ISCShowClosestBossLocations(void *p, void *context)
{
    static uint32 NextMinimapUpdate = 0;
    if (NextMinimapUpdate > GameTime::GetGameTimeMS())
        return;
    NextMinimapUpdate = GameTime::GetGameTimeMS() + 30 * 1000; //update closest boss location every 30 sec
    Player *pp = (Player *)p;
    PingBossLocationsForPlayer(pp);
}

class TC_GAME_API InstanceClearRegisterScript : public PlayerScript
{
public:
    InstanceClearRegisterScript() : PlayerScript("InstanceClearRegisterScript") {}

    void OnCreatureKill(Player* killer, Creature* killed)
    {
        if (killer == NULL || killed == NULL)
            return;
        ICSOnPlayerKilledMonster(killer, killed->GetEntry());
    }

    void OnMapChanged(Player* p)
    {
        if (p == NULL || p->FindMap() == NULL)
            return;

        //p->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, ISCShowClosestBossLocations, NULL);

        //only register boss kills
        uint32 MapEntry = p->FindMap()->GetId();
        if (MapBosses.find(MapEntry) == MapBosses.end())
            return;

        PingBossLocationsForPlayer(p);
        //this will only register once
        p->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, ISCShowClosestBossLocations, NULL);
    }
    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_InstanceClearScores where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);
void ICParseClientUserCommand(Player* player, uint32 type, const char *cmsg)
{
    //        printf("got command %s\n",cmsg);
    if (CheckValidClientCommand(cmsg, type, NULL) == false)
        return;
    //do we want to set the difficulty ?
    if (strstr(cmsg, "#csIstanceClearStatus") == cmsg)
    {
        IsInstanceFullCleared(player, true);
    }
    if (strstr(cmsg, "#csIstancePingLocations") == cmsg)
    {
        PingBossLocationsForPlayer(player);
    }
}

void ICOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    ICParseClientUserCommand(params->SenderPlayer, params->MsgType, params->Msg->c_str());
}

void AddInstanceClearScoresScripts()
{
    /*
    CREATE TABLE `character_InstanceClearScores` (
    `GUID` INT NULL,
    `MapEntry` INT NULL,
    `Score` INT NULL,
    INDEX `Index1` (`GUID`,`MapEntry`),
    UNIQUE KEY `relation` (`GUID`,`MapEntry`),
    KEY `RowId` (`GUID`,`MapEntry`) USING BTREE
    )ENGINE=InnoDB;
    */
    //MapId = 48, MapName = Blackfathom Deeps
    MapBosses[48].insert(4831);
    MapBosses[48].insert(6243);
    MapBosses[48].insert(12902);
    MapBosses[48].insert(4832);
    MapBosses[48].insert(4830);
    MapBosses[48].insert(4829);
    MapBosses[48].insert(4887);

    //MapId = 230, MapName = Blackrock Depths
    MapBosses[230].insert(9025);
    MapBosses[230].insert(9016);
    MapBosses[230].insert(9319);
    MapBosses[230].insert(9018);
    MapBosses[230].insert(9024);
    MapBosses[230].insert(9033);
    MapBosses[230].insert(8983);
    MapBosses[230].insert(9543);
    MapBosses[230].insert(9537);
    MapBosses[230].insert(9499);
    MapBosses[230].insert(9502);
    MapBosses[230].insert(9017);
    MapBosses[230].insert(9056);
    MapBosses[230].insert(9041);
    MapBosses[230].insert(9042);
    MapBosses[230].insert(9156);
    MapBosses[230].insert(9938);
    MapBosses[230].insert(8929);
    MapBosses[230].insert(9019);

    //MapId = 229, MapName = Blackrock Spire
    MapBosses[229].insert(9196);
    MapBosses[229].insert(9236);
    MapBosses[229].insert(9237);
    MapBosses[229].insert(10596);
    MapBosses[229].insert(9736);
    MapBosses[229].insert(10220);
    MapBosses[229].insert(9568);
    MapBosses[229].insert(9816);
    MapBosses[229].insert(10429);
    MapBosses[229].insert(10430);
    MapBosses[229].insert(10363);

    //MapId = 429, MapName = Dire Maul
    MapBosses[429].insert(11490);
    MapBosses[429].insert(13280);
    MapBosses[429].insert(14327);
    MapBosses[429].insert(11492);
    MapBosses[429].insert(14326);
    MapBosses[429].insert(14322);
    MapBosses[429].insert(14321);
    MapBosses[429].insert(14323);
    MapBosses[429].insert(14325);
    MapBosses[429].insert(11501);
    MapBosses[429].insert(14324);
    MapBosses[429].insert(11489);
    MapBosses[429].insert(11488);
    MapBosses[429].insert(11487);
    MapBosses[429].insert(11496);
    MapBosses[429].insert(11486);

    //MapId = 90, MapName = Gnomeregan
    MapBosses[90].insert(7079);
    MapBosses[90].insert(6235);
    MapBosses[90].insert(6229);
    MapBosses[90].insert(7800);

    //MapId = 349, MapName = Maraudon
    MapBosses[349].insert(13282);
    MapBosses[349].insert(12258);
    MapBosses[349].insert(13601);
    MapBosses[349].insert(12236);
    MapBosses[349].insert(12225);
    MapBosses[349].insert(12203);
    MapBosses[349].insert(13596);
    MapBosses[349].insert(12201);

    //MapId = 389, MapName = Ragefire Chasm
    MapBosses[389].insert(11520);
    MapBosses[389].insert(11517);
    MapBosses[389].insert(11518);
    MapBosses[389].insert(11519);

    //MapId = 129, MapName = Razorfen Downs
    MapBosses[129].insert(7357);
    MapBosses[129].insert(8567);
    MapBosses[129].insert(7358);

    //MapId = 47, MapName = Razorfen Kraul
    MapBosses[47].insert(6168);
    MapBosses[47].insert(4424);
    MapBosses[47].insert(4428);
    MapBosses[47].insert(4420);
    MapBosses[47].insert(4422);
    MapBosses[47].insert(4421);

    //MapId = 189, MapName = Scarlet Monastery
    MapBosses[189].insert(3983);
    MapBosses[189].insert(4543);
    MapBosses[189].insert(3974);
    MapBosses[189].insert(6487);
    MapBosses[189].insert(3975);
    MapBosses[189].insert(4542);
    MapBosses[189].insert(3977);
    MapBosses[189].insert(3976);

    //MapId = 289, MapName = Scholomance
    MapBosses[289].insert(10503);
    MapBosses[289].insert(11622);
    MapBosses[289].insert(10433);
    MapBosses[289].insert(10432);
    MapBosses[289].insert(10508);
    MapBosses[289].insert(10505);
    MapBosses[289].insert(11261);
    MapBosses[289].insert(10901);
    MapBosses[289].insert(10507);
    MapBosses[289].insert(10504);
    MapBosses[289].insert(10502);

    //MapId = 33, MapName = Shadowfang Keep
    MapBosses[33].insert(4279);
    MapBosses[33].insert(4275);
    MapBosses[33].insert(3887);
    MapBosses[33].insert(3886);
    MapBosses[33].insert(3914);
    MapBosses[33].insert(3927);
    MapBosses[33].insert(4274);

    //MapId = 329, MapName = Stratholme
    MapBosses[329].insert(11032);
    MapBosses[329].insert(10997);
    MapBosses[329].insert(10811);
    MapBosses[329].insert(10436);
    MapBosses[329].insert(10437);
    MapBosses[329].insert(10438);
    MapBosses[329].insert(10435);

    //MapId = 109, MapName = Sunken Temple
    MapBosses[109].insert(5710);
    MapBosses[109].insert(5709);
    MapBosses[109].insert(5711);
    MapBosses[109].insert(5712);
    MapBosses[109].insert(5713);
    MapBosses[109].insert(5714);
    MapBosses[109].insert(5715);
    MapBosses[109].insert(5716);
    MapBosses[109].insert(5717);
    MapBosses[109].insert(5719);
    MapBosses[109].insert(5722);

    //MapId = 36, MapName = The Deadmines
    MapBosses[36].insert(639);
    MapBosses[36].insert(642);
    MapBosses[36].insert(644);
    MapBosses[36].insert(645);
    MapBosses[36].insert(646);
    MapBosses[36].insert(1763);
    MapBosses[36].insert(647);
    MapBosses[36].insert(3586);

    //MapId = 34, MapName = The Stockade
    MapBosses[34].insert(1663);
    MapBosses[34].insert(1666);
    MapBosses[34].insert(1696);
    MapBosses[34].insert(1716);
    MapBosses[34].insert(1717);
    MapBosses[34].insert(1720);

    //MapId = 70, MapName = Uldaman
    MapBosses[70].insert(6910);
    MapBosses[70].insert(6906);
    MapBosses[70].insert(7228);
    MapBosses[70].insert(7023);
    MapBosses[70].insert(7206);
    MapBosses[70].insert(7291);
    MapBosses[70].insert(4854);
    MapBosses[70].insert(2748);

    //MapId = 43, MapName = Wailing Caverns
    MapBosses[43].insert(3671);
    MapBosses[43].insert(3669);
    MapBosses[43].insert(3653);
    MapBosses[43].insert(3670);
    MapBosses[43].insert(3674);
    MapBosses[43].insert(3673);
    MapBosses[43].insert(5775);

    //MapId = 209, MapName = Zul'Farrak
    MapBosses[209].insert(8127);
    MapBosses[209].insert(7272);
    MapBosses[209].insert(7271);
    MapBosses[209].insert(7795);
    MapBosses[209].insert(7797);
    MapBosses[209].insert(7267);

    //MapId = 558, MapName = Auchenai Crypts
    MapBosses[558].insert(18371);
    MapBossesAlternativeEntries[18371].insert(20318);
    MapBossesAlternativeEntries[20318].insert(18371);
    MapBosses[558].insert(18373);
    MapBossesAlternativeEntries[18373].insert(20306);
    MapBossesAlternativeEntries[20306].insert(18373);

    //MapId = 543, MapName = Hellfire Ramparts
    MapBosses[543].insert(17306);
    MapBossesAlternativeEntries[17306].insert(18436);
    MapBossesAlternativeEntries[18436].insert(17306);
    MapBosses[543].insert(17308);
    MapBossesAlternativeEntries[17308].insert(18433);
    MapBossesAlternativeEntries[18433].insert(17308);

    //MapId = 534, MapName = Hyjal Past
    MapBosses[534].insert(17968);

    //MapId = 585, MapName = Magisters' Terrace
    MapBosses[585].insert(24723);
    MapBossesAlternativeEntries[24723].insert(25562);
    MapBossesAlternativeEntries[25562].insert(24723);
    MapBosses[585].insert(24744);
    MapBossesAlternativeEntries[24744].insert(25573);
    MapBossesAlternativeEntries[25573].insert(24744);
    MapBosses[585].insert(24560);
    MapBossesAlternativeEntries[24560].insert(25560);
    MapBossesAlternativeEntries[25560].insert(24560);
    MapBosses[585].insert(24664);

    //MapId = 557, MapName = Mana-Tombs
    MapBosses[557].insert(18341);
    MapBossesAlternativeEntries[18341].insert(20267);
    MapBossesAlternativeEntries[20267].insert(18341);
    MapBosses[557].insert(18343);
    MapBossesAlternativeEntries[18343].insert(20268);
    MapBossesAlternativeEntries[20268].insert(18343);
    MapBosses[557].insert(18344);
    MapBossesAlternativeEntries[18344].insert(20266);
    MapBossesAlternativeEntries[20266].insert(18344);

    //MapId = 556, MapName = Sethekk Halls
    MapBosses[556].insert(18472);
    MapBossesAlternativeEntries[18472].insert(20690);
    MapBossesAlternativeEntries[20690].insert(18472);
    MapBosses[556].insert(18473);
    MapBossesAlternativeEntries[18473].insert(20706);
    MapBossesAlternativeEntries[20706].insert(18473);

    //MapId = 555, MapName = Shadow Labyrinth
    MapBosses[555].insert(18731);
    MapBossesAlternativeEntries[18731].insert(20636);
    MapBossesAlternativeEntries[20636].insert(18731);
    MapBosses[555].insert(18667);
    MapBossesAlternativeEntries[18667].insert(20637);
    MapBossesAlternativeEntries[20637].insert(18667);
    MapBosses[555].insert(18732);
    MapBossesAlternativeEntries[18732].insert(20653);
    MapBossesAlternativeEntries[20653].insert(18732);
    MapBosses[555].insert(18708);
    MapBossesAlternativeEntries[18708].insert(20657);
    MapBossesAlternativeEntries[20657].insert(18708);

    //MapId = 552, MapName = The Arcatraz
    MapBosses[552].insert(20870);
    MapBossesAlternativeEntries[20870].insert(21626);
    MapBossesAlternativeEntries[21626].insert(20870);
    MapBosses[552].insert(20885);
    MapBossesAlternativeEntries[20885].insert(21590);
    MapBossesAlternativeEntries[21590].insert(20885);
    MapBosses[552].insert(20886);
    MapBossesAlternativeEntries[20886].insert(21624);
    MapBossesAlternativeEntries[21624].insert(20886);

    //MapId = 542, MapName = The Blood Furnace
    MapBosses[542].insert(17381);
    MapBossesAlternativeEntries[17381].insert(18621);
    MapBossesAlternativeEntries[18621].insert(17381);
    MapBosses[542].insert(17380);
    MapBossesAlternativeEntries[17380].insert(18601);
    MapBossesAlternativeEntries[18601].insert(17380);
    MapBosses[542].insert(17377);
    MapBossesAlternativeEntries[17377].insert(18607);
    MapBossesAlternativeEntries[18607].insert(17377);

    //MapId = 553, MapName = The Botanica
    MapBosses[553].insert(17976);
    MapBossesAlternativeEntries[17976].insert(21551);
    MapBossesAlternativeEntries[21551].insert(17976);
    MapBosses[553].insert(17975);
    MapBossesAlternativeEntries[17975].insert(21558);
    MapBossesAlternativeEntries[21558].insert(17975);
    MapBosses[553].insert(17978);
    MapBossesAlternativeEntries[17978].insert(21581);
    MapBossesAlternativeEntries[21581].insert(17978);
    MapBosses[553].insert(17980);
    MapBossesAlternativeEntries[17980].insert(21559);
    MapBossesAlternativeEntries[21559].insert(17980);
    MapBosses[553].insert(17977);
    MapBossesAlternativeEntries[17977].insert(21582);
    MapBossesAlternativeEntries[21582].insert(17977);

    //MapId = 554, MapName = The Mechanar
    MapBosses[554].insert(19219);
    MapBossesAlternativeEntries[19219].insert(21533);
    MapBossesAlternativeEntries[21533].insert(19219);
    MapBosses[554].insert(19221);
    MapBossesAlternativeEntries[19221].insert(21536);
    MapBossesAlternativeEntries[21536].insert(19221);
    MapBosses[554].insert(19220);
    MapBossesAlternativeEntries[19220].insert(21537);
    MapBossesAlternativeEntries[21537].insert(19220);

    //MapId = 540, MapName = The Shattered Halls
    MapBosses[540].insert(16809);
    MapBossesAlternativeEntries[16809].insert(20596);
    MapBossesAlternativeEntries[20596].insert(16809);
    MapBosses[540].insert(16808);
    MapBossesAlternativeEntries[16808].insert(20597);
    MapBossesAlternativeEntries[20597].insert(16808);
    MapBosses[540].insert(16807);
    MapBossesAlternativeEntries[16807].insert(20568);
    MapBossesAlternativeEntries[20568].insert(16807);

    //MapId = 547, MapName = The Slave Pens
    MapBosses[547].insert(17941);
    MapBossesAlternativeEntries[17941].insert(19893);
    MapBossesAlternativeEntries[19893].insert(17941);
    MapBosses[547].insert(17991);
    MapBossesAlternativeEntries[17991].insert(19895);
    MapBossesAlternativeEntries[19895].insert(17991);
    MapBosses[547].insert(17942);
    MapBossesAlternativeEntries[17942].insert(19894);
    MapBossesAlternativeEntries[19894].insert(17942);

    //MapId = 545, MapName = The Steamvault
    MapBosses[545].insert(17797);
    MapBossesAlternativeEntries[17797].insert(20629);
    MapBossesAlternativeEntries[20629].insert(17797);
    MapBosses[545].insert(17796);
    MapBossesAlternativeEntries[17796].insert(20630);
    MapBossesAlternativeEntries[20630].insert(17796);
    MapBosses[545].insert(17798);
    MapBossesAlternativeEntries[17798].insert(20633);
    MapBossesAlternativeEntries[20633].insert(17798);

    //MapId = 546, MapName = The Underbog
    MapBosses[546].insert(17770);
    MapBossesAlternativeEntries[17770].insert(20169);
    MapBossesAlternativeEntries[20169].insert(17770);
    MapBosses[546].insert(18105);
    MapBossesAlternativeEntries[18105].insert(20168);
    MapBossesAlternativeEntries[20168].insert(18105);
    MapBosses[546].insert(17826);
    MapBossesAlternativeEntries[17826].insert(20183);
    MapBossesAlternativeEntries[20183].insert(17826);
    MapBosses[546].insert(17882);
    MapBossesAlternativeEntries[17882].insert(20184);
    MapBossesAlternativeEntries[20184].insert(17882);

    //MapId = 619, MapName = Ahn'kahet: The Old Kingdom
    MapBosses[619].insert(29309);
    MapBossesAlternativeEntries[29309].insert(31456);
    MapBossesAlternativeEntries[31456].insert(29309);
    MapBosses[619].insert(29308);
    MapBossesAlternativeEntries[29308].insert(31469);
    MapBossesAlternativeEntries[31469].insert(29308);
    MapBosses[619].insert(29310);
    MapBossesAlternativeEntries[29310].insert(31465);
    MapBossesAlternativeEntries[31465].insert(29310);
    MapBosses[619].insert(29311);
    MapBossesAlternativeEntries[29311].insert(31464);
    MapBossesAlternativeEntries[31464].insert(29311);
    MapBosses[619].insert(30258);
    MapBossesAlternativeEntries[30258].insert(31463);
    MapBossesAlternativeEntries[31463].insert(30258);

    //MapId = 601, MapName = Azjol-Nerub
    MapBosses[601].insert(28684);
    MapBossesAlternativeEntries[28684].insert(31612);
    MapBossesAlternativeEntries[31612].insert(28684);
    MapBosses[601].insert(28921);
    MapBossesAlternativeEntries[28921].insert(31611);
    MapBossesAlternativeEntries[31611].insert(28921);
    MapBosses[601].insert(29120);
    MapBossesAlternativeEntries[29120].insert(31610);
    MapBossesAlternativeEntries[31610].insert(29120);

    //MapId = 600, MapName = Drak'Tharon Keep
    MapBosses[600].insert(26630);
    MapBossesAlternativeEntries[26630].insert(31362);
    MapBossesAlternativeEntries[31362].insert(26630);
    MapBosses[600].insert(26631);
    MapBossesAlternativeEntries[26631].insert(31350);
    MapBossesAlternativeEntries[31350].insert(26631);
    MapBosses[600].insert(27483);
    MapBossesAlternativeEntries[27483].insert(31349);
    MapBossesAlternativeEntries[31349].insert(27483);
    MapBosses[600].insert(26632);
    MapBossesAlternativeEntries[26632].insert(31360);
    MapBossesAlternativeEntries[31360].insert(26632);

    //MapId = 604, MapName = Gundrak
    MapBosses[604].insert(29304);
    MapBossesAlternativeEntries[29304].insert(31370);
    MapBossesAlternativeEntries[31370].insert(29304);
    MapBosses[604].insert(29307);
    MapBossesAlternativeEntries[29307].insert(31365);
    MapBossesAlternativeEntries[31365].insert(29307);
    MapBosses[604].insert(29305);
    MapBossesAlternativeEntries[29305].insert(30530);
    MapBossesAlternativeEntries[30530].insert(29305);
    MapBosses[604].insert(29306);
    MapBossesAlternativeEntries[29306].insert(31368);
    MapBossesAlternativeEntries[31368].insert(29306);

    //MapId = 602, MapName = Halls of Lightning
    MapBosses[602].insert(28586);
    MapBossesAlternativeEntries[28586].insert(31533);
    MapBossesAlternativeEntries[31533].insert(28586);
    MapBosses[602].insert(28587);
    MapBossesAlternativeEntries[28587].insert(31536);
    MapBossesAlternativeEntries[31536].insert(28587);
    MapBosses[602].insert(28546);
    MapBossesAlternativeEntries[28546].insert(31537);
    MapBossesAlternativeEntries[31537].insert(28546);

    //MapId = 668, MapName = Halls of Reflection
    MapBosses[668].insert(38112);
    MapBossesAlternativeEntries[38112].insert(38599);
    MapBossesAlternativeEntries[38599].insert(38112);
    MapBosses[668].insert(38113);
    MapBossesAlternativeEntries[38113].insert(38603);
    MapBossesAlternativeEntries[38603].insert(38113);

    //MapId = 599, MapName = Halls of Stone
    MapBosses[599].insert(27975);
    MapBossesAlternativeEntries[27975].insert(31384);
    MapBossesAlternativeEntries[31384].insert(27975);
    MapBosses[599].insert(27977);
    MapBossesAlternativeEntries[27977].insert(31381);
    MapBossesAlternativeEntries[31381].insert(27977);
    MapBosses[599].insert(27978);
    MapBossesAlternativeEntries[27978].insert(31386);
    MapBossesAlternativeEntries[31386].insert(27978);

    //MapId = 658, MapName = Pit of Saron
    MapBosses[658].insert(36494);
    MapBossesAlternativeEntries[36494].insert(37613);
    MapBossesAlternativeEntries[37613].insert(36494);
    MapBosses[658].insert(36476);
    MapBossesAlternativeEntries[36476].insert(37627);
    MapBossesAlternativeEntries[37627].insert(36476);

    //MapId = 632, MapName = The Forge of Souls
    MapBosses[632].insert(36497);
    MapBossesAlternativeEntries[36497].insert(36498);
    MapBossesAlternativeEntries[36498].insert(36497);
    MapBosses[632].insert(36502);
    MapBossesAlternativeEntries[36502].insert(37677);
    MapBossesAlternativeEntries[37677].insert(36502);

    //MapId = 576, MapName = The Nexus
    MapBosses[576].insert(26731);
    MapBossesAlternativeEntries[26731].insert(30510);
    MapBossesAlternativeEntries[30510].insert(26731);
    MapBosses[576].insert(26763);
    MapBossesAlternativeEntries[26763].insert(30529);
    MapBossesAlternativeEntries[30529].insert(26763);
    MapBosses[576].insert(26794);
    MapBossesAlternativeEntries[26794].insert(30532);
    MapBossesAlternativeEntries[30532].insert(26794);

    //MapId = 578, MapName = The Oculus
    MapBosses[578].insert(27654);
    MapBossesAlternativeEntries[27654].insert(31558);
    MapBossesAlternativeEntries[31558].insert(27654);
    MapBosses[578].insert(27447);
    MapBossesAlternativeEntries[27447].insert(31559);
    MapBossesAlternativeEntries[31559].insert(27447);
    MapBosses[578].insert(27655);
    MapBossesAlternativeEntries[27655].insert(31560);
    MapBossesAlternativeEntries[31560].insert(27655);
    MapBosses[578].insert(27656);
    MapBossesAlternativeEntries[27656].insert(31561);
    MapBossesAlternativeEntries[31561].insert(27656);

    //MapId = 574, MapName = Utgarde Keep
    MapBosses[574].insert(23953);
    MapBossesAlternativeEntries[23953].insert(30748);
    MapBossesAlternativeEntries[30748].insert(23953);
    MapBosses[574].insert(24200);
    MapBossesAlternativeEntries[24200].insert(31679);
    MapBossesAlternativeEntries[31679].insert(24200);

    //MapId = 575, MapName = Utgarde Pinnacle
    MapBosses[575].insert(26687);
    MapBossesAlternativeEntries[26687].insert(30774);
    MapBossesAlternativeEntries[30774].insert(26687);
    MapBosses[575].insert(26693);
    MapBossesAlternativeEntries[26693].insert(30807);
    MapBossesAlternativeEntries[30807].insert(26693);

    //MapId = 608, MapName = Violet Hold
    MapBosses[608].insert(29315);
    MapBossesAlternativeEntries[29315].insert(31507);
    MapBossesAlternativeEntries[31507].insert(29315);
    MapBosses[608].insert(29316);
    MapBossesAlternativeEntries[29316].insert(31510);
    MapBossesAlternativeEntries[31510].insert(29316);
    MapBosses[608].insert(29313);
    MapBossesAlternativeEntries[29313].insert(31508);
    MapBossesAlternativeEntries[31508].insert(29313);
    MapBosses[608].insert(29266);
    MapBossesAlternativeEntries[29266].insert(31511);
    MapBossesAlternativeEntries[31511].insert(29266);
    MapBosses[608].insert(29312);
    MapBossesAlternativeEntries[29312].insert(31509);
    MapBossesAlternativeEntries[31509].insert(29312);
    MapBosses[608].insert(29314);
    MapBossesAlternativeEntries[29314].insert(31512);
    MapBossesAlternativeEntries[31512].insert(29314);

    //MapId = 409, MapName = Molten Core
    MapBosses[409].insert(11982);
    MapBosses[409].insert(12259);
    MapBosses[409].insert(12057);
    MapBosses[409].insert(12264);
    MapBosses[409].insert(12056);
    MapBosses[409].insert(11988);
    MapBosses[409].insert(12098);
    MapBosses[409].insert(12118);

    //MapId = 531, MapName = Ahn'Qiraj
    MapBosses[531].insert(15263);
    MapBosses[531].insert(15516);
    MapBosses[531].insert(15510);
    MapBosses[531].insert(15509);
    MapBosses[531].insert(15276);
    MapBosses[531].insert(15275);
    MapBosses[531].insert(15727);

    //MapId = 509, MapName = Ruins of Ahn'Qiraj
    MapBosses[509].insert(15348);
    MapBosses[509].insert(15341);
    MapBosses[509].insert(15340);
    MapBosses[509].insert(15370);
    MapBosses[509].insert(15369);
    MapBosses[509].insert(15339);

    //MapId = 469, MapName = Blackwing Lair
    MapBosses[469].insert(12435);
    MapBosses[469].insert(13020);
    MapBosses[469].insert(12017);
    MapBosses[469].insert(11983);
    MapBosses[469].insert(14601);
    MapBosses[469].insert(11981);
    MapBosses[469].insert(14020);

    //MapId = 564, MapName = Black Temple
    MapBosses[564].insert(22917);
    MapBosses[564].insert(22887);
    MapBosses[564].insert(22898);
    MapBosses[564].insert(22841);
    MapBosses[564].insert(22948);
    MapBosses[564].insert(22947);

    //MapId = 534, MapName = Hyjal Summit
    MapBosses[534].insert(17968);

    //MapId = 548, MapName = Serpentshrine Cavern
    MapBosses[548].insert(21212);
    MapBosses[548].insert(21216);
    MapBosses[548].insert(21217);
    MapBosses[548].insert(21215);
    MapBosses[548].insert(21214);
    MapBosses[548].insert(21213);

    //MapId = 580, MapName = Sunwell Plateau
    MapBosses[580].insert(24892);
    MapBosses[580].insert(25166);
    MapBosses[580].insert(25165);

    //MapId = 544, MapName = Magtheridon's Lair
    MapBosses[544].insert(17257);

    //MapId = 532, MapName = Karazhan
    MapBosses[532].insert(15687);
    MapBosses[532].insert(16457);
    MapBosses[532].insert(15691);
    MapBosses[532].insert(15688);
    MapBosses[532].insert(16524);
    MapBosses[532].insert(15689);
    MapBosses[532].insert(17225);
    MapBosses[532].insert(15690);

    //MapId = 565, MapName = Gruul's Lair
    MapBosses[565].insert(19044);
    MapBosses[565].insert(18831);

    //MapId = 616, MapName = The Eye
    MapBosses[616].insert(28859);

    //MapId = 603, MapName = Ulduar
    MapBosses[603].insert(33113);
    MapBossesAlternativeEntries[33113].insert(34003);
    MapBossesAlternativeEntries[34003].insert(33113);
    MapBosses[603].insert(33118);
    MapBossesAlternativeEntries[33118].insert(33190);
    MapBossesAlternativeEntries[33190].insert(33118);
    MapBosses[603].insert(33186);
    MapBossesAlternativeEntries[33186].insert(33724);
    MapBossesAlternativeEntries[33724].insert(33186);
    MapBosses[603].insert(33293);
    MapBossesAlternativeEntries[33293].insert(33885);
    MapBossesAlternativeEntries[33885].insert(33293);
    MapBosses[603].insert(32857);
    MapBossesAlternativeEntries[32857].insert(33694);
    MapBossesAlternativeEntries[33694].insert(32857);
    MapBosses[603].insert(33515);
    MapBossesAlternativeEntries[33515].insert(34175);
    MapBossesAlternativeEntries[34175].insert(33515);
    MapBosses[603].insert(33271);
    MapBossesAlternativeEntries[33271].insert(33449);
    MapBossesAlternativeEntries[33449].insert(33271);

    //MapId = 724, MapName = The Ruby Sanctum
    MapBosses[724].insert(39751);
    MapBossesAlternativeEntries[39751].insert(39920);
    MapBossesAlternativeEntries[39920].insert(39751);
    MapBosses[724].insert(39746);
    MapBossesAlternativeEntries[39746].insert(39805);
    MapBossesAlternativeEntries[39805].insert(39746);
    MapBosses[724].insert(39747);
    MapBossesAlternativeEntries[39747].insert(39823);
    MapBossesAlternativeEntries[39823].insert(39747);

    //MapId = 249, MapName = Onyxia's Lair
    MapBosses[249].insert(10184);
    MapBossesAlternativeEntries[10184].insert(36538);
    MapBossesAlternativeEntries[36538].insert(10184);

    //MapId = 615, MapName = The Obsidian Sanctum
    MapBosses[615].insert(30452);
    MapBossesAlternativeEntries[30452].insert(31534);
    MapBossesAlternativeEntries[31534].insert(30452);
    MapBosses[615].insert(30451);
    MapBossesAlternativeEntries[30451].insert(31520);
    MapBossesAlternativeEntries[31520].insert(30451);
    MapBosses[615].insert(30449);
    MapBossesAlternativeEntries[30449].insert(31535);
    MapBossesAlternativeEntries[31535].insert(30449);
    MapBosses[615].insert(28860);
    MapBossesAlternativeEntries[28860].insert(31311);
    MapBossesAlternativeEntries[31311].insert(28860);

    //MapId = 533, MapName = Naxxramas
    MapBosses[533].insert(15956);
    MapBossesAlternativeEntries[15956].insert(29249);
    MapBossesAlternativeEntries[29249].insert(15956);
    MapBosses[533].insert(15953);
    MapBossesAlternativeEntries[15953].insert(29268);
    MapBossesAlternativeEntries[29268].insert(15953);
    MapBosses[533].insert(15952);
    MapBossesAlternativeEntries[15952].insert(29278);
    MapBossesAlternativeEntries[29278].insert(15952);
    MapBosses[533].insert(15954);
    MapBossesAlternativeEntries[15954].insert(29615);
    MapBossesAlternativeEntries[29615].insert(15954);
    MapBosses[533].insert(15936);
    MapBossesAlternativeEntries[15936].insert(29701);
    MapBossesAlternativeEntries[29701].insert(15936);
    MapBosses[533].insert(16011);
    MapBossesAlternativeEntries[16011].insert(29718);
    MapBossesAlternativeEntries[29718].insert(16011);
    MapBosses[533].insert(16061);
    MapBossesAlternativeEntries[16061].insert(29940);
    MapBossesAlternativeEntries[29940].insert(16061);
    MapBosses[533].insert(16060);
    MapBossesAlternativeEntries[16060].insert(29955);
    MapBossesAlternativeEntries[29955].insert(16060);
    MapBosses[533].insert(16028);
    MapBossesAlternativeEntries[16028].insert(29324);
    MapBossesAlternativeEntries[29324].insert(16028);
    MapBosses[533].insert(15931);
    MapBossesAlternativeEntries[15931].insert(29373);
    MapBossesAlternativeEntries[29373].insert(15931);
    MapBosses[533].insert(15932);
    MapBossesAlternativeEntries[15932].insert(29417);
    MapBossesAlternativeEntries[29417].insert(15932);
    MapBosses[533].insert(15928);
    MapBossesAlternativeEntries[15928].insert(29448);
    MapBossesAlternativeEntries[29448].insert(15928);
    MapBosses[533].insert(15989);
    MapBossesAlternativeEntries[15989].insert(29991);
    MapBossesAlternativeEntries[29991].insert(15989);
    MapBosses[533].insert(15990);
    MapBossesAlternativeEntries[15990].insert(30061);
    MapBossesAlternativeEntries[30061].insert(15990);

    //MapId = 631, MapName = Icecrown Citadel
    MapBosses[631].insert(36612);
    MapBossesAlternativeEntries[36612].insert(37957);
    MapBossesAlternativeEntries[37957].insert(36612);
    MapBossesAlternativeEntries[36612].insert(37958);
    MapBossesAlternativeEntries[37958].insert(36612);
    MapBossesAlternativeEntries[36612].insert(37959);
    MapBossesAlternativeEntries[37959].insert(36612);
    MapBosses[631].insert(36855);
    MapBossesAlternativeEntries[36855].insert(38106);
    MapBossesAlternativeEntries[38106].insert(36855);
    MapBossesAlternativeEntries[36855].insert(38296);
    MapBossesAlternativeEntries[38296].insert(36855);
    MapBossesAlternativeEntries[36855].insert(38297);
    MapBossesAlternativeEntries[38297].insert(36855);
    MapBosses[631].insert(36678);
    MapBossesAlternativeEntries[36678].insert(38431);
    MapBossesAlternativeEntries[38431].insert(36678);
    MapBossesAlternativeEntries[36678].insert(38585);
    MapBossesAlternativeEntries[38585].insert(36678);
    MapBossesAlternativeEntries[36678].insert(38586);
    MapBossesAlternativeEntries[38586].insert(36678);
    MapBosses[631].insert(37955);
    MapBossesAlternativeEntries[37955].insert(38434);
    MapBossesAlternativeEntries[38434].insert(37955);
    MapBossesAlternativeEntries[37955].insert(38435);
    MapBossesAlternativeEntries[38435].insert(37955);
    MapBossesAlternativeEntries[37955].insert(38436);
    MapBossesAlternativeEntries[38436].insert(37955);

    //MapId = 616, MapName = The Eye of Eternity
    MapBosses[616].insert(28859);

    //MapId = 624, MapName = Vault of Archavon
    MapBosses[624].insert(38433);
    MapBossesAlternativeEntries[38433].insert(38462);
    MapBossesAlternativeEntries[38462].insert(38433);
    MapBosses[624].insert(31125);
    MapBossesAlternativeEntries[31125].insert(31722);
    MapBossesAlternativeEntries[31722].insert(31125);
    MapBosses[624].insert(33993);
    MapBossesAlternativeEntries[33993].insert(33994);
    MapBossesAlternativeEntries[33994].insert(33993);
    MapBosses[624].insert(35013);
    MapBossesAlternativeEntries[35013].insert(35360);
    MapBossesAlternativeEntries[35360].insert(35013);

    MapClearRewards[48].push_back(17967);
    MapClearRewards[230].push_back(23854);
    MapClearRewards[229].push_back(20819);
    MapClearRewards[429].push_back(20822);
    MapClearRewards[90].push_back(20825);
    MapClearRewards[349].push_back(20829);
    MapClearRewards[389].push_back(20952);
    MapClearRewards[129].push_back(20953);
    MapClearRewards[47].push_back(20957);
    MapClearRewards[189].push_back(20962);
    MapClearRewards[289].push_back(20965);
    MapClearRewards[33].push_back(21772);
    MapClearRewards[329].push_back(21773);
    MapClearRewards[109].push_back(36915);
    MapClearRewards[36].push_back(43557);
    MapClearRewards[34].push_back(43558);
    MapClearRewards[70].push_back(43559);
    MapClearRewards[43].push_back(43560);
    MapClearRewards[209].push_back(43561);
    MapClearRewards[558].push_back(43562);
    MapClearRewards[543].push_back(43563);
    MapClearRewards[534].push_back(2693);
    MapClearRewards[585].push_back(5105);
    MapClearRewards[557].push_back(5330);
    MapClearRewards[556].push_back(5333);
    MapClearRewards[555].push_back(6216);
    MapClearRewards[552].push_back(6374);
    MapClearRewards[542].push_back(7681);
    MapClearRewards[553].push_back(8426);
    MapClearRewards[554].push_back(9443);
    MapClearRewards[540].push_back(17024);
    MapClearRewards[547].push_back(17195);
    MapClearRewards[545].push_back(19882);
    MapClearRewards[546].push_back(19911);
    MapClearRewards[619].push_back(34645);
    MapClearRewards[601].push_back(34647);
    MapClearRewards[600].push_back(34735);
    MapClearRewards[604].push_back(36914);
    MapClearRewards[602].push_back(37089);
    MapClearRewards[668].push_back(37090);
    MapClearRewards[599].push_back(37100);
    MapClearRewards[658].push_back(37161);
    MapClearRewards[632].push_back(37837);
    MapClearRewards[576].push_back(38270);
    MapClearRewards[578].push_back(38272);
    MapClearRewards[574].push_back(38625);
    MapClearRewards[575].push_back(39506);
    MapClearRewards[608].push_back(39526);
    MapClearRewards[409].push_back(39527);
    MapClearRewards[531].push_back(41804);
    MapClearRewards[509].push_back(41811);
    MapClearRewards[469].push_back(42170);
    MapClearRewards[564].push_back(42171);
    MapClearRewards[534].push_back(44852);
    MapClearRewards[548].push_back(44988);
    MapClearRewards[580].push_back(44989);
    MapClearRewards[544].push_back(44991);
    MapClearRewards[532].push_back(44992);
    MapClearRewards[565].push_back(44993);
    MapClearRewards[616].push_back(44994);
    MapClearRewards[603].push_back(44996);
    MapClearRewards[724].push_back(44997);
    MapClearRewards[249].push_back(54469);
    MapClearRewards[615].push_back(1222);
    MapClearRewards[533].push_back(3168);
    MapClearRewards[631].push_back(5362);
    MapClearRewards[616].push_back(5364);
    MapClearRewards[624].push_back(5367);

    //Stormwind Stockade
/*    MapBosses[34].insert(46383);
    MapBosses[34].insert(46264);
    MapBosses[34].insert(46254);
    //Shadowfang Keep
    MapBosses[33].insert(46962);
    MapBosses[33].insert(3887);
    MapBosses[33].insert(4278);
    MapBosses[33].insert(46963);
    MapBosses[33].insert(46964);*/

    new InstanceClearRegisterScript();
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, ICOnChatMessageReceived, NULL);

    //check spawn locations for each of the above monsters
    for (auto mapitr = MapBosses.begin(); mapitr != MapBosses.end(); mapitr++)
    {
        std::set<uint32> ListCopy = mapitr->second;
        for (auto entryitr = ListCopy.begin(); entryitr != ListCopy.end(); entryitr++)
        {
            char QueryByff[500];
            sprintf_s(QueryByff, sizeof(QueryByff), "SELECT position_x,position_y,guid FROM creature where map=%d and id=%d limit 0,1", mapitr->first, *entryitr);
            QueryResult result = WorldDatabase.Query(QueryByff);
            if (!result)
            {
                printf("!Could not find mob entry %d on map %d. Players will unable to complete instance clears !", *entryitr, mapitr->first);
                mapitr->second.erase(*entryitr);
                continue;
            }
            const CreatureTemplate *ce = sObjectMgr->GetCreatureTemplate(*entryitr);
            if(ce == NULL)
            {
                printf("!Could not find mob entry %d. Players will unable to complete instance clears !", *entryitr);
                mapitr->second.erase(*entryitr);
                continue;
            }

            Field* fields = result->Fetch();
            PingXY *txy = new PingXY();
            txy->x = fields[0].GetFloat();
            txy->y = fields[1].GetFloat();
            txy->SpawnId = fields[2].GetUInt32();
            txy->Name = ce->Name.c_str();
            MapBossLocations[*entryitr] = txy;
        }
    }
}
//select * from item_template where entry in (813,1222,2693,3168,5105,5330,5333,5362,5363,5364,5367,5370,5371,5377,5435,6150,6216,6297,6374,6455,6456,7681,8164,8426,8427,9443,10457,11941,17024,17195,17967,19882,19911,20819,20822,20825,20829,20952,20953,20957,20962,20965,21772,21773,21878,23330,23854,23922,23952,24506,24509,27441,27443,29565,29575,29576,30506,30507,30509,32725,34467,34645,34647,34735,34822,34823,34824,34825,34839,34843,34907,35626,36794,36795,36829,36830,36914,36915,37089,37090,37100,37161,37837,37839,38261,38263,38264,38269,38270,38272,38273,38274,38625,38957,39506,39526,39527,41804,41811,42170,42171,43321,43325,43326,43328,43329,43330,43333,43341,43557,43558,43559,43560,43561,43562,43563,43576,43577,43643,43645,43653,43694,43701,44299,44300,44464,44578,44580,44729,44755,44760,44761,44833,44852,44988,44989,44991,44992,44993,44994,44996,44997,45188,45190,45191,45194,45195,45197,45199,45202,45977,45978,45979,45980,45981,45999,46000,46001,46002,46003,46361,46368,46369,49209,54469);
//update item_template set stackable=20 quality=6 where entry in(17967,43562,34645,39527,42171,44996,23854,43563,34647,41804,44852,44997,20819,44852,34735,41811,44988,54469,20822,5105,36914,42170,44989,1222,20825,5330,37089,39527,44991,3168,20829,5333,37090,41804,44992,5362,20952,6216,37100,41811,44993,5364,20953,6374,37161,42170,5364,5367,20957,7681,37837,39527,42171,44996,20962,8426,38270,41804,44852,44997,20965,9443,38272,41811,44988,54469,21772,17024,38625,42170,44989,1222,21773,17195,39506,39527,44991,3168,36915,19882,39526,41804,44992,5362,43557,19911,34645,41811,44993,5364,43558,43562,34647,42170,5364,5367,43559,43563,34735,39527,42171,44996,43560,44852,36914,41804,44852,44997,43561,5105,37089,41811,44988,54469,17967,5330,37090,42170,44989,1222,23854,5333,37100,39527,44991,3168,20819,6216,37161,41804,44992,5362,20822,6374,37837,41811,44993,5364,20825,7681,38270,42170,5364,5367,20829,8426,38272,39527,42171,44996,20952,9443,38625,41804,44852,44997,20953,17024,39506,41811,44988,54469,20957,17195,39526,42170,44989,1222,20962,19882,34645,39527,44991,3168,20965,19911,34647,41804,44992,5362);

/*
48 Blackfathom Deeps	21 - 24	5-player	Dungeon
    Lady Sarevess 4831, Gelihast 6243, Lorgus Jett 12902, Twilight Lord Kelris 4832, Old Serra'kis 4830, Aku'mai 4829, Ghamoo-ra 4887
230 Blackrock Depths	49 - 56	5-player	Dungeon
    Lord Roccor 9025, Bael'Gar 9016, Houndmaster Grebmar 9319, High Interrogator Gerstahn 9018, Pyromancer Loregrain 9024, General Angerforge 9033, Golem Lord Argelmach 8983, Ribbly Screwspigot 9543, Hurley Blackbreath 9537, Plugger Spazzring 9499, Phalanx 9502, Lord Incendius 9017, Fineous Darkvire 9056, Warder Stilgiss 9041, Verek 9042, Ambassador Flamelash 9156, Magmus 9938, Princess Moira Bronzebeard 8929, Emperor Dagran Thaurissan 9019
229 Blackrock Spire	57 - 63	15-player	Dungeon
    Highlord Omok 9196, Shadow Hunter Vosh'gajin 9236, War Master Voone 9237, Mother Smolderweb 10596, Quartermaster Zigris 9736,Halycon 10220, Overlord Wyrmthalak 9568, Pyroguard Emberseer 9816, Warchief Rend Blackhand 10429, The Beast 10430, General Drakkisath 10363
429 Dire Maul	55 - 60	5-player	Dungeon
    Zevrim Thornhoof 11490, Hydrospawn 13280, Lethtendris 14327, Alzzin the Wildshaper 11492,   Guard Mol'dar 14326, Stomper Kreeg 14322, Guard Fengus 14321, Guard Slip'kik 14323, Captain Kromcrush 14325, King Gordok 11501,Cho'Rush the Observer 14324, Tendris Warpwood 11489, Illyanna Ravenoak 11488, Magister Kalendris 11487, Immol'thar 11496, Prince Tortheldrin 11486
90 Gnomeregan	25 - 28	5-player	Dungeon
    Viscous Fallout 7079, Electrocutioner 6000 6235, Crowd Pummeler 9-60 6229, Mekgineer Thermaplugg 7800
349 Maraudon	41 - 48	5-player	Dungeon
    Noxxion 13282, Razorlash 12258, Tinkerer Gizlock 13601, Lord Vyletongue 12236, Celebras the Cursed 12225, Landslide 12203, Rotgrip 13596, Princess Theradras 12201
389 Ragefire Chasm	15 - 16	5-player	Dungeon
    Taragaman the Hungerer 11520, Oggleflint 11517, Jergosh the Invoker 11518, Bazzalan 11519
129 Razorfen Downs	34 - 37	5-player	Dungeon
    Mordresh Fire Eye 7357, Glutton 8567, Amnennar the Coldbringer 7358
47 Razorfen Kraul	24 - 27	5-player	Dungeon
    Roogug 6168, Aggem Thorncurse 4424, Death Speaker Jargba 4428, Overlord Ramtusk 4420, Agathelos the Raging 4422, Charlga Razorflank 4421
189 Scarlet Monastery	29 - 40	5-player	Dungeon
    Interrogator Vishas 3983, Bloodmage Thalnos 4543, Houndmaster Loksey 3974, Arcanist Doan 6487, Herod <The Scarlet Champion> 3975, High Inquisitor Fairbanks 4542, High Inquisitor Whitemane 3977, Scarlet Commander Mograine 3976
289 Scholomance	55 - 60	5-player	Dungeon
    Jandice Barov 10503, Rattlegore 11622, Marduk Blackpool 10433, Vectus 10432, Ras Frostwhisper 10508, Instructor Malicia 10505, Doctor Theolen Krastinov 11261, Lorekeeper Polkelt 10901, The Ravenian 10507, Lord Alexei Barov 10504, Lady Illucia Barov 10502
33 Shadowfang Keep	18 - 21	5-player	Dungeon
    Odo the Blindwatcher 4279, Archmage Arugal 4275, Baron Silverlaine 3887, Razorclaw the Butcher 3886, Rethilgore 3914, Wolf Master Nandos 3927, Fenrus the Devourer 4274
329 Stratholme	55 - 60	5-player	Dungeon
    Malor the Zealous 11032, Cannon Master Willey 10997, Archivist Galford 10811, Baroness Anastari 10436, Nerub'enkan 10437, Maleki the Pallid 10438, Magistrate Barthilas 10435
109 Sunken Temple	47 - 50	5-player	Dungeon
    Jammal'an the Prophet 5710,Shade of Eranikus 5709,Ogom the Wretched 5711, Zolo 5712, Gasher 5713, Loro 5714, Hukku 5715, Zul'Lor 5716, Mijan 5717, Morphaz 5719, Hazzas 5722
36 The Deadmines	17 - 20	5-player	Dungeon
    Edwin VanCleef 639, Sneed's Shredder 642, Rhahk'Zor 644, Cookie 645, Mr. Smite 646, Gilnid 1763, Captain Greenskin 647, Miner Johnson 3586
34 The Stockade	22 - 25	5-player	Dungeon
    Dextren Ward 1663, Kam Deepfury 1666, Targorr the Dread 1696, Bazil Thredd 1716, Hamhock 1717, Bruegal Ironknuckle 1720
70 Uldaman	37 - 40	5-player	Dungeon
    Revelosh 6910,Baelog 6906,Ironaya 7228,Obsidian Sentinel 7023, Ancient Stone Keeper 7206,Galgann Firehammer 7291,Grimlok 4854, Archaedas 2748
43 Wailing Caverns	17 - 20	5-player	Dungeon
    Lady Anacondra 3671, Lord Cobrahn 3669, Kresh 3653, Lord Pythas 3670, Skum 3674, Lord Serpentis 3673, Verdan the Everliving 5775
209 Zul'Farrak	43 - 46	5-player	Dungeon
    Antu'sul 8127, Theka the Martyr 7272, Witch Doctor Zum'rah 7271, Hydromancer Velratha 7795, Ruuzlu 7797, Chief Ukorz Sandscalp 7267
558 Auchenai Crypts	65 - 73	5-player	Dungeon
    Shirrak the Dead Watcher 18371, Exarch Maladaar 18373
543 Hellfire Ramparts	59 - 73	5-player	Dungeon
    Watchkeeper Gargolmar 17306, Omor the Unscarred 17308
534 Hyjal Past	66 - 73	5-player	Dungeon
    Archimonde 17968
585 Magisters' Terrace	68 - 73	5-player	Dungeon
    Selin Fireheart 24723, Vexallus 24744, Priestess Delrissa 24560, Kael'thas Sunstrider 24664
557 Mana-Tombs	64 - 73	5-player	Dungeon
    Pandemonius 18341, Tavarok 18343, Nexus-Prince Shaffar 18344
556 Sethekk Halls	67 - 73	5-player	Dungeon
    Darkweaver Syth 18472, Talon King Ikiss 18473
555 Shadow Labyrinth	67 - 73	5-player	Dungeon
    Ambassador Hellmaw 18731, Blackheart the Inciter 18667, Grandmaster Vorpil 18732, Murmur 18708
552 The Arcatraz	68 - 73	5-player	Dungeon
    Zereketh the Unbound 20870, Dalliah the Doomsayer 20885, Wrath-Scryer Soccothrates 20886
542 The Blood Furnace	61 - 73	5-player	Dungeon
    The Maker 17381, Broggok 17380, Keli'dan the Breaker 17377
553 The Botanica	67 - 73	5-player	Dungeon
    Commander Sarannis 17976, High Botanist Freywinn 17975, Thorngrin the Tender 17978, Laj 17980, Warp Splinter 17977
554 The Mechanar	67 - 73	5-player	Dungeon
    Mechano-Lord Capacitus 19219, Nethermancer Sepethrea 19221, Pathaleon the Calculator 19220
540 The Shattered Halls	67 - 73	5-player	Dungeon
    Warbringer O'mrogg 16809, Warchief Kargath Bladefist 16808, Grand Warlock Nethekurse 16807
547 The Slave Pens	62 - 73	5-player	Dungeon
    Mennu the Betrayer 17941, Rokmar the Crackler 17991, Quagmirran 17942
545 The Steamvault	67 - 73	5-player	Dungeon
    Hydromancer Thespia 17797, Mekgineer Steamrigger 17796, Warlord Kalithresh 17798
546 The Underbog	63 - 73	5-player	Dungeon
    Hungarfen 17770, Ghaz'an 18105, Swamplord Musel'ek 17826, The Black Stalker 17882
wotlk

619 Ahn'kahet: The Old Kingdom	73 - 83	5-player	Dungeon
    Elder Nadox 29309, Prince Taldaram 29308, Jedoga Shadowseeker 29310, Herald Volazj 29311, Amanitar 30258
601 Azjol-Nerub	72 - 83	5-player	Dungeon
    Krik'thir the Gatewatcher 28684, Hadronox 28921, Anub'arak 29120
600 Drak'Tharon Keep	74 - 83	5-player	Dungeon
    Trollgore 26630, Novos the Summoner 26631, King Dred 27483, The Prophet Tharon'ja 26632
604 Gundrak	76 - 83	5-player	Dungeon
    Slad'ran 29304, Drakkari Colossus 29307, Moorabi 29305, Gal'darah 29306
602 Halls of Lightning	79 - 83	5-player	Dungeon
    General Bjarngrim 28586, Volkhan 28587, Ionar 28546
668 Halls of Reflection	79 - 83	5-player	Dungeon
    Falric 38112, Marwyn 38113
599 Halls of Stone	77 - 83	5-player	Dungeon
    Maiden of Grief 27975, Krystallus 27977, Sjonnir The Ironshaper 27978
658 Pit of Saron	79 - 83	5-player	Dungeon
    Forgemaster Garfrost 36494, Ick 36476
632 The Forge of Souls	79 - 83	5-player	Dungeon
    Bronjahm 36497, Devourer of Souls 36502
576 The Nexus	71 - 83	5-player	Dungeon
    Grand Magus Telestra 26731, Anomalus 26763, Ormorok the Tree-Shaper 26794
578 The Oculus	79 - 83	5-player	Dungeon
    Drakos the Interrogator 27654, Varos Cloudstrider 27447, Mage-Lord Urom 27655, Ley-Guardian Eregos 27656
Trial of the Champion	79 - 83	5-player	Dungeon

574 Utgarde Keep	69 - 83	5-player	Dungeon
    Prince Keleseth 23953, Skarvald the Constructor 24200
575 Utgarde Pinnacle	79 - 83	5-player	Dungeon
    Gortok Palehoof 26687, Skadi the Ruthless 26693
608 Violet Hold	75 - 83	5-player	Dungeon
    Erekem 29315, Moragg 29316, Ichoron 29313, Xevozz 29266, Lavanthor 29312, Zuramat the Obliterator 29314
*/
