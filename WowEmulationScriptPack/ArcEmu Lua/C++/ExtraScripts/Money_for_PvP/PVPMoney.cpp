#include "StdAfx.h"
#include "Setup.h"

#define TWL_ADD_GOLD 100000 // 100 gold

// Made by Twl at <HHScripts>

void MoneyForKill(Player* pPlayer, Player* pVictim)
{
	if(pPlayer->GetTeam() == pVictim->GetTeam() || !pVictim->IsPlayer()) return;

	uint32 currentgold = pPlayer->GetUInt32Value(PLAYER_FIELD_COINAGE);
	uint32 newgold = currentgold + TWL_ADD_GOLD;

	pPlayer->BroadcastMessage("%sHHScript[PvP]: %Megolted %s-t ezert kapsz 100 goldot!", MSG_COLOR_RED, MSG_COLOR_YELLOW, pVictim->GetName());
	pPlayer->SetUInt32Value(PLAYER_FIELD_COINAGE, newgold);
	
}

void SetupMoneyForKill(ScriptMgr * mgr)
{
	mgr->register_hook(SERVER_HOOK_EVENT_ON_KILL_PLAYER, (void*)MoneyForKill);	
}