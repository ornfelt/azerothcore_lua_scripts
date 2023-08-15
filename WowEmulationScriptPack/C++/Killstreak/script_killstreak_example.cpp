#include "ScriptMgr.h"
#include "WorldSession.h"
#include "KillstreakManager.h"

class script_killstreak_example : public PlayerScript {

public:

	// Constructor ===================================================================================================================================================
	script_killstreak_example() : PlayerScript("script_killstreak_example") {}
	//================================================================================================================================================================

	// Overriding script functions ===================================================================================================================================
	void OnPVPKill(Player* killer, Player* killed) {
		try {
			//ALWAYS CALL THIS FUNCTTION FIRST
			Maelstrom::sKillstreakMgr->HandlePvPKill(killer, killed);

			//We say to the killed that its killstreak has been reset
			killed->GetSession()->SendAreaTriggerMessage("Killstreak reset :(");

			killed->SetObjectScale(1.f);

			//We do several actions depending on the killer's killstreak
			uint64 killerKS = Maelstrom::sKillstreakMgr->GetPlayerKS(killer);
			if (killerKS == 1) {
				killer->GetSession()->SendAreaTriggerMessage("First Kill, Keep going !");
				killer->SetObjectScale(1.5f);
			}
			else if (killerKS == 2) {
				killer->GetSession()->SendAreaTriggerMessage("Two in a row !");
				killer->SetObjectScale(2.f);
				//Add an aura
				killer->AddAura(1126, killer);
				//Add a horde flag
				killer->AddAura(23333, killer);
			}
			else if (killerKS >= 3) {
				killer->SetObjectScale(killerKS);
			}
		}
		catch (const std::exception& e){
			std::cout << e.what() << std::endl;
		}
	}
	//================================================================================================================================================================
};

void AddSC_script_killstreak_example() {
	new script_killstreak_example();
}