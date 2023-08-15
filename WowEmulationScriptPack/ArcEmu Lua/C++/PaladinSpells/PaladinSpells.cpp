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

/*
	How to add a new paladin spell to the dummy spell handler:

		1) Add a new function to handle the spell at the end of this file but before the
		   SetupPaladinSpells() function. SetupPaladinSpells() must always be the last function.

		2) Register the dummy spell by adding a new line to the end of the list in the
		   SetupPaladinSpells() function.

	Please look at how the other spells are handled and try to use the
	same variable names and formatting style in your new spell handler.
*/

// *****************************************************************************

bool SealOfRighteousness(uint32 i, Aura* pAura, bool apply)
{
	if(i != 0) return false;

	uint32 applyId = 20187;
	Unit* u_caster = pAura->GetUnitCaster();

	if(u_caster == 0 || !u_caster->IsPlayer()) return false;

	SpellEntry * m_spellInfo = dbcSpell.LookupEntry(applyId);

	if(apply == true)
	{
		float MWS = 1.0f;
		Item* mainHand = TO_PLAYER(u_caster)->GetItemInterface()->GetInventoryItem(EQUIPMENT_SLOT_MAINHAND);
		if(mainHand && mainHand->GetProto())
			MWS = mainHand->GetProto()->Delay / 1000.0f;

		uint32 AP = u_caster->GetAP();
		uint32 SPH = u_caster->GetUInt32Value(PLAYER_FIELD_MOD_DAMAGE_DONE_POS + SCHOOL_HOLY);
		float damage = MWS * (0.022f * AP + 0.044f * SPH);

		uint32 max_dmg = uint32(damage * 1.01f);
		uint32 min_dmg = uint32(damage * 0.99f);
		TO_PLAYER(u_caster)->AddOnStrikeSpellDamage(pAura->m_spellProto->Id, min_dmg, max_dmg);
	}
	else
		TO_PLAYER(u_caster)->RemoveOnStrikeSpellDamage(pAura->m_spellProto->Id);

	return true;
}

// -----------------------------------------------------------------------------

bool HolyShock(uint32 i, Spell* pSpell)
{
	Unit* target = pSpell->GetUnitTarget();
	if(!pSpell->p_caster || !target) return true;

	uint32 newspell = 0;

	if( isAttackable(pSpell->p_caster, target, true) ) // if its an enemy
	{
		switch(pSpell->m_spellInfo->Id)
		{
		case 20473:
			newspell = 25912;
			break;
		case 20929:
			newspell = 25911;
			break;
		case 20930:
			newspell = 25902;
			break;
		case 27174:
			newspell = 27176;
			break;
		case 33072:
			newspell = 33073;
			break;
		case 48824:
			newspell = 48822;
			break;
		case 48825:
			newspell = 48823;
			break;
		}
	}
	else // if its friendly
	{
		switch(pSpell->m_spellInfo->Id)
		{
		case 20473:
			newspell = 25914;
			break;
		case 20929:
			newspell = 25913;
			break;
		case 20930:
			newspell = 25903;
			break;
		case 27174:
			newspell = 27175;
			break;
		case 33072:
			newspell = 33074;
			break;
		case 48824:
			newspell = 48820;
			break;
		case 48825:
			newspell = 48821;
			break;
		}
	}

	SpellEntry *spInfo = dbcSpell.LookupEntry(newspell);
	if(!spInfo) return true;

	pSpell->p_caster->CastSpell(target, spInfo, true);
	return true;
}

bool SacredShield(uint32 i, Spell* pSpell)
{
	UnitPointer target = pSpell->GetUnitTarget();

	if(!target || !(target = pSpell->p_caster)) return true;

	
	
	if((pSpell->m_spellInfo->Id) == 53601)
	{
		Aura* sacredshield( new Aura( dbcSpell.LookupEntry(53601), 3000, pSpell->m_caster, pSpell->u_caster));
		pSpell->p_caster->AddAura(sacredshield);
	}
	else
		return true;


	return true;

}

// ADD NEW FUNCTIONS ABOVE THIS LINE
// *****************************************************************************

void SetupPaladinSpells(ScriptMgr * mgr)
{
	mgr->register_dummy_aura( 21084, &SealOfRighteousness); // Seal of Righteousness
	mgr->register_dummy_spell(20473, &HolyShock);           // Holy Shock rank 1
	mgr->register_dummy_spell(20929, &HolyShock);           // Holy Shock rank 2
	mgr->register_dummy_spell(20930, &HolyShock);           // Holy Shock rank 3
	mgr->register_dummy_spell(27174, &HolyShock);           // Holy Shock rank 4
	mgr->register_dummy_spell(33072, &HolyShock);           // Holy Shock rank 5
	mgr->register_dummy_spell(48824, &HolyShock);           // Holy Shock rank 6
	mgr->register_dummy_spell(48825, &HolyShock);           // Holy Shock rank 7
	mgr->register_dummy_spell(53601, &SacredShield);		// Sacred Shield rank 1

// REGISTER NEW DUMMY SPELLS ABOVE THIS LINE
// *****************************************************************************
}
