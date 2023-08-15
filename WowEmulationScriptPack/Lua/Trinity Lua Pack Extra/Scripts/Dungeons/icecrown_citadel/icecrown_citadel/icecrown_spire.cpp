/* Copyright (C) 2010 FlameScripts <http://www.flame-wow.org/>
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/
 
/* ScriptData
SDName: icecrown_spire
SD%Complete: 10%
SDComment: by Netherblood
SDCategory: Icecrown Citadel - mobs
EndScriptData */
 
#include "precompiled.h"
#include "def_spire.h"
enum
{
        //common
        SPELL_BERSERK = 47008,
        //yells
        //summons
        //Abilities
        SPELL_FROST_BREATH_N = 70116,
        SPELL_BLIZZARD_N = 70362,
        SPELL_SOUL_FEAST = 71203,
        SPELL_CLEAVE = 70361,
 
        SPELL_FROST_BREATH_H = 72641,
        SPELL_BLIZZARD_H = 71118,
 
};
 
struct FLAMEMU_DLL_DECL mob_spire_frostwyrmAI : public ScriptedAI
{
    mob_spire_frostwyrmAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        Regular = pCreature->GetMap()->IsRegularDifficulty();
        Reset();
    }
 
    bool Regular;
    ScriptedInstance *pInstance;
    uint8 stage;
    uint32 m_uiFrostBreath_Timer;
    uint32 m_uiBlizzard_Timer;
    uint32 m_uiSoulFeast_Timer;
    uint32 m_uiCleave_Timer;
    uint32 m_uiBerserk_Timer;
    uint8 health;
    uint8 wirmsdied;
 
    void Reset()
    {
    stage = 0;
    health = 100;
    m_uiFrostBreath_Timer=urand(10000,15000);
    m_uiBlizzard_Timer=urand(20000,25000);
    m_uiSoulFeast_Timer = 7000;
    m_uiCleave_Timer = 5000;
    m_uiBerserk_Timer = 120000;
    wirmsdied=pInstance->GetData(TYPE_FROSTWIRM_COUNT);
    }
 
    void Aggro(Unit *who)
    {
        if(pInstance && who->GetTypeId() == TYPEID_PLAYER) pInstance->SetData(TYPE_SKULLS_PLATO, IN_PROGRESS);
    }
 
    void JustDied(Unit *killer)
    {
        if(pInstance && killer->GetTypeId() == TYPEID_PLAYER) {
               pInstance->SetData(TYPE_SKULLS_PLATO, DONE);
               wirmsdied=pInstance->GetData(TYPE_FROSTWIRM_COUNT);
               ++wirmsdied;
               pInstance->SetData(TYPE_FROSTWIRM_COUNT,wirmsdied);
               if (pInstance->GetData(TYPE_FROSTWIRM_COUNT) >= 8 ) pInstance->SetData(TYPE_FLIGHT_WAR,DONE);
               }
    }
 
    void UpdateAI(const uint32 diff)
    {
        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim())
            return;
 
        switch(stage)
        {
            case 0: {
                    if (m_uiSoulFeast_Timer < diff)
                    { if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    DoCastSpellIfCan(pTarget, SPELL_SOUL_FEAST);
                    m_uiSoulFeast_Timer=urand(5000,7000);
                    } else m_uiSoulFeast_Timer -= diff;
 
                    if (m_uiCleave_Timer < diff) {
                    DoCastSpellIfCan(m_creature->getVictim(), SPELL_CLEAVE);
                    m_uiCleave_Timer=urand(5000,7000);
                    } else m_uiCleave_Timer -= diff;
                    break;}
 
            case 1: {
                    if (m_uiSoulFeast_Timer < diff)
                    { if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    DoCastSpellIfCan(pTarget, SPELL_SOUL_FEAST);
                    m_uiSoulFeast_Timer=urand(4000,6000);
                    } else m_uiSoulFeast_Timer -= diff;
 
                    if (m_uiCleave_Timer < diff) {
                    DoCastSpellIfCan(m_creature->getVictim(), SPELL_CLEAVE);
                    m_uiCleave_Timer=urand(3000,5000);
                    } else m_uiCleave_Timer -= diff;
                    break;}
            case 2: {
                    DoCastSpellIfCan(m_creature, SPELL_BERSERK);
                    m_uiBlizzard_Timer=urand(1000,2000);
                    m_uiFrostBreath_Timer=urand(1000,3000);
                    stage = 3;
                    break;}
            case 3: {
                    if (m_uiSoulFeast_Timer < diff)
                    { if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    DoCastSpellIfCan(pTarget, SPELL_SOUL_FEAST);
                    m_uiSoulFeast_Timer=urand(2000,4000);
                    } else m_uiSoulFeast_Timer -= diff;
 
                    if (m_uiCleave_Timer < diff) {
                    DoCastSpellIfCan(m_creature->getVictim(), SPELL_CLEAVE);
                    m_uiCleave_Timer=urand(2000,4000);
                    } else m_uiCleave_Timer -= diff;
                    break;}
            }
 
                    if (m_uiBlizzard_Timer < diff)
                    {
                    if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    DoCastSpellIfCan(pTarget, Regular ? SPELL_BLIZZARD_N : SPELL_BLIZZARD_H);
                    m_uiBlizzard_Timer=urand(20000,25000);
                    } else m_uiBlizzard_Timer -= diff;
 
                    if (m_uiFrostBreath_Timer < diff)
                    {if (Unit* pTarget = SelectUnit(SELECT_TARGET_RANDOM, 0))
                    DoCastSpellIfCan(pTarget, Regular ? SPELL_FROST_BREATH_N :SPELL_FROST_BREATH_H);
                    m_uiFrostBreath_Timer=urand(10000,15000);
                    } else m_uiFrostBreath_Timer -= diff;
 
        health = m_creature->GetHealth()*100 / m_creature->GetMaxHealth();
        if (health <= 50 && stage == 0) stage = 1;
        if (health <= 10 && stage == 1) stage = 2;
 
        if (m_uiBerserk_Timer < diff)
        {
            DoCastSpellIfCan(m_creature, SPELL_BERSERK);
        }
        else m_uiBerserk_Timer -= diff;
 
        DoMeleeAttackIfReady();
 
    }
};
 
CreatureAI* GetAI_mob_spire_frostwyrm(Creature* pCreature)
{
    return new mob_spire_frostwyrmAI(pCreature);
}
 
void AddSC_icecrown_spire()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "mob_spire_frostwyrm";
    newscript->GetAI = &GetAI_mob_spire_frostwyrm;
    newscript->RegisterSelf();
}