#include "SharedDefines.h"
#include "ScriptMgr.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "Player.h"
#include "Random.h"
#include "WhoListStorage.h"
#include "DBCStores.h"
#include "DBCStorageIterator.h"
#include "DBCStructure.h"
#include "ObjectGuid.h"
#include "Language.h"
#include "Chat.h"
#include "DatabaseEnv.h"
#include "WorldSession.h"
#include "ObjectAccessor.h"

#define NUMBER_OF_FAKE_PLAYERS_EXIST    30
#define MIN_NUMBER_PLAYER_CLASS         5
#define MIN_PLAYER_LEVEL                80
#define MAX_PLAYER_LEVEL                80

class FakeWhoIsPlayer
{
public:
    FakeWhoIsPlayer()
    {
        Team = rand32() % 2;
        Sex = rand32() % 2;
        GUID = ( rand32() & 0x000FFFFF ) + 128123;// generate a random non existing guid
    }
    std::string  Name;
    std::string  GuildName;
    uint8        Level;
    uint8        Class_;
    uint8        Race;
    uint8        Gender;
    uint32       ZoneId;
    uint8        Team;
    uint8        Sex;
    uint64       GUID;
    uint64       LastWisperedBackPlayerGUID;
    bool         LoadFromDBAsIndex(uint32 Index);
};

std::list<FakeWhoIsPlayer*> FakePlayers;
static int LastWhisperBackMessageIndex = 0;

FakeWhoIsPlayer *FindFakePlayer(const char *DestinationPlayer)
{
    std::string SearchFor(DestinationPlayer);
    for (std::list<FakeWhoIsPlayer*>::iterator i = FakePlayers.begin(); i != FakePlayers.end(); i++)
        if ((*i)->Name == SearchFor)
        {
            //if this player is online than this is not a fake player !
            Player* invitedPlayer = ObjectAccessor::FindPlayerByName(SearchFor);
            if (invitedPlayer != NULL)
                return NULL;
            //this is a fake player indeed
            return (*i);
        }
    return NULL;
}
FakeWhoIsPlayer *FindFakePlayer(const uint64 GUID)
{
    for (std::list<FakeWhoIsPlayer*>::iterator i = FakePlayers.begin(); i != FakePlayers.end(); i++)
        if ((*i)->GUID == GUID)
            return (*i);
    return NULL;
}

void HandleAddFriendFakePlayer(void *p, void *)
{
    CP_ADD_FRIEND *params = PointerCast(CP_ADD_FRIEND, p);

    if (params->Player == NULL)
        return;

    FakeWhoIsPlayer *FP = FindFakePlayer(params->TargetPlayer);
    if (FP)
    {
        ChatHandler(params->Player->GetSession()).PSendSysMessage(LANG_PLAYER_AFK, FP->Name.c_str(), "");
        //do not allow server to tell the player that we do not exist
        params->DenyDefaultParsing = 1;
    }
}

void HandleGroupInviteFakePlayer(void *p, void *)
{
    CP_GROUP_INVITE *params = PointerCast(CP_GROUP_INVITE, p);

    if (params->Player == NULL)
        return;

    FakeWhoIsPlayer *FP = FindFakePlayer(params->TargetPlayer);
    if (FP)
    {
        ChatHandler(params->Player->GetSession()).PSendSysMessage(LANG_PLAYER_AFK, FP->Name.c_str(), "");
        //do not allow server to tell the player that we do not exist
        params->DenyDefaultParsing = 1;
    }
}

