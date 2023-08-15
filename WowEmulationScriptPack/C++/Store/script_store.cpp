#include "ScriptMgr.h"
#include "StoreManager.h"
#include "ScriptedGossip.h"
#include "WorldSession.h"
#include "ObjectMgr.h"

#define MAX_ENTRY 10000000

class script_store : public CreatureScript {

public:

	script_store() : CreatureScript("script_store") {}

	bool displayInitialMenu(Player* player, Creature* creature) {
		player->PlayerTalkClass->ClearMenus();

		//On récupère les points boutiques du joueur et on les affiche
		uint32 coins = Maelstrom::sStoreMgr->GetAccountCoins(player->GetSession()->GetAccountId());
		std::string msg = "You have " + std::to_string(coins) + " store coins";
		player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, msg.c_str(), GOSSIP_SENDER_MAIN, 0);

		//On récupère la liste des catégories
		std::map<uint32, Maelstrom::StoreManager::StoreCategory> categories = Maelstrom::sStoreMgr->GetCategories();
		for (auto it = categories.begin(); it != categories.end(); it++){
			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, (it->second.m_name).c_str(), GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + it->first);
		}

		player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
		return true;
	}

	bool OnGossipHello(Player* player, Creature* creature) {
		return displayInitialMenu(player, creature);
	}

	bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
	{

		if (action == 0) {
			player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
			return true;
		}

		if (action == 9000000) {
			displayInitialMenu(player, creature);
			return true;
		}

		if (action >= MAX_ENTRY && action != 9000000) {
			//On récupère l'entry de l'objet à acheter
			uint32 itemEntryToBuy = action - MAX_ENTRY;
			Maelstrom::StoreManager::PurchaseResult purchaseResult = Maelstrom::sStoreMgr->PurchaseItem(player, itemEntryToBuy);
			switch (purchaseResult) {
			case Maelstrom::StoreManager::PURCHASE_RESULT_ERROR: {
				player->GetSession()->SendAreaTriggerMessage("An error occured");
				player->PlayerTalkClass->ClearMenus();
				player->CLOSE_GOSSIP_MENU();
				return false;
			}
			break;

			case Maelstrom::StoreManager::PURCHASE_RESULT_NOT_ENOUGH_COINS: {
				player->GetSession()->SendAreaTriggerMessage("You don't have enough coins to purchase this item");
				player->PlayerTalkClass->ClearMenus();
				player->CLOSE_GOSSIP_MENU();
				return false;
			}
			break;

			case Maelstrom::StoreManager::PURCHASE_RESULT_NOT_ENOUGH_FREE_SLOTS: {
				player->GetSession()->SendAreaTriggerMessage("You don't have enough free slots in your bags to purchase this item");
				player->PlayerTalkClass->ClearMenus();
				player->CLOSE_GOSSIP_MENU();
				return false;
			}
		    break;

			case Maelstrom::StoreManager::PURCHASE_RESULT_SUCCESS: {
				player->GetSession()->SendAreaTriggerMessage("Thank you for your purchase !");
				player->PlayerTalkClass->ClearMenus();
				player->CLOSE_GOSSIP_MENU();
				return true;
			}
			break;
			}
		}

		player->PlayerTalkClass->ClearMenus();

		//On récupère les points boutiques du joueur et on les affiche
		uint32 coins = Maelstrom::sStoreMgr->GetAccountCoins(player->GetSession()->GetAccountId());
		std::string msgCoins = "You have " + std::to_string(coins) + " store coins";
		player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, msgCoins.c_str(), GOSSIP_SENDER_MAIN, 0);

		//On récupère la catégorie demandée
		uint32 catId = action - GOSSIP_ACTION_INFO_DEF;

		//On récupère tous les objets de la catégorie en question
		std::map<uint32, Maelstrom::StoreManager::StoreItem> items = Maelstrom::sStoreMgr->GetItems(catId, player->GetAverageItemLevel());
		ItemTemplateContainer const* itemTemplateContainer = sObjectMgr->GetItemTemplateStore();
		if (!itemTemplateContainer) {
			player->GetSession()->SendAreaTriggerMessage("Error");
			return false;
		}
		//On affiche tous les items en question
		for (auto elem : items){
			Maelstrom::StoreManager::StoreItem currItem = elem.second;
			const ItemLocale* itemsLoc = sObjectMgr->GetItemLocale(currItem.m_itemEntry);
			if (!itemsLoc)
				continue;
			std::string itemName = itemsLoc->Name.at(player->GetSession()->GetSessionDbLocaleIndex());
			std::string priceText = std::to_string(currItem.m_price);
			std::string message = "[" + priceText + "] " + itemName;
			std::string quantityMsg = currItem.m_quantity == 1 ? "" : " (x" + std::to_string(currItem.m_quantity) + ")";
			std::string gossip = "[" + priceText + " coins] " + itemName + quantityMsg;

			player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, gossip.c_str(), GOSSIP_SENDER_MAIN, MAX_ENTRY + currItem.m_itemEntry);
		}

		//On ajoute un bouton retour
		player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Go Back", GOSSIP_SENDER_MAIN, 9000000);

		player->SEND_GOSSIP_MENU(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
		return true;
	}

};


void AddSC_script_store() {
	new script_store();
}