#include "ScriptPCH.h"

enum ArmorSpells
{
	PLATE_MAIL       = 750,
	ARMOR_MAIL       = 8737
};

enum WeaponProficiencies
{
	BLOCK            = 107,
	BOWS             = 264,
	CROSSBOWS        = 5011,
	DAGGERS          = 1180,
	FIST_WEAPONS     = 15590,
	GUNS             = 266,
	ONE_H_AXES       = 196,
	ONE_H_MACES      = 198,
	ONE_H_SWORDS     = 201,
	POLEARMS         = 200,
	SHOOT            = 5019,
	STAVES           = 227,
	TWO_H_AXES       = 197,
	TWO_H_MACES      = 199,
	TWO_H_SWORDS     = 202,
	WANDS            = 5009,
	THROW_WAR        = 2567
};

class CopyGearCommands : public CommandScript
{
public:
	CopyGearCommands() : CommandScript("CopyGearCommands") { }

	std::vector<ChatCommand> GetCommands() const override
	{
		static std::vector<ChatCommand> HandleCopyGearCommandTable =
		{
			{ "gear",        SEC_PLAYER, false, &HandleCopyGearCommand,           ""},
			{ "talents",     SEC_PLAYER, false, &HandleCopyTalentsCommand,        ""},
			{ "all",         SEC_PLAYER, false, &HandleCopyGearAndTalentsCommand, ""},
			// { NULL, 0, false, NULL, ""}
		};

		static std::vector<ChatCommand> CommandTable =
		{
			{ "copy",        SEC_PLAYER, true, NULL, "", HandleCopyGearCommandTable },
			// { NULL, 0, false, NULL, ""}
		};
		return CommandTable;
	}

	static bool HandleCopyGearCommand(ChatHandler* handler, const char* args)
	{
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

		std::string name;
		Player* player = handler->GetSession()->GetPlayer();
		Player* target;
		char* targetName = strtok((char*)args, " "); // Get entered name

		if (targetName)
		{
			name = targetName;
			normalizePlayerName(name);
			target = sObjectAccessor->FindPlayerByName(name.c_str());
		}
		else // If no name was entered - use target
		{
			target = handler->getSelectedPlayer();
			if (target)
				name = target->GetName();
		}

		if (target)
		{
			if (target == player)
			{
				handler->GetSession()->SendAreaTriggerMessage("You can't copy your own gear.");
				return false;
			}

			// Restrict copying from the opposite faction
			if (player->GetTeamId() != target->GetTeamId())
			{
				handler->GetSession()->SendAreaTriggerMessage("You can only copy talents from players thats in opposite faction.");
				return false;
			}

			CopyGear(player, target);
			handler->GetSession()->SendAreaTriggerMessage("Successfuly copied gear of %s",
				target->GetName());

			LearnPlateMailSpells(player);
			player->UpdateSkillsForLevel();
			LearnWeaponSkills(player);
			player->SaveToDB(false, false);
			return true;
		}
		else
			player->GetSession()->SendAreaTriggerMessage("You must have a target.");

		return true;
	}

	static bool HandleCopyTalentsCommand(ChatHandler* handler, const char* args)
	{
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

		std::string name;
		Player* player = handler->GetSession()->GetPlayer();
		Player* target;
		char* targetName = strtok((char*)args, " "); // Get entered name

		if (targetName)
		{
			name = targetName;
			normalizePlayerName(name);
			target = sObjectAccessor->FindPlayerByName(name.c_str());
		}
		else // If no name was entered - use target
		{
			target = handler->getSelectedPlayer();
			if (target && target != player)
				name = target->GetName();
			else
			{
				handler->GetSession()->SendAreaTriggerMessage("You can't copy your own gear/talents.");
				return false;
			}
		}

		if (target)
		{
			if (target == player)
			{
				handler->GetSession()->SendAreaTriggerMessage("You can't copy your own talents.");
				return false;
			}

			CopyTalents(player, target);
			handler->GetSession()->SendAreaTriggerMessage("Successfuly copied talents of %s",
				target->GetName());

			player->UpdateSkillsForLevel();
			player->SaveToDB(false, false);
			return true;
		}
		else
			player->GetSession()->SendAreaTriggerMessage("You must have a target.");

		return true;
	}

