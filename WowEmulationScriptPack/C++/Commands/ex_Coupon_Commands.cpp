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
#include <Custom/Logic/CustomPlayerLog.h>


class coupon : public CommandScript
{
public:
	coupon() : CommandScript("coupon") { }

	std::vector<ChatCommand> GetCommands()  const override
	{

		static std::vector<ChatCommand> coupontable =
		{

			{ "redeem", SEC_PLAYER, false, &HandleGutscheinCommand, "" },
			{ "generate", SEC_ADMINISTRATOR, false, &HandlegutscheinerstellenCommand, "" }

		};

		static std::vector<ChatCommand> commandTable =
		{
			{ "coupon", SEC_ADMINISTRATOR , false, NULL, "" , coupontable },

		};

		return commandTable;
	}



	

	//Gibt dem Eventteam die Moeglichkeit Gutscheine fuer Spieler zu erstellen.
	static bool HandlegutscheinerstellenCommand(ChatHandler* handler, const char* args)
	{
		CustomCouponSystem * CouponSystem = 0;
		CouponSystem->couponGenerationperCommand(handler->GetSession()->GetPlayer(), args);
		return true;

	};



	static bool HandleGutscheinCommand(ChatHandler* handler, const char* args)
	{

		CustomCouponSystem * CouponSystem = 0;
		CouponSystem->playerRedeemCommand(handler->GetSession()->GetPlayer(), args);
		return true;

	}

};

	
void AddSC_coupon()
{
	new coupon();
}