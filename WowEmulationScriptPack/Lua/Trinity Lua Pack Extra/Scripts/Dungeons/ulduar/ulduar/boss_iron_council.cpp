/* Copyright (C) 2010 FlameScripts <http://www.flame-wow.org/>
* This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/* ScriptData
SDName: boss_iron_council
SD%Complete: 90%
SDComment: missing yells and rune of power
SDCategory: Ulduar
EndScriptData */

#include "precompiled.h"
#include "ulduar.h"

enum
{
    //yells

    //all
    SPELL_BERSERK                = 47008,
    SPELL_SUPERCHARGE            = 61920,
    //steelbreaker
    SPELL_HIGH_VOLTAGE            = 61890,
    SPELL_HIGH_VOLTAGE_H        = 63498,
    SPELL_FUSION_PUNCH            = 61903,
    SPELL_FUSION_PUNCH_H        = 63493,
    SPELL_STATIC_DISRUPTION        = 44008,
    SPELL_STATIC_DISRUPTION_H    = 63494,
    SPELL_POWER                    = 64637,
    SPELL_POWER_H                = 61888,
    SPELL_ELECTRICAL_CHARGE        = 61902,
    //runemaster molgeim
    SPELL_SHIELD                = 62274,
    SPELL_SHIELD_H                = 63489,
    SPELL_RUNE_OF_POWER            = 63513,
    SPELL_RUNE_OF_DEATH            = 62269,
    SPELL_RUNE_OF_DEATH_H        = 63490,
    SPELL_RUNE_OF_SUMMONING        = 62273,
    //rune of power
    AURA_RUNE_OF_POWER            = 61974,
    //rune of summoning
    AURA_RUNE_OF_SUMMONING        = 62019,
    //lightning elemental
    SPELL_LIGHTNING_BLAST        = 62054,
    SPELL_LIGHTNING_BLAST_H        = 63491,
    //stormcaller brundir
    SPELL_CHAIN_LIGHTNING        = 61879,
    SPELL_CHAIN_LIGHTNING_H        = 63479,
    SPELL_OVERLOAD                = 61869,
    SPELL_LIGHTNING_WHIRL        = 61915,
    SPELL_LIGHTNING_WHIRL_H        = 63483,
    SPELL_STORMSHIELD            = 64187,
    SPELL_LIGHTNING_TENDRILS    = 61887,
    SPELL_LIGHTNING_TENDRILS_H    = 63486,
    LIGHTNING_TENDRILS_VISUAL    = 61883,
    //NPC ids
    MOB_LIGHTNING_ELEMENTAL        = 32958
};

// Rune of Power
struct FLAMEMU_DLL_DECL mob_rune_of_powerAI : public ScriptedAI
{
    mob_rune_of_powerAI(Creature* pCreature) : ScriptedAI(pCreature) 
    {
        Reset();
        SetCombatMovement(false);
    }

    uint32 Death_Timer;

    void Reset()
    {
        Death_Timer = 60000;
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        DoCast(m_creature,  AURA_RUNE_OF_POWER);
    }

    void UpdateAI(const uint32 diff)
    {
        if (Death_Timer < diff)
        {
            m_creature->DealDamage(m_creature, m_creature->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }else Death_Timer -= diff;
    }
};

CreatureAI* GetAI_mob_rune_of_power(Creature* pCreature)
{
    return new mob_rune_of_powerAI(pCreature);
}

// Lightning Elemental
struct FLAMEMU_DLL_DECL mob_ulduar_lightning_elementalAI : public ScriptedAI
{
    mob_ulduar_lightning_elementalAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        Reset();
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;
    bool m_bIsRegularMode;

    uint32 Death_Timer;
    uint32 Check_Timer;
    bool explode;

    void Reset()
    {
        explode = false;
        Check_Timer = 1000;
    }

    void UpdateAI(const uint32 diff)
    {
        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim())
            return;

