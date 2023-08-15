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
SDName: Ulduar
SD%Complete: 80%
SDComment: trash scripts & GO scripts
SDCategory: ulduar
EndScriptData */

/* ContentData
mob_ulduar_teleporter
go_ulduar_teleporter
EndContentData */

#include "precompiled.h"
#include "ulduar.h"

#define GOSSIP_BASE_CAMP     "Expedition Base Camp"
#define GOSSIP_FORMATION_GROUNDS     "Formation Grounds"
#define GOSSIP_COLOSSAL_FORGE     "Colossal Forge"
#define GOSSIP_ANTECHAMBER     "Antechamber of Ulduar"
#define GOSSIP_SHATTERED     "Shattered Walkway"
#define GOSSIP_CONSERVATORY     "Conservatory of Life"
#define GOSSIP_SPARK     "Spark of Imagination"
#define GOSSIP_PRISON     "Prison of Yogg-Saron"

/*######
## mob_ulduar_teleporter
######*/

struct FLAMEMU_DLL_DECL mob_ulduar_teleporterAI : public ScriptedAI
{
    mob_ulduar_teleporterAI(Creature* pCreature) : ScriptedAI(pCreature)
    {
        m_pInstance = (ScriptedInstance*)pCreature->GetInstanceData();
        Reset();
        SetCombatMovement(false);
        m_creature->SetVisibility(VISIBILITY_ON);
    }

    ScriptedInstance* m_pInstance;

    void Reset()
    {
    }

    void BaseCamp(Player* pPlayer)
    {
        if (!m_pInstance)
            return;
        pPlayer->TeleportTo(603, -706.098022, -92.512573, 430.275574, 6.279854);
    }

    void FormationGrounds(Player* pPlayer)
    {
        if (!m_pInstance)
            return;
        if(m_pInstance->GetData(TYPE_LEVIATHAN) == FAIL || m_pInstance->GetData(TYPE_LEVIATHAN) == DONE){
            pPlayer->TeleportTo(603, 131.107910, -35.377659, 410.203522, 6.275923);
        }else debug_log("SD2: Ulduar - player %s is a moron. he tried to teleport to the formation grounds without engaging the Flame Leviathan", pPlayer->GetName());
    }

    void ColossalForge(Player* pPlayer)
    {
        if (!m_pInstance)
            return;
        //if(m_pInstance->GetData(TYPE_LEVIATHAN) == DONE){                IGNORE SINCE NO FLAME LEVIATHAN ENCOUNTER
            pPlayer->TeleportTo(603, 553.266235, -12.240425, 410.078552, 6.279848);
        //}else debug_log("SD2: Ulduar - player %s is a moron. he tried to teleport to the colossal forge without defeating the Flame Leviathan", pPlayer->GetName());
    }

    void Antechamber(Player* pPlayer)
    {
        if (!m_pInstance)
            return;
        if(m_pInstance->GetData(TYPE_XT002) == DONE){
            pPlayer->TeleportTo(603, 1498.145020, -24.150503, 421.366638, 6.275710);
        }else debug_log("SD2: Ulduar - player %s is a moron. he tried to teleport to the antechamber of ulduar without defeating XT-002", pPlayer->GetName());
    }

    void Shattered(Player* pPlayer)
    {
        if (!m_pInstance)
            return;
        if(m_pInstance->GetData(TYPE_KOLOGARN) == DONE){
            pPlayer->TeleportTo(603, 1859.405396, -24.037266, 449.299652, 6.275713);
        }else debug_log("SD2: Ulduar - player %s is a moron. he tried to teleport to the shattered walkway without defeating Kologarn", pPlayer->GetName());
    }

    void Conservatory(Player* pPlayer)
    {
        if (!m_pInstance)
            return;
        if(m_pInstance->GetData(TYPE_AURIAYA) == DONE){
            pPlayer->TeleportTo(603, 2086.194580, -24.216295, 421.638611, 6.279638);
        }else debug_log("SD2: Ulduar - player %s is a moron. he tried to teleport to the conservatory of life without defeating Auriaya", pPlayer->GetName());
    }

