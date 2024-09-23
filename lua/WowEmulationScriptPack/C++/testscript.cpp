#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include "Bag.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Define.h"
#include "Field.h"
#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include "Bag.h"
#include "Mail.h"
#include "Common.h"
#include "CalendarMgr.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStructure.h"
#include "Define.h"
#include "Field.h"
#include "GameEventMgr.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "ObjectGuid.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QueryResult.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Transaction.h"
#include "WorldSession.h"
#include <sstream>
#include <string>
#include <stdlib.h>
#include "Guild.h"
#include "Arena.h"
#include "ArenaTeam.h"
#include "ArenaScore.h"
#include "ArenaTeamMgr.h"
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomCharacterSystem.h>
#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "SocialMgr.h"
#include <Custom/Logic/CustomWorldSystem.h>
#include <Custom/Logic/CustomCouponSystem.h>
#include <Custom/Logic/CustomGMLogic.h>
#include <Custom/Logic/CustomCharacterSystem.h>


class TestScript : public CommandScript
{
public:
	TestScript() : CommandScript("TestScript") { }

	std::vector<ChatCommand> GetCommands()  const override
	{

		static std::vector<ChatCommand> testtable =
		{

			{ "one", SEC_ADMINISTRATOR, false, &HandleSetTestScript, "" },

		};

		static std::vector<ChatCommand> commandTable =
		{
			{ "testscript", SEC_ADMINISTRATOR , false, NULL, "" , testtable },

		};

		return commandTable;
	}





	//Gibt dem Eventteam die Moeglichkeit Gutscheine fuer Spieler zu erstellen.
	static bool HandleSetTestScript(ChatHandler* handler, const char* /*args*/)
	{
		Player * player = handler->GetSession()->GetPlayer();
		Map * map = player->GetMap();

		Map::PlayerList const& players = map->GetPlayers();

		if (!players.isEmpty())
		{
			for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
			{
				if (Player* player = itr->GetSource()) {
					player->TeleportTo(0, -12832.98f, -1374.24f, 113.46f, 3.97f);
					
				}
			}
		}

		player->GetSession()->SendAreaTriggerMessage("Executed!");
		return true;

	};



};



void AddSC_testscript()
{
	new TestScript();
}
	