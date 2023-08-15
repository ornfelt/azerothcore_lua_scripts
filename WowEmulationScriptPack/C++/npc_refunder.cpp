#include "../scripts/PrecompiledHeaders/ScriptPCH.h"

class RefundMaster : public CreatureScript
{
public:
	RefundMaster() : CreatureScript("RefundMaster") { }

	bool OnGossipHello(Player* player, Creature* creature) override
	{
		WorldSession* session = player->GetSession();
		bool found = false;
		for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
		{
			Item* newItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot);
			if (newItem && newItem->GetTemplate()->DP > 0)
			{
				if (const char* slotName = sTransmogrification->GetSlotName(slot, session))
				{
					std::string icon = sTransmogrification->GetItemIcon(newItem->GetEntry(), 33, 33, -21, 0);
					player->ADD_GOSSIP_ITEM(GOSSIP_ICON_DOT, icon + std::string(slotName), 1, slot);
					found = true;
				}
			}
		}
		if (!found)
		{
			player->GetSession()->SendNotification("You do not have any items equipped that can be refunded.");
			return true;
		}
		player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/Ability_Spy:35:35:-22:0|tNo thanks.", 11, 0);
		player->SEND_GOSSIP_MENU(10, creature->GetGUID());

		return true;
	}

	bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action) override
	{
		player->PlayerTalkClass->ClearMenus();

		if (sender == 1)
		{
			if (Item* invItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, action))
			{
				char price[250];
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/Ability_Paladin_BlessedHands:35:35:-22:0|tSelected item:", sender, action);
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, sTransmogrification->GetItemIcon(invItem->GetEntry(), 25, 25, -22, 0) + sTransmogrification->GetItemName(invItem->GetEntry(), player->GetSession()).c_str(), sender, action);

				snprintf(price, 250, "|TInterface/ICONS/Achievement_BG_returnXflags_def_WSG:35:35:-22:0|tCan be refunded for: |cffFF0000%u|r Donation Points", invItem->GetTemplate()->DP);
				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, price, sender, action);

				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "---------------------------------", sender, action);

				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/INV_Misc_Coin_02:35:35:-22:0|tCLICK TO REFUND.", 2, action);

				player->ADD_GOSSIP_ITEM(GOSSIP_ICON_MONEY_BAG, "|TInterface/ICONS/Ability_Spy:25:25:-22:0|tBack..", 10, 0);
				player->SEND_GOSSIP_MENU(10, creature->GetGUID());
				return true;
			}
			else
			{
				player->GetSession()->SendNotification("You do not have any items that can be refunded.");
				player->PlayerTalkClass->SendCloseGossip();
			}
		}
		else if (sender == 2)
		{
			if (Item* invItem = player->GetItemByPos(INVENTORY_SLOT_BAG_0, action))
			{
				player->DestroyItemCount(invItem->GetEntry(), 1, true);
				LoginDatabase.PExecute("UPDATE fusionsite.account_data SET DP = DP + %u WHERE id = %u", invItem->GetTemplate()->DP, player->GetSession()->GetAccountId());
				player->GetSession()->SendNotification("You have been refunded %u Donation Points", invItem->GetTemplate()->DP);
				player->PlayerTalkClass->SendCloseGossip();
			}
			else
			{
				player->GetSession()->SendNotification("You do not have any items that can be refunded.");
				player->PlayerTalkClass->SendCloseGossip();
			}
		}
		else if (sender == 10)
			OnGossipHello(player, creature);
		else if (sender == 11)
			player->PlayerTalkClass->SendCloseGossip();

		return true;
	}
};

void AddSC_Refunder()
{
	new RefundMaster();
}