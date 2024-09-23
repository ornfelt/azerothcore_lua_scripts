#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "Common.h"
#include "Player.h"
#include "WorldSession.h"
#include "Language.h"
#include "Log.h"
#include "SpellAuras.h"
#include "World.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "Config.h"
#include <iostream>
#include <iterator>
#include <vector>
#include <random>
#include <algorithm>

#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "SocialMgr.h"
#include <Custom/Logic/CustomWorldSystem.h>
#include <Custom/Logic/CustomCouponSystem.h>
#include <Custom/Logic/CustomGMLogic.h>
#include <Custom/Logic/CustomCharacterSystem.h>


class autobroadcast : public CommandScript
{
public:
	autobroadcast() : CommandScript("autobroadcast") { }

	std::vector<ChatCommand> GetCommands()  const override
	{

		static std::vector<ChatCommand> autobroadcasttable =
		{

			{ "set", SEC_ADMINISTRATOR, false, &HandleSetAutobroadcast, "" },

		};

		static std::vector<ChatCommand> commandTable =
		{
			{ "autobroadcast", SEC_ADMINISTRATOR , false, NULL, "" , autobroadcasttable },

		};

		return commandTable;
	}





	//Gibt dem Eventteam die Moeglichkeit Gutscheine fuer Spieler zu erstellen.
	static bool HandleSetAutobroadcast(ChatHandler* handler, const char* args)
	{
		CustomGMLogic * GMLogic = 0;
		GMLogic->insertNewAutobroadCast(handler->GetSession()->GetPlayer(),args);
		return true;

	};



};


void AddSC_AutobroadCast()
{
	new autobroadcast();
}