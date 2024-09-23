#ifndef BOUTIQUE_MGR
#define BOUTIQUE_MGR

#include "Player.h"
#include <map>

namespace Maelstrom {

	class StoreManager {

	public:

		// Singleton ------------------------------------------------------------------------------------------
		static StoreManager* instance()
		{
			static StoreManager instance;
			return &instance;
		}

		// Structures publiques -------------------------------------------------------------------------------
		struct StoreItem {

			// Rep ---------------------
			uint32 m_id;
			uint32 m_catId;
			uint32 m_itemEntry;
			uint32 m_price;
			uint32 m_quantity;
			uint32 m_requiredAvgItemLevel;
			//--------------------------

			// Constructor -------------
			StoreItem(uint32 id, uint32 catId, uint32 itemEntry, uint32 price, uint32 quantity, uint32 requiredAvgItemLevel) {
				m_id = id;
				m_catId = catId;
				m_itemEntry = itemEntry;
				m_price = price;
				m_quantity = quantity;
				m_requiredAvgItemLevel = requiredAvgItemLevel;
			}
			//--------------------------
		};

		struct StoreCategory {

			// Rep ---------------------
			uint32             m_catId;
			std::string        m_name;      //Nom de la catégorie dans les différentes langues prises en charge
			//--------------------------

			// Constructor -------------
			StoreCategory(uint32 catId, const std::string name) {
				m_catId = catId;
				m_name = name;
			}
		};
		//-----------------------------------------------------------------------------------------------------

		// Enumérations publiques -----------------------------------------------------------------------------
		enum PurchaseResult {
			PURCHASE_RESULT_ERROR,
			PURCHASE_RESULT_NOT_ENOUGH_COINS,
			PURCHASE_RESULT_NOT_ENOUGH_FREE_SLOTS,
			PURCHASE_RESULT_SUCCESS
		};

		//-----------------------------------------------------------------------------------------------------

		// Constructeur ---------------------------------------------------------------------------------------
		StoreManager();
		//-----------------------------------------------------------------------------------------------------

		// Méthodes publiques ---------------------------------------------------------------------------------
		void LoadStore();
		uint32 GetAccountCoins(uint32 accountId) const;
		void SetAccountCoins(uint32 accountId, uint32 newCoinsValue);
		PurchaseResult PurchaseItem(Player* player, uint32 itemEntry);

		std::map<uint32, StoreCategory> GetCategories()									  const;
		std::map<uint32, StoreItem>     GetItems()										  const;
		std::map<uint32, StoreItem>     GetItems(uint32 catId, uint32 playerAvgItemLevel) const;

	private:

		// Méthodes privées -----------------------------------------------------------------------------------
		void LoadCategories();
		void LoadItems();
		//-----------------------------------------------------------------------------------------------------


		// Représentation -------------------------------------------------------------------------------------
		std::map<uint32 /*boutique_item_id*/, StoreItem>     m_items;
		std::map<uint32 /*cat_id*/          , StoreCategory> m_categories;

	};

#define sStoreMgr StoreManager::instance()

}

#endif