/////////////////////////////////////////////////////////////////////////////
//        ____        __  __  __     ___                                   //
//       / __ )____ _/ /_/ /_/ /__  /   |  ________  ____  ____ ______     //
//      / __  / __ `/ __/ __/ / _ \/ /| | / ___/ _ \/ __ \/ __ `/ ___/     //
//     / /_/ / /_/ / /_/ /_/ /  __/ ___ |/ /  /  __/ / / / /_/ (__  )      //
//    /_____/\__,_/\__/\__/_/\___/_/  |_/_/   \___/_/ /_/\__,_/____/       //
//         Developed by Natureknight for BattleArenas.no-ip.org            //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////

#include "ScriptPCH.h"
#include "Battleground.h"

class FastArenaCrystal : public GameObjectScript
{
public:

	FastArenaCrystal()
		: GameObjectScript("FastArenaCrystal") { }

	bool OnGossipHello(Player* player, GameObject* go)
	{
		if (Battleground *bg = player->GetBattleground())
		{
			// Don't let spectators to use arena crystal
			if (player->isSpectator())
			{
				player->GetSession()->SendAreaTriggerMessage("You're not be able to do this while spectating.");
				return false;
			}

			if (bg->isArena() && bg->IsChallenge()) // 1v1 challenge
				player->GetSession()->SendAreaTriggerMessage("Players marked as ready: %u/2", bg->ClickFastStart(player, go));

			if (!bg->IsChallenge())
			{
				if (bg->isArena() && bg->GetArenaType() == ARENA_TYPE_3v3_SOLO) // 3v3 solo queue
					player->GetSession()->SendAreaTriggerMessage("Players marked as ready: %u/6", bg->ClickFastStart(player, go));

				if (bg->isArena() && bg->GetArenaType() == ARENA_TYPE_5v5) // 1v1
					player->GetSession()->SendAreaTriggerMessage("Players marked as ready: %u/2", bg->ClickFastStart(player, go));

				if (bg->isArena() && bg->GetArenaType() == ARENA_TYPE_2v2) // 2v2
					player->GetSession()->SendAreaTriggerMessage("Players marked as ready: %u/4", bg->ClickFastStart(player, go));

				if (bg->isArena() && bg->GetArenaType() == ARENA_TYPE_3v3) // 3v3
					player->GetSession()->SendAreaTriggerMessage("Players marked as ready: %u/6", bg->ClickFastStart(player, go));

				if (bg->isArena() && bg->GetArenaType() == ARENA_TYPE_10v10) // 10v10
					player->GetSession()->SendAreaTriggerMessage("Players marked as ready: %u/20", bg->ClickFastStart(player, go));
			}
		}
		return false;
	}
};

void AddSC_fast_arena_start()
{
	new FastArenaCrystal();
}