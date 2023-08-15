#include "CustomReportSystem.h"
#include "CharacterDatabase.h"
#include <Custom/Logic/CustomCharacterSystem.h>
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomWorldSystem.h>
#include "Config.h"
#include "Language.h"
#include <stdio.h>
#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "Common.h"
#include "Player.h"
#include "Config.h"
#include "WorldSession.h"
#include "Language.h"
#include "Log.h"
#include "SpellAuras.h"
#include "World.h"
#include "Transport.h"
#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "SocialMgr.h"
#include "CreatureGroups.h"
#include "Language.h"
#include "TargetedMovementGenerator.h"
#include "CreatureAI.h"
#include "Player.h"
#include "Pet.h"
#include "ObjectGuid.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QueryResult.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Transaction.h"
#include "WorldSession.h"
#include <sstream>
#include <string>
#include <stdlib.h>
#include "Chat.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "ReputationMgr.h"
#include "ScriptMgr.h"

#define REPORT_QUEST_SUCESS "Quest report sucessfull."
#define REPORT_QUEST_SUCESS_AND_COMPLETE "Quest reported and completed."
#define REPORT_QUEST_ERROR  "You already reported this quest!"
#define CHECK_QUEST_ERROR "Quest was not found in DB!"
#define REPORT_ACTIVATE "Quest sucessfully activated!"
#define REPORT_DEACTIVATE "Quest sucessfully deactivate!"
#define REPORT_NO_VALID_QUEST "Without entering a valid Questerrormessage, the command cannot be executed!"
#define REPORT_QUEST_SYNTAX "Syntax: .report quest [Shift-click on Questname], Your Reportmessage."

bool CustomReportSystem::checkIfPlayerHasAlreadyReportedQuest(int accountid, int questid)
{

	PreparedStatement * selreportquestplayer = CharacterDatabase.GetPreparedStatement(CHAR_SEL_PLAYER_REPORT_QUEST);
	selreportquestplayer->setInt32(0, accountid);
	selreportquestplayer->setInt32(1, questid);
	PreparedQueryResult existplayer = CharacterDatabase.Query(selreportquestplayer);

	if (!existplayer) {
		return false;
	}

	return 	true;
}

void CustomReportSystem::addNewPlayerReportInDB(std::string playername, std::string guildname, int guid, int accountid, int questid)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_PLAYER_REPORT_QUEST);
	stmt->setString(0, playername);
	stmt->setString(1, guildname);
	stmt->setInt32(2, guid);
	stmt->setInt32(3, accountid);
	stmt->setInt32(4, questid);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);

}


//Insert an new reported Quest in DB if the quest isn´t already reported!
void CustomReportSystem::addNewQuestReportInDB(std::string questname, int questid, int quantity, int active)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_REPORT_QUEST);
	stmt->setString(0, questname);
	stmt->setInt32(1, questid);
	stmt->setInt32(2, quantity);
	stmt->setInt32(3, active);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}



//Update quantity of a speicifc questid
void CustomReportSystem::UpdateQuantityQuestReportInDB(int quantity, int questid)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_REPORT_QUEST_COUNT);
	stmt->setInt32(0, quantity);
	stmt->setInt32(1, questid);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}


//Activate or Deactivate a reported Quest with specific questid
void CustomReportSystem::setQuestActiveOrInactive(int active, int questid)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_REPORT_QUEST_SET_QUEST_ACTIVE);
	stmt->setInt32(0, active);
	stmt->setInt32(1, questid);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

//Get Questdetails about a specific reported quest.
PreparedQueryResult CustomReportSystem::getReportedQuestDetails(int questid)
{
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_REPORT_QUEST);
	stmt->setInt32(0, questid);
	PreparedQueryResult ergebnis = CharacterDatabase.Query(stmt);

	
	if (!ergebnis) {
		return nullptr;
	}

	return ergebnis;
}

void CustomReportSystem::insertErrorMessageForQuest(Player* player, int questid, std::string error_message)
{
	CustomCharacterSystem * CharacterSystem = 0;
	std::string accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_REPORT_ERROR_MESSAGE);
	stmt->setString(0, player->GetSession()->GetPlayerName());
	stmt->setInt32(1, player->GetGUID());
	stmt->setString(2, accountname);
	stmt->setInt32(3, player->GetSession()->GetAccountId());
	stmt->setInt32(4, questid);
	stmt->setString(5, error_message);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