	static bool HandleCopyGearAndTalentsCommand(ChatHandler* handler, const char* args)
	{
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

		std::string name;
		Player* player = handler->GetSession()->GetPlayer();
		Player* target;
		char* targetName = strtok((char*)args, " "); // Get entered name

		if (targetName)
		{
			name = targetName;
			normalizePlayerName(name);
			target = sObjectAccessor->FindPlayerByName(name.c_str());
		}
		else // If no name was entered - use target
		{
			target = handler->getSelectedPlayer();
			if (target && target != player)
				name = target->GetName();
			else
			{
				handler->GetSession()->SendAreaTriggerMessage("You can't copy your own gear/talents.");
				return false;
			}
		}

		if (target)
		{
			if (target == player)
			{
				handler->GetSession()->SendAreaTriggerMessage("You can't copy your own gear/talents.");
				return false;
			}

			// Restrict copying from the opposite faction
			if (player->GetTeamId() != target->GetTeamId())
			{
				handler->GetSession()->SendAreaTriggerMessage("You can only copy talents from players thats in opposite faction.");
				return false;
			}

			CopyGear(player, target);
			CopyTalents(player, target);
			handler->GetSession()->SendAreaTriggerMessage("Successfuly copied gear and talents of %s",
				target->GetName());

			LearnPlateMailSpells(player);
			LearnWeaponSkills(player);
			player->UpdateSkillsForLevel();
			player->SaveToDB(false, false);
			return true;
		}
		else
			player->GetSession()->SendAreaTriggerMessage("You must have a target.");

		return true;
	}

private:
	static void ApplyBonus(Player* player, Item* item, EnchantmentSlot slot, uint32 bonusEntry)
	{
		if (!item)
			return;

		if (!bonusEntry || bonusEntry == 0)
			return;

		player->ApplyEnchantment(item, slot);
		item->SetEnchantment(slot, bonusEntry, 0, 0);
		player->ApplyEnchantment(item, slot);
	}

