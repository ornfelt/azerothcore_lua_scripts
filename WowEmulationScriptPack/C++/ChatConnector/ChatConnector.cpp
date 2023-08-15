#include "DatabaseEnv.h"
#include "ChannelMgr.h"
#include "Channel.h"
#include "ScriptMgr.h"
#include "Player.h"
#include "World.h"
#include "Chat.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "worldSession.h"
#include "GameTime.h"
#include <string.h>

#define CHAT_CONNECTOR_FAKE_PLAYER_GUID     ((uint64)(0x00FFFFFF-1))
#define CHAT_CONNECTOR_FAKE_PLAYER_Name     "Discord"

char *DBName = "";
char *RealmName = "FunRealm";
char ChatServerInternalId = 2;
char *ChannelToMonitor = "global";

#define toLower(c) (((c >= 'A') && (c <= 'Z')) ? (c - 'A' + 'a') : c)

bool IsSameStrInsensitive2(const char *str1, const char *str2)
{
    int Index = 0;
    while (str2[Index] != 0)
    {
        if (str1[Index] == toLower(str2[Index]))
            Index++;
        else
            return false;
    }

    if (str1[Index] == str2[Index]) //both should be at terminating 0
        return true;

    return false;
}

//on chat message, write it to DB
void ChatConnectorOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //skip GM messages
    if (params->Msg->c_str()[0] == '.')
        return;

    //is this message directed to channel we want to link ?
	if(IsSameStrInsensitive2(ChannelToMonitor, (*params->Channel).c_str( ) ) )
	{
		char Query[5000];
        std::string SafeMsg = *params->Msg;
        CharacterDatabase.EscapeString(SafeMsg);
		sprintf_s(Query, sizeof(Query), "insert into %sChatConnector (Stamp,SenderType,Server,Channel,UserName,Msg,Faction,PClass)values(%d,%d,'%s','%s','%s','%s','%d','%d')",
            DBName,(uint32)GameTime::GetGameTime(), ChatServerInternalId, RealmName, params->Channel->c_str(), params->SenderPlayer->GetName().c_str(), SafeMsg.c_str(), params->SenderPlayer->GetTeamId(), params->SenderPlayer->getClass());
		CharacterDatabase.Execute(Query);	
	}
}

HANDLE  MsgPushThread = 0;
DWORD __stdcall NotificationPushThread(LPVOID lpParam)
{
	int *ThreadIsRunning = (int*)lpParam;
	*ThreadIsRunning = 1;
	const int OneLoopSleepAmt = 500;
	int LastFetchedRowId = 0;
	while (*ThreadIsRunning == 1)
	{
		//periodically read DB to see if new messages appeared
        int PrevFetchedId = LastFetchedRowId;
		char Query[5000];

        //delete older than 10 minutes messages
        uint32 OldMessageStamp = (uint32)(GameTime::GetGameTime() - 10 * 60 * 1000);
        sprintf_s(Query, sizeof(Query), "delete from %sChatConnector where stamp < %u", DBName, OldMessageStamp);
        CharacterDatabase.Execute(Query);

		sprintf_s(Query, sizeof(Query), "select Id,UserName,Msg from %sChatConnector where SenderType!=%d and id>%d order by 268435455 - id desc limit 10", DBName, ChatServerInternalId,LastFetchedRowId);
		QueryResult result = CharacterDatabase.Query(Query);
		if (result)
		{
            do {
                Field* fields = result->Fetch();
                LastFetchedRowId = fields[0].GetUInt32();
                //send chat message in the name of this user
                ChannelMgr* cMgr = ChannelMgr::forTeam(ALLIANCE);
                Channel *chan = cMgr->GetJoinChannel(0, ChannelToMonitor, NULL);
                std::string what = "|cFFFF0000" + fields[1].GetString() + "|cFFFFFFFF" + ":" + "|cFF00FF00" + fields[2].GetString();

                chan->SayOfflinePlayer( ObjectGuid(CHAT_CONNECTOR_FAKE_PLAYER_GUID), what);
				
			} while (result->NextRow());
		}

        //delete the messages that we read from the DB
/*        if (PrevFetchedId != LastFetchedRowId)
        {
            sprintf_s(Query, sizeof(Query), "delete from ChatConnector where SenderType != %d and Id <= %d", ChatServerInternalId, LastFetchedRowId);
            CharacterDatabase.Execute(Query);
        }*/

        //wait a bit. No need to spam DB with polling
		Sleep(OneLoopSleepAmt);
	}

	// signal back that we finished running this thread
	*ThreadIsRunning = 0;

    printf("Exited ChatConnector message push thread. How is this even possible?\n");

	//all went as expected
	return 0;
}

