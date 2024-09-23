#include "ScriptPCH.h"

// Must declare identifiers
class ItemUse_item_custom_summon : public ItemScript

// Must open main construct
{
    public:

        ItemUse_item_custom_summon()
        // Will be the actual scriptname placed on the item
            : ItemScript("item_custom_summon")
        {
        }
	// Be sure to use OnUse, not ItemUse otherwise you will declare it twice
	bool OnUse(Player* pPlayer, Item* pItem, const SpellCastTargets &pTargets)

	{
  // Do not allow player to use item while in combat, flight, or dead
	if ((pPlayer->isInCombat()) || (pPlayer->isInFlight()) || (pPlayer->isDead()))
	{
      pPlayer->SendEquipError(EQUIP_ERR_NOT_IN_COMBAT, pItem, NULL);
        return false;
	}
	if (pPlayer->IsMounted()) // Is player mounted
	{
      pPlayer->SendEquipError(EQUIP_ERR_CANT_DO_RIGHT_NOW, pItem, NULL);
        return true; 
	}
	//{ Don't need an else cause on every error the function is getting returned
	// Summons NPCs to the player at distances that can be set furthermore additional npcs could be spawned.
	// TeleNPC
      pPlayer->SummonCreature(162,pPlayer->GetPositionX()+4 ,pPlayer->GetPositionY(), pPlayer->GetPositionZ(), 0,TEMPSUMMON_TIMED_DESPAWN,20000);
	//}
        return false;
	}

	// Make sure wrap your main define
};

// Always use new standards such as GoHello_ ItemUse_ AT_ etc, function links to the scriptname hence ItemUse=function and item_custom_summon=scriptname

void AddSC_item_custom_summon()

{
    new ItemUse_item_custom_summon();
}
