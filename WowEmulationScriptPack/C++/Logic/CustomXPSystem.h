




#ifndef _CUSTOMXP_H
#define _CUSTOMXP_H

class CustomXP {
public:

	
	void setCustomXPEntry(std::string charactername, int characterguid, int xpvalue);
	std::string getCustomXPExntry(int characterguid);
	void updateCustomXPEntry(int xpvalue, int characterguid);
	int getCustomXPValue(int characterguid);
	
	void setXPRate(Player * player, const char* args);
	
		
};



#endif