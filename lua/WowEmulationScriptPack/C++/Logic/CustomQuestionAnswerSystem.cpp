#include "CustomQuestionAnswerSystem.h"
#include "Custom/Logic/CustomPlayerLog.h"
#include "Custom/Logic/CustomCharacterSystem.h"
#include "Custom/Logic/CustomGMLogic.h"
#include <Custom/Logic/CustomWorldSystem.h>

int CustomQuestionAnswerSystem::generateRandomInt(int min, int max)
{
		unsigned int N = (max - min <= RAND_MAX)
			? (max - min + 1U)
			: (RAND_MAX + 1U);
		unsigned int x = (RAND_MAX + 1U) / N;
		unsigned int y = x * N;
		unsigned int r;
		do {
			r = rand();
		} while (r >= y);

		return r / x + min;
}

void CustomQuestionAnswerSystem::getQuestionForPlayer(Player * player)
{
	CustomPlayerLog * PlayerLog = 0;
	int max = selectMaxEntryCountofPlayerQuestionsAndAnswers();
	uint32 rdnquestionnr = generateRandomInt(1, max);
	int whilecounter = 0;
	int whilebreakpoint = selectMaxEntryCountofPlayerQuestionsAndAnswers();
	while (hasPlayerAlreadyAnsweredQuestion(player->GetSession()->GetAccountId(), rdnquestionnr) == true) {
		rdnquestionnr = generateRandomInt(1, max);
		if(whilecounter == whilebreakpoint)
		{
			ChatHandler(player->GetSession()).PSendSysMessage("########################################",
				player->GetName());
			ChatHandler(player->GetSession()).PSendSysMessage("You answered all available Questions!",
				player->GetName());
			ChatHandler(player->GetSession()).PSendSysMessage("Wait for new ones, please!",
				player->GetName());
			ChatHandler(player->GetSession()).PSendSysMessage("########################################",
				player->GetName());
			return;

		}
		whilecounter++;
	}


	bool hasPlayerQuestionstoAnswer = hasPlayerNewQuestionsToAnswer(player->GetSession()->GetAccountId());
	if (!hasPlayerQuestionstoAnswer) {
		ChatHandler(player->GetSession()).PSendSysMessage("########################################",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("You answered all available Questions!",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Wait for new ones, please!",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("########################################",
			player->GetName());
		return;
	}

	
	PreparedQueryResult result = getSingleQuestionByID(rdnquestionnr);

	if (!result) {
		ChatHandler(player->GetSession()).PSendSysMessage("########################################",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("There are no more Questions for you!",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Come again later for new ones!",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("########################################",
			player->GetName());
		return;
	}

	Field * ergebnis = result->Fetch();
	int id = ergebnis[0].GetInt32();
	std::string question = ergebnis[1].GetCString();
	//std::string answer = ergebnis[1].GetCString();
	//int reward = ergebnis[2].GetInt32();
	//int quantity = ergebnis[3].GetInt32();
	//std::string creatorname = ergebnis[4].GetCString();
	//int creatorid = ergebnis[5].GetInt32();
	std::ostringstream tt;
	tt << "Get Questionnr: " << id;
	std::string reason = tt.str().c_str();
	PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);

	ChatHandler(player->GetSession()).PSendSysMessage("########################################",
		player->GetName());
	ChatHandler(player->GetSession()).PSendSysMessage("Your Question is: ",
		player->GetName());
	ChatHandler(player->GetSession()).PSendSysMessage("%s",question,
		player->GetName());
	ChatHandler(player->GetSession()).PSendSysMessage("########################################",
		player->GetName());

	return;
	
}

bool CustomQuestionAnswerSystem::hasPlayerAlreadyAnsweredQuestion(int accountid, int questionnr)
{
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_ALREADY_ANSWERED_QUESTIONS);
	stmt->setInt32(0, accountid);
	stmt->setInt32(1, questionnr);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return false;
	}

	return true;
}

