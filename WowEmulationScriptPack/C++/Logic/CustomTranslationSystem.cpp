#include "CustomTranslationSystem.h"
#include "Chat.h"

std::string CustomTranslationSystem::checkPlayerLocale(Player * player)
{
	

	ChatHandler(player->GetSession()).PSendSysMessage("GetSessionDBCLocale %u ", player->GetSession()->GetSessionDbcLocale(),
		player->GetName());

	std::string rr = "";
	return rr;
}

std::string CustomTranslationSystem::getCompleteTranslationsString(int groupid, int translationid, Player * player)
{
	
	std::string translation = "";

	switch (player->GetSession()->GetSessionDbLocaleIndex()) {

	case 0:
	{
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_ENGLISH,groupid,translationid);
		return translation;	
	}

	case 1:
	{
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_ENGLISH, groupid, translationid);
		return translation;
	}

	case 2:
	{
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_FRENCH, groupid, translationid);
		return translation;
	}


	case 3:
	{
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_GERMAN, groupid, translationid);
		return translation;
	}

	case 4:
	{
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_ENGLISH, groupid, translationid);
		return translation;
	}

	case 5:
	{
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_ENGLISH, groupid, translationid);
		return translation;
	}

	case 6:
	{
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_SPANISH1, groupid, translationid);
		return translation;
	}

	case 7:
	{
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_SPANISH2, groupid, translationid);
		return translation;
	}

	case 8:
	{
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_RUSSIAN, groupid, translationid);
		return translation;
	}


	default:
		translation = CustomTranslationSystem::getTranslationString(CHAR_SEL_TRANSLATION_ENGLISH, groupid, translationid);
		return translation;
	}

	
	return "Missing Translation";
}

std::string CustomTranslationSystem::getTranslationString(CharacterDatabaseStatements statement, int groupid, int translationid)
{
	std::string translation = "";
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(statement);
	stmt->setInt32(0, groupid);
	stmt->setInt32(1, translationid);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		std::ostringstream tt;
		tt << "Missing Translation. Add colum " << groupid << " with TranslationID: " << translationid;

		translation = tt.str().c_str();
		return translation;

	}

	Field * ergebnis = result->Fetch();
	translation = ergebnis[0].GetCString();

	if (translation == "empty") {
		PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_TRANSLATION_ENGLISH);
		stmt->setInt32(0, groupid);
		stmt->setInt32(1, translationid);
		PreparedQueryResult result = CharacterDatabase.Query(stmt);

		if (!result) {

			std::ostringstream tt;
			tt << "Missing Translation. Add a Translation with GroupID " << groupid << " and TranslationID: " << translationid;

			translation = tt.str().c_str();
			return translation;

		}

		Field * ergebnis = result->Fetch();
		translation = ergebnis[0].GetCString();

		return translation;
	}



	return translation;
}


