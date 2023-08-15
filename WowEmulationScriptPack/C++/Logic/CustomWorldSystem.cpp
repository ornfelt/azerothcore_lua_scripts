
#include <Custom/Logic/CustomWorldSystem.h>



//Return a specific itemid if the id exist. IF NO ITEM EXIST VALUE = 0, VALUE != 0 ITEM EXIST
//RETURN VALUE INT32
int CustomWorldSystem::getItemID(int itemid) {
	PreparedStatement * stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_ITEM_NR);
	stmt->setUInt32(0, itemid);
	PreparedQueryResult ergebnis = WorldDatabase.Query(stmt);

	if (!ergebnis) {
		return 0;
	}

	Field* itemnrfield = ergebnis->Fetch();
	int32 itemID = itemnrfield[0].GetInt32();

	return itemID;
}



//Return questid. If no quest found return value = 0
int CustomWorldSystem::getQuestIDbyName(std::string questname)
{

	PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_QUESTID_BY_NAME);
	stmt->setString(0, questname);
	PreparedQueryResult result = WorldDatabase.Query(stmt);

	if (!result) {
		return 0;
	}


	Field* questnr = result->Fetch();
	uint32 questid = questnr[0].GetInt32();
	return questid;
}

bool CustomWorldSystem::doesItemExistinDB(int itemid)
{
	PreparedStatement * stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_ITEM_NR);
	stmt->setUInt32(0, itemid);
	PreparedQueryResult ergebnis = WorldDatabase.Query(stmt);

	if (!ergebnis) {
		return false;
	}
	
	return true;
}

std::string CustomWorldSystem::getItemNamebyItemId(int itemid)
{
	PreparedStatement * stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_ITEMNAME_BY_ID);
	stmt->setInt32(0, itemid);
	PreparedQueryResult result = WorldDatabase.Query(stmt);

	if (!result) {
		return "0";
	}

	Field* ergebnis = result->Fetch();
	std::string itemname = "";
	itemname = ergebnis[0].GetCString();

	return itemname;
}




//Return QuestName. If Error then return 0
std::string CustomWorldSystem::getQuestNamebyID(int questid)
{
	PreparedStatement* stmt = WorldDatabase.GetPreparedStatement(WORLD_SEL_QUESTNAME_BY_ID);
	stmt->setInt32(0, questid);
	PreparedQueryResult result = WorldDatabase.Query(stmt);

	if (!result) {
		return "0";
	}

	Field* questnamefield = result->Fetch();
	std::string questname = questnamefield[0].GetCString();

	return questname;
}