int CustomQuestionAnswerSystem::selectMaxEntryCountofPlayerQuestionsAndAnswers()
{
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_QUESTIONS_AND_ANSWERS_MAX_COUNT);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return 0;
	}

	Field* ergebnis = result->Fetch();
	int32 maxcount = ergebnis[0].GetInt32();

	return maxcount;

}

PreparedQueryResult CustomQuestionAnswerSystem::getSingleQuestionByID(int questionid)
{
	PreparedStatement *stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_QUESTIONS_AND_ANSWERS);
	stmt->setInt32(0, questionid);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	return result;
}

bool CustomQuestionAnswerSystem::checkifAnswerDoesExist(std::string answer)
{
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_QUESTIONS_AND_ANSWERS_BY_ANSWER);
	stmt->setString(0, answer);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return false;
	}

	return true;
}

PreparedQueryResult CustomQuestionAnswerSystem::getQuestionByAnswer(std::string answer)
{
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_QUESTIONS_AND_ANSWERS_BY_ANSWER);
	stmt->setString(0, answer);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return PreparedQueryResult();
	}

	return result;
}

void CustomQuestionAnswerSystem::checkPlayerAnswer(Player * player, const char * args)
{
	CustomPlayerLog * PlayerLog = 0;
	CustomCharacterSystem * CharacterSystem = 0;

	std::string answer = args;
	bool doesAnswerExist = checkifAnswerDoesExist(answer);

	if (!doesAnswerExist) {
		ChatHandler(player->GetSession()).PSendSysMessage("########################################",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Your Answer %s is not correct!", answer,
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Try again!",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("########################################",
			player->GetName());
		return;
	}

	

	PreparedQueryResult result = getQuestionByAnswer(answer);

	Field* ergebnis = result->Fetch();
	int questionid = ergebnis[0].GetInt32();
	std::string question = ergebnis[1].GetCString();
	//std::string answer = ergebnis[2].GetCString();
	int reward = ergebnis[3].GetInt32();
	int quantity = ergebnis[4].GetInt32();
	//std::string creatorname = ergebnis[5].GetCString();
	//int creatorid = ergebnis[6].GetInt32();

	bool hasPlayeralreadyAnsweredQuestion = hasPlayerAlreadyAnsweredQuestion(player->GetSession()->GetAccountId(), questionid);

	if (hasPlayeralreadyAnsweredQuestion) {
		ChatHandler(player->GetSession()).PSendSysMessage("########################################",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("You already answered the question '%s'!", question,
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("########################################",
			player->GetName());
		return;
	}
	
	ChatHandler(player->GetSession()).PSendSysMessage("########################################",
		player->GetName());
	ChatHandler(player->GetSession()).PSendSysMessage("Your Answer %s is correct!",answer ,
		player->GetName());
	ChatHandler(player->GetSession()).PSendSysMessage("Please check your Inbox!",
		player->GetName());
	ChatHandler(player->GetSession()).PSendSysMessage("########################################",
		player->GetName());

	std::ostringstream tt;
	tt << "Answered Questionnr: " << questionid;
	std::string reason = tt.str().c_str();
	PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
	insertNewAnsweredQuestionforPlayer(questionid, player->GetSession()->GetPlayer());
	CharacterSystem->sendPlayerMailwithItem(reward, quantity, "Congratulations", "You answered the Question correct. Here is your Reward. Have fun with it!", player->GetSession()->GetPlayer());

	return;

}

bool CustomQuestionAnswerSystem::hasPlayerNewQuestionsToAnswer(int accountid)
{
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_ALREADY_ANSWERED_QUESTIONS_ACCOUNTID_COUNT);
	stmt->setInt32(0, accountid);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return true;
	}
	
	PreparedStatement * prepmaxquestion = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_QUESTIONS_AND_ANSWERS_MAX_COUNT);
	PreparedQueryResult prepmaxresult = CharacterDatabase.Query(prepmaxquestion);

	if (!prepmaxresult) {
		return false;
	}

	Field* prepMaxField = prepmaxresult->Fetch();
	int maxquestioncount = prepMaxField[0].GetInt32();


	Field* ergebnis = result->Fetch();
	int playercount = ergebnis[0].GetUInt32();

	if (playercount < maxquestioncount) {
		return true;
	}

	return false;
}

