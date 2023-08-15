#ifndef _TRANSLATIONSYSTEM_H
#define _TRANSLATIONSYSTEM_H


class CustomTranslationSystem {
private:




public:

	std::string checkPlayerLocale(Player* player);
	std::string getCompleteTranslationsString(int groupid, int translationid,Player* player);
	std::string getTranslationString(CharacterDatabaseStatements statement, int groupid, int translationid);

};



#endif