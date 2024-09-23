
#ifndef _GMLOGIC_H
#define _GMLOGIC_H

class CustomGMLogic {

private:

	void addGMPlayerCount(int accountid);
	void updateGMPlayerCount(int counter, int accountid);
	int getGMPlayerCount(int accountid);
	PreparedQueryResult selectGMPlayerCount(int accountid);
	int selectMaxCountAutobroadcastID(int realmid);

public:

	
	void insertNewAutobroadCast(Player* player,const char* args);
	void insertNewCouponGMLog(std::string charactername, int guid,int itemid, std::string couponcode, int quantity);
	void addCompleteGMCountLogic(Player* player, std::string logmessage);	
	void addGMLog(std::string charactername, int characterid, std::string accountname, int accountid, std::string action);
	
};



#endif