        if (Death_Timer < diff && explode)
        {
            m_creature->DealDamage(m_creature, m_creature->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }else Death_Timer -= diff;

        if (Check_Timer < diff)
        {
            if (m_creature->IsWithinDistInMap(m_creature->getVictim(), 15))
            {
                DoCast(m_creature, m_bIsRegularMode ? SPELL_LIGHTNING_BLAST : SPELL_LIGHTNING_BLAST_H);
                explode = true;
                Death_Timer = 1000;
            }
            Check_Timer = 1000;
        }else Check_Timer -= diff;
    }
};

CreatureAI* GetAI_mob_ulduar_lightning_elemental(Creature* pCreature)
{
    return new mob_ulduar_lightning_elementalAI(pCreature);
}

// Rune of Summoning
struct FLAMEMU_DLL_DECL mob_rune_of_summoningAI : public ScriptedAI
{
    mob_rune_of_summoningAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        Reset();
        SetCombatMovement(false);
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
    }

    ScriptedInstance* m_pInstance;

    uint32 Death_Timer;
    uint32 Summon_Timer;
    uint32 summon_delay;
    uint32 summonnum;
    bool summondone;

    void Reset()
    {
        summondone = false;
        summon_delay = 3000;
        summonnum = 0;
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        DoCast(m_creature,  AURA_RUNE_OF_SUMMONING);
    }

    void UpdateAI(const uint32 diff)
    {
        if (Death_Timer < diff && summondone)
        {
            m_creature->DealDamage(m_creature, m_creature->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }else Death_Timer -= diff;

        if (summon_delay < diff)
        {
            if (Creature* pTemp = m_creature->SummonCreature(MOB_LIGHTNING_ELEMENTAL, 0.0f, 0.0f, 0.0f, 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 10000))
                ++summonnum;
            summon_delay = 500;
            if (summonnum > 9)
            {
                summondone = true;
                Death_Timer = 400;
            }
        } else summon_delay -= diff;
    }
};

CreatureAI* GetAI_mob_rune_of_summoning(Creature* pCreature)
{
    return new mob_rune_of_summoningAI(pCreature);
}

//Stormcaller Brundir
struct FLAMEMU_DLL_DECL boss_brundirAI : public ScriptedAI
{
    boss_brundirAI(Creature* pCreature) : ScriptedAI(pCreature) 
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        m_bIsRegularMode = pCreature->GetMap()->IsRegularDifficulty();

        Reset();
    }

    ScriptedInstance* m_pInstance;
    bool m_bIsRegularMode;

    uint32 Chain_Lightning_Timer;
    uint32 Overload_Timer;
    uint32 Whirl_Timer;
    uint32 Tendrils_start_Timer;
    uint32 Tendrils_Change;
    uint32 Tendrils_end_Timer;
    uint32 die_delay;
    uint32 Enrage_Timer;
    uint32 Check;

    bool supercharge1;
    bool supercharge2;
    bool tendrils;
    bool die;
    bool steelbreaker;
    bool molgeim;
    bool enrage;

    void Reset()
    {
        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
        Chain_Lightning_Timer = 0;
        Overload_Timer = 35000;
        Enrage_Timer = 900000;
        Check = 1000;
        enrage = false;
        supercharge1 = false;
        supercharge2 = false;
        tendrils = false;
        steelbreaker = false;
        molgeim = false;
        die = false;
        if (m_creature->HasAura(SPELL_SUPERCHARGE))
            m_creature->RemoveAurasDueToSpell(SPELL_SUPERCHARGE);
    }

