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
SDName: Boss_Deathwhisper
SD%Complete: 0
SDComment: By Netherblood
SDCategory: Icecrown Citadel
EndScriptData */

#include "precompiled.h"
#include "def_spire.h"

#define ADD_1X -619.006f
#define ADD_1Y 2158.104f
#define ADD_1Z 50.848f

#define ADD_2X -598.697f
#define ADD_2Y 2157.767f
#define ADD_2Z 50.848f

#define ADD_3X -577.992f
#define ADD_3Y 2156.989f
#define ADD_3Z 50.848f

#define ADD_4X -618.748f
#define ADD_4Y 2266.648f
#define ADD_4Z 50.849f

#define ADD_5X -598.573f
#define ADD_5Y 2266.870f
#define ADD_5Z 50.849f

#define ADD_6X -578.360f
#define ADD_6Y 2267.210f
#define ADD_6Z 50.849f

enum
{
    SAY_INTRO1                 = -1631020,
    SAY_INTRO2                 = -1631021,
    SAY_INTRO3                 = -1631022,
    SAY_AGGRO                  = -1631023,
    SAY_PHASE2                 = -1631024,
    SAY_DOMINATEMIND           = -1631025,
    SAY_DARKEMPOWERMENT        = -1631026,
    SAY_DARKTRANSFORMATION     = -1631027,
    SAY_ANIMATEDEAD            = -1631028,
    SAY_KILL1                  = -1631029,
    SAY_KILL2                  = -1631030,
    SAY_BERSERK                = -1631031,
    SAY_DEATH                  = -1631032,

    SPELL_MANA_BARRIER         = 70842,
    SPELL_SHADOW_BOLT          = 71254,
    H_SPELL_SHADOW_BOLT        = 72008,
    SPELL_DEATH_AND_DECAY      = 71001,
    H_SPELL_DEATH_AND_DECAY    = 72108,
    //SPELL_DARK_EMPOWERMENT     = 70901,
    SPELL_FROSTBOLT            = 71420,
    H_SPELL_FROSTBOLT          = 72007,
    SPELL_INSIGNIFICANCE       = 71204,
    SPELL_FROSTBOLT_VOLLEY     = 72905,
    H_SPELL_FROSTBOLT_VOLLEY   = 72906,
    SPELL_VENGEFUL_SHADE       = 71426,

    NPC_CULT_ADHERENT          = 37949,
    NPC_CULT_FANATIC           = 37890,
    NPC_VENGEFUL_SHADE         = 38222,
};

