#include "StdAfx.h"
#include "Setup.h"

#define REQ_HONOR_POINT 10000
#define ITEM_ID			123

//Script made by Twilight at <HHScripts>

void ItemForHonor(Player* pPlayer)
{
	if(!pPlayer || !pPlayer->IsPlayer()) return;

	uint32 honor = pPlayer->GetUInt32Value(PLAYER_FIELD_HONOR_CURRENCY);
	
	if(honor < REQ_HONOR_POINT) return;
	
	SlotResult slotresult;
	ItemPrototype *proto = ItemPrototypeStorage.LookupEntry( ITEM_ID );

	if(!proto) return;

	if( !slotresult.Result )
	{
		pPlayer->GetItemInterface()->BuildInventoryChangeError(NULLITEM, NULLITEM, INV_ERR_INVENTORY_FULL);
		return;
	}

	Item* itm = objmgr.CreateItem( ITEM_ID, pPlayer );
	pPlayer->GetItemInterface()->SafeAddItem( itm, slotresult.ContainerSlot, slotresult.Slot);
	pPlayer->BroadcastMessage("%sHHScripts[PvP]: %sElerted a %d honor pontot. Ezert megkapod ezt az itemet: %d", MSG_COLOR_RED, MSG_COLOR_YELLOW, REQ_HONOR_POINT, ITEM_ID);
	
}

void RegisterPvPItem(ScriptMgr * mgr)
{
	mgr->register_hook(SERVER_HOOK_EVENT_ON_HONORABLE_KILL, (void*)ItemForHonor);
}