#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include "Bag.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "Define.h"
#include "Field.h"
#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include "Bag.h"
#include "Mail.h"
#include "Common.h"
#include "CalendarMgr.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStructure.h"
#include "Define.h"
#include "Field.h"
#include "GameEventMgr.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
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
#include "Guild.h"
#include "Arena.h"
#include "ArenaTeam.h"
#include "ArenaScore.h"
#include "ArenaTeamMgr.h"
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomCharacterSystem.h>


class QuestLog : public PlayerScript
{

public:
	QuestLog() : PlayerScript("QuestLog") {}


	void OnQuestStatusChange(Player* player, uint32 questId) {

		if (sConfigMgr->GetBoolDefault("QuestStatus.Log", 1)) {
			CustomPlayerLog * PlayerLog = 0;
			std::ostringstream tt;
			tt << "Queststatus changed: " << questId;
			std::string reason = tt.str().c_str();
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
			return;
		}
		
		return;
	
	}

};


class KilledByLog : public PlayerScript
{

public:
	KilledByLog() : PlayerScript("KilleyByLog") {}

	void OnPlayerKilledByCreature(Creature* killer, Player* player) { 
		if (sConfigMgr->GetBoolDefault("PlayerKilledByCreature.Log", 1)) {
			CustomPlayerLog * PlayerLog = 0;
			std::ostringstream tt;
			tt << "Player was killed by: " << killer->GetName();
			std::string reason = tt.str().c_str();
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
			return;
		}
		
		return;
	}
};

class GraveYardReleaseLog : public PlayerScript
{
public: GraveYardReleaseLog() : PlayerScript("GraveYardReleaseLog") {}

		void OnPlayerRepop(Player* player) { 
			if (sConfigMgr->GetBoolDefault("PlayerGraveyardRelease.Log", 1)) {
				CustomPlayerLog * PlayerLog = 0;
				PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), "Release Soul with Release Button!");
				return;
			}

			return;
		}

};




class LevelLog : public PlayerScript
{
public:
	LevelLog() : PlayerScript("LevelLog") {}




	void OnLevelChanged(Player* player, uint8 /*oldLevel*/) {
		if (sConfigMgr->GetBoolDefault("PlayerLevelChange.Log", 1)) {
			CustomPlayerLog * PlayerLog = 0;
			std::ostringstream tt;
			tt << "Level changed from " << player->getLevel() - 1 << " to " << player->getLevel();
			std::string reason = tt.str().c_str();
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
			return;
		}
		return;

	}


};


class CreatureKillLog : public PlayerScript 
{
public:
	CreatureKillLog() : PlayerScript("CreatureKillLog") {}

	void OnCreatureKill(Player* player, Creature* killed) {
		if (sConfigMgr->GetBoolDefault("PlayerKilledCreature.Log", 1)) {
			std::string creaturename = killed->GetName();
			CustomPlayerLog * PlayerLog = 0;
			std::ostringstream tt;
			tt << "Killed: " << creaturename;
			std::string reason = tt.str().c_str();
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), reason);
			return;
		}
		return;
	}

};


class ResetTalentLog : public PlayerScript {
public:
	ResetTalentLog() : PlayerScript("ResetTalentLog") { }

	void OnTalentsReset(Player* player, bool /*noCost*/) { 
		if (sConfigMgr->GetBoolDefault("PlayerResetTalents.Log", 1)) {
			CustomPlayerLog * PlayerLog = 0;
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), "Reset Talents");
			return;
		}
		
		return;
	}

};


class PVPKillLog : public PlayerScript {
public:
	PVPKillLog() : PlayerScript("PVPKillLog") {}

	void OnPVPKill(Player* killer, Player* killed) { 
		if (sConfigMgr->GetBoolDefault("PlayerPVPKills.Log", 1)) {
			CustomPlayerLog * PlayerLog = 0;
			std::ostringstream tt;
			tt << killer << " killed : " << killed;
			std::string reason = tt.str().c_str();

			std::ostringstream zz;
			zz << killed << "was killed by " << killer;
			std::string reasone = zz.str().c_str();
			PlayerLog->addCompletePlayerLog(killer->GetSession()->GetPlayer(), reason);
			PlayerLog->addCompletePlayerLog(killed->GetSession()->GetPlayer(), reasone);
			return;
		}
		return;
	}
};

class LoginLogoutLog : public PlayerScript {
public:
	LoginLogoutLog() : PlayerScript("LoginLogoutLog") {}

	void OnLogin(Player* player, bool /*firstLogin*/) {
		if (sConfigMgr->GetBoolDefault("LoginLogout.Log", 1)) {
			CustomPlayerLog * PlayerLog = 0;
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), "Player logged in!");
			return;
		}
		return;
	}
	
	void OnLogout(Player* player) {
		if (sConfigMgr->GetBoolDefault("LoginLogout.Log", 1)) {
			CustomPlayerLog * PlayerLog = 0;
			PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), "Player logged out!");
			return;
		}
		return;
	}

};



class DuelLog : public PlayerScript
{
public:
	DuelLog() : PlayerScript("DuelLog") {}

	std::ostringstream ss;

	void OnDuelStart(Player* player1, Player* player2) {
		if (sConfigMgr->GetBoolDefault("DuelStart.Log", 1)) {
			ss << "|cff54b5ffDuel wurde gestartet mit den Teilnehmern: |r " << ChatHandler(player1->GetSession()).GetNameLink() << " |cff54b5ff und |r" << ChatHandler(player2->GetSession()).GetNameLink();
			sWorld->SendGMText(LANG_GM_BROADCAST, ss.str().c_str());
			
			CustomPlayerLog * PlayerLog = 0;
			std::ostringstream tt;
			tt << player1 << "challenged a Duel with Player " << player2;
			std::string reason = tt.str().c_str();

			PlayerLog->addCompletePlayerLog(player1->GetSession()->GetPlayer(),reason);
			return;
		}
		return;

	}

};



void AddSC_logscript()
{
	new DuelLog();
	new ResetTalentLog();
	new GraveYardReleaseLog();
	new QuestLog();
	new LevelLog();
	new CreatureKillLog();
	new KilledByLog();
	new PVPKillLog();
	new LoginLogoutLog();
}