void HandleDirectWisper(void *p, void *)
{
    CP_WHISPER_FROM_CLIENT *params = PointerCast(CP_WHISPER_FROM_CLIENT, p);

    //sanity check
    if (params->Whisperer == NULL)
        return;

    //find the target player in the fake players list. If there is one
    FakeWhoIsPlayer *FP = FindFakePlayer(params->DestinationPlayer);
    if( FP )
    {
        //do not allow server to tell the player that we do not exist
        params->DenyDefaultParsing = 1;
        ChatHandler(params->Whisperer->GetSession()).PSendSysMessage(LANG_PLAYER_AFK, FP->Name.c_str(), "");
        //if we already whispered back, say we went quiet
        /*if (FP->LastWisperedBackPlayerGUID == params->Whisperer->GetGUID().GetRawValue())
        {
            ChatHandler(params->Whisperer->GetSession()).PSendSysMessage(LANG_PLAYER_AFK, FP->Name.c_str(), "");
            return;
        }
        FP->LastWisperedBackPlayerGUID = params->Whisperer->GetGUID().GetRawValue();

        //pick a random whisper back message
        static char *ReplyBackMessages[] = { "Come ICC, need healer", "Help me test my gear. Let's duel at mall", "Please join our guild", "How do i get starter gear ?", "What rates is this server ?", "YES !", " " };    //last message needs to be empty !
        if (ReplyBackMessages[LastWhisperBackMessageIndex][0] == ' ')
            LastWhisperBackMessageIndex = 0;

        WorldPacket data;
        ChatHandler::BuildChatPacket(data, CHAT_MSG_WHISPER, Language::LANG_UNIVERSAL, ObjectGuid(FP->GUID), params->Whisperer->GetGUID(), std::string(ReplyBackMessages[LastWhisperBackMessageIndex]),
            CHAT_TAG_NONE, FP->Name, params->Whisperer->GetName());
        params->Whisperer->SendDirectMessage(&data);

        //next player gets the next message
        LastWhisperBackMessageIndex++;*/
    }
}

void HandleNameQueryFakePlayer(void *p, void *)
{
    CP_NAME_QUERY *params = PointerCast(CP_NAME_QUERY, p);

    FakeWhoIsPlayer *FP = FindFakePlayer(params->GUID);
    if (FP)
    {
        WorldPacket data(SMSG_NAME_QUERY_RESPONSE, (8 + 1 + 1 + 1 + 1 + 1 + 10));
        data << ObjectGuid(params->GUID).WriteAsPacked();
        data << uint8(0);                         // name known
        data << FP->Name;                         // played name
        data << uint8(0);                         // realm name - only set for cross realm interaction (such as Battlegrounds)
        data << uint8(FP->Race);
        data << uint8(FP->Sex);     //sex
        data << uint8(FP->Class_);
        data << uint8(0);                           // Name is not declined
        params->Player->GetSession()->SendPacket(&data);
    }
}

void HandleWhoisListUpdated(void *p, void *)
{
    WhoListInfoVector *PlayerList = (WhoListInfoVector *)p;
    for (std::list<FakeWhoIsPlayer*>::iterator i = FakePlayers.begin(); i != FakePlayers.end(); i++)
    {
        //if this player is online, skipp adding him to the list a second time
        bool IsPlayerOnline = false;
        for( WhoListInfoVector::iterator i2 = PlayerList->begin(); i2 != PlayerList->end(); i2++)
            if (i2->GetPlayerName() == (*i)->Name )
            {
                IsPlayerOnline = true;
                break;
            }
        if (IsPlayerOnline == true)
            continue;

        uint32 FreqZones1[] = { 4813,4809,4820,4722,4812,4603 };
        uint32 FreqZones2[] = { 210,66,67,3537,495,394 };
        uint32 FreqZones3[] = { 4613,1637,1519 };
        uint32 ZoneId = 0;
        if (rand_chance() < 50)
            ZoneId = FreqZones1[rand32() % (sizeof(FreqZones1) / sizeof(uint32))];
        else if (rand_chance() < 50)
            ZoneId = FreqZones2[rand32() % (sizeof(FreqZones2) / sizeof(uint32))];
        else if (rand_chance() < 50)
            ZoneId = FreqZones3[rand32() % (sizeof(FreqZones3) / sizeof(uint32))];
        else
        {
            //pick a random zone Id
            uint32 SearchRowNum = rand32() % (sAreaTableStore.GetNumRows() / 2);
            for (DBCStorageIterator<AreaTableEntry> j = sAreaTableStore.begin(); j != sAreaTableStore.end(); j++)
            {
                SearchRowNum--;
                if (SearchRowNum == 0)
                {
                    ZoneId = (*j)->ID;      // just in case we did not initialize it yet
                    break;
                }
            }
        }

        std::wstring NameW;
        if (!Utf8toWStr((*i)->Name, NameW))
            continue;
        std::wstring GuildW;
        if (!Utf8toWStr((*i)->GuildName, GuildW))
            continue;

        //inject ourself into the list
        PlayerList->emplace_back( ObjectGuid((*i)->GUID), (*i)->Team, SEC_PLAYER, (*i)->Level, (*i)->Class_, (*i)->Race, ZoneId, (*i)->Gender, 1, NameW, GuildW, (*i)->Name, (*i)->GuildName);
    }
}

