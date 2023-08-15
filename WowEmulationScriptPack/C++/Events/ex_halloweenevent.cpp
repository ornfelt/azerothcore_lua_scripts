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


class halloween : public CreatureScript
{

public:
	halloween() : CreatureScript("halloween") { }

	bool OnGossipHello(Player *player, Creature* creature){
		if (creature->IsQuestGiver())
			player->PrepareQuestMenu(creature->GetGUID());


		player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
		return true;
	}

	bool OnQuestReward(Player* player, Creature* creature, Quest const* quest, uint32 /*opt*/){
			
		if (quest->GetQuestId() == 900510){
			player->AddAura(44185, player);
			creature->HandleEmoteCommand(EMOTE_ONESHOT_APPLAUD);
			return true;
		}


		if (quest->GetQuestId() == 900509){
			/*player->CanFlyInZone(0, 40);*/
			player->CanFly();
			player->ResetDailyQuestStatus();
			return true;
		}
		return true;

	}

};


void AddSC_halloween()
{
	new halloween();
}