    void Spark(Player* pPlayer)
    {
        if (!m_pInstance)
            return;
        if(m_pInstance->GetData(TYPE_MIMIRON) == FAIL || m_pInstance->GetData(TYPE_MIMIRON) == DONE){
            pPlayer->TeleportTo(603, 2517.345459, 2568.905762, 412.698486, 0.000377);
        }else debug_log("SD2: Ulduar - player %s is a moron. he tried to teleport to the spark of imagination without engaging Mimiron", pPlayer->GetName());
    }

    void Prison(Player* pPlayer)
    {
        if (!m_pInstance)
            return;
        if(m_pInstance->GetData(TYPE_VEZAX) == DONE){
            pPlayer->TeleportTo(603, 1854.667480, -11.641102, 334.974670, 4.709239);
        }else debug_log("SD2: Ulduar - player %s is a moron. he tried to teleport to the prison of yogg-saron without defeating General Vezax", pPlayer->GetName());
    }

    void UpdateAI(const uint32 diff)
    {
        if (!m_creature->SelectHostileTarget() || !m_creature->getVictim()) return;

        if (!m_pInstance)
            return;
    }
};

CreatureAI* GetAI_mob_ulduar_teleporter(Creature* pCreature)
{
    return new mob_ulduar_teleporterAI(pCreature);
}

bool GossipHello_mob_ulduar_teleporter(Player* pPlayer, Creature* pCreature)
{
    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_BASE_CAMP, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_FORMATION_GROUNDS, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_COLOSSAL_FORGE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+3);
    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ANTECHAMBER, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+4);
    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SHATTERED, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+5);
    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_CONSERVATORY, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+6);
    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SPARK, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+7);
    pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_PRISON, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+8);

    pPlayer->SEND_GOSSIP_MENU(pPlayer->GetGossipTextId(pCreature), pCreature->GetGUID());
    return true;
}

bool GossipSelect_mob_ulduar_teleporter(Player* pPlayer, Creature* pCreature, uint32 uiSender, uint32 uiAction)
{
    if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        ((mob_ulduar_teleporterAI*)pCreature->AI())->BaseCamp(pPlayer);
    }
    if (uiAction == GOSSIP_ACTION_INFO_DEF+2)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        ((mob_ulduar_teleporterAI*)pCreature->AI())->FormationGrounds(pPlayer);
    }
    if (uiAction == GOSSIP_ACTION_INFO_DEF+3)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        ((mob_ulduar_teleporterAI*)pCreature->AI())->ColossalForge(pPlayer);
    }
    if (uiAction == GOSSIP_ACTION_INFO_DEF+4)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        ((mob_ulduar_teleporterAI*)pCreature->AI())->Antechamber(pPlayer);
    }
    if (uiAction == GOSSIP_ACTION_INFO_DEF+5)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        ((mob_ulduar_teleporterAI*)pCreature->AI())->Shattered(pPlayer);
    }
    if (uiAction == GOSSIP_ACTION_INFO_DEF+6)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        ((mob_ulduar_teleporterAI*)pCreature->AI())->Conservatory(pPlayer);
    }
    if (uiAction == GOSSIP_ACTION_INFO_DEF+7)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        ((mob_ulduar_teleporterAI*)pCreature->AI())->Spark(pPlayer);
    }
    if (uiAction == GOSSIP_ACTION_INFO_DEF+8)
    {
        pPlayer->CLOSE_GOSSIP_MENU();
        ((mob_ulduar_teleporterAI*)pCreature->AI())->Prison(pPlayer);
    }

    return true;
}

/*######
## go_ulduar_teleporter
######*/

bool GOHello_go_ulduar_teleporter(Player* pPlayer, GameObject* pGo)
{
    //GossipHello_mob_ulduar_teleporter;
    return false;
}

void AddSC_ulduar()
{
    Script* NewScript;

    NewScript = new Script;
    NewScript->Name = "mob_ulduar_teleporter";
    NewScript->GetAI = &GetAI_mob_ulduar_teleporter;
    NewScript->pGossipHello = &GossipHello_mob_ulduar_teleporter;
    NewScript->pGossipSelect = &GossipSelect_mob_ulduar_teleporter;
    NewScript->RegisterSelf();

    NewScript = new Script;
    NewScript->Name = "go_ulduar_teleporter";
    NewScript->pGOHello = &GOHello_go_ulduar_teleporter;
    NewScript->RegisterSelf();
}
