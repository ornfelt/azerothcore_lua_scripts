#include <stdio.h>
#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "Common.h"
#include "Player.h"
#include "Config.h"
#include "WorldSession.h"
#include "Language.h"
#include "Log.h"
#include "SpellAuras.h"
#include "World.h"
#include "Transport.h"
#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "SocialMgr.h"
#include "CreatureGroups.h"
#include "Language.h"
#include "TargetedMovementGenerator.h"
#include "CreatureAI.h"
#include "Player.h"
#include "Pet.h"
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
#include "Chat.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"
#include <time.h>
#include <stdio.h>
#include <Custom/Logic/CustomCharacterSystem.h>
#include <Custom/Logic/CustomReportSystem.h>
#include <Custom/Logic/CustomGMLogic.h>
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomTranslationSystem.h>

class ex_testcommands : public CommandScript
{
public:
	ex_testcommands() : CommandScript("ex_testcommands") { }

	std::vector<ChatCommand> GetCommands() const
	{

		
	
		static std::vector<ChatCommand> logicTable =
		{
			{ "id", SEC_ADMINISTRATOR , false, &HandleLogicIDTest, "" },
			{ "report", SEC_ADMINISTRATOR , false, &HandleLogicReportTest, "" },
			{ "gmlog", SEC_ADMINISTRATOR , false, &HandleLogicGMLogTest, "" },
			{ "name", SEC_ADMINISTRATOR, false, &HandleLogicNameTest, "" },
			{ "gildenid", SEC_ADMINISTRATOR, false, &HandleLogicGildenIDTest, "" },
			{ "time", SEC_ADMINISTRATOR, false, &HandleLogicTimeTest, "" },
			{ "playerlog", SEC_ADMINISTRATOR, false, &HandleLogicPlayerlogTest, "" },
			{ "gmaddlog", SEC_ADMINISTRATOR, false, &HandleLogicGMAddLogTest, "" },
			{ "playtime", SEC_ADMINISTRATOR, false, &HandleLogicPlayTimeTest, "" },
			{ "playinsert", SEC_ADMINISTRATOR, false, &HandleLogicPlayInsertTest, "" },
			{ "translate", SEC_ADMINISTRATOR, false, &HandleLogicTranslate, "" },
			
		};

	

		static std::vector<ChatCommand> commandTable =
		{
			{ "logic", SEC_ADMINISTRATOR , false, NULL, "" , logicTable },
			
		};

		return commandTable;
	}

	static bool HandleLogicTranslate(ChatHandler* handler, const char* /*args*/) {
		CustomTranslationSystem * TranslationSystem = 0;
		std::string teststring = TranslationSystem->getCompleteTranslationsString(1, 1, handler->GetSession()->GetPlayer());
		handler->PSendSysMessage("%s", teststring);
		return true;
	}



	static bool HandleLogicPlayInsertTest(ChatHandler* handler, const char* /*args*/) {
		//Player* player = handler->GetSession()->GetPlayer();
		//CharacterSystem->insertNewPlayerPlayTimeReward(200, player->GetSession()->GetPlayerName(), player->GetGUID());
		handler->PSendSysMessage("Command executed but Function is now private!");

		return true;
	}

	static bool HandleLogicPlayTimeTest(ChatHandler* handler, const char* /*args*/) {
		CustomCharacterSystem * CharacterSystem = 0;
		Player* player = handler->GetSession()->GetPlayer();
		CharacterSystem->completeAddPlayTimeReward(999,player->GetSession()->GetPlayer(),0,38186,"testcommand executed");
		handler->PSendSysMessage("Command executed!");
		return true;
	}

	static bool HandleLogicGMAddLogTest(ChatHandler* handler, const char* /*args*/) {
		CustomGMLogic * GMLogic = 0;
		Player* player = handler->GetSession()->GetPlayer();
	
		GMLogic->addCompleteGMCountLogic(player->GetSession()->GetPlayer(),"Testlog");
		return true;
	}
	
	static bool HandleLogicPlayerlogTest(ChatHandler* handler, const char* /*args*/) {
		CustomPlayerLog * PlayerLog = 0;
		Player* player = handler->GetSession()->GetPlayer();
		PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), "Testeintrag");
		return true;
	}

	static bool HandleLogicTimeTest(ChatHandler* handler, const char* /*args*/) {
		int playtime = 0;
		int leveltime = 0;
		

		//double difftime(time_t t1, time_t t2);
		Player* player = handler->GetSession()->GetPlayer();
		leveltime = player->GetLevelPlayedTime();
		
		playtime =	player->GetTotalPlayedTime();

		int differenz = 0;
		differenz = playtime - leveltime;
		handler->PSendSysMessage("Time Difference: %u", differenz);
		handler->PSendSysMessage("Totalplaytime: %u", playtime);
		handler->PSendSysMessage("Leveltime: %u", leveltime);
		return true;
	}

	static bool HandleLogicGildenIDTest(ChatHandler* handler, const char* /*args*/) {
		Player* player = handler->GetSession()->GetPlayer();
		
		int gildenid = 0;
		gildenid = player->GetGuildId();

		player->GetSession()->SendAreaTriggerMessage("Gildenid ist %u", gildenid);
		return true;
	}


	static bool HandleLogicIDTest(ChatHandler* handler, const char* /*args*/) {
		Player* player = handler->GetSession()->GetPlayer();
		CustomCharacterSystem* CharacterSystem = 0;
		
		int32 accountid = CharacterSystem->getAccountID(player->GetSession()->GetPlayerName());
		
		handler->PSendSysMessage("Accountid ist %u", accountid);
		return true;
	}

	static bool HandleLogicNameTest(ChatHandler* handler, const char* /*args*/) {
		Player* player = handler->GetSession()->GetPlayer();
		CustomCharacterSystem* CharacterSystem = 0;

		int32 accountid = CharacterSystem->getAccountID(player->GetSession()->GetPlayerName());
		std::string accountname = CharacterSystem->getAccountName(accountid);

	

		handler->PSendSysMessage("AccountId ist: %u und der Name ist %s",accountid,accountname);
		return true;
	}


	static bool HandleLogicReportTest(ChatHandler* handler, const char* args) {
		//Player* player = handler->GetSession()->GetPlayer();
		CustomReportSystem * ReportSystem = 0;
		

		std::string eingabe = std::string((char*)args);

		if (eingabe == "") {
			handler->PSendSysMessage("Bitte Questid angeben.");
			return true;
		}

		char* px = strtok((char*)args, " ");

		if (!px)
			return false;

		uint32 questid = (uint32)atoi(px);

		bool isreported = ReportSystem->checkIfQuestIsAlreadyReported(questid);
		handler->PSendSysMessage("Der Befehl hat den return wert: %s", isreported);
		return true;
	}

	static bool HandleLogicGMLogTest(ChatHandler* handler, const char* /*args*/) {
		CustomGMLogic* GMLogic = 0;
		CustomCharacterSystem* CharacterSystem =0;
		Player* player = handler->GetSession()->GetPlayer();
		int32 accountid = CharacterSystem->getAccountID(player->GetSession()->GetPlayerName());
		std::string accountname = CharacterSystem->getAccountName(accountid);
		GMLogic->addGMLog(player->GetSession()->GetPlayerName(), player->GetGUID(), accountname, accountid, "Testinsert");
		handler->PSendSysMessage("Command executed");
		return true;
	}
};

void AddSC_ex_testcommands()
{
	new ex_testcommands();
}