	// Get the gear from the selected player
	static void CopyGear(Player* player, Player* target)
	{
        if (target->IsGameMaster() || target->GetSession()->GetSecurity() >= 1)
        {
            player->GetSession()->SendAreaTriggerMessage("%s is a game master, you can't copy his gear.",
                target->GetName());
            return;
        }

		for (uint8 i = EQUIPMENT_SLOT_START; i < EQUIPMENT_SLOT_END; i++)
		{
			// Delete previous items if equipped
			player->RemoveItem(INVENTORY_SLOT_BAG_0, i, true);

			if (Item* equippedItem = target->GetItemByPos(INVENTORY_SLOT_BAG_0, i))
			{
				// TODO: Implement checks for items here

				player->EquipNewItem(i, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i)->GetEntry(), true);
				ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, i),
					PERM_ENCHANTMENT_SLOT, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i)->GetEnchantmentId(PERM_ENCHANTMENT_SLOT));
				ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, i),
					SOCK_ENCHANTMENT_SLOT, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i)->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT));
				ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, i),
					SOCK_ENCHANTMENT_SLOT_2, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i)->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_2));
				ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, i),
					SOCK_ENCHANTMENT_SLOT_3, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i)->GetEnchantmentId(SOCK_ENCHANTMENT_SLOT_3));
				ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, i),
					BONUS_ENCHANTMENT_SLOT, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i)->GetEnchantmentId(BONUS_ENCHANTMENT_SLOT));
				ApplyBonus(player, player->GetItemByPos(INVENTORY_SLOT_BAG_0, i),
					PRISMATIC_ENCHANTMENT_SLOT, target->GetItemByPos(INVENTORY_SLOT_BAG_0, i)->GetEnchantmentId(PRISMATIC_ENCHANTMENT_SLOT));
			}
		}
	}

	static void CopyTalents(Player* player, Player* target)
	{
        if (target->IsGameMaster() || target->GetSession()->GetSecurity() >= 1)
        {
            player->GetSession()->SendAreaTriggerMessage("%s is a game master, you can't copy his talents.",
                target->GetName());
            return;
        }

		// Reset current talents first
		if (player->GetFreeTalentPoints() < 71)
		{
			player->resetTalents(true);
			player->SendTalentsInfoData(false);
		}

		target->SaveToDB(false, false);

		QueryResult result = CharacterDatabase.PQuery("SELECT spell FROM character_talent WHERE guid = '%u' "
			"AND spec = '%u';", target->GetGUID(), target->GetActiveSpec());

		if (!result)
		{
			player->GetSession()->SendAreaTriggerMessage("%s doesn't have any talents yet.",
				target->GetName());
			return;
		}

		do
		{
			Field* fields = result->Fetch();
			uint32 spell = fields[0].GetUInt32();

			player->learnSpell(spell);
			player->addTalent(spell, player->GetActiveSpec(), 1); 

		} while (result->NextRow());


		CopyGlyphs(player, target);
		player->SetFreeTalentPoints(0);
		player->SendTalentsInfoData(false);
	}

	static void CopyGlyphs(Player* player, Player* target)
	{
        if (target->IsGameMaster() || target->GetSession()->GetSecurity() >= 1)
        {
            player->GetSession()->SendAreaTriggerMessage("%s is a game master, you can't copy his glyphs.",
                target->GetName());
            return;
        }

		QueryResult result = CharacterDatabase.PQuery("SELECT glyph1, glyph2, glyph3, glyph4, glyph5, glyph6 "
			"FROM character_glyphs WHERE guid = '%u' AND spec = '%u';", target->GetGUID(), target->GetActiveSpec());

		for (uint8 slot = 0; slot < MAX_GLYPH_SLOT_INDEX; ++slot)
		{
			if (!result)
				continue;

			Field* fields = result->Fetch();
			uint32 glyph1 = fields[0].GetUInt32();
			uint32 glyph2 = fields[1].GetUInt32();
			uint32 glyph3 = fields[2].GetUInt32();
			uint32 glyph4 = fields[3].GetUInt32();
			uint32 glyph5 = fields[4].GetUInt32();
			uint32 glyph6 = fields[5].GetUInt32();

			uint32 tempGlyph; // Temp

			switch (slot)
			{
			case 0: tempGlyph = glyph1; break;
			case 1: tempGlyph = glyph2; break;
			case 2: tempGlyph = glyph3; break;
			case 3: tempGlyph = glyph4; break;
			case 4: tempGlyph = glyph5; break;
			case 5: tempGlyph = glyph6; break;
			default:
				break;
			}

			if (GlyphPropertiesEntry const* gp = sGlyphPropertiesStore.LookupEntry(tempGlyph))
			{
				if (uint32 oldGlyph = player->GetGlyph(slot))
				{
					player->RemoveAurasDueToSpell(sGlyphPropertiesStore.LookupEntry(oldGlyph)->SpellId);
					player->SetGlyph(slot, 0, true);
				}
				player->CastSpell(player, gp->SpellId);
				player->SetGlyph(slot, tempGlyph, true);
			}
		}
	}

	static void LearnWeaponSkills(Player* player)
	{
		WeaponProficiencies wepSkills[] = {
			BLOCK, BOWS, CROSSBOWS, DAGGERS, FIST_WEAPONS, GUNS, ONE_H_AXES, ONE_H_MACES,
			ONE_H_SWORDS, POLEARMS, SHOOT, STAVES, TWO_H_AXES, TWO_H_MACES, TWO_H_SWORDS, WANDS, THROW_WAR
		};

		uint32 size = 17;

		for (uint32 i = 0; i < size; ++i)
			if (player->HasSpell(wepSkills[i]))
				continue;

		switch (player->getClass())
		{
		case CLASS_WARRIOR:
			player->learnSpell(THROW_WAR);
			player->learnSpell(TWO_H_SWORDS);
			player->learnSpell(TWO_H_MACES);
			player->learnSpell(TWO_H_AXES);
			player->learnSpell(STAVES);
			player->learnSpell(POLEARMS);
			player->learnSpell(ONE_H_SWORDS);
			player->learnSpell(ONE_H_MACES);
			player->learnSpell(ONE_H_AXES);
			player->learnSpell(GUNS);
			player->learnSpell(FIST_WEAPONS);
			player->learnSpell(DAGGERS);
			player->learnSpell(CROSSBOWS);
			player->learnSpell(BOWS);
			player->learnSpell(BLOCK);
			break;
		case CLASS_PRIEST:
			player->learnSpell(WANDS);
			player->learnSpell(STAVES);
			player->learnSpell(SHOOT);
			player->learnSpell(ONE_H_MACES);
			player->learnSpell(DAGGERS);
			break;
		case CLASS_PALADIN:
			player->learnSpell(TWO_H_SWORDS);
			player->learnSpell(TWO_H_MACES);
			player->learnSpell(TWO_H_AXES);
			player->learnSpell(POLEARMS);
			player->learnSpell(ONE_H_SWORDS);
			player->learnSpell(ONE_H_MACES);
			player->learnSpell(ONE_H_AXES);
			player->learnSpell(BLOCK);
			break;
		case CLASS_ROGUE:
			player->learnSpell(ONE_H_SWORDS);
			player->learnSpell(ONE_H_MACES);
			player->learnSpell(ONE_H_AXES);
			player->learnSpell(GUNS);
			player->learnSpell(FIST_WEAPONS);
			player->learnSpell(DAGGERS);
			player->learnSpell(CROSSBOWS);
			player->learnSpell(BOWS);
			break;
		case CLASS_DEATH_KNIGHT:
			player->learnSpell(TWO_H_SWORDS);
			player->learnSpell(TWO_H_MACES);
			player->learnSpell(TWO_H_AXES);
			player->learnSpell(POLEARMS);
			player->learnSpell(ONE_H_SWORDS);
			player->learnSpell(ONE_H_MACES);
			player->learnSpell(ONE_H_AXES);
			break;
		case CLASS_MAGE:
			player->learnSpell(WANDS);
			player->learnSpell(STAVES);
			player->learnSpell(SHOOT);
			player->learnSpell(ONE_H_SWORDS);
			player->learnSpell(DAGGERS);
			break;
		case CLASS_SHAMAN:
			player->learnSpell(TWO_H_MACES);
			player->learnSpell(TWO_H_AXES);
			player->learnSpell(STAVES);
			player->learnSpell(ONE_H_MACES);
			player->learnSpell(ONE_H_AXES);
			player->learnSpell(FIST_WEAPONS);
			player->learnSpell(DAGGERS);
			player->learnSpell(BLOCK);
			break;
		case CLASS_HUNTER:
			player->learnSpell(THROW_WAR);
			player->learnSpell(TWO_H_SWORDS);
			player->learnSpell(TWO_H_AXES);
			player->learnSpell(STAVES);
			player->learnSpell(POLEARMS);
			player->learnSpell(ONE_H_SWORDS);
			player->learnSpell(ONE_H_AXES);
			player->learnSpell(GUNS);
			player->learnSpell(FIST_WEAPONS);
			player->learnSpell(DAGGERS);
			player->learnSpell(CROSSBOWS);
			player->learnSpell(BOWS);
			break;
		case CLASS_DRUID:
			player->learnSpell(TWO_H_MACES);
			player->learnSpell(STAVES);
			player->learnSpell(POLEARMS);
			player->learnSpell(ONE_H_MACES);
			player->learnSpell(FIST_WEAPONS);
			player->learnSpell(DAGGERS);
			break;
		case CLASS_WARLOCK:
			player->learnSpell(WANDS);
			player->learnSpell(STAVES);
			player->learnSpell(SHOOT);
			player->learnSpell(ONE_H_SWORDS);
			player->learnSpell(DAGGERS);
			break;
		default:
			break;
		}
	}

	static void LearnPlateMailSpells(Player* player)
	{
		switch (player->getClass())
		{
		case CLASS_WARRIOR:
		case CLASS_PALADIN:
		case CLASS_DEATH_KNIGHT:
			player->learnSpell(PLATE_MAIL);
			break;
		case CLASS_SHAMAN:
		case CLASS_HUNTER:
			player->learnSpell(ARMOR_MAIL);
			break;
		default:
			break;
		}
	}
};

void AddSC_CopyGearCommands()
{
	new CopyGearCommands();
}
