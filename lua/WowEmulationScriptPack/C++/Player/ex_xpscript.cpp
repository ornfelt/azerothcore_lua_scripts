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
#include <Custom/Logic/CustomXPSystem.h>




class DoupleXP : public PlayerScript
{
public:
	DoupleXP() : PlayerScript("DoupleXP") {}

	void OnGiveXP(Player* player, uint32& amount, Unit* /*victim*/)
	{
		CustomXP * XPSystem = 0;

		int xpvalue = 0;
		xpvalue = XPSystem->getCustomXPValue(player->GetGUID());

		//Custom XP is on, check if double xp is on.
		if (sConfigMgr->GetBoolDefault("Custom.XP", 1)) {

			if (player->getLevel() < 80) {
				//Check if Xp Weekend is on
				if (sConfigMgr->GetBoolDefault("XP.Weekend.Active", true)) {

					int32 xpweekendrate = sConfigMgr->GetIntDefault("XP.Weekend.Rate", 2);

					boost::gregorian::date date(boost::gregorian::day_clock::local_day());
					if (date.day_of_week() == boost::date_time::Friday ||
						date.day_of_week() == boost::date_time::Saturday ||
						date.day_of_week() == boost::date_time::Sunday)
					{

						if (player->getLevel() < 80) {
							int xpvalue = XPSystem->getCustomXPValue(player->GetGUID());

							amount = (amount *xpvalue)* xpweekendrate;
							ChatHandler(player->GetSession()).PSendSysMessage("XP Weekend active. You get: %u", amount,
								player->GetName());

							return;
						}

						return;
					}


					if (date.day_of_week() == boost::date_time::Monday ||
						date.day_of_week() == boost::date_time::Tuesday ||
						date.day_of_week() == boost::date_time::Wednesday || date.day_of_week() == boost::date_time::Thursday)
					{
						if (player->getLevel() < 80) {
							int xpvalue = XPSystem->getCustomXPValue(player->GetGUID());
							amount = amount * xpvalue;
							return;
						}
						return;
					}

					//Should never be reached.
					else {
						amount = amount* xpvalue;
						return;
					}
				}

				//XP Weekend is offline
				else {
					amount = amount * xpvalue;
				}

			}
			else {
				return;
			}

		}

		//Custom XP is off , but maybe double XP is on.
		else {

			//Check if Xp Weekend is on
			if (sConfigMgr->GetBoolDefault("XP.Weekend.Active", true)) {

				int32 xpweekendrate = sConfigMgr->GetIntDefault("XP.Weekend.Rate", 2);

				boost::gregorian::date date(boost::gregorian::day_clock::local_day());
				if (date.day_of_week() == boost::date_time::Friday ||
					date.day_of_week() == boost::date_time::Saturday ||
					date.day_of_week() == boost::date_time::Sunday)
				{

					if (player->getLevel() < 80) {

						amount = amount * xpweekendrate;
						ChatHandler(player->GetSession()).PSendSysMessage("XP Weekend active. You get: %u", amount,
							player->GetName());

						return;
					}

					return;
				}


				if (date.day_of_week() == boost::date_time::Monday ||
					date.day_of_week() == boost::date_time::Tuesday ||
					date.day_of_week() == boost::date_time::Wednesday || date.day_of_week() == boost::date_time::Thursday)
				{
					if (player->getLevel() < 80) {
						return;
					}
					return;
				}


				else {
					return;
				}
			}


			//Xp Weekend is not online
			else {
				return;
			}

		}

	}
};








void AddSC_XPScripts()
{	
	new DoupleXP();
}
