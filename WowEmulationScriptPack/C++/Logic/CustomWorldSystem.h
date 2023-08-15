


#ifndef _CUSTOMWORLDSYSTEM_H
#define _CUSTOMWORLDSYSTEM_H

class CustomWorldSystem {
public:


	int getItemID(int itemid);
	std::string getQuestNamebyID(int questid);
	int getQuestIDbyName(std::string questname);
	bool doesItemExistinDB(int itemid);
	std::string getItemNamebyItemId(int itemid);
};



#endif