#include "CustomPlayerLog.h"
#include <Custom/Logic/CustomCharacterSystem.h>

void CustomPlayerLog::insertNewPlayerLog(std::string charactername,int guid, std::string accountname, int accountid, std::string action_done)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYERLOG);
	stmt->setString(0, charactername);
	stmt->setInt32(1, guid);
	stmt->setString(2, accountname);
	stmt->setInt32(3, accountid);
	stmt->setString(4, action_done);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

void CustomPlayerLog::insertNewCurrencyLog(std::string charactername, int guid, std::string accountname, int accountid, int currencyitemid, int amount,int amountcost, std::string buy_action)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_CURRENCYLOG);
	stmt->setString(0, charactername);
	stmt->setInt32(1, guid);
	stmt->setString(2, accountname);
	stmt->setInt32(3, accountid);
	stmt->setInt32(4, currencyitemid);
	stmt->setInt32(5, amount);
	stmt->setInt32(6, amountcost);
	stmt->setString(7, buy_action);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

void CustomPlayerLog::addCompletePlayerLog(Player * player, std::string log_message)
{
	
	CustomCharacterSystem * CharacterSystem = 0;
	std::string accountname = "";
	accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
	insertNewPlayerLog(player->GetSession()->GetPlayerName(), player->GetGUID(), accountname, player->GetSession()->GetAccountId(), log_message);
	
}

void CustomPlayerLog::addCompleteCurrencyLog(Player * player, int currencyid, int amount, int amountcost, std::string buy_action)
{
	CustomCharacterSystem * CharacterSystem = 0;
	std::string accountname = "";
	accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
	insertNewCurrencyLog(player->GetSession()->GetPlayerName(), player->GetGUID(), accountname, player->GetSession()->GetAccountId(), currencyid, amount, amountcost, buy_action);
}