bool CustomReportSystem::completeQuest(int32 entry, ChatHandler * handler, Player * player)
{
	Quest const* quest = sObjectMgr->GetQuestTemplate(entry);
	
	// If player doesn't have the quest
	if (!quest || player->GetQuestStatus(entry) == QUEST_STATUS_NONE)
	{
		handler->PSendSysMessage(LANG_COMMAND_QUEST_NOTFOUND, entry);
		handler->SetSentErrorMessage(true);
		return false;
	}

	// Add quest items for quests that require items
	for (uint8 x = 0; x < QUEST_ITEM_OBJECTIVES_COUNT; ++x)
	{
		uint32 id = quest->RequiredItemId[x];
		uint32 count = quest->RequiredItemCount[x];
		if (!id || !count)
			continue;

		uint32 curItemCount = player->GetItemCount(id, true);

		ItemPosCountVec dest;
		uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, id, count - curItemCount);
		if (msg == EQUIP_ERR_OK)
		{
			Item* item = player->StoreNewItem(dest, id, true);
			player->SendNewItem(item, count - curItemCount, true, false);
		}
	}

	// All creature/GO slain/cast (not required, but otherwise it will display "Creature slain 0/10")
	for (uint8 i = 0; i < QUEST_OBJECTIVES_COUNT; ++i)
	{
		int32 creature = quest->RequiredNpcOrGo[i];
		uint32 creatureCount = quest->RequiredNpcOrGoCount[i];

		if (creature > 0)
		{
			if (CreatureTemplate const* creatureInfo = sObjectMgr->GetCreatureTemplate(creature))
				for (uint16 z = 0; z < creatureCount; ++z)
					player->KilledMonster(creatureInfo, ObjectGuid::Empty);
		}
		else if (creature < 0)
			for (uint16 z = 0; z < creatureCount; ++z)
				player->KillCreditGO(creature);
	}

	// If the quest requires reputation to complete
	if (uint32 repFaction = quest->GetRepObjectiveFaction())
	{
		uint32 repValue = quest->GetRepObjectiveValue();
		uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
		if (curRep < repValue)
			if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
				player->GetReputationMgr().SetReputation(factionEntry, repValue);
	}

	// If the quest requires a SECOND reputation to complete
	if (uint32 repFaction = quest->GetRepObjectiveFaction2())
	{
		uint32 repValue2 = quest->GetRepObjectiveValue2();
		uint32 curRep = player->GetReputationMgr().GetReputation(repFaction);
		if (curRep < repValue2)
			if (FactionEntry const* factionEntry = sFactionStore.LookupEntry(repFaction))
				player->GetReputationMgr().SetReputation(factionEntry, repValue2);
	}

	// If the quest requires money
	int32 ReqOrRewMoney = quest->GetRewOrReqMoney();
	if (ReqOrRewMoney < 0)
		player->ModifyMoney(-ReqOrRewMoney);

	if (sWorld->getBoolConfig(CONFIG_QUEST_ENABLE_QUEST_TRACKER)) // check if Quest Tracker is enabled
	{
		SQLTransaction trans = CharacterDatabase.BeginTransaction();
		// prepare Quest Tracker datas
		PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_QUEST_TRACK_GM_COMPLETE);
		stmt->setUInt32(0, quest->GetQuestId());
		stmt->setUInt32(1, player->GetGUID().GetCounter());

		// add to Quest Tracker
		trans->Append(stmt);
		CharacterDatabase.CommitTransaction(trans);
	}

	player->CompleteQuest(entry);
	return true;
}

