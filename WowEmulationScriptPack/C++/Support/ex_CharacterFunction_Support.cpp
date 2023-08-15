#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"
#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include "Bag.h"
#include "Common.h"
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
#include <Custom/Logic/CustomGMLogic.h>
#include <Custom/Logic/CustomCharacterSystem.h>
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomTranslationSystem.h>

#define GROUPID 4


enum Supportmenu {
	DOESCHARACTEREXISTMENU = 1,
	TRANSFERCHARACTERMENU = 2,
	GIVEMENEWFIRSTCHARACTERMENU = 3,
	BRINGMEBACKMENU = 4,
	HELPMENU = 5,
	ACCOUNTTRANSFERMENU = 6,

};

enum areusure {

	YOURCHARACTERNAME = 3000,
	YOURACCOUNTNAME = 3001,
	AREUSUREFIRST = 3002,

};

enum Errormsg {
	NOCHARACTERFOUNDERR = 1000,
	NOACCOUNTFOUNDERR = 1001,
	NOTENOUGHCOINSERR = 1002,
	TOOMANYCHARACTERSERR = 1003,
};


enum Explanations {
	HOWDOESCHARACTERFRANSFERWORKHELP = 2000,
};

class automatic : public CreatureScript
{
public:
	automatic() : CreatureScript("automatic") { }


	bool OnGossipHello(Player* player, Creature* creature)
	{
		if (sConfigMgr->GetBoolDefault("Characterhelper.NPC", true)) {
			CustomTranslationSystem * TranslationSystem = 0;

			std::string characterexistmenu = TranslationSystem->getCompleteTranslationsString(GROUPID, DOESCHARACTEREXISTMENU, player->GetSession()->GetPlayer());
			std::string transfercharactermenu = TranslationSystem->getCompleteTranslationsString(GROUPID, TRANSFERCHARACTERMENU, player->GetSession()->GetPlayer());
			std::string newfirstcharactermenu = TranslationSystem->getCompleteTranslationsString(GROUPID, GIVEMENEWFIRSTCHARACTERMENU, player->GetSession()->GetPlayer());
			std::string bringmebackmenu = TranslationSystem->getCompleteTranslationsString(GROUPID, BRINGMEBACKMENU, player->GetSession()->GetPlayer());
			std::string helpmemenu = TranslationSystem->getCompleteTranslationsString(GROUPID, HELPMENU, player->GetSession()->GetPlayer());

			std::string charactername = TranslationSystem->getCompleteTranslationsString(GROUPID, YOURCHARACTERNAME, player->GetSession()->GetPlayer());
			std::string accountname = TranslationSystem->getCompleteTranslationsString(GROUPID, YOURACCOUNTNAME, player->GetSession()->GetPlayer());
			std::string areusure = TranslationSystem->getCompleteTranslationsString(GROUPID, AREUSUREFIRST, player->GetSession()->GetPlayer());

			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, characterexistmenu, GOSSIP_SENDER_MAIN, 0, charactername, 0, true);
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, transfercharactermenu, GOSSIP_SENDER_MAIN, 2, accountname, 0, true);
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, newfirstcharactermenu, GOSSIP_SENDER_MAIN, 3, areusure, 0, true);
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, bringmebackmenu, GOSSIP_SENDER_MAIN, 1, "", 0, false);
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, helpmemenu, GOSSIP_SENDER_MAIN, 4, "", 0, false);
			player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
			return true;
		}

		else {
			creature->SetPhaseMask(2, true);
			player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
			return true;
		}
	
	}

	
	bool OnGossipSelectCode(Player * player, Creature* /*creature*/, uint32 /*sender*/, uint32 action, const char* code) {
		CustomCharacterSystem * CharacterSystem = 0;
		
		switch (action) {

		//CharacterExists?
		case 0:
		{
			CharacterSystem->doesCharacterExist(player->GetSession()->GetPlayer(), code);

		}break;

		//MoveCharactertoanther Account
		case 2:
		{
			CharacterSystem->moveCharacterToAnotherAccount(player->GetSession()->GetPlayer(), code);
			return true;
		}break;

		//Request new Firstchar!
		case 3:
		{
			CharacterSystem->requestNewFirstCharacter(player->GetSession()->GetPlayer(), code);
			return true;

		}break;


		return true;


		}
		return true;

	}

	bool OnGossipSelect(Player * player, Creature * creature, uint32 /*uiSender*/, uint32 uiAction){
		CustomTranslationSystem * TranslationSystem = 0;
		switch (uiAction)
		{
		
		case 1:
		{
			player->Recall();
			return true;
		}break;

		
		case 4:{
			std::string accountransfermenu = TranslationSystem->getCompleteTranslationsString(GROUPID, ACCOUNTTRANSFERMENU, player->GetSession()->GetPlayer()); 
			player->PlayerTalkClass->ClearMenus();
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, accountransfermenu, GOSSIP_SENDER_MAIN, 6, "", 0, false);
			player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
			return true;
			
		}break;


		case 6:
		{
			std::string accounttransferhelp = TranslationSystem->getCompleteTranslationsString(GROUPID, HOWDOESCHARACTERFRANSFERWORKHELP, player->GetSession()->GetPlayer());
			ChatHandler(player->GetSession()).PSendSysMessage("%s", accounttransferhelp ,player->GetName());
			return true;
		}break;
		
			return true;
		}
		return true;
	}

};

void AddSC_automaticsupport()
{
	new automatic();
}