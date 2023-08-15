#include "ScriptMgr.h"
#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include <stdlib.h>
#include "GameEventMgr.h"
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
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomCharacterSystem.h>
#include <Custom/Logic/CustomTranslationSystem.h>

#define GROUPID 3

enum Translations {
	HELPMENU = 1,
	BUYVIPTOKENMENU = 2,
	WHATAREVIPTOKENMENU = 4,
	AMOUNTOFTOKENS = 5,
	ACTUALTOKENCOSTMENU = 6,
	VIPTOKENEXPLANATION = 7,
	VIPTOKENACTUALCOST = 8,

	
};


class vipvendor : public CreatureScript
{
public: vipvendor() : CreatureScript("vipvendor") { }


		bool OnGossipHello(Player *player, Creature* creature)
		{
			if (creature->IsQuestGiver())
				player->PrepareQuestMenu(creature->GetGUID());


			CustomTranslationSystem * TranslationSystem = 0;
			
			if (sConfigMgr->GetBoolDefault("Vip.Vendor", true)) {
				std::string helpmenu = TranslationSystem->getCompleteTranslationsString(GROUPID, HELPMENU, player->GetSession()->GetPlayer());
				std::string buytokens = TranslationSystem->getCompleteTranslationsString(GROUPID, BUYVIPTOKENMENU, player->GetSession()->GetPlayer());
				std::string howmanytokenyouwantbuy = TranslationSystem->getCompleteTranslationsString(GROUPID, AMOUNTOFTOKENS, player->GetSession()->GetPlayer());

				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, helpmenu, GOSSIP_SENDER_MAIN, 2, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, buytokens, GOSSIP_SENDER_MAIN, 1 , howmanytokenyouwantbuy, 0, true);
				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;
			}


			else {
				creature->SetPhaseMask(2, true);
				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;
			}
		}

		bool OnGossipSelect(Player * player, Creature * creature, uint32 /*uiSender*/, uint32 uiAction) {
			CustomTranslationSystem * TranslationSystem = 0;
			switch (uiAction)
			{

			case 2:
			{
				std::string whatareviptokens = TranslationSystem->getCompleteTranslationsString(GROUPID, WHATAREVIPTOKENMENU, player->GetSession()->GetPlayer());
				std::string actualpriceofviptoken = TranslationSystem->getCompleteTranslationsString(GROUPID, ACTUALTOKENCOSTMENU, player->GetSession()->GetPlayer());
				player->PlayerTalkClass->ClearMenus();
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, whatareviptokens, GOSSIP_SENDER_MAIN, 1000, "", 0, false);
				player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, actualpriceofviptoken, GOSSIP_SENDER_MAIN, 1001, "", 0, false);
				player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
				return true;
			}break;

			case 1000:
			{
				std::string viptokenexplanation = TranslationSystem->getCompleteTranslationsString(GROUPID, VIPTOKENEXPLANATION, player->GetSession()->GetPlayer());
				ChatHandler(player->GetSession()).PSendSysMessage("%s", viptokenexplanation,
					player->GetName());
				return true;
			}break;

			case 1001:
			{
				std::string viptokencostactual = TranslationSystem->getCompleteTranslationsString(GROUPID, VIPTOKENACTUALCOST, player->GetSession()->GetPlayer());
				int tokencost = sConfigMgr->GetIntDefault("Vip.Vendor.CurrencyCost", 1000);
				ChatHandler(player->GetSession()).PSendSysMessage("%s: %u", viptokencostactual, tokencost,
					player->GetName());
				return true;
			}break;

			return true;
			}
			return true;
		}

		bool OnGossipSelectCode(Player * player, Creature* /*creature*/, uint32 /*sender*/, uint32 action, const char* code) {
			
			switch (action) {
				
			case 1:
			{
				CustomCharacterSystem * CharacterSystem = 0;
				CharacterSystem->sellPlayerVIPCurrency(player->GetSession()->GetPlayer(), code);
				return true;
			}break;

			

			return true;

			}

			return true;
		}

};





void AddSC_vipvendor()
{
	new vipvendor();
}