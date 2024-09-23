#include <Custom/Logic/CustomGMLogic.h>
#include <Custom/Logic/CustomCharacterSystem.h>
#include "WorldSession.h"
#include "Config.h"
#include "Language.h"



//Insert a GM Log action, to control your GM´s. No Return Value. Log is found in Character DB , Tablename: "gm_action"
void CustomGMLogic::addGMLog(std::string charactername, int characterid, std::string accountname, int accountid, std::string action) {

	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_GM_ACTION);
	stmt->setString(0, charactername);
	stmt->setInt32(1, characterid);
	stmt->setString(2, accountname);
	stmt->setInt32(3, accountid);
	stmt->setString(4, action);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

void CustomGMLogic::addGMPlayerCount(int accountid)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_GM_ACTION_PLAYER_COUNT);
	stmt->setInt32(0, accountid);
	stmt->setInt32(1, 1);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

void CustomGMLogic::updateGMPlayerCount(int counter, int accountid)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_GM_ACTION_PLAYER_COUNT);
	stmt->setInt32(0, counter);
	stmt->setInt32(1, accountid);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

PreparedQueryResult CustomGMLogic::selectGMPlayerCount(int accountid)
{
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GM_ACTION_PLAYER_COUNT);
	stmt->setInt32(0, accountid);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);
	
	if (!result) {
		return NULL;
	}
		

	return result;
}

void CustomGMLogic::insertNewAutobroadCast(Player* player,const char* args)
{
	CustomCharacterSystem * CharacterSystem = 0;
	char* weightchar = strtok((char*)args, " ");
	if (!weightchar) {
		player->GetSession()->SendNotification("Without weight the command will not work!");
		return;
	}

	char* message = strtok(NULL, ",");
	if (!message) {
		player->GetSession()->SendNotification("Without message the command will not work!");
		return;
	}

	uint32 weight = atoi((char*)weightchar);
	std::string accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
	addGMLog(player->GetSession()->GetPlayerName(), player->GetGUID(), accountname, player->GetSession()->GetAccountId(), "Insert new Autobroadcast");
	int realmid = sConfigMgr->GetIntDefault("RealmID", 1);
	int idmaxcount = selectMaxCountAutobroadcastID(realmid);
	SQLTransaction trans = LoginDatabase.BeginTransaction();
	PreparedStatement * stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_AUTOBROADCAST_NEW);
	stmt->setInt32(0, realmid);
	stmt->setInt32(1, idmaxcount);
	stmt->setInt32(2, weight);
	stmt->setString(3, message);
	trans->Append(stmt);
	LoginDatabase.CommitTransaction(trans);
}

int CustomGMLogic::selectMaxCountAutobroadcastID(int realmid)
{
	PreparedStatement * stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_AUTOBROADCAST_MAX_COUNT_ID);
	stmt->setInt32(0, realmid);
	PreparedQueryResult result = LoginDatabase.Query(stmt);

	if (!result) {
		return 0;
	}

	Field* ergebnis = result->Fetch();
	int32 idmaxcount = ergebnis[0].GetInt32();

	return idmaxcount;
}

void CustomGMLogic::insertNewCouponGMLog(std::string charactername, int guid,int itemid, std::string couponcode, int quantity)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_GM_ACTIONS_COUPON_DETAILS);
	stmt->setString(0, charactername);
	stmt->setInt32(1, guid);
	stmt->setInt32(2, itemid);
	stmt->setString(3, couponcode);
	stmt->setInt32(4, quantity);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

int CustomGMLogic::getGMPlayerCount(int accountid)
{

	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GM_ACTION_PLAYER_COUNT);
	stmt->setInt32(0, accountid);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return -1;
	}

	Field* ergebnis = result->Fetch();
	int counter = ergebnis[2].GetInt32();

	return counter;
}

void CustomGMLogic::addCompleteGMCountLogic(Player* player, std::string logmessage)
{
	
	CustomCharacterSystem * CharacterSystem = 0;
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_GM_ACTION_PLAYER_COUNT);
	stmt->setInt32(0, player->GetSession()->GetAccountId());
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		addGMPlayerCount(player->GetSession()->GetAccountId());
		std::string accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
		addGMLog(player->GetSession()->GetPlayerName(), player->GetGUID(), accountname, player->GetSession()->GetAccountId(), logmessage);
		return;
	}

	/*PrepareStatement(CHAR_INS_GM_ACTION, "INSERT INTO gm_actions (charactername,characterID, accountname, accountID, action_done) VALUES (?,?,?,?,?)", CONNECTION_ASYNC);
	PrepareStatement(CHAR_INS_GM_ACTION_PLAYER_COUNT, "INSERT into gm_actions_player_count (accountid, counter) VALUES (?,?)", CONNECTION_ASYNC);
	PrepareStatement(CHAR_SEL_GM_ACTION_PLAYER_COUNT, "Select id,accountid, counter from gm_actions_player_count where accountid = ?", CONNECTION_SYNCH);
	PrepareStatement(CHAR_UPD_GM_ACTION_PLAYER_COUNT, "Update gm_actions_player_count set counter = ? where id = ?", CONNECTION_ASYNC);*/

	Field* fields = result->Fetch();
	int32 id = fields[0].GetInt32();
	int32 counter = fields[2].GetInt32();

	int newcounter = 0;
	newcounter = counter + 1;
	ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
	ChatHandler(player->GetSession()).PSendSysMessage("GM Warning!");
	ChatHandler(player->GetSession()).PSendSysMessage("This is your %u Incident. Beware %s!", newcounter,player->GetSession()->GetPlayerName());
	ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
	updateGMPlayerCount(newcounter, id);
	std::string accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
	addGMLog(player->GetSession()->GetPlayerName(), player->GetGUID(), accountname, player->GetSession()->GetAccountId(), logmessage);
	if (sConfigMgr->GetBoolDefault("GM.Security", 1)) {
		int maxcount = 0;
		maxcount = sConfigMgr->GetIntDefault("GM.Security.Number", 3);
		PreparedQueryResult queryresult = selectGMPlayerCount(player->GetSession()->GetAccountId());
		
		if (!queryresult) {
			return;
		}

		Field * array = queryresult->Fetch();
		int strikes = array[2].GetInt32();

		if (strikes >= maxcount-1) {
			std::string accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
			sWorld->BanAccount(BAN_ACCOUNT, accountname, 0, "To many bad Decisions", "AvariusCore");
			std::ostringstream ss;
			std::ostringstream tt;
			std::ostringstream uu;
			ss << "Gamemaster " << player->GetSession()->GetPlayerName() << " has been banned by Core.";
			tt << "Reason: To many Failures with Cheating Commands. This is a friedly Reminder for the whole Team.";
			uu << "Read and unterstand the Rules of your Server!";
			sWorld->SendGMText(LANG_GM_BROADCAST, ss.str().c_str());
			sWorld->SendGMText(LANG_GM_BROADCAST, tt.str().c_str());
			sWorld->SendGMText(LANG_GM_BROADCAST, uu.str().c_str());
			return;
		}

	}

	return;

}

