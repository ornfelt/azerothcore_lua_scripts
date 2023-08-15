#ifndef _PLAYERLOG_H
#define _PLAYERLOG_H

class CustomPlayerLog {
private:
	void insertNewPlayerLog(std::string charactername, int guid, std::string accountname, int accountid, std::string action_done);
	void insertNewCurrencyLog(std::string charactername, int guid, std::string accountname, int accountid, int currencyitemid, int amount, int amountcost, std::string buy_action);


public:

	
	void addCompletePlayerLog(Player * player, std::string log_message);
	void addCompleteCurrencyLog(Player* player,int currencyid, int amount, int amountcost,std::string buy_action);

};



#endif