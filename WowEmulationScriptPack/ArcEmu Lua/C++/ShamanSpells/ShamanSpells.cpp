/****************************************************************************
 *
 * SpellHandler Plugin
 * Copyright (c) 2007 Team Ascent
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0
 * License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons,
 * 543 Howard Street, 5th Floor, San Francisco, California, 94105, USA.
 *
 * EXCEPT TO THE EXTENT REQUIRED BY APPLICABLE LAW, IN NO EVENT WILL LICENSOR BE LIABLE TO YOU
 * ON ANY LEGAL THEORY FOR ANY SPECIAL, INCIDENTAL, CONSEQUENTIAL, PUNITIVE OR EXEMPLARY DAMAGES
 * ARISING OUT OF THIS LICENSE OR THE USE OF THE WORK, EVEN IF LICENSOR HAS BEEN ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGES.
 *
 */

#include "StdAfx.h"
#include "Setup.h"

/************************************************************************/
/* Spell Defs                                                           */
/************************************************************************/

bool RockbiterWeapon(uint32 i, Spell* pSpell)
{
    uint32 enchantment_entry = 0;
    switch(pSpell->m_spellInfo->RankNumber)
    {
    case 1:
        enchantment_entry = 3021;
        break;
    case 2:
        enchantment_entry = 3024;
        break;
    case 3:
        enchantment_entry = 3027;
        break;
    case 4:
        enchantment_entry = 3030;
        break;
    case 5:
        enchantment_entry = 3033;
        break;
    case 6:
        enchantment_entry = 3036;
        break;
    case 7:
        enchantment_entry = 3039;
        break;
    case 8:
        enchantment_entry = 3042;
        break;
    case 9:
        enchantment_entry = 3018;
        break;
    }

    if(!enchantment_entry || !pSpell->p_caster)
        return true;

    Item* item = pSpell->p_caster->GetItemInterface()->GetInventoryItem(EQUIPMENT_SLOT_MAINHAND);
    EnchantEntry * enchant = dbcEnchant.LookupEntry(enchantment_entry);
    if(!item || !enchant)
        return true;

    int32 Slot = item->HasEnchantment(enchant->Id);
    if(Slot >= 0)
        item->ModifyEnchantmentTime(Slot, 1800);
    else
    {
		//check if enchantment slot 1 is taken. If there was no enchantment there function will quit
		item->RemoveEnchantment(1);
		//this will also apply bonuses for us
        Slot = item->AddEnchantment(enchant, 1800, false, true, false, 1);   // 5min
        if(Slot < 0) return true;
    }

    sLog.outDebug("ShamanSpells.cpp :: Rockbiter Weapon Rank %u, enchant %u, slot %u", pSpell->m_spellInfo->RankNumber,
        enchantment_entry, Slot);
    
    return true;
}

class LinkedHPElemental : public CreatureAIScript
{
public:
    ADD_CREATURE_FACTORY_FUNCTION(LinkedHPElemental);
	LinkedHPElemental(CreaturePointer pCreature) : CreatureAIScript(pCreature) { }

	void OnLoad()
	{
		//we should be in world here, lets get totem
		Unit* totem=_unit->GetMapMgr()->GetUnit(_unit->GetUInt64Value(UNIT_FIELD_CREATEDBY));

		if (totem == NULL) //WTF
			return;

#ifdef ASCENT_CORE
		_unit->ShareHealthWithUnit(totem);
#endif
	}
};

bool EarthLivingWeapon(uint32 i, Spell* pSpell)  // fix healing weapon ench.
{
	uint32 e_entry = 0;
	switch(pSpell->m_spellInfo->RankNumber)
	{
	case 1:
		e_entry = 3345;
		break;
	case 2:
		e_entry = 3346;
		break;
	case 3:
		e_entry = 3347;
		break;
	case 4:
		e_entry = 3348;
		break;
	case 5:
		e_entry = 3349;
		break;
	case 6:
		e_entry = 3350;
		break;

	}

	if(e_entry == 0 || !pSpell->p_caster)
		return true;


	Item* item = pSpell->p_caster->GetItemInterface()->GetInventoryItem(EQUIPMENT_SLOT_MAINHAND);
    EnchantEntry * enchant = dbcEnchant.LookupEntry(e_entry);
    if(!item || !enchant)
        return true;

    int32 Slot = item->HasEnchantment(enchant->Id);
    if(Slot >= 0)
        item->ModifyEnchantmentTime(Slot, 1800); // set for 30 min
    else
    {
		//check if enchantment slot 1 is taken. If there was no enchantment there function will quit
		item->RemoveEnchantment(1);
		//this will also apply bonuses for us
        Slot = item->AddEnchantment(enchant, 1800, false, true, false, 1);   // 30min
		
        if(Slot < 0) return true;
    }

    sLog.outDebug("ShamanSpells.cpp :: Earthliving Weapon Rank %u, enchant %u, slot %u", pSpell->m_spellInfo->RankNumber,
        e_entry, Slot);
    
    return true;

}

