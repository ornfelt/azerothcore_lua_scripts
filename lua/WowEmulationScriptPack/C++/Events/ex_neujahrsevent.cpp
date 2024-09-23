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

class neujahrsevent : public CreatureScript
{
public:
	neujahrsevent() : CreatureScript("neujahrsevent") {  }

	bool OnGossipHello(Player* player, Creature* creature)
	{
		if (creature->IsQuestGiver())
			player->PrepareQuestMenu(creature->GetGUID());

		player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,GOSSIP_ICON_CHAT, "Was bin ich?", GOSSIP_SENDER_MAIN, 0, "", 0, false);
		
		if (player->GetQuestRewardStatus(900100) == true){
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,GOSSIP_ICON_CHAT, "Bring mich zum Labyrintheingang.", GOSSIP_SENDER_MAIN, 1, "", 0, false);
		}

		if (player->GetQuestRewardStatus(900101) == true){
			player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,GOSSIP_ICON_CHAT, "Bring mich zum Labyrinthausgang.", GOSSIP_SENDER_MAIN, 2,"",0,false);
		}

		player->PlayerTalkClass->SendGossipMenu(1, creature->GetGUID());
		return true;
	}
	
	bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action){
		switch (action)
		{
			case 0:
			{

				player->GetGUID();
				ChatHandler(player->GetSession()).PSendSysMessage("Wenn ihr die nachfolgenden Quests abgeschlossen habt, koennt ihr euch zu verschiedenen Punkten im Event porten um euren Fortschritt sozusagen zu speichern.",
					player->GetName());

			}break;

			case 1:
			{
				player->GetGUID();
				player->TeleportTo(1, -8646.00f, -1316.99f, 8.87f, 3.10f, 0);
				return true;
			}break;
			

			case 2:
			{
				player->GetGUID();
				player->TeleportTo(1, -8790.68f, -1339.47f, 8.87f, 3.16f, 0);
				return true;
			}break;

		}return true;
	}
};

void AddSC_neujahrsevent()
{
	new neujahrsevent();
}