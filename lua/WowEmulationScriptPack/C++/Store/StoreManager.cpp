#include "StoreManager.h"
#include "WorldSession.h"
#include "ObjectMgr.h"
#include "DBCStores.h"
#include "DBCStructure.h"

using namespace Maelstrom;

// Constructeur ---------------------------------------------------------------------------------------
StoreManager::StoreManager() : m_categories(), m_items() {}
//-----------------------------------------------------------------------------------------------------

// Méthodes publiques  --------------------------------------------------------------------------------
void StoreManager::LoadStore(){
	TC_LOG_INFO("server.loading", ">> Store loading...");
	LoadCategories();
	LoadItems();
	TC_LOG_INFO("server.loading", ">> Store successfully loaded");
}

uint32 StoreManager::GetAccountCoins(uint32 accountId) const {
	QueryResult result = LoginDatabase.PQuery("SELECT coins FROM account WHERE id=%u", accountId);
	if (!result)
		return 0;

	Field* field = result->Fetch();
	return field[0].GetUInt32();
}

void StoreManager::SetAccountCoins(uint32 accountId, uint32 newCoinsValue) {
	LoginDatabase.PExecute("UPDATE account SET coins=%u WHERE id=%u", newCoinsValue, accountId);
}


std::map<uint32, StoreManager::StoreCategory> StoreManager::GetCategories() const {
	return m_categories;
}

std::map<uint32, StoreManager::StoreItem> StoreManager::GetItems() const {
	return m_items;
}

std::map<uint32, StoreManager::StoreItem> StoreManager::GetItems(uint32 catId, uint32 playerAvgItemLevel) const {
	std::map<uint32, StoreManager::StoreItem> itemsToReturn;
	for (auto it = m_items.begin(); it != m_items.end(); it++){
		if (it->second.m_catId != catId)
			continue;
		if (it->second.m_requiredAvgItemLevel > playerAvgItemLevel)
			continue;

		itemsToReturn.insert(std::make_pair(it->first, it->second));
	}

	return itemsToReturn;
}

StoreManager::PurchaseResult StoreManager::PurchaseItem(Player* player, uint32 itemEntry) {
	//On vérifie si le joueur existe
	if (player == nullptr)
		return PURCHASE_RESULT_ERROR;

	//On vérifie si l'item est bien dans la boutique
	auto it = std::find_if(m_items.begin(), m_items.end(), [=](std::pair<uint32, StoreItem> pair) {
		if (pair.second.m_itemEntry == itemEntry)
			return true;
		return false;
	});

	if (it == m_items.end())
		return PURCHASE_RESULT_ERROR;

	//On récupère le prix de l'item
	uint32 price = it->second.m_price;
	//On récupère les points du joueur
	uint32 coins = GetAccountCoins(player->GetSession()->GetAccountId());

	//Le joueur n'a pas assez d'argent !
	if (price > coins)
		return PURCHASE_RESULT_NOT_ENOUGH_COINS;

	//On vérifie si le joueur a assez de place dans son inventaire
	bool couldAddItem = player->AddItem(itemEntry, it->second.m_quantity);
	if (!couldAddItem) {
		return PURCHASE_RESULT_NOT_ENOUGH_FREE_SLOTS;
	}
	else { //Si c'est le cas, on procède à l'achat
		SetAccountCoins(player->GetSession()->GetAccountId(), GetAccountCoins(player->GetSession()->GetAccountId()) - price);
		return PURCHASE_RESULT_SUCCESS;
	}
}

//-----------------------------------------------------------------------------------------------------

// Méthodes privées  ----------------------------------------------------------------------------------
void StoreManager::LoadCategories() {
	QueryResult result = CharacterDatabase.PQuery("SELECT * FROM store_categories");
	if (!result)
		return;

	do {

		Field* field = result->Fetch();
		m_categories.insert(std::make_pair(field[0].GetUInt32(), StoreCategory(field[0].GetUInt32(), field[1].GetString())));

	} while (result->NextRow());
}

void StoreManager::LoadItems() {
	QueryResult result = CharacterDatabase.PQuery("SELECT * FROM store_items ORDER BY price");
	if (!result)
		return;

	do {

		Field* field = result->Fetch();
		m_items.insert(std::make_pair(field[0].GetUInt32(), StoreItem(field[0].GetUInt32(), field[1].GetUInt32(), field[2].GetUInt32(), field[3].GetUInt32(), field[4].GetUInt32(), field[5].GetUInt32())));

	} while (result->NextRow());
}