char *GetnextPlayerName(uint32 Index)
{
    //try to select next one from DB
    //list of names we will pick from
    char *FakePlayerNames[] = { "Zombie","Gold","Snoffie","Enerhy","Pallysong","Red","Negru","Sarah","Oxycodone","Beez","Baremaras","Phenomx","Zeroz","Daddy","Rapiniggers","Hanginiggers","Azeryth","Ceedio","Rodakq","Kensai","Kaliria","Disharmony","Battlemaid","Wraith","Kamaitachi","Aurelia","Starfaller","Obama","Furbyball","Prodigy","Hodge","Mailguy","Dad","Nyx","Jd","Foxxy","Todne","Rahorku","Power","Ierg","Sup","Fireballin","Arrowz","Swp","Lawlz","Foxxymoo","Gorgoroth","Dog","Kitty","Pandora","Ry","Arina","Complication","Asdasd","Lawlzi","Pop","Malakith","Fake","Geforce","Bella","Magic","Deminaris","Flabotomize","Priestality","Crystca","Huntarded","Moonmann","Milkorcream","Elemental","Hancook","Kazekari","Lina","Zerozx","Myth","Asdgf","First","Ugly","Bdfoxxy","Miria","Nahilli","Reffelar","Danix","Calleymor","Foxxytroll","Nightmare","Kickstarter","Annoying","Rare","Irky","Rebz","Iluminaughty","Gorgeous","Innocence","Lecihawajska","Vyntlanth","Sorrow","Cone","Portun","Thun","Heargangus","Warlartis","Gandelik","Darlayson","Curthane","Kyuss","Sanso","Llin","Hallian","Krabat","Darak","Unholyvanish","Anticide","Banished","Ghjgjfg","Rottentits","Hush","Tangsaku","Rawrg","Gilgan","Kiaxxar","Athena","Ares","Persephone","Artemis","Hecate","Aphrodite","Freyja","Drug","Rick","Anduin","Bartosz","Assesyn","Fdgdg","Yhdyhdh","Husciasasinu","Delhuskimag","Huskyhunter","Leron","Dort","Malfoyd","Hyperstorm","Stela","Kosata","Apophysis","Abirnar","Todd","Kalstan","Larinia","Beautiful","Leonter","Nox","Blazehaze","Branah","Ibelus","Paradox","Shade","Pyrodox","Dox","Dante","Arnna","Jarlax","Neith","Saeada","Taurenlady","Deimos","Angulz","Heal","Lock","Baal","Reid","Elwasson","Teengodswag","Zombiedalv","Roguetrainer","Gotacold","Adouken","Thranduil","Foxxydruid","Kyoze","Foxxyredhead","Maplesyrup","Ketamine","Asdadsd","Joly","Clexios","Dagger","Storme","Totem","Crvenii","Hath","Lawl","Superdeath","Aliz","Rendo","Rendobro","Ruzio","Speedy","Dzsalock","Mihbrad","Galex","Slay","Kill","Dead","Shadow","Good","Demon","Deathbound","Warmaid","Dread","Blood","Battlemage","Suspect","Talan","Virginmary","Crybaby","Beauty","Silence","Holycow","Aky","Hottany","Rageyboi","Kesotia","Idktoheal","Onakio","Rynea","Plop","Nestor","Naxx","Ayo","Gaffermor","Tariirn","Bruair","Mina","Wargex","Kassar","Ftka","Mihpin","Enguia","Aziado","Mihflore","Sapdatass","Craigy","Deathsmiles","Mechahunter","Mecbeth","Insane","Voth","Palamendon","Nightmareflf","Buh","Picadarken","Ded","Coolname","Ihadnochoice","Ariana","Konkon","Envi","Dsqdqs","Crying","Akos","Sora","Death","Crazyrock","Unholytechno","Benediction","Dogstomper","Oj","Paladox","Sick","Shamwow","Phildoh","Falgore","Nerdform","Bryn","Swiftmane","Houndess","Dinget","Shlidd","Shiftter","Shauana","Adorant","Knowing","Saber","Danden","Vaeian","Waydelan","Mara","Xandazann","Nevil","Pathamarol","Chris","Tareile","Lothay","Velinnis","Priestes","Dkdarken","Day","Night","Dark","Volume","Bigb","Percsbruh","Shmatka","Law","Beast","Nenadus","Dale","Light","Ice","Inferno","Life","Steel","Helicopter","Gsdfgdsgfsd","Kalira","Suchii","Gungand","Hiimnew","Leiko","John","Berthon","Falamorda","Evil","Walamorda","Kowal","Nmn","Thanaqt","Verthe","Cursing","Azhael","Melvira","Wearelegends","Kapostigrite","Peligroso","Zoepox","Plauz","Devonettin","Erodorissa","Greghar","Xakil","Seluna","Defconz","Thunderstorm","Madox","Athenez","Froatitude","Oladipo","Magoxy","Amsera","Angelz","Feardotcom","Altezia", " " };   //last name needs to be ' '
    if(FakePlayerNames[Index][0] == ' ')
        return NULL;
    char *ret = FakePlayerNames[Index];
    return ret;
}

