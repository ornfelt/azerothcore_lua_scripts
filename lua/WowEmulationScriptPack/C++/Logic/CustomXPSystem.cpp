#include <Custom/Logic/CustomXPSystem.h>
#include <Custom/Logic/CustomCharacterSystem.h>
#include <Custom/Logic/CustomPlayerLog.h>
#include "Config.h"

	

	void CustomXP::setCustomXPEntry(std::string charactername, int characterguid, int xpvalue)
	{
		SQLTransaction trans = CharacterDatabase.BeginTransaction();
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CUSTOM_XP);
		stmt->setString(0, charactername);
		stmt->setInt32(1, characterguid);
		stmt->setInt32(2, xpvalue);
		trans->Append(stmt);
		CharacterDatabase.CommitTransaction(trans);
	}

	//Returns the name of the player, if an DB entry exist. If Not "0" is Returnvalue
	std::string CustomXP::getCustomXPExntry(int characterguid)
	{
		PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CUSTOM_XP);
		stmt->setInt32(0, characterguid);
		PreparedQueryResult stmtresult = CharacterDatabase.Query(stmt);

		if (!stmtresult) {
			return "0";
		}

		Field* stmtfield = stmtresult->Fetch();
		std::string charactername = stmtfield[0].GetString();

		return charactername;
	}

	//Update Custom XP Rate for a specified Player
	void CustomXP::updateCustomXPEntry(int xpvalue, int characterguid)
	{
		SQLTransaction trans = CharacterDatabase.BeginTransaction();
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CUSTOM_XP);
		stmt->setInt32(0, xpvalue);
		stmt->setInt32(1, characterguid);
		trans->Append(stmt);
		CharacterDatabase.CommitTransaction(trans);
	}

	//Select Custom XP Rate from a specified Player
	int CustomXP::getCustomXPValue(int characterguid)
	{

		PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CUSTOM_XP_VALUE);
		stmt->setInt32(0, characterguid);
		PreparedQueryResult stmtresult = CharacterDatabase.Query(stmt);

		if (!stmtresult) {
			return 1;
		}

		Field* stmtfield = stmtresult->Fetch();
		int xp_value = stmtfield[0].GetInt32();

		return xp_value;
	}

	void CustomXP::setXPRate(Player * player, const char * args)
	{
		if (sConfigMgr->GetBoolDefault("Custom.XP", 1)) {
			CustomXP *CustomXP = 0;
			CustomPlayerLog * PlayerLog = 0;

			char* px = strtok((char*)args, " ");

			int playerxp = CustomXP->getCustomXPValue(player->GetGUID());

			if (!px) {
				int32 minxprate = sConfigMgr->GetIntDefault("Custom.XP.MinRate", 1);
				int32 maxxprate = sConfigMgr->GetIntDefault("Custom.XP.MaxRate", 5);
				PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), "Show XPRate");
				ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
				ChatHandler(player->GetSession()).PSendSysMessage("Your XP Multiplier is currently: %u", playerxp);
				ChatHandler(player->GetSession()).PSendSysMessage("To change your Multiplier just type '.xprate 2' for a 2x Multiplier.");
				ChatHandler(player->GetSession()).PSendSysMessage("Valid Values are between %u and %u.",minxprate,maxxprate);
				ChatHandler(player->GetSession()).PSendSysMessage("Have fun with it, %s.", player->GetSession()->GetPlayerName());
				ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
				return;
			}


			int32 newxpvalue = (uint32)atoi(px);
			int32 minxprate = sConfigMgr->GetIntDefault("Custom.XP.MinRate", 1);
			int32 maxxprate = sConfigMgr->GetIntDefault("Custom.XP.MaxRate", 5);
			if (newxpvalue == 0 || newxpvalue > maxxprate) {
				PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), "Change of XP Rate not possible. Value Problem!");
				ChatHandler(player->GetSession()).PSendSysMessage("Your Values are invalid. Use only values between %u and %u!", minxprate, maxxprate);
				return;
			}


			std::string charactername = CustomXP->getCustomXPExntry(player->GetGUID());
			if (player->GetSession()->GetSecurity() <= 2) {
				ChatHandler(player->GetSession()).PSendSysMessage("Debug: XPValue: %u", newxpvalue);
				ChatHandler(player->GetSession()).PSendSysMessage("Debug: GUID: %u", player->GetGUID());
			}


			if (charactername == "0") {
				std::string accountname = "";
				std::ostringstream tt;
				tt << "Changed XP Rate to: " << newxpvalue;
				std::string reason = tt.str().c_str();
				PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
				CustomXP->setCustomXPEntry(player->GetSession()->GetPlayerName(), player->GetGUID(), newxpvalue);
				ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
				ChatHandler(player->GetSession()).PSendSysMessage("Your XP Multiplier is set to %u", newxpvalue);
				ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
				return;
			}

			std::ostringstream tt;
			tt << "Changed XP Rate to: " << newxpvalue;
			std::string reason = tt.str().c_str();
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
			CustomXP->updateCustomXPEntry(newxpvalue, player->GetGUID());
			ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
			ChatHandler(player->GetSession()).PSendSysMessage("Your XP Multiplier is set to %u", newxpvalue);
			ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
			return;
		}

		else {
			return;
		}
	}


	

	


	



	

	

	