    void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
    {
        if (uiDamage > m_creature->GetHealth() && !die)
        {
            uiDamage = 0;
            m_creature->CastStop();
            m_creature->setFaction(1925);
            if (supercharge1)
            {
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
                    if (pTemp->isAlive() && pTemp->HasAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0))
                        pTemp->GetAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0)->modStackAmount(+1);
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
                    if (pTemp->isAlive() && pTemp->HasAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0))
                        pTemp->GetAura(SPELL_SUPERCHARGE,EFFECT_INDEX_0)->modStackAmount(+1);
            }else
                DoCast(m_creature, SPELL_SUPERCHARGE);
            die_delay = 500;
            die = true;
        }
    }

    void JustDied(Unit* pKiller)
    {
        //death yell
        m_creature->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        m_creature->setFaction(14);
        Map* pMap = m_creature->GetMap();
        if (pMap && pMap->IsDungeon())
        {
            Map::PlayerList const &PlayerList = pMap->GetPlayers();
            if (PlayerList.isEmpty())
                return;
            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (i->getSource()->isAlive() && i->getSource()->HasAura(SPELL_SUPERCHARGE))
                    i->getSource()->RemoveAurasDueToSpell(SPELL_SUPERCHARGE);
            }
        }
        if (m_pInstance)
        {
            if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
                if (!pTemp->isAlive())
                    if (Creature* p2Temp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
                        if (!p2Temp->isAlive())
                        {
                            m_pInstance->SetData(TYPE_ASSEMBLY, DONE);
                            m_creature->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                            pTemp->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                            p2Temp->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                        }
            if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
                if (!pTemp->isAlive())
                    pTemp->SetHealth(pTemp->GetMaxHealth());
            if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
                if (!pTemp->isAlive())
                    pTemp->SetHealth(pTemp->GetMaxHealth());
        }
    }

    void Aggro(Unit* pWho)
    {
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
            if (pTemp->isAlive())
                pTemp->SetInCombatWithZone();
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
            if (pTemp->isAlive())
                pTemp->SetInCombatWithZone();
        if (m_pInstance)
            m_pInstance->SetData(TYPE_ASSEMBLY, IN_PROGRESS);
    }

    void JustReachedHome()
    {
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
            if (!pTemp->isAlive())
                pTemp->Respawn();
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
            if (!pTemp->isAlive())
                pTemp->Respawn();
        if (m_pInstance)
            m_pInstance->SetData(TYPE_ASSEMBLY, FAIL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim())
            return;

        if (Chain_Lightning_Timer < diff && !tendrils)
        {
            DoCast(m_creature->getVictim(), m_bIsRegularMode ? SPELL_CHAIN_LIGHTNING : SPELL_CHAIN_LIGHTNING_H);
            Chain_Lightning_Timer = 2000;
        }else Chain_Lightning_Timer -= diff;   

        if (Overload_Timer < diff && !tendrils)
        {
            //overload emote
            m_creature->CastStop();
            DoCast(m_creature, SPELL_OVERLOAD);
            Overload_Timer = 40000;
        }else Overload_Timer -= diff;  

        if (Whirl_Timer < diff && !tendrils && supercharge1)
        {
            m_creature->CastStop();
            DoCast(m_creature, m_bIsRegularMode ? SPELL_LIGHTNING_WHIRL : SPELL_LIGHTNING_WHIRL_H);
            Whirl_Timer = 10000;
        }else Whirl_Timer -= diff;

        if (Tendrils_start_Timer < diff && supercharge2)
        {
            if (!tendrils)
            {
                //tendrils emote (?)
                m_creature->CastStop();
                DoCast(m_creature, LIGHTNING_TENDRILS_VISUAL);
                if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0))
                {
                    m_creature->AddThreat(pTarget,0.0f);
                    m_creature->AI()->AttackStart(pTarget);
                }
                tendrils = true;
                m_creature->SetSpeedRate(MOVE_RUN, 0.8);
                Tendrils_start_Timer = 3000;
                Tendrils_end_Timer = 40000;
                Tendrils_Change = 5000;
            } else
            {
                DoCast(m_creature, m_bIsRegularMode ? SPELL_LIGHTNING_TENDRILS : SPELL_LIGHTNING_TENDRILS_H);
                Tendrils_start_Timer = 90000;
            }
        }else Tendrils_start_Timer -= diff;

        if (Tendrils_Change < diff && tendrils)
        {
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0))
            {
                m_creature->AddThreat(pTarget,0.0f);
                m_creature->AI()->AttackStart(pTarget);
            }
            Tendrils_Change = 6000;
        }else Tendrils_Change -= diff;

        if (Tendrils_end_Timer < diff && tendrils)
        {
            if (m_creature->HasAura(SPELL_LIGHTNING_TENDRILS))
                m_creature->RemoveAurasDueToSpell(SPELL_LIGHTNING_TENDRILS);
            if (m_creature->HasAura(SPELL_LIGHTNING_TENDRILS_H))
                m_creature->RemoveAurasDueToSpell(SPELL_LIGHTNING_TENDRILS_H);
            if (m_creature->HasAura(LIGHTNING_TENDRILS_VISUAL))
                m_creature->RemoveAurasDueToSpell(LIGHTNING_TENDRILS_VISUAL);
            Tendrils_start_Timer = 90000;
            m_creature->SetSpeedRate(MOVE_RUN, 1.8);
            tendrils = false;
            Chain_Lightning_Timer = 5000;
            Overload_Timer = 35000;
            Whirl_Timer = 10000;
        }else Tendrils_end_Timer -= diff;

        if (die_delay < diff)
        {
            if (die)
                m_creature->DealDamage(m_creature, m_creature->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }
        else die_delay -= diff;

        if (Enrage_Timer < diff && !enrage)
        {
            m_creature->CastStop();
            DoCast(m_creature, SPELL_BERSERK);
            enrage = true;
        }else Enrage_Timer -= diff;

        if (Check < diff)
        {
            if (!steelbreaker)
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
                    if (!pTemp->isAlive())
                    {
                        steelbreaker = true;
                        if (!supercharge1)
                        {
                            supercharge1 = true;
                            Whirl_Timer = 10000;
                        }
                        else
                        {
                            supercharge2 = true;
                            Tendrils_start_Timer = 40000;
                            Tendrils_end_Timer = 60000;
                            Tendrils_Change = 6000;
                        }
                    }
            if (!molgeim)
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
                    if (!pTemp->isAlive())
                    {
                        molgeim = true;
                        if (!supercharge1)
                        {
                            supercharge1 = true;
                            Whirl_Timer = 10000;
                        }
                        else
                        {
                            supercharge2 = true;
                            Tendrils_start_Timer = 40000;
                            Tendrils_end_Timer = 60000;
                            Tendrils_Change = 6000;
                        }
                    }
            Check = 1000;
        }else Check -= diff;
        
        if (!tendrils && !die)
            DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_brundir(Creature* pCreature)
{
    return new boss_brundirAI(pCreature);
}

//Runemaster Molgeim
struct FLAMEMU_DLL_DECL boss_molgeimAI : public ScriptedAI
{
    boss_molgeimAI(Creature* pCreature) : ScriptedAI(pCreature) 
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        m_bIsRegularMode = pCreature->GetMap()->IsRegularDifficulty();

        Reset();
    }

    ScriptedInstance* m_pInstance;
    bool m_bIsRegularMode;

    uint32 Shield_Timer;
    uint32 Rune_Power_Timer;
    uint32 Rune_Death_Timer;
    uint32 Rune_Summon_Timer;
    uint32 die_delay;
    uint32 Enrage_Timer;
    uint32 Check;

    bool supercharge1;
    bool supercharge2;
    bool die;
    bool brundir;
    bool steelbreaker;
    bool enrage;

    void Reset()
    {
        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
        Shield_Timer = 20000;
        Rune_Power_Timer = 10000;
        Enrage_Timer = 900000;
        Check = 1000;
        enrage = false;
        brundir = false;
        steelbreaker = false;
        supercharge1 = false;
        supercharge2 = false;
        die = false;
        if (m_creature->HasAura(SPELL_SUPERCHARGE))
            m_creature->RemoveAurasDueToSpell(SPELL_SUPERCHARGE);
    }

    void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
    {
        if (uiDamage > m_creature->GetHealth() && !die)
        {
            uiDamage = 0;
            m_creature->CastStop();
            m_creature->setFaction(1925);
            if (supercharge1)
            {
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
                    if (pTemp->isAlive() && pTemp->HasAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0))
                        pTemp->GetAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0)->modStackAmount(+1);
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
                    if (pTemp->isAlive() && pTemp->HasAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0))
                        pTemp->GetAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0)->modStackAmount(+1);
            }else
                DoCast(m_creature, SPELL_SUPERCHARGE);
            die_delay = 500;
            die = true;
        }
    }

    void JustDied(Unit* pKiller)
    {
        //death yell
        m_creature->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        m_creature->setFaction(14);
        Map* pMap = m_creature->GetMap();
        if (pMap && pMap->IsDungeon())
        {
            Map::PlayerList const &PlayerList = pMap->GetPlayers();
            if (PlayerList.isEmpty())
                return;
            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (i->getSource()->isAlive() && i->getSource()->HasAura(SPELL_SUPERCHARGE))
                    i->getSource()->RemoveAurasDueToSpell(SPELL_SUPERCHARGE);
            }
        }
        if (m_pInstance)
        {
            if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
                if (!pTemp->isAlive())
                    if (Creature* p2Temp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
                        if (!p2Temp->isAlive())
                        {
                            m_pInstance->SetData(TYPE_ASSEMBLY, DONE);
                            m_creature->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                            pTemp->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                            p2Temp->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                        }
            if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
                if (!pTemp->isAlive())
                    pTemp->SetHealth(pTemp->GetMaxHealth());
            if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
                if (!pTemp->isAlive())
                    pTemp->SetHealth(pTemp->GetMaxHealth());
        }
    }

    void Aggro(Unit* pWho)
    {
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
            if (pTemp->isAlive())
                pTemp->SetInCombatWithZone();
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
            if (pTemp->isAlive())
                pTemp->SetInCombatWithZone();
        if (m_pInstance)
            m_pInstance->SetData(TYPE_ASSEMBLY, IN_PROGRESS);
    }

    void JustReachedHome()
    {
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
            if (!pTemp->isAlive())
                pTemp->Respawn();
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
            if (!pTemp->isAlive())
                pTemp->Respawn();
        if (m_pInstance)
            m_pInstance->SetData(TYPE_ASSEMBLY, FAIL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim())
            return;

        if (Shield_Timer < diff)
        {
            DoCast(m_creature->getVictim(), m_bIsRegularMode ? SPELL_SHIELD : SPELL_SHIELD_H);
            Shield_Timer = 50000;
        }else Shield_Timer -= diff;   

        if (Rune_Power_Timer < diff)
        {
            switch(urand(0, 2))
            {
                case 0:
                    if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
                        if (pTemp->isAlive())
                            DoCast(pTemp, SPELL_RUNE_OF_POWER);
                        else
                            DoCast(m_creature, SPELL_RUNE_OF_POWER);
                break;
                case 1:
                    if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
                        if (pTemp->isAlive())
                            DoCast(pTemp, SPELL_RUNE_OF_POWER);
                        else
                            DoCast(m_creature, SPELL_RUNE_OF_POWER);
                break;
                case 2:
                    DoCast(m_creature, SPELL_RUNE_OF_POWER);
                break;
            }
            Rune_Power_Timer = 55000;
        }else Rune_Power_Timer -= diff;

        if (Rune_Death_Timer < diff && supercharge1)
        {
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(pTarget, m_bIsRegularMode ? SPELL_RUNE_OF_DEATH : SPELL_RUNE_OF_DEATH_H);
            Rune_Death_Timer = 60000;
        }else Rune_Death_Timer -= diff;

        if (Rune_Summon_Timer < diff && supercharge2)
        {
            m_creature->CastStop();
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCast(pTarget, SPELL_RUNE_OF_SUMMONING);
            Rune_Summon_Timer = 30000;
        }else Rune_Summon_Timer -= diff;

        if (die_delay < diff)
        {
            if (die)
                m_creature->DealDamage(m_creature, m_creature->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }
        else die_delay -= diff;

        if (Enrage_Timer < diff && !enrage)
        {
            m_creature->CastStop();
            DoCast(m_creature, SPELL_BERSERK);
            enrage = true;
        }else Enrage_Timer -= diff;

        if (Check < diff)
        {
            if (!steelbreaker)
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_STEELBREAKER))))
                    if (!pTemp->isAlive())
                    {
                        steelbreaker = true;
                        if (!supercharge1)
                        {
                            supercharge1 = true;
                            Rune_Death_Timer = 10000;
                        }
                        else
                        {
                            supercharge2 = true;
                            Rune_Summon_Timer = 20000;
                        }
                    }
            if (!brundir)
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
                    if (!pTemp->isAlive())
                    {
                        brundir = true;
                        if (!supercharge1)
                        {
                            supercharge1 = true;
                            Rune_Death_Timer = 10000;
                        }
                        else
                        {
                            supercharge2 = true;
                            Rune_Summon_Timer = 20000;
                        }
                    }
            Check = 1000;
        }else Check -= diff;
        
        if (!die)
            DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_molgeim(Creature* pCreature)
{
    return new boss_molgeimAI(pCreature);
}

