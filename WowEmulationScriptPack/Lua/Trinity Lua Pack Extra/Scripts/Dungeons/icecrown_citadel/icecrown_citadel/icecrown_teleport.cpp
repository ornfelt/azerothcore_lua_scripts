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
SDName: icecrown_teleport
SD%Complete: 30%
SDComment: by Netherblood
SDCategory: Icecrown Citadel
EndScriptData */
#include "precompiled.h"
#include "def_spire.h"
 
enum
{
PORTALS_COUNT = 8
};
 
struct t_Locations
{
    char const* name;
    float x, y, z;
    uint32 id;
    bool state;
    bool active;
    uint32 encounter;
};
 
static t_Locations PortalLoc[]=
{
{"Light's Hammer", -17.1928f, 2211.44f, 30.1158f, 0, true, true, TYPE_TELEPORT}, //
{"The Spire", -503.62f, 2211.47f, 62.8235f , 1, false, true, TYPE_MARROWGAR},  //
{"Oratory of the Damned", -615.145f, 2211.47f, 199.972f, 2, false, true, TYPE_DEATHWHISPER}, //
{"Aerial Battle", -209.5f, 2211.91f, 199.97f, 3, false, true, TYPE_SKULLS_PLATO}, //
{"Deathbringer's Rise", -549.131f, 2211.29f, 539.291f, 4, false, true, TYPE_FLIGHT_WAR}, //
{"The Rampart of Skulls", 4198.42f, 2769.22f, 351.065f, 5, false, false, TYPE_SAURFANG}, //
{"The Crimson Hall", 4490.205566f, 2769.275635f, 403.983765f, 6, false, false, TYPE_BLOOD_COUNCIL}, //
{"Frostwing Halls", 4356.236816f, 2402.573242f, 220.462540f, 7, false, false, TYPE_VALITHRIA}, //
};
 
 
bool GossipSelect_icecrown_teleporter(Player *player, Creature* pCreature, uint32 sender, uint32 action)
{
    if(sender != GOSSIP_SENDER_MAIN) return true;
    if(!player->getAttackers().empty()) return true;
    if(action >= 0 && action <= PORTALS_COUNT)
        player->TeleportTo(MAP_NUM, PortalLoc[action].x, PortalLoc[action].y, PortalLoc[action].z, 0);
        player->CLOSE_GOSSIP_MENU();
    return true;
}
 
bool GossipHello_icecrown_teleporter(Player *player, Creature* pCreature)
{
    for(uint8 i = 0; i < PORTALS_COUNT; i++) {
    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_TAXI, PortalLoc[i].name, GOSSIP_SENDER_MAIN, i);
    };
    player->SEND_GOSSIP_MENU(TELEPORT_GOSSIP_MESSAGE, pCreature->GetGUID());
    return true;
}
 
 
bool GOHello_go_icecrown_teleporter(Player *player, GameObject* pGo)
{
 
    player->SEND_GOSSIP_MENU(GO_TELEPORT_GOSSIP_MESSAGE, pGo->GetGUID());
    return true;
}
 
 
void AddSC_icecrown_teleporter()
{
    Script *newscript;
 
    newscript = new Script;
    newscript->Name = "icecrown_teleporter";
    newscript->pGossipHello = &GossipHello_icecrown_teleporter;
    newscript->pGossipSelect = &GossipSelect_icecrown_teleporter;
    newscript->RegisterSelf();
 
    newscript = new Script;
    newscript->Name = "go_icecrown_teleporter";
    newscript->pGOHello = &GOHello_go_icecrown_teleporter;
    newscript->RegisterSelf();
}