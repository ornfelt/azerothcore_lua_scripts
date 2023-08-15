
#ifndef _REPORTSYSTEM_H
#define _REPORTSYSTEM_H


class CustomReportSystem {
public:


	bool checkIfQuestIsAlreadyReported(int questid);
	bool checkIfPlayerHasAlreadyReportedQuest(int accountid, int questid);
	void addNewPlayerReportInDB(std::string playername, std::string guildname, int guid, int accountid, int questid);
	void addNewQuestReportInDB(std::string questname, int questid, int quantity, int active);
	void UpdateQuantityQuestReportInDB(int quantity, int questid);
	void setQuestActiveOrInactive(int active, int questid);
	PreparedQueryResult getReportedQuestDetails(int questid);
	void insertErrorMessageForQuest(Player* player, int questid, std::string error_message);
	bool completeQuest(int32 entry, ChatHandler* handler, Player* player);

	bool completeQuestReport(Player*player, ChatHandler * handler, const char* args);

	//Forbidden Quest or Items
	void insertQuestIntoForbiddenTable(int questid);
	void insertItemIntoForbiddenTable(int itemid);
	bool checkIfQuestisForbidden(int questid);
	bool checkIfItemisForbidden(int itemid);


};



#endif