#ifndef _QUESTIONANSWERSYSTEM_H
#define _QUESTIONANSWERSYSTEM_H

class CustomQuestionAnswerSystem {
public:

	/*
	PrepareStatement(CHAR_INS_PLAYER_ALREADY_ANSWERED_QUESTIONS, "INSERT INTO player_already_answered_questions (accountid, accountname, questionnr,actiontime) VALUES (?,?,?,NOW())", CONNECTION_ASYNC);
	PrepareStatement(CHAR_SEL_PLAYER_ALREADY_ANSWERED_QUESTIONS, "SELECT accountid,accountname,questionnr,actiontime FROM player_already_answered_questions WHERE accountid = ? and questionnr = ?",CONNECTION_SYNCH);
	PrepareStatement(CHAR_INS_PLAYER_QUESTIONS_AND_ANSWERS, "INSERT INTO player_questions_and_answers (frage,antwort,belohnung,anzahl,insertdate,creatorname,creatorid) VALUES (?,?,?,?,NOW(),?,?)", CONNECTION_ASYNC);
	PrepareStatement(CHAR_SEL_PLAYER_QUESTIONS_AND_ANSWERS, "SELECT id,frage,antwort,belohnung,anzahl,creatorname,creatorid FROM player_questions_and_answers WHERE id = ?", CONNECTION_SYNCH);
	PrepareStatement(CHAR_SEL_PLAYER_QUESTIONS_AND_ANSWERS_MAX_COUNT, "SELECT max(id) FROM player_questions_and_answers", CONNECTION_SYNCH);
	PrepareStatement(CHAR_SEL_PLAYER_QUESTIONS_AND_ANSWERS_BY_ANSWER, "Select id, frage, antwort, belohnung, anzahl, creatorname, creatorid FROM player_questions_and_answers WHERE antwort = ? ", CONNECTION_SYNCH);
	*/

	int generateRandomInt(int min, int max);
	void getQuestionForPlayer(Player * player);
	bool hasPlayerAlreadyAnsweredQuestion(int accountid, int questionnr);
	int selectMaxEntryCountofPlayerQuestionsAndAnswers();
	PreparedQueryResult getSingleQuestionByID(int questionid);
	bool checkifAnswerDoesExist(std::string answer);
	PreparedQueryResult getQuestionByAnswer(std::string answer);

	void checkPlayerAnswer(Player * player, const char* args);
	bool hasPlayerNewQuestionsToAnswer(int accountid);
	void insertNewAnsweredQuestionforPlayer(int questionid, Player * player);


	void insertNewQuestion(Player * player , const char* args);
};



#endif