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

#ifndef TALENT_FUNCTIONS_H
#define TALENT_FUNCTIONS_H

#include "Define.h"
#include <ace/Singleton.h>
#include <ace/Thread_Mutex.h>

enum templateSpells
{
	PLATE_MAIL = 750,
	MAIL       = 8737
};

enum WeaponProficiencies
{
	BLOCK           = 107,
	BOWS            = 264,
	CROSSBOWS       = 5011,
	DAGGERS         = 1180,
	FIST_WEAPONS    = 15590,
	GUNS            = 266,
	ONE_H_AXES      = 196,
	ONE_H_MACES     = 198,
	ONE_H_SWORDS    = 201,
	POLEARMS        = 200,
	SHOOT           = 5019,
	STAVES          = 227,
	TWO_H_AXES      = 197,
	TWO_H_MACES     = 199,
	TWO_H_SWORDS    = 202,
	WANDS           = 5009,
	THROW_WAR       = 2567
};

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
		player->learnSpell(THROW_WAR, false);
		player->learnSpell(TWO_H_SWORDS, false);
		player->learnSpell(TWO_H_MACES, false);
		player->learnSpell(TWO_H_AXES, false);
		player->learnSpell(STAVES, false);
		player->learnSpell(POLEARMS, false);
		player->learnSpell(ONE_H_SWORDS, false);
		player->learnSpell(ONE_H_MACES, false);
		player->learnSpell(ONE_H_AXES, false);
		player->learnSpell(GUNS, false);
		player->learnSpell(FIST_WEAPONS, false);
		player->learnSpell(DAGGERS, false);
		player->learnSpell(CROSSBOWS, false);
		player->learnSpell(BOWS, false);
		player->learnSpell(BLOCK, false);
		break;
	case CLASS_PRIEST:
		player->learnSpell(WANDS, false);
		player->learnSpell(STAVES, false);
		player->learnSpell(SHOOT, false);
		player->learnSpell(ONE_H_MACES, false);
		player->learnSpell(DAGGERS, false);
		break;
	case CLASS_PALADIN:
		player->learnSpell(TWO_H_SWORDS, false);
		player->learnSpell(TWO_H_MACES, false);
		player->learnSpell(TWO_H_AXES, false);
		player->learnSpell(POLEARMS, false);
		player->learnSpell(ONE_H_SWORDS, false);
		player->learnSpell(ONE_H_MACES, false);
		player->learnSpell(ONE_H_AXES, false);
		player->learnSpell(BLOCK, false);
		break;
	case CLASS_ROGUE:
		player->learnSpell(ONE_H_SWORDS, false);
		player->learnSpell(ONE_H_MACES, false);
		player->learnSpell(ONE_H_AXES, false);
		player->learnSpell(GUNS, false);
		player->learnSpell(FIST_WEAPONS, false);
		player->learnSpell(DAGGERS, false);
		player->learnSpell(CROSSBOWS, false);
		player->learnSpell(BOWS, false);
		break;
	case CLASS_DEATH_KNIGHT:
		player->learnSpell(TWO_H_SWORDS, false);
		player->learnSpell(TWO_H_MACES, false);
		player->learnSpell(TWO_H_AXES, false);
		player->learnSpell(POLEARMS, false);
		player->learnSpell(ONE_H_SWORDS, false);
		player->learnSpell(ONE_H_MACES, false);
		player->learnSpell(ONE_H_AXES, false);
		break;
	case CLASS_MAGE:
		player->learnSpell(WANDS, false);
		player->learnSpell(STAVES, false);
		player->learnSpell(SHOOT, false);
		player->learnSpell(ONE_H_SWORDS, false);
		player->learnSpell(DAGGERS, false);
		break;
	case CLASS_SHAMAN:
		player->learnSpell(TWO_H_MACES, false);
		player->learnSpell(TWO_H_AXES, false);
		player->learnSpell(STAVES, false);
		player->learnSpell(ONE_H_MACES, false);
		player->learnSpell(ONE_H_AXES, false);
		player->learnSpell(FIST_WEAPONS, false);
		player->learnSpell(DAGGERS, false);
		player->learnSpell(BLOCK, false);
		break;
	case CLASS_HUNTER:
		player->learnSpell(THROW_WAR, false);
		player->learnSpell(TWO_H_SWORDS, false);
		player->learnSpell(TWO_H_AXES, false);
		player->learnSpell(STAVES, false);
		player->learnSpell(POLEARMS, false);
		player->learnSpell(ONE_H_SWORDS, false);
		player->learnSpell(ONE_H_AXES, false);
		player->learnSpell(GUNS, false);
		player->learnSpell(FIST_WEAPONS, false);
		player->learnSpell(DAGGERS, false);
		player->learnSpell(CROSSBOWS, false);
		player->learnSpell(BOWS, false);
		break;
	case CLASS_DRUID:
		player->learnSpell(TWO_H_MACES, false);
		player->learnSpell(STAVES, false);
		player->learnSpell(POLEARMS, false);
		player->learnSpell(ONE_H_MACES, false);
		player->learnSpell(FIST_WEAPONS, false);
		player->learnSpell(DAGGERS, false);
		break;
	case CLASS_WARLOCK:
		player->learnSpell(WANDS, false);
		player->learnSpell(STAVES, false);
		player->learnSpell(SHOOT, false);
		player->learnSpell(ONE_H_SWORDS, false);
		player->learnSpell(DAGGERS, false);
		break;
	default:
		break;
	}
}