void SendFakeNameQuery(uint64 Guid, const char *Name, Player *Destination)
{
    WorldPacket data(SMSG_NAME_QUERY_RESPONSE, (8 + 1 + 1 + 1 + 1 + 1 + 10));
    data << ObjectGuid(Guid).WriteAsPacked();
    data << uint8(0);                           // name known
    data << Name;                               // played name
    data << uint8(0);                           // realm name - only set for cross realm interaction (such as Battlegrounds)
    data << uint8(RACE_BLOODELF);
    data << uint8(1);     //sex
    data << uint8(CLASS_MAGE);
    data << uint8(0);                           // Name is not declined

    Destination->GetSession()->SendPacket(&data);
}

void HandleNameQueryChatConnectorPlayer(void *p, void *)
{
    CP_NAME_QUERY *params = PointerCast(CP_NAME_QUERY, p);

    if (params->GUID != CHAT_CONNECTOR_FAKE_PLAYER_GUID)
        return;

    SendFakeNameQuery(params->GUID, CHAT_CONNECTOR_FAKE_PLAYER_Name, params->Player);

    params->DenyDefaultParsing = 1;
}

static int      StatingMessagePushThread = 0;
static DWORD    MsgPushThreadIsRunning = 0;     //can shut it down with external command
class TC_GAME_API StartChatSenderThread : public PlayerScript
{
public:
    StartChatSenderThread() : PlayerScript("StartChatSenderThread") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        if (StatingMessagePushThread == 0)
        {
            StatingMessagePushThread = 1;

            //register thread that will periodically transfer messages found in DB to ingame chat
            DWORD   ThreadId;
            MsgPushThread = CreateThread(
                NULL,						// default security attributes
                0,							// use default stack size  
                NotificationPushThread,		// thread function name
                &MsgPushThreadIsRunning,	// argument to thread function 
                0,							// use default creation flags 
                &ThreadId);					// returns the thread identifier 

                                            //this is bad
            if (MsgPushThread == 0)
            {
                printf("Could not start message fetch thread");
                MsgPushThreadIsRunning = 0;
            }

        }
    }
};

void ReadLine2(FILE *f, char *buff, uint32 MaxLen)
{
    *buff = 0;
    while (!feof(f))
    {
        size_t BytesRead = fread(buff, 1, 1, f);
        if (*buff == '\n')
        {
            *buff = 0;
            return;
        }
        buff++;
    }
}

char *StringStartsWith(char *LongStr, char *PartialStr)
{
    int Index = 0;
    while (LongStr[Index] != 0 && PartialStr[Index] != 0 && toLower(LongStr[Index]) == toLower(PartialStr[Index]))
        Index++;

    if (LongStr[Index] != 0 && PartialStr[Index] == 0) //both should be at terminating 0
        return &LongStr[Index];

    return NULL;
}

void LoadSettings()
{
    FILE *SettingsFile = NULL;
    errno_t res = fopen_s(&SettingsFile,"ChatConnectorSettings.txt", "rt");
    if (SettingsFile == NULL)
        return;
    char LineBuff[500];
    do {
        ReadLine2(SettingsFile, LineBuff, sizeof(LineBuff));
        if (LineBuff[0] == 0)
            break;
        if (LineBuff[0] == '\n' || LineBuff[0] == '\r' || LineBuff[0] == '#')
            continue;
        if (char *ValStart= StringStartsWith(LineBuff,"DatabaseName="))
            DBName = strdup(ValStart);
        else if (char *ValStart = StringStartsWith(LineBuff, "RealmName="))
            RealmName = strdup(ValStart);
        else if (char *ValStart = StringStartsWith(LineBuff, "RealmId="))
            ChatServerInternalId = atoi(ValStart);
        else if (char *ValStart = StringStartsWith(LineBuff, "MonitoredChannel="))
            ChannelToMonitor = strdup(ValStart);
    } while (!feof(SettingsFile));
    fclose(SettingsFile);
}

void AddChatConnectorScripts()
{
    //load which channel to monitor
    LoadSettings();

	//register listner that will push messages to DB
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, ChatConnectorOnChatMessageReceived, NULL);

    //client might deny all posted messages unless comming form a real player
    RegisterCallbackFunction(CALLBACK_TYPE_NAME_QUERY, HandleNameQueryChatConnectorPlayer, NULL);

    //have to delay starting this thread or it will crash server. requires mysql to be up and running ...
    new StartChatSenderThread();
/*
CREATE TABLE IF NOT EXISTS `chatconnector` (
`Id` int(11) NOT NULL AUTO_INCREMENT,
`Stamp` int(11) DEFAULT NULL,
`Sendertype` int(11) DEFAULT NULL,
`Server` varchar(50) DEFAULT NULL,
`Channel` varchar(50) DEFAULT NULL,
`UserName` varchar(50) DEFAULT NULL,
`Msg` varchar(250) DEFAULT NULL,
`SeenByClients` int(11) DEFAULT NULL,
`Faction` int(11) DEFAULT NULL,
`PClass` int(11) DEFAULT NULL,
UNIQUE KEY `relation` (`Id`),
KEY `RowUniqueId` (`Id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
*/
}
