/////////////////////////////////////////////////////////////////////////////
//        ____        __  __  __     ___                                   //
//       / __ )____ _/ /_/ /_/ /__  /   |  ________  ____  ____ ______     //
//      / __  / __ `/ __/ __/ / _ \/ /| | / ___/ _ \/ __ \/ __ `/ ___/     //
//     / /_/ / /_/ / /_/ /_/ /  __/ ___ |/ /  /  __/ / / / /_/ (__  )      //
//    /_____/\__,_/\__/\__/_/\___/_/  |_/_/   \___/_/ /_/\__,_/____/       //
//         Developed by Natureknight for BattleArenas.no-ip.org            //
//             Copyright (C) 2015 Natureknight/JessiqueBA                  //
//                      battlearenas.no-ip.org                             //
/////////////////////////////////////////////////////////////////////////////

#include "ScriptPCH.h"

const uint32 SPELL_DEMENTIA = 41406;

class AntiDrawSystem : public PlayerScript
{
public:
	AntiDrawSystem() : PlayerScript("AntiDrawSystem") {}

	void OnUpdateZone(Player* player, uint32 newZone, uint32 newArea)
	{
		// Remove Dementia on updating zone
		if (player->HasAura(SPELL_DEMENTIA))
			player->RemoveAura(SPELL_DEMENTIA);
	}

	void OnLogin(Player* player)
	{
		// Remove Dementia on player login
		if (player->HasAura(SPELL_DEMENTIA))
			player->RemoveAura(SPELL_DEMENTIA);
	}
};

void AddSC_Arena_AntiDraw()
{
	new AntiDrawSystem();
}