struct TalentTemplate
{
	std::string    playerClass;
	std::string    playerSpec;
	uint32         talentId;
};

struct GlyphTemplate
{
	std::string    playerClass;
	std::string    playerSpec;
	uint8          slot;
	uint32         glyph;
};

struct HumanGearTemplate
{
	std::string    playerClass;
	std::string    playerSpec;
	uint8          pos;
	uint32         itemEntry;
	uint32         enchant;
	uint32         socket1;
	uint32         socket2;
	uint32         socket3;
	uint32         bonusEnchant;
	uint32         prismaticEnchant;
};

struct AllianceGearTemplate
{
	std::string    playerClass;
	std::string    playerSpec;
	uint8          pos;
	uint32         itemEntry;
	uint32         enchant;
	uint32         socket1;
	uint32         socket2;
	uint32         socket3;
	uint32         bonusEnchant;
	uint32         prismaticEnchant;
};

struct HordeGearTemplate
{
	std::string    playerClass;
	std::string    playerSpec;
	uint8          pos;
	uint32         itemEntry;
	uint32         enchant;
	uint32         socket1;
	uint32         socket2;
	uint32         socket3;
	uint32         bonusEnchant;
	uint32         prismaticEnchant;
};

typedef std::vector<HumanGearTemplate*> HumanGearContainer;
typedef std::vector<AllianceGearTemplate*> AllianceGearContainer;
typedef std::vector<HordeGearTemplate*> HordeGearContainer;

typedef std::vector<TalentTemplate*> TalentContainer;
typedef std::vector<GlyphTemplate*> GlyphContainer;

class sTemplateNPC
{
public:
	void LoadTalentsContainer();
	void LoadGlyphsContainer();

	void LoadHumanGearContainer();
	void LoadAllianceGearContainer();
	void LoadHordeGearContainer();

	void ApplyGlyph(Player* player, uint8 slot, uint32 glyphID);
	void ApplyBonus(Player* player, Item* item, EnchantmentSlot slot, uint32 bonusEntry);

	bool OverwriteTemplate(Player* /*player*/, std::string& /*playerSpecStr*/);
	void ExtractGearTemplateToDB(Player* /*player*/, std::string& /*playerSpecStr*/);
	void ExtractTalentTemplateToDB(Player* /*player*/, std::string& /*playerSpecStr*/);
	void ExtractGlyphsTemplateToDB(Player* /*player*/, std::string& /*playerSpecStr*/);
	bool CanEquipTemplate(Player* /*player*/, std::string& /*playerSpecStr*/);

	std::string GetClassString(Player* /*player*/);
	std::string sTalentsSpec;

	void LearnTemplateTalents(Player* /*player*/);
	void LearnTemplateGlyphs(Player* /*player*/);
	void EquipTemplateGear(Player* /*player*/);

	void LearnPlateMailSpells(Player* /*player*/);

	GlyphContainer m_GlyphContainer;
	TalentContainer m_TalentContainer;

	HumanGearContainer m_HumanGearContainer;
	AllianceGearContainer m_AllianceGearContainer;
	HordeGearContainer m_HordeGearContainer;
};
#define sTemplateNpcMgr ACE_Singleton<sTemplateNPC, ACE_Null_Mutex>::instance()
#endif