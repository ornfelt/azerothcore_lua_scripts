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
SDName: Utgarde_Keep
SD%Complete: 75
SDComment:
SDCategory: Utgarde Keep
EndScriptData */

/* ContentData
mob_dragonflayer_forge_master
EndContentData */

#include "precompiled.h"
#include "utgarde_keep.h"

/*######
## mob_dragonflayer_forge_master
######*/

enum
{
    SPELL_BURNING_BRAND     = 43757,
    SPELL_BURNING_BRAND_H   = 59601,
    SPELL_CAUTERIZE         = 60211,

    MAX_FORGE               = 3
};

struct FLAMEMU_DLL_DECL mob_dragonflayer_forge_masterAI : public ScriptedAI
{
    mob_dragonflayer_forge_masterAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        m_bIsRegularMode = pCreature->GetMap()->IsRegularDifficulty();
        m_uiForgeEncounterId = 0;
        Reset();
    }

    ScriptedInstance* m_pInstance;
    bool m_bIsRegularMode;

    uint32 m_uiForgeEncounterId;
    uint32 m_uiBurningBrandTimer;

    void Reset()
    {
        m_uiBurningBrandTimer = 2000;
    }

    void SetMyForge()
    {
        std::list<GameObject *> lGOList;
        uint32 uiGOBellow = 0;
        uint32 uiGOFire = 0;

        for(uint8 i = 0; i < MAX_FORGE; ++i)
        {
            switch(i)
            {
                case 0: uiGOBellow = GO_BELLOW_1; break;
                case 1: uiGOBellow = GO_BELLOW_2; break;
                case 2: uiGOBellow = GO_BELLOW_3; break;
            }

            if (GameObject* pGOTemp = m_pInstance->instance->GetGameObject(m_pInstance->GetData64(uiGOBellow)))
                lGOList.push_back(pGOTemp);
        }

        if (!lGOList.empty())
        {
            if (lGOList.size() != MAX_FORGE)
                error_log("SD2: mob_dragonflayer_forge_master expected %u in lGOList, but does not match.", MAX_FORGE);

            lGOList.sort(ObjectDistanceOrder(m_creature));

            if (lGOList.front()->getLootState() == GO_READY)
                lGOList.front()->UseDoorOrButton(DAY);
            else if (lGOList.front()->getLootState() == GO_ACTIVATED)
                lGOList.front()->ResetDoorOrButton();

            switch(lGOList.front()->GetEntry())
            {
                case GO_BELLOW_1: uiGOFire = GO_FORGEFIRE_1; break;
                case GO_BELLOW_2: uiGOFire = GO_FORGEFIRE_2; break;
                case GO_BELLOW_3: uiGOFire = GO_FORGEFIRE_3; break;
            }

            if (GameObject* pGOTemp = m_pInstance->instance->GetGameObject(m_pInstance->GetData64(uiGOFire)))
            {
                if (pGOTemp->getLootState() == GO_READY)
                    pGOTemp->UseDoorOrButton(DAY);
                else if (pGOTemp->getLootState() == GO_ACTIVATED)
                    pGOTemp->ResetDoorOrButton();
            }

            m_uiForgeEncounterId = lGOList.front()->GetEntry();
        }
    }

    void Aggro(Unit* pWho)
    {
        SetMyForge();
    }

    void JustReachedHome()
    {
        SetMyForge();
    }

    void JustDied(Unit* pKiller)
    {
        if (m_pInstance)
            m_pInstance->SetData(m_uiForgeEncounterId, DONE);
    }

    void UpdateAI(const uint32 uiDiff)
    {
        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim())
            return;

        if (m_uiBurningBrandTimer < uiDiff)
        {
            DoCastSpellIfCan(m_creature->getVictim(), m_bIsRegularMode ? SPELL_BURNING_BRAND : SPELL_BURNING_BRAND_H);
            m_uiBurningBrandTimer = 15000;
        }
        else m_uiBurningBrandTimer -= uiDiff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_dragonflayer_forge_master(Creature* pCreature)
{
    return new mob_dragonflayer_forge_masterAI(pCreature);
}

void AddSC_utgarde_keep()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "mob_dragonflayer_forge_master";
    newscript->GetAI = &GetAI_mob_dragonflayer_forge_master;
    newscript->RegisterSelf();
}