bool WindfuryWeapon(uint32 i, Spell* pSpell)
{
	uint32 e_entry = 0; // initalize

	switch(pSpell->m_spellInfo->RankNumber)
	{
		case 1:
			e_entry = 283;
			break;
		case 2:
			e_entry = 284;
			break;
		case 3:
			e_entry = 525;
			break;
		case 5:
			e_entry = 1669;
			break;
		case 6:
			e_entry = 2636;
			break;
		case 7:
			e_entry = 3786;
			break;
		case 8:
			e_entry = 3787;
			break;
	}

		if(e_entry == 0 || !pSpell->p_caster)
			return true;


    Item* item = pSpell->p_caster->GetItemInterface()->GetInventoryItem(EQUIPMENT_SLOT_MAINHAND);
    EnchantEntry * enchant = dbcEnchant.LookupEntry(e_entry);
    if(!item || !enchant)
        return true;

	int32 Slot = item->HasEnchantment(enchant->Id);
    if(Slot >= 0)
        item->ModifyEnchantmentTime(Slot, 1800); // set for 30 min
    else
    {
		//check if enchantment slot 1 is taken. If there was no enchantment there function will quit
		item->RemoveEnchantment(1);
		//this will also apply bonuses for us
        Slot = item->AddEnchantment(enchant, 1800, false, true, false, 1);   // 30min
		
        if(Slot < 0) return true;
    }

    sLog.outDebug("ShamanSpells.cpp :: Windfury Weapon Rank %u, enchant %u, slot %u", pSpell->m_spellInfo->RankNumber,
        e_entry, Slot);
    
    return true;

		
}


void SetupShamanSpells(ScriptMgr * mgr)
{
	mgr->register_dummy_spell(8017, &RockbiterWeapon); // rank 1
	mgr->register_dummy_spell(8018, &RockbiterWeapon); // rank 2
	mgr->register_dummy_spell(8019, &RockbiterWeapon); // rank 3
	mgr->register_dummy_spell(10399, &RockbiterWeapon);// rank 4
	mgr->register_dummy_spell(16314, &RockbiterWeapon);// rank 5
	mgr->register_dummy_spell(16315, &RockbiterWeapon);// rank 6
	mgr->register_dummy_spell(16316, &RockbiterWeapon);// rank 7
	mgr->register_dummy_spell(25479, &RockbiterWeapon);// rank 8
	mgr->register_dummy_spell(25485, &RockbiterWeapon);// rank 9

	mgr->register_creature_script(15352, &LinkedHPElemental::Create);
	mgr->register_creature_script(15438, &LinkedHPElemental::Create);

	// earthliving

	mgr->register_dummy_spell(51730, &EarthLivingWeapon); // rank 1
	mgr->register_dummy_spell(51988, &EarthLivingWeapon); // rank 2
	mgr->register_dummy_spell(51991, &EarthLivingWeapon); // rank 3
	mgr->register_dummy_spell(51992, &EarthLivingWeapon); // rank 4
	mgr->register_dummy_spell(51993, &EarthLivingWeapon); // rank 5
	mgr->register_dummy_spell(51994, &EarthLivingWeapon); // rank 6

	// windfury
	mgr->register_dummy_spell(8232, &WindfuryWeapon); // rank 1
	mgr->register_dummy_spell(8235, &WindfuryWeapon); // rank 2
	mgr->register_dummy_spell(10486, &WindfuryWeapon); // rank 3
	mgr->register_dummy_spell(16362, &WindfuryWeapon); // rank 4
	mgr->register_dummy_spell(25505, &WindfuryWeapon); // rank 5
	mgr->register_dummy_spell(58801, &WindfuryWeapon); // rank 6
	mgr->register_dummy_spell(58803, &WindfuryWeapon); // rank 7
	mgr->register_dummy_spell(58804, &WindfuryWeapon); // rank 8
}