bool CustomReportSystem::completeQuestReport(Player * player, ChatHandler * handler, const char* args)
{
	CustomReportSystem * ReportSystem = 0;
	CustomWorldSystem * WorldSystem = 0;
	CustomPlayerLog * PlayerLog = 0;


	char* questlogname = strtok((char*)args, ",");
	char* reportmsg = strtok(NULL, "");

	//char* reportmsg = strtok((char*)args, " ");
	if (!reportmsg) {
		handler->PSendSysMessage("##########################################################");
		handler->PSendSysMessage(REPORT_NO_VALID_QUEST);
		handler->PSendSysMessage(REPORT_QUEST_SYNTAX);
		handler->PSendSysMessage("##########################################################");
		return true;
	}

	std::string error_message = std::string((char*)reportmsg);

	//char* questlogname = strtok(NULL, " ");
	if (!questlogname) {
		handler->PSendSysMessage("##########################################################");
		handler->PSendSysMessage(REPORT_NO_VALID_QUEST);
		handler->PSendSysMessage(REPORT_QUEST_SYNTAX);
		handler->PSendSysMessage("##########################################################");
		player->GetSession()->SendNotification("Without entering a valid Quest, the command cannot be executed! Syntax: .report quest [Shift-click on Questname] !");
		return true;
	}

	std::string eingabe = std::string((char*)questlogname);


	if (eingabe == "") {
		handler->PSendSysMessage("##########################################################");
		handler->PSendSysMessage(REPORT_NO_VALID_QUEST);
		handler->PSendSysMessage(REPORT_QUEST_SYNTAX);
		handler->PSendSysMessage("##########################################################");
		player->GetSession()->SendNotification("Without entering a valid Quest, the command cannot be executed! Syntax: .report quest [Shift-click on Questname]!");
		return true;
	}

	char const* id = handler->extractKeyFromLink((char*)questlogname, "Hquest");
	if (!id) {
		handler->PSendSysMessage("##########################################################");
		handler->PSendSysMessage(REPORT_NO_VALID_QUEST);
		handler->PSendSysMessage(REPORT_QUEST_SYNTAX);
		handler->PSendSysMessage("##########################################################");
		player->GetSession()->SendNotification("Without entering a valid Quest, the command cannot be executed! Syntax: .report quest [Shift-click on Questname]!");
		return true;
	}




	int questid = atoul(id);

	if (player->GetSession()->GetSecurity() <= 2) {
		handler->PSendSysMessage("QuestID : %u", questid);
	}

	//check if Playeraccount already reported Quest. If yes return true 
	bool playerhasreported = ReportSystem->checkIfPlayerHasAlreadyReportedQuest(player->GetSession()->GetAccountId(), questid);

	if (player->GetSession()->GetSecurity() <= 2) {
		handler->PSendSysMessage("PlayerHasReported: %s", playerhasreported);
	}

	if (playerhasreported) {
		handler->PSendSysMessage("##########################################################");
		handler->PSendSysMessage(REPORT_QUEST_ERROR);
		handler->PSendSysMessage("##########################################################");
		return true;
	}

	//check if quest is already reported or not.
	bool questisalreadyreported = ReportSystem->checkIfQuestIsAlreadyReported(questid);

	if (questisalreadyreported) {

		if (player->GetSession()->GetSecurity() <= 2) {
			handler->PSendSysMessage("QuestisalreadyReported : %s", questisalreadyreported);
		}

		PreparedQueryResult ergebnis = ReportSystem->getReportedQuestDetails(questid);

		Field* report_quest = ergebnis->Fetch();
		uint32 questreportid = report_quest[0].GetInt32();
		uint32 anzahl = report_quest[1].GetInt32();
		uint32 aktiv = report_quest[2].GetInt32();
		uint32 activateamount = sConfigMgr->GetIntDefault("Quest.Report.Amount", 5);
		//if quantity == 5 , set quest to autocomplete
		if (anzahl + 1 == activateamount) {
			bool isQuestForbidden = false;
			isQuestForbidden = ReportSystem->checkIfQuestisForbidden(questid);

			if (player->GetSession()->GetSecurity() >= 2) {
				handler->PSendSysMessage("Debug: Questid: %u", questid);
				handler->PSendSysMessage("Debug: Is Quest Forbidden?: %s", isQuestForbidden);
			}

			if (player->GetGuildId() != 0) {
				//Quest is forbidden and should not be activated!
				if (isQuestForbidden) {
					std::ostringstream tt;
					tt << "Quest mit ID " << questid << " geportet";
					std::string reason = tt.str().c_str();
					PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
					ReportSystem->addNewPlayerReportInDB(player->GetSession()->GetPlayerName(), player->GetGuildName(), player->GetGUID(), player->GetSession()->GetAccountId(), questid);
					ReportSystem->UpdateQuantityQuestReportInDB(anzahl + 1, questid);
					ReportSystem->insertErrorMessageForQuest(player->GetSession()->GetPlayer(), questid, error_message);
					std::string questname = WorldSystem->getQuestNamebyID(questid);
					handler->PSendSysMessage("##########################################################");
					handler->PSendSysMessage(REPORT_QUEST_SUCESS);
					handler->PSendSysMessage("QuestID: %u", questid);
					handler->PSendSysMessage("Questname: %s", questname);
					handler->PSendSysMessage("Reportmessage: %s", error_message);
					handler->PSendSysMessage("##########################################################");
					return true;
				}

				//Quest is not forbidden and activating is ok!
				std::ostringstream tt;
				tt << "Quest mit ID " << questid << " geportet";
				std::string reason = tt.str().c_str();
				PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
				ReportSystem->addNewPlayerReportInDB(player->GetSession()->GetPlayerName(), player->GetGuildName(), player->GetGUID(), player->GetSession()->GetAccountId(), questid);
				ReportSystem->UpdateQuantityQuestReportInDB(anzahl + 1, questid);
				ReportSystem->setQuestActiveOrInactive(1, questid);
				ReportSystem->insertErrorMessageForQuest(player->GetSession()->GetPlayer(), questid, error_message);
				std::string questname = WorldSystem->getQuestNamebyID(questid);
				handler->PSendSysMessage("##########################################################");
				handler->PSendSysMessage(REPORT_QUEST_SUCESS);
				handler->PSendSysMessage("QuestID: %u", questid);
				handler->PSendSysMessage("Questname: %s", questname);
				handler->PSendSysMessage("Reportmessage: %s", error_message);
				handler->PSendSysMessage("##########################################################");
				return true;
			}

			//Player has no guild !
			std::ostringstream tt;
			tt << "Quest mit ID " << questid << " geportet";
			std::string reason = tt.str().c_str();
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
			ReportSystem->addNewPlayerReportInDB(player->GetSession()->GetPlayerName(), "null", player->GetGUID(), player->GetSession()->GetAccountId(), questid);
			ReportSystem->UpdateQuantityQuestReportInDB(anzahl + 1, questid);
			ReportSystem->insertErrorMessageForQuest(player->GetSession()->GetPlayer(), questid, error_message);
			std::string questname = WorldSystem->getQuestNamebyID(questid);
			handler->PSendSysMessage("##########################################################");
			handler->PSendSysMessage(REPORT_QUEST_SUCESS);
			handler->PSendSysMessage("QuestID: %u", questid);
			handler->PSendSysMessage("Questname: %s", questname);
			handler->PSendSysMessage("Reportmessage: %s", error_message);
			handler->PSendSysMessage("##########################################################");

			if (isQuestForbidden) {
				ReportSystem->setQuestActiveOrInactive(0, questid);
				return true;
			}
			ReportSystem->setQuestActiveOrInactive(1, questid);
			return true;

		}

		//if quest active, complete quest
		if (aktiv == 1) {
			std::ostringstream tt;
			tt << "Quest mit ID " << questid << " geportet";
			std::string reason = tt.str().c_str();
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
			ReportSystem->addNewPlayerReportInDB(player->GetSession()->GetPlayerName(), "null", player->GetGUID(), player->GetSession()->GetAccountId(), questid);
			ReportSystem->UpdateQuantityQuestReportInDB(anzahl + 1, questid);
			completeQuest(questreportid, handler, player);
			ReportSystem->insertErrorMessageForQuest(player->GetSession()->GetPlayer(), questid, error_message);
			std::string questname = WorldSystem->getQuestNamebyID(questid);
			handler->PSendSysMessage("##########################################################");
			handler->PSendSysMessage(REPORT_QUEST_SUCESS);
			handler->PSendSysMessage("QuestID: %u", questid);
			handler->PSendSysMessage("Questname: %s", questname);
			handler->PSendSysMessage("Reportmessage: %s", error_message);
			handler->PSendSysMessage("##########################################################");
			handler->PSendSysMessage(REPORT_QUEST_SUCESS_AND_COMPLETE);
			return true;
		}

		//Quest acitve != 0 and quantity < 5
		std::ostringstream tt;
		tt << "Quest mit ID " << questid << " geportet";
		std::string reason = tt.str().c_str();
		PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
		ReportSystem->addNewPlayerReportInDB(player->GetSession()->GetPlayerName(), "null", player->GetGUID(), player->GetSession()->GetAccountId(), questid);
		ReportSystem->UpdateQuantityQuestReportInDB(anzahl + 1, questid);
		ReportSystem->insertErrorMessageForQuest(player->GetSession()->GetPlayer(), questid, error_message);
		std::string questname = WorldSystem->getQuestNamebyID(questid);
		handler->PSendSysMessage("##########################################################");
		handler->PSendSysMessage(REPORT_QUEST_SUCESS);
		handler->PSendSysMessage("QuestID: %u", questid);
		handler->PSendSysMessage("Questname: %s", questname);
		handler->PSendSysMessage("Reportmessage: %s", error_message);
		handler->PSendSysMessage("##########################################################");
		handler->PSendSysMessage(REPORT_QUEST_SUCESS);
		return true;

	}



	else {
		std::string questname = WorldSystem->getQuestNamebyID(questid);
		ReportSystem->addNewQuestReportInDB(questname, questid, 1, 0);
		if (player->GetGuildId() != 0) {
			std::ostringstream tt;
			tt << "Quest mit ID " << questid << " geportet";
			std::string reason = tt.str().c_str();
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
			ReportSystem->addNewPlayerReportInDB(player->GetSession()->GetPlayerName(), player->GetGuildName(), player->GetGUID(), player->GetSession()->GetAccountId(), questid);
			ReportSystem->insertErrorMessageForQuest(player->GetSession()->GetPlayer(), questid, error_message);
			handler->PSendSysMessage("##########################################################");
			handler->PSendSysMessage(REPORT_QUEST_SUCESS);
			handler->PSendSysMessage("QuestID: %u", questid);
			handler->PSendSysMessage("Questname: %s", questname);
			handler->PSendSysMessage("Reportmessage: %s", error_message);
			handler->PSendSysMessage("##########################################################");
			player->GetSession()->SendAreaTriggerMessage(REPORT_QUEST_SUCESS);
			return true;
		}

		std::ostringstream tt;
		tt << "Quest mit ID " << questid << " geportet";
		std::string reason = tt.str().c_str();
		PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
		ReportSystem->addNewPlayerReportInDB(player->GetSession()->GetPlayerName(), "null", player->GetGUID(), player->GetSession()->GetAccountId(), questid);
		ReportSystem->insertErrorMessageForQuest(player->GetSession()->GetPlayer(), questid, error_message);
		handler->PSendSysMessage("##########################################################");
		handler->PSendSysMessage(REPORT_QUEST_SUCESS);
		handler->PSendSysMessage("QuestID: %u", questid);
		handler->PSendSysMessage("Questname: %s", questname);
		handler->PSendSysMessage("Reportmessage: %s", error_message);
		handler->PSendSysMessage("##########################################################");
		player->GetSession()->SendAreaTriggerMessage(REPORT_QUEST_SUCESS);
		return true;
	}



	return true;

}