bool FakeWhoIsPlayer::LoadFromDBAsIndex(uint32 Index)
{
    char Query[5000];
    sprintf_s(Query, sizeof(Query), "select guid,name,level,class,race,gender from characters where online=0 order by totaltime desc limit %d,1", Index);
    QueryResult result = CharacterDatabase.Query(Query);
    if (!result || result->GetRowCount() != 1)
        return false;

    Field* fields = nullptr;
    fields = result->Fetch();
//    GUID = fields[0].GetUInt32();
    Name = fields[1].GetString();
    Level = fields[2].GetUInt8();
    Class_ = fields[3].GetUInt8();
    Race = fields[4].GetUInt8();
    Gender = fields[5].GetUInt32();

    return true;
}

void GenerateFakePlayers()
{
    char *FakePlayerGuilds[] = { "La Onda","The Politicians","Gjallarhorn","HoldMyBearNWatchThis","Gods", " " };   //last name needs to be ' '
    uint32 NextPlayerNameToPick = 0;
    uint32 DBLoadedIndex = 0;
    for (int team = 0; team <= 1; team++)
    {
        for (int i = 0; i < NUMBER_OF_FAKE_PLAYERS_EXIST / 2; i++)
        {
            FakeWhoIsPlayer *fp = new FakeWhoIsPlayer;

            if (!fp->LoadFromDBAsIndex(DBLoadedIndex))
            {
                //pick a name
                do {
                    fp->Name = GetnextPlayerName(NextPlayerNameToPick);
                    if (fp->Name.length() == 0)
                        return; //that's it. We can't add more players
                    NextPlayerNameToPick++;
                } while (FindFakePlayer(fp->Name.c_str()) != NULL);

                //pick a guild
                for (int j = 0; FakePlayerGuilds[j][0] != ' '; j++)
                {
                    if (rand_chance() < 70)
                        continue;
                    fp->GuildName = FakePlayerGuilds[j];
                    break;
                }

                //pick a level
                if (MAX_PLAYER_LEVEL - MIN_PLAYER_LEVEL > 0)
                    fp->Level = MIN_PLAYER_LEVEL + (int)(rand_chance() * (MAX_PLAYER_LEVEL - MIN_PLAYER_LEVEL) / 100.f);
                else
                    fp->Level = MAX_PLAYER_LEVEL;

                //pick a class
                do {
                    fp->Class_ = rand32() % MAX_CLASSES;
                } while (fp->Class_ == 10);

                //pick a race
                do {
                    fp->Race = rand32() % MAX_RACES;
                } while (fp->Race == 9);

                //pick a gender
                fp->Gender = rand32() % 2;
            }
            else
            {
                DBLoadedIndex++;
            }

            //level 60 playing on insta 80 server ?
            if (fp->Level < MIN_PLAYER_LEVEL)
                fp->Level = MIN_PLAYER_LEVEL;

            //add it to our list
            FakePlayers.push_back(fp);
        }
    }
}

void AddFakeWhoPlayersScripts()
{
    //get some from DB, add extra if not enough
    GenerateFakePlayers();

    //when server refreshes the list of players, we add our list to it
    RegisterCallbackFunction(CALLBACK_TYPE_WHOIS_LIST_UPDATED, HandleWhoisListUpdated, NULL);

    //If someone whispers us, we whisper back something
    RegisterCallbackFunction(CALLBACK_TYPE_WHISPER_NOCHECKS, HandleDirectWisper, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_ADD_FRIEND, HandleAddFriendFakePlayer, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_GROUP_INVITE, HandleGroupInviteFakePlayer, NULL);
    RegisterCallbackFunction(CALLBACK_TYPE_NAME_QUERY, HandleNameQueryFakePlayer, NULL);
}
