/* Copyright (C) AstoriaCore 2021 | This piece of Code was customly coded by frytiks
* for the AstoriaCore Team and is fully ported over from TrinityCore to AzerothCore.
* It has multiple Bugfixes, Performance and Efficiency Updates! ~ Lushen */

#include "Player.h"
#include "Creature.h"
#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Define.h"
#include "Map.h"
#include "Pet.h"
#include "Item.h"
#include "Chat.h"

#define SPELL_SICKNESS 15007
#define GOB_CHEST 179697

void ReskillCheck(Player* killer, Player* killed)
{
	// if killer have same ip as killed or if player kill self dont spawn chest
	if (killer->GetSession()->GetRemoteAddress() == killed->GetSession()->GetRemoteAddress() || killer->GetGUID() == killed->GetGUID())
		return;
	// if killer is not a player dont drop
	if (!IS_PLAYER_GUID(killer->GetGUID()))
		return;
	// if player have sickness, dont drop loot
	if (killed->HasAura(SPELL_SICKNESS))
		return;
	// if player is above 5 levels or more, dont drop loot
	if (killer->getLevel() - 5 >= killed->getLevel())
		return;
	// if player is in sanctuary zone dont drop loot
	AreaTableEntry const* area = sAreaTableStore.LookupEntry(killed->GetAreaId());
	AreaTableEntry const* area2 = sAreaTableStore.LookupEntry(killer->GetAreaId());
	if (area->IsSanctuary() || area2->IsSanctuary())
		return;
	
}
class HighRiskSystem : public PlayerScript
{
public:
	HighRiskSystem() : PlayerScript("HighRiskSystem") {}
	void OnPVPKill(Player* killer, Player* killed)
	{
		if (!roll_chance_i(70))
			return;
		ReskillCheck(killer, killed);

		if (!killed->IsAlive())
		{
			uint32 prev = 0;
			uint32 count = 0;
			Position pos = killed->GetPosition();
			G3D::Quat rot = G3D::Matrix3::fromEulerAnglesZYX(pos.GetOrientation(), 0.f, 0.f);
			if (GameObject* go = killer->SummonGameObject(GOB_CHEST, killed->GetPositionX(), killed->GetPositionY(), killed->GetPositionZ(), killed->GetOrientation(), 0.0f, 0.0f, 0.0f, 0.0f, 300))
			{
				killer->AddGameObject(go);
				go->SetOwnerGUID(NULL);

				for (int i = urand(0, 17); i < EQUIPMENT_SLOT_END; ++i)
					/* Equipment Set first */

					for (uint8 i = urand(0, 17); i < EQUIPMENT_SLOT_END; ++i)
					{
						if (count >= 2) // if there is 2 or more items stop for
							if (Item* pItem = killed->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
							{
								if (pItem->GetTemplate() && (!pItem->IsEquipped() || pItem->GetTemplate()->Quality < ITEM_QUALITY_UNCOMMON))
									continue;

								uint8 slot = pItem->GetSlot();
								ChatHandler(killed->GetSession()).PSendSysMessage("|cffDA70D6You have lost your |cffffffff|Hitem:%d:0:0:0:0:0:0:0:0|h[%s]|h|r", pItem->GetEntry(), pItem->GetTemplate()->Name1.c_str());
								LootStoreItem storeItem = LootStoreItem(pItem->GetEntry(), 0, 100, 0, LOOT_MODE_DEFAULT, 0, 1, 1);
								go->loot.AddItem(storeItem);
								killed->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
								prev = i;
								count++;
								break;
							}
					}

				for (uint8 i = urand(0, 17); i < EQUIPMENT_SLOT_END; ++i)
				{
					if (!roll_chance_i(70))
						break;

					if (Item* pItem = killed->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
					{
						if (pItem->GetTemplate() && (!pItem->IsEquipped() || pItem->GetTemplate()->Quality < ITEM_QUALITY_UNCOMMON))
							continue;

						if (prev == i)
							continue;

						uint8 slot = pItem->GetSlot();
						ChatHandler(killed->GetSession()).PSendSysMessage("|cffDA70D6You have lost your |cffffffff|Hitem:%d:0:0:0:0:0:0:0:0|h[%s]|h|r", pItem->GetEntry(), pItem->GetTemplate()->Name1.c_str());
						LootStoreItem storeItem = LootStoreItem(pItem->GetEntry(), 0, 100, 0, LOOT_MODE_DEFAULT, 0, 1, 1);
						go->loot.AddItem(storeItem);
						killed->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
						ChatHandler(killed->GetSession()).PSendSysMessage("|cffDA70D6You have lost your [%s]", pItem->GetTemplate()->Name1.c_str());
						prev = 0;
						count++;
						break;
					}
				}

				/* Main bag and bagpacks */

				for (uint8 i = INVENTORY_SLOT_ITEM_START; i < INVENTORY_SLOT_ITEM_END; ++i)
				{
					if (Item* pItem = killed->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
					{
						if (count >= 2)
							break;

						if (pItem->GetTemplate() && pItem->GetTemplate()->Quality < ITEM_QUALITY_UNCOMMON)
							continue;

						uint8 slot = pItem->GetSlot();
						ChatHandler(killed->GetSession()).PSendSysMessage("|cffDA70D6You have lost your |cffffffff|Hitem:%d:0:0:0:0:0:0:0:0|h[%s]|h|r", pItem->GetEntry(), pItem->GetTemplate()->Name1.c_str());
						LootStoreItem storeItem = LootStoreItem(pItem->GetEntry(), 0, 100, 0, LOOT_MODE_DEFAULT, 0, 1, 1);
						go->loot.AddItem(storeItem);
						killed->DestroyItemCount(pItem->GetEntry(), pItem->GetCount(), true, false);
						count++;
						break;
					}
				}

				//Other bags:
				for (uint8 i = INVENTORY_SLOT_BAG_START; i < INVENTORY_SLOT_BAG_END; ++i)
				{
					if (Bag* bag = killed->GetBagByPos(i))
					{
						for (uint32 j = 0; j < bag->GetBagSize(); ++j)
						{
							if (Item* pItem = killed->GetItemByPos(i, j))
							{
								if (count >= 2)
									break;

								if (pItem->GetTemplate() && pItem->GetTemplate()->Quality < ITEM_QUALITY_UNCOMMON)
									continue;

								uint8 slot = pItem->GetSlot();
								ChatHandler(killed->GetSession()).PSendSysMessage("|cffDA70D6You have lost your |cffffffff|Hitem:%d:0:0:0:0:0:0:0:0|h[%s]|h|r", pItem->GetEntry(), pItem->GetTemplate()->Name1.c_str());
								LootStoreItem storeItem = LootStoreItem(pItem->GetEntry(), 0, 100, 0, LOOT_MODE_DEFAULT, 0, 1, 1);
								go->loot.AddItem(storeItem);
								killed->DestroyItemCount(pItem->GetEntry(), pItem->GetCount(), true, false);
								count++;
								break;
							}
						}
					}
				}
			}
		}
	}
};
void AddSC_HighRiskSystems()
{
	new HighRiskSystem();
}