//Steelbreaker
struct FLAMEMU_DLL_DECL boss_steelbreakerAI : public ScriptedAI
{
    boss_steelbreakerAI(Creature* pCreature) : ScriptedAI(pCreature) 
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        m_bIsRegularMode = pCreature->GetMap()->IsRegularDifficulty();

        Reset();
    }

    ScriptedInstance* m_pInstance;
    bool m_bIsRegularMode;

    uint32 Fusion_Punch_Timer;
    uint32 Static_Disruption_Timer;
    uint32 Power_Timer;
    uint32 Meltdown_Timer;
    uint32 die_delay;
    uint32 Enrage_Timer;
    uint32 Check;

    uint64 MeltTarget;

    bool brundir;
    bool molgeim;
    bool supercharge1;
    bool supercharge2;
    bool die;
    bool enrage;

    void Reset()
    {
        m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_OOC_NOT_ATTACKABLE);
        Fusion_Punch_Timer = 20000;
        Enrage_Timer = 900000;
        MeltTarget = 0;
        Check = 1000;
        enrage = false;
        brundir = false;
        molgeim = false;
        supercharge1 = false;
        supercharge2 = false;
        die = false;
        if (m_creature->HasAura(SPELL_SUPERCHARGE))
            m_creature->RemoveAurasDueToSpell(SPELL_SUPERCHARGE);
        if (m_creature->HasAura(SPELL_ELECTRICAL_CHARGE))
            m_creature->RemoveAurasDueToSpell(SPELL_ELECTRICAL_CHARGE);
        if (m_creature->HasAura(SPELL_HIGH_VOLTAGE))
            m_creature->RemoveAurasDueToSpell(SPELL_HIGH_VOLTAGE);
        if (m_creature->HasAura(SPELL_HIGH_VOLTAGE_H))
            m_creature->RemoveAurasDueToSpell(SPELL_HIGH_VOLTAGE_H);
    }

    void KilledUnit(Unit* pVictim)
    {
        if (supercharge2)
            DoCast(m_creature, SPELL_ELECTRICAL_CHARGE);
    }

    void DamageTaken(Unit* pDoneBy, uint32& uiDamage)
    {
        if (uiDamage > m_creature->GetHealth() && !die)
        {
            uiDamage = 0;
            m_creature->CastStop();
            m_creature->setFaction(1925);
            if (supercharge1)
            {
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
                    if (pTemp->isAlive() && pTemp->HasAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0))
                        pTemp->GetAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0)->modStackAmount(+1);
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
                    if (pTemp->isAlive() && pTemp->HasAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0))
                        pTemp->GetAura(SPELL_SUPERCHARGE, EFFECT_INDEX_0)->modStackAmount(+1);
            }else
                DoCast(m_creature, SPELL_SUPERCHARGE);
            die_delay = 500;
            die = true;
        }
    }

    void JustDied(Unit* pKiller)
    {
        //death yell
        m_creature->RemoveFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
        m_creature->setFaction(14);
        Map* pMap = m_creature->GetMap();
        if (pMap && pMap->IsDungeon())
        {
            Map::PlayerList const &PlayerList = pMap->GetPlayers();
            if (PlayerList.isEmpty())
                return;
            for (Map::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
            {
                if (i->getSource()->isAlive() && i->getSource()->HasAura(SPELL_SUPERCHARGE))
                    i->getSource()->RemoveAurasDueToSpell(SPELL_SUPERCHARGE);
            }
        }
        if (m_pInstance)
        {
            if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
                if (!pTemp->isAlive())
                    if (Creature* p2Temp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
                        if (!p2Temp->isAlive())
                        {
                            m_pInstance->SetData(TYPE_ASSEMBLY, DONE);
                            m_creature->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                            pTemp->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                            p2Temp->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                        }
            if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
                if (!pTemp->isAlive())
                    pTemp->SetHealth(pTemp->GetMaxHealth());
            if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
                if (!pTemp->isAlive())
                    pTemp->SetHealth(pTemp->GetMaxHealth());
        }
    }

    void Aggro(Unit* pWho)
    {
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
            if (pTemp->isAlive())
                pTemp->SetInCombatWithZone();
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
            if (pTemp->isAlive())
                pTemp->SetInCombatWithZone();
        DoCast(m_creature, m_bIsRegularMode ? SPELL_HIGH_VOLTAGE : SPELL_HIGH_VOLTAGE_H);
        if (m_pInstance)
            m_pInstance->SetData(TYPE_ASSEMBLY, IN_PROGRESS);
    }

    void JustReachedHome()
    {
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
            if (!pTemp->isAlive())
                pTemp->Respawn();
        if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
            if (!pTemp->isAlive())
                pTemp->Respawn();
        if (m_pInstance)
            m_pInstance->SetData(TYPE_ASSEMBLY, FAIL);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim())
            return;

        if (Fusion_Punch_Timer < diff)
        {
            DoCast(m_creature->getVictim(), m_bIsRegularMode ? SPELL_FUSION_PUNCH : SPELL_FUSION_PUNCH_H);
            Fusion_Punch_Timer = 20000;
        }else Fusion_Punch_Timer -= diff;

        if (Static_Disruption_Timer < diff && supercharge1)
        {
            if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,1))
                DoCast(pTarget, m_bIsRegularMode ? SPELL_STATIC_DISRUPTION : SPELL_STATIC_DISRUPTION_H);
            Static_Disruption_Timer = 60000;
        }else Static_Disruption_Timer -= diff;

        if (Power_Timer < diff && supercharge2)
        {
            m_creature->CastStop();
            DoCast(m_creature->getVictim(), SPELL_POWER);
            MeltTarget = m_creature->getVictim()->GetGUID();
            Power_Timer = m_bIsRegularMode ? 65000 : 35000;
            Meltdown_Timer = m_bIsRegularMode ? 60500 : 30500;
        }else Power_Timer -= diff;

        if (Meltdown_Timer < diff && supercharge2)
        {
            if (Unit* pMeltTarget = Unit::GetUnit(*m_creature, MeltTarget))
                m_creature->DealDamage(pMeltTarget, pMeltTarget->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            Meltdown_Timer = 90000;
        }else Meltdown_Timer -= diff;

        if (die_delay < diff)
        {
            if (die)
                m_creature->DealDamage(m_creature, m_creature->GetHealth(), NULL, DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
        }
        else die_delay -= diff;

        if (Enrage_Timer < diff && !enrage)
        {
            m_creature->CastStop();
            DoCast(m_creature, SPELL_BERSERK);
            enrage = true;
        }else Enrage_Timer -= diff;

        if (Check < diff)
        {
            if (!brundir)
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_BRUNDIR))))
                    if (!pTemp->isAlive())
                    {
                        brundir = true;
                        if (!supercharge1)
                        {
                            supercharge1 = true;
                            Static_Disruption_Timer = 12000;
                        }
                        else
                        {
                            supercharge2 = true;
                            Power_Timer = 5000;
                            Meltdown_Timer = m_bIsRegularMode ? 60000 : 30000;
                        }
                    }
            if (!molgeim)
                if (Creature* pTemp = ((Creature*)Unit::GetUnit((*m_creature), m_pInstance->GetData64(DATA_MOLGEIM))))
                    if (!pTemp->isAlive())
                    {
                        molgeim = true;
                        if (!supercharge1)
                        {
                            supercharge1 = true;
                            Static_Disruption_Timer = 22000;
                        }
                        else
                        {
                            supercharge2 = true;
                            Power_Timer = 5000;
                            Meltdown_Timer = m_bIsRegularMode ? 60000 : 30000;
                        }
                    }
            Check = 1000;
        }else Check -= diff;
        
        if (!die)
            DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_steelbreaker(Creature* pCreature)
{
    return new boss_steelbreakerAI(pCreature);
}

void AddSC_boss_iron_council()
{
    Script* NewScript;

    NewScript = new Script;
    NewScript->Name = "boss_brundir";
    NewScript->GetAI = GetAI_boss_brundir;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "boss_molgeim";
    NewScript->GetAI = GetAI_boss_molgeim;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "boss_steelbreaker";
    NewScript->GetAI = GetAI_boss_steelbreaker;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "mob_rune_of_power";
    NewScript->GetAI = &GetAI_mob_rune_of_power;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "mob_rune_of_summoning";
    NewScript->GetAI = &GetAI_mob_rune_of_summoning;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "mob_ulduar_lightning_elemental";
    NewScript->GetAI = &GetAI_mob_ulduar_lightning_elemental;
    NewScript->RegisterSelf();
}