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
#include <vector>
#include <Custom/Logic/CustomGMLogic.h>
#include <Custom/Logic/CustomCharacterSystem.h>


#define THX "Thank you for playing on Blacknetwork!"
#define PRESENT "Your Present"


class PlayTimeRewards : public PlayerScript
{
public:
	PlayTimeRewards() : PlayerScript("PlayTimeRewards") { }


	void OnLogin(Player* player, bool /*firstLogin*/) {

		uint32 time = player->GetTotalPlayedTime();

		if (sConfigMgr->GetBoolDefault("Playtime.Rewards", true)) {
			CustomCharacterSystem * CharacterSystem = 0;
			//1h
			if (time >= 3600 && time <= 43199) {
				CharacterSystem->completeAddPlayTimeReward(1, player->GetSession()->GetPlayer(), 5,0,"Hi, you reached the first Playtime Reward! Take your Reward and have fun! More Rewards are coming! Just play and get rewarded!  Your Serverteam!");
				return;
			}

			//12h
			if (time >= 43200 && time <= 86399) {
				CharacterSystem->completeAddPlayTimeReward(12, player->GetSession()->GetPlayer(), 0, 20400, "Hey, you got it! The next Playtime Reward is yours! Have fun with it.");
				return;
			}

			//24h
			if (time >= 86400 && time <= 143999) {
				CharacterSystem->completeAddPlayTimeReward(24, player->GetSession()->GetPlayer(), 0, 34499, "Hey, you got it! The next Playtime Reward is yours! Have fun with it.");
				return;
			}


			//120h
			if (time >= 144000 && time <= 431999) {
				CharacterSystem->completeAddPlayTimeReward(120, player->GetSession()->GetPlayer(), 0, 34493, "Hey, you got it! The next Playtime Reward is yours! Have fun with it.");
				return;
			}


			//240h
			if (time >= 432000 && time <= 1727999) {	
				CharacterSystem->completeAddPlayTimeReward(240, player->GetSession()->GetPlayer(), 0, 38186, "Hey, you got it! The next Playtime Reward is yours! Have fun with it.");
				return;
			}

			//480h
			if (time >= 1728000 && time <= 4319999) {				
				CharacterSystem->completeAddPlayTimeReward(480, player->GetSession()->GetPlayer(), 0, 23713, "Hey, you got it! The next Playtime Reward is yours! Have fun with it.");
				return;
			}


			//1200h
			if (time >= 4320000 && time <= 6479999) {
				CharacterSystem->completeAddPlayTimeReward(1200, player->GetSession()->GetPlayer(), 0, sConfigMgr->GetIntDefault("Playtime.1200", 43599), "Hey, you are insane! And for insane People there are insane Rewards. Get it and have fun with it!");
				return;
			}


			//1800h
			if (time >= 6480000 && time <= 8639999) {
				CharacterSystem->completeAddPlayTimeReward(1800, player->GetSession()->GetPlayer(), 0, 45047, "Hey, you got it! The next Playtime Reward is yours! Have fun with it.");
				return;
			}

			//2400h
			if (time >= 8640000 && time <= 17279999) {
				CharacterSystem->completeAddPlayTimeReward(2400, player->GetSession()->GetPlayer(), 0, sConfigMgr->GetIntDefault("Playtime.2400",33809), "Hey, you are insane! And for insane People there are insame Rewards. Get it and have fun with it!");
				return;
			}


			//4800h
			if (time >= 17280000) {
				CharacterSystem->completeAddPlayTimeReward(24, player->GetSession()->GetPlayer(), 10000, 0, "Hey, you got it! The next Playtime Reward is yours! Have fun with it.");
				return;
			}

		}


	}
	
};



void AddSC_PlayTimeRewards()
{
	new PlayTimeRewards();
}