//Returns if a Quest was already reported or not. If 0 = quest wasn´t reported. 1 = quest is already reported.
//RETURN VALUE IS BOOLEAN
bool CustomReportSystem::checkIfQuestIsAlreadyReported(int questid) {
	PreparedStatement * selreportquest = CharacterDatabase.GetPreparedStatement(CHAR_SEL_REPORT_QUEST);
	selreportquest->setInt32(0, questid);
	PreparedQueryResult ergebnis = CharacterDatabase.Query(selreportquest);

	if (!ergebnis) {
		return false;
	}

	return true;
}


void CustomReportSystem::insertQuestIntoForbiddenTable(int questid)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_QUEST_IN_FORBIDDEN_TABLE);
	stmt->setInt32(0, questid);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

void CustomReportSystem::insertItemIntoForbiddenTable(int itemid)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ITEM_IN_FORBIDDEN_TABLE);
	stmt->setInt32(0, itemid);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

bool CustomReportSystem::checkIfQuestisForbidden(int questid)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_QUEST_FROM_FORBIDDEN_TABLE);
	stmt->setInt32(0, questid);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return false;
	}
	return true;
}

bool CustomReportSystem::checkIfItemisForbidden(int itemid)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEM_FROM_FORBIDDEN_TABLE);
	stmt->setInt32(0, itemid);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return false;
	}
	return true;
}