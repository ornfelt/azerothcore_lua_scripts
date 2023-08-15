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
SDName: boss_lord_marrowgar
SD%Complete: 0
SDComment: By Netherblood
SDCategory: Icecrown Citadel
EndScriptData */

#include "precompiled.h"
#include "def_spire.h"

enum
{
    SAY_INTRO            = -1631000,
    SAY_AGGRO            = -1631001,
    SAY_BONESTORM        = -1631002,
    SAY_BONESPIKE1       = -1631003,
    SAY_BONESPIKE2       = -1631004,
    SAY_BONESPIKE3       = -1631005,
    SAY_KILL1            = -1631006,
    SAY_KILL2            = -1631007,
    SAY_ENRAGE           = -1631008,
    SAY_DEATH            = -1631009,

    SPELL_SABER_LASH     = 69055,
    H_SPELL_SABER_LASH   = 70814,
    SPELL_COLDFLAME      = 69146,
    H_SPELL_COLDFLAME    = 70824,
    SPELL_BONE_SPIKE     = 69057,
    H_SPELL_BONE_SPIKE   = 72088,
    SPELL_BONE_STORM     = 69076,
    H_SPELL_BONE_STORM   = 70835
};

struct FLAMEMU_DLL_DECL boss_lord_marrowgarAI : public ScriptedAI
{
    boss_lord_marrowgarAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        m_bIsRegularMode = pCreature->GetMap()->IsRegularDifficulty();
        Reset();
    }

    ScriptedInstance* m_pInstance;
    bool m_bIsRegularMode;

    uint32 SaberLash_Timer;
    uint32 ColdFlame_Timer;
    uint32 BoneSpike_Timer;
    uint32 BoneStorm_Timer;
    bool IntroText;

    void Reset()
    {
        SaberLash_Timer = 1000;
        ColdFlame_Timer = 15000;
        BoneSpike_Timer = 30000;
        BoneStorm_Timer = 45000;
        IntroText = true;
    }

    void Aggro(Unit* pWho)
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_MARROWGAR, IN_PROGRESS);

        DoScriptText(SAY_AGGRO, m_creature);
    }

    void JustDied(Unit* pKiller)
    {
        DoScriptText(SAY_DEATH, m_creature);

        if (m_pInstance)
            m_pInstance->SetData(TYPE_MARROWGAR, DONE);
    }

    void JustReachedHome()
    {
        if (m_pInstance)
            m_pInstance->SetData(TYPE_MARROWGAR, FAIL);
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
        if (IntroText && m_creature->IsWithinDistInMap(pWho, 60.0f))
        {
            DoScriptText(SAY_INTRO, m_creature);
            IntroText = false;
        }
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim())
            return;

        if (BoneStorm_Timer < uiDiff)
        {
            DoScriptText(SAY_BONESTORM, m_creature);

            DoCastSpellIfCan(m_creature->getVictim(), m_bIsRegularMode ? SPELL_BONE_STORM : H_SPELL_BONE_STORM);
            BoneStorm_Timer = 90000;
        }
        else BoneStorm_Timer -= uiDiff;

        if (BoneSpike_Timer < uiDiff)
        {
            switch(urand(0, 2))
            {
                case 0: DoScriptText(SAY_BONESPIKE1, m_creature); break;
                case 1: DoScriptText(SAY_BONESPIKE2, m_creature); break;
                case 2: DoScriptText(SAY_BONESPIKE3, m_creature); break;
            }

            if (Unit* target = SelectUnit(SELECT_TARGET_RANDOM,0))
                DoCastSpellIfCan(target, m_bIsRegularMode ? SPELL_BONE_SPIKE : H_SPELL_BONE_SPIKE);
            SaberLash_Timer = 4000;
            BoneSpike_Timer = 30000;
        }
        else BoneSpike_Timer -= uiDiff;

        if (ColdFlame_Timer < uiDiff)
        {
            DoCastSpellIfCan(m_creature->getVictim(), m_bIsRegularMode ? SPELL_COLDFLAME : H_SPELL_COLDFLAME);
            ColdFlame_Timer = 15000;
        }
        else ColdFlame_Timer -= uiDiff;

        if (SaberLash_Timer < uiDiff)
        {
            DoCastSpellIfCan(m_creature->getVictim(), m_bIsRegularMode ? SPELL_SABER_LASH : H_SPELL_SABER_LASH);
            SaberLash_Timer = 1000;
        }
        else SaberLash_Timer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_lord_marrowgar(Creature* pCreature)
{
    return new boss_lord_marrowgarAI(pCreature);
}

void AddSC_boss_lord_marrowgar()
{
    Script* NewScript;
    NewScript = new Script;
    NewScript->Name = "boss_lord_marrowgar";
    NewScript->GetAI = &GetAI_boss_lord_marrowgar;
    NewScript->RegisterSelf();
}