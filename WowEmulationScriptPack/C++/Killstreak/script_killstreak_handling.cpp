#include "ScriptMgr.h"
#include "KillstreakManager.h"
#include <thread>

class script_killstreak_handling : public PlayerScript {

public:

	// Constructor ===================================================================================================================================================
	script_killstreak_handling() : PlayerScript("script_killstreak_handling") {}
	//================================================================================================================================================================

	// Overriding script functions ===================================================================================================================================
	void OnLogout(Player* player) { 
		Maelstrom::sKillstreakMgr->RemovePlayer(player);
	}
	//================================================================================================================================================================
};

void AddSC_script_killstreak_handling() {
	new script_killstreak_handling();
}