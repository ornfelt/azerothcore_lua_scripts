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
SDName: Boss_Anubarak
SD%Complete: 20%
SDComment:
SDCategory: Azjol'Nerub
EndScriptData */

#include "precompiled.h"
#include "azjol-nerub.h"

enum
{
    SAY_INTRO                       = -1601014,
    SAY_AGGRO                       = -1601015,
    SAY_KILL_1                      = -1601016,
    SAY_KILL_2                      = -1601017,
    SAY_KILL_3                      = -1601018,
    SAY_SUBMERGE_1                  = -1601019,
    SAY_SUBMERGE_2                  = -1601020,
    SAY_LOCUST_1                    = -1601021,
    SAY_LOCUST_2                    = -1601022,
    SAY_LOCUST_3                    = -1601023,
    SAY_DEATH                       = -1601024
};

/*######
## boss_anubarak
######*/

struct FLAMEMU_DLL_DECL boss_anubarakAI : public ScriptedAI
{
    boss_anubarakAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        m_bIsRegularMode = pCreature->GetMap()->IsRegularDifficulty();
        Reset();
    }

    ScriptedInstance* m_pInstance;
    bool m_bIsRegularMode;

    void Reset()
    {
    }

    void Aggro(Unit* pWho)
    {
        DoScriptText(SAY_AGGRO, m_creature);
    }

    void KilledUnit(Unit* pVictim)
    {
        switch(urand(0, 2))
        {
            case 0: DoScriptText(SAY_KILL_1, m_creature); break;
            case 1: DoScriptText(SAY_KILL_2, m_creature); break;
            case 2: DoScriptText(SAY_KILL_3, m_creature); break;
        }
    }

    void JustDied(Unit* pKiller)
    {
        DoScriptText(SAY_DEATH, m_creature);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_boss_anubarak(Creature* pCreature)
{
    return new boss_anubarakAI(pCreature);
}

void AddSC_boss_anubarak()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "boss_anubarak";
    newscript->GetAI = &GetAI_boss_anubarak;
    newscript->RegisterSelf();
}