struct FLAMEMU_DLL_DECL boss_deathwhisperAI : public ScriptedAI
{
    boss_deathwhisperAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        m_bIsRegularMode = pCreature->GetMap()->IsRegularDifficulty();
        Reset();
    }

    ScriptedInstance* m_pInstance;
    bool m_bIsRegularMode;

    uint32 ShadowBolt_Timer;
    uint32 DeathAndDecay_Timer;
    uint32 Frostbolt_Timer;
    uint32 FrostboltVolley_Timer;
    uint32 Insignificance_Timer;
    uint32 Summon_Cult_Timer;
    uint32 Summon_Shade_Timer;
    uint8 Phase;
    uint8 Summon_Cult_Count;
    uint8 Summon_Shade_Count;
    bool SpawnLeft;
    uint8 IntroText;
    uint32 IntroText_Timer;

    void Reset()
    {
        ShadowBolt_Timer = 5000;
        DeathAndDecay_Timer = 30000;
        Summon_Cult_Timer = 20000;
        Frostbolt_Timer = 15000;
        FrostboltVolley_Timer = 40000;
        Insignificance_Timer = 5000+rand()%40000;
        Summon_Shade_Timer = 25000;
        Phase = 1;
        Summon_Cult_Count = 0;
        Summon_Shade_Count = 0;
        SpawnLeft = true;
        IntroText = 0;
        IntroText_Timer = 8000;
    }

    void Aggro(Unit* pWho)
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_DEATHWHISPER, IN_PROGRESS);

        DoScriptText(SAY_AGGRO, m_creature);
    }

    void JustDied(Unit* pKiller)
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_DEATHWHISPER, DONE);

        DoScriptText(SAY_DEATH, m_creature);
    }

    void JustReachedHome()
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_DEATHWHISPER, FAIL);
    }

    void KilledUnit(Unit* pVictim)
    {
        switch(urand(0, 1))
        {
            case 0: DoScriptText(SAY_KILL1, m_creature); break;
            case 1: DoScriptText(SAY_KILL2, m_creature); break;
        }
    }

    void MoveInLineOfSight(Unit* pWho)
    {
        if (m_creature->IsWithinDistInMap(pWho, 60.0f) && IntroText == 0)
        {
            DoScriptText(SAY_INTRO1, m_creature);
            IntroText++;
        }
    }

    void JustSummoned(Creature* pSummoned)
    {
        if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM,0))
            pSummoned->AI()->AttackStart(pTarget);
    }

    //Mana Barrier is bugged so we override it for now
    void DamageTaken(Unit *done_by, uint32 &damage)
    {
        if (m_creature->HasAura(SPELL_MANA_BARRIER))
        {
            m_creature->SetHealth(m_creature->GetHealth()+damage);
            m_creature->SetPower(POWER_MANA,m_creature->GetPower(POWER_MANA)-damage);
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (IntroText == 1 || IntroText == 2)
        {
            if (IntroText_Timer < uiDiff)
            {
                switch(IntroText)
                {
                    case 1: DoScriptText(SAY_INTRO2, m_creature); break;
                    case 2: DoScriptText(SAY_INTRO3, m_creature); break;
                }
                IntroText++;
                IntroText_Timer = 8000;
            }
            else IntroText_Timer -= uiDiff;
        }

        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim())
            return;

        if (Phase == 1)
        {
            if ((m_creature->GetPower(POWER_MANA)*100 / m_creature->GetMaxPower(POWER_MANA)) < 1)
            {
                DoScriptText(SAY_PHASE2, m_creature);
                Phase = 2;
                return;
            }

            if (!m_creature->HasAura(SPELL_MANA_BARRIER))
                 DoCastSpellIfCan(m_creature, SPELL_MANA_BARRIER);

            if (Summon_Cult_Timer < uiDiff)
            {
                if (SpawnLeft)
                {
                    m_creature->SummonCreature(NPC_CULT_FANATIC,ADD_1X,ADD_1Y,ADD_1Z,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,5000);
                    m_creature->SummonCreature(NPC_CULT_ADHERENT,ADD_2X,ADD_2Y,ADD_2Z,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,5000);
                    m_creature->SummonCreature(NPC_CULT_FANATIC,ADD_3X,ADD_3Y,ADD_3Z,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,5000);
                    SpawnLeft = false;
                }
                else
                {
                    m_creature->SummonCreature(NPC_CULT_ADHERENT,ADD_4X,ADD_4Y,ADD_4Z,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,5000);
                    m_creature->SummonCreature(NPC_CULT_FANATIC,ADD_5X,ADD_5Y,ADD_5Z,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,5000);
                    m_creature->SummonCreature(NPC_CULT_ADHERENT,ADD_6X,ADD_6Y,ADD_6Z,0,TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT,5000);
                    SpawnLeft = true;
                }

                Summon_Cult_Count++;
                Summon_Cult_Timer = 60000;
            }
            else Summon_Cult_Timer -= uiDiff;

            if (ShadowBolt_Timer < uiDiff)
            {
                if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                     DoCastSpellIfCan(target, m_bIsRegularMode ? SPELL_SHADOW_BOLT : H_SPELL_SHADOW_BOLT);
                ShadowBolt_Timer = 5000;
            }
            else ShadowBolt_Timer -= uiDiff;

            DoStartNoMovement(m_creature->getVictim());
        }

        if (Phase == 2)
        {
            if (m_creature->HasAura(SPELL_MANA_BARRIER))
                m_creature->RemoveAurasDueToSpell(SPELL_MANA_BARRIER);

            if (Insignificance_Timer < uiDiff)
            {
                 DoCastSpellIfCan(m_creature->getVictim(), SPELL_INSIGNIFICANCE);
                Insignificance_Timer = 5000+rand()%40000;
            }
            else Insignificance_Timer -= uiDiff;

            if (FrostboltVolley_Timer < uiDiff)
            {
                if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                     DoCastSpellIfCan(target, m_bIsRegularMode ? SPELL_FROSTBOLT_VOLLEY : H_SPELL_FROSTBOLT_VOLLEY);
                FrostboltVolley_Timer = 40000;
            }
            else FrostboltVolley_Timer -= uiDiff;

            if (Summon_Shade_Count < Summon_Cult_Count)
            {
                if (Summon_Shade_Timer < uiDiff)
                {
                     DoCastSpellIfCan(m_creature, SPELL_VENGEFUL_SHADE);
                    Summon_Shade_Count++;
                    Summon_Shade_Timer = 25000;
                }
                else Summon_Shade_Timer -= uiDiff;
            }

            if (Frostbolt_Timer < uiDiff)
            {
                if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                     DoCastSpellIfCan(target, m_bIsRegularMode ? SPELL_FROSTBOLT : H_SPELL_FROSTBOLT);
                Frostbolt_Timer = 15000;
            }
            else Frostbolt_Timer -= uiDiff;

            DoMeleeAttackIfReady();
        }

        if (DeathAndDecay_Timer < uiDiff)
        {
            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                 DoCastSpellIfCan(target, m_bIsRegularMode ? SPELL_DEATH_AND_DECAY : H_SPELL_DEATH_AND_DECAY);
            DeathAndDecay_Timer = 30000;
        }
        else DeathAndDecay_Timer -= uiDiff;
    }
};

CreatureAI* GetAI_boss_deathwhisper(Creature* pCreature)
{
    return new boss_deathwhisperAI(pCreature);
}

void AddSC_boss_deathwhisper()
{
    Script* NewScript;
    NewScript = new Script;
    NewScript->Name = "boss_deathwhisper";
    NewScript->GetAI = &GetAI_boss_deathwhisper;
    NewScript->RegisterSelf();
}