void CustomQuestionAnswerSystem::insertNewAnsweredQuestionforPlayer(int questionid, Player * player)
{
	CustomCharacterSystem * CharacterSystem = 0;
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	std::string accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYER_ALREADY_ANSWERED_QUESTIONS);
	stmt->setInt32(0, player->GetSession()->GetAccountId());
	stmt->setString(1, accountname);
	stmt->setInt32(2, questionid);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

void CustomQuestionAnswerSystem::insertNewQuestion(Player * player, const char* args)
{

	CustomCharacterSystem * CharacterSystem = 0;
	CustomGMLogic * GMLogic = 0;
	CustomWorldSystem * WorldSystem = 0;
	CustomReportSystem * ReportSystem = 0;


	char* frage = strtok((char*)args, " ");
	if (!frage) {
		player->GetSession()->SendNotification("Without question the command will not work!");
		return;
	}

	char* antwort = strtok(NULL, " ");
	if (!antwort) {
		player->GetSession()->SendNotification("Without answer the command will not work!");
		return;
	}


	char* belohnung = strtok(NULL, " ");
	if (!belohnung) {
		player->GetSession()->SendNotification("Without reward the command will not work!");
		return ;
	}

	char* anzahl = strtok(NULL, " ");
	if (!anzahl) {
		player->GetSession()->SendNotification("Without quantity the command will not work!");
		return ;
	}

	uint32 intanzahl = atoi((char*)anzahl);
	uint32 itemid = atoi((char*)belohnung);

	bool existItem = false;
	existItem = WorldSystem->doesItemExistinDB(itemid);


	if (!existItem) {
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		ChatHandler(player->GetSession()).PSendSysMessage("Item does not exist in DB!");
		ChatHandler(player->GetSession()).PSendSysMessage("ItemID: %u", itemid);
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		return;
	}

	bool checkifItemIsForbidden = false;
	checkifItemIsForbidden = ReportSystem->checkIfItemisForbidden(itemid);

	if (checkifItemIsForbidden) {
		std::string accountname = "";
		accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
		GMLogic->addCompleteGMCountLogic(player->GetSession()->GetPlayer(), "Try to generate a forbidden Item Reward in a question!");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		ChatHandler(player->GetSession()).PSendSysMessage("Warning: GM should be a supporter not a cheater!");
		ChatHandler(player->GetSession()).PSendSysMessage("This incident has been logged in DB.");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################"); 
		return;
	}

	//PrepareStatement(CHAR_INS_PLAYER_QUESTIONS_AND_ANSWERS, "INSERT INTO player_questions_and_answers (frage,antwort,belohnung,anzahl,insertdate,creatorname,creatorid) VALUES (?,?,?,?,NOW(),?,?)", CONNECTION_ASYNC);

	PreparedStatement* insert = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYER_QUESTIONS_AND_ANSWERS);
	insert->setString(0, frage);
	insert->setString(1, antwort);
	insert->setInt32(2, itemid);
	insert->setInt32(3, intanzahl);
	insert->setString(4, player->GetSession()->GetPlayerName());
	insert->setInt32(5, player->GetSession()->GetAccountId());
	CharacterDatabase.Execute(insert);
	player->GetSession()->SendNotification("Question was sucessful imported into DB!");
	std::string itemname = "";
	itemname = WorldSystem->getItemNamebyItemId(itemid);
	ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
	ChatHandler(player->GetSession()).PSendSysMessage("Sucess! Question is now in DB!");
	ChatHandler(player->GetSession()).PSendSysMessage("Question: %s || Answer: %s ", frage, antwort);
	ChatHandler(player->GetSession()).PSendSysMessage("ItemID: %u", itemid);
	ChatHandler(player->GetSession()).PSendSysMessage("ItemName: %s", itemname);
	ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
	return;

}
