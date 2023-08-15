/*   
	
    Hungarian Half Scripting team (HHScripts).
    Copyright (C) 2009  Twl

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.*/

#include "StdAfx.h"
#include "Setup.h"

#ifdef WIN32
#pragma warning(disable:4305)		// warning C4305: 'argument' : truncation from 'double' to 'float'
#endif


#define VISSZA_BUTTON

#ifdef VISSZA_BUTTON

// Make code neater with this define.
#define SendQuickMenu(textid) objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), textid, Plr); \
    Menu->SendTo(Plr);

#else

// Make code neater with this define.
#define SendQuickMenu(textid) objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), textid, Plr); \
    Menu->AddItem(0, "Nem ezt akartam.", 0); \
    Menu->SendTo(Plr);

#endif

class SCRIPT_DECL CustomNPC : public GossipScript
{
public:
	void Destroy()
	{
		delete this;
	}
	  void GossipHello(Object* pObject, Player* Plr, bool AutoSend)
	  {
		  GossipMenu *Menu;
		  objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 3874, Plr);
		  

			if(Plr->GetTeam() > 0)
			{
				Menu->AddItem(0, "Vigyel Orgrimmarba!", 2);
			}
			else
			{
				 Menu->AddItem(0, "Vigyel Stormwindbe!", 1);
			}

		  Menu->AddItem(0, "Arenak", 3);
		  Menu->AddItem(0, "Szedd le a debuffokat(death es bg)!", 4);
		  Menu->AddItem(0, "Adj goldot!", 5);
		  if((Plr->GetSession()->CanUseCommand('y')))
				Menu->AddItem(0, "VIP Panel", 6);

		  Menu->AddItem(0, "Level 80!", 15);

		  if(AutoSend)
				Menu->SendTo(Plr);
	  }

	  void GossipSelectOption(Object* pObject, Player* Plr, uint32 Id, uint32 IntId, const char * Code)
	  {
			GossipMenu* Menu;
			int32 currentcoins = Plr->GetUInt32Value(PLAYER_FIELD_COINAGE);
			int32 newgoldfull = currentcoins + 10000000;	 // 1000 gold
			

			switch(IntId)
			{
			case 0: // return to main
				 GossipHello(pObject, Plr, true);
				 break;
			case 1:
				 Plr->SafeTeleport(0, 0, -8913.23f, 554.633f, 94.7944f, 3.730638f);	 // stormwind
				 Plr->Gossip_Complete();
				 break;
			case 2:
				 Plr->SafeTeleport(1, 0, 1502.71f, -4415.42f, 22.5512f, 3.730638f);	  // orgrimmar
				 Plr->Gossip_Complete();
				 break;
			case 3:			// arenak
				 objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 3874, Plr);
				 Menu->AddItem(0, "Gurubashi Arena", 16);
				 Menu->AddItem(0, "Ring of Trials", 17);
				 Menu->AddItem(0, "[Vissza]", 18);
				 Menu->SendTo(Plr);
				 break;
			case 4:
				 Plr->RemoveAura(15007);
				 Plr->RemoveAura(26013);
				 Plr->BroadcastMessage("%sResurrection sickness es Deserter leszedve!", MSG_COLOR_GREEN);
				 GossipHello(pObject, Plr, true);
				 break;
			case 5:
				 Plr->SetUInt32Value(PLAYER_FIELD_COINAGE, newgoldfull);
				 Plr->BroadcastMessage("%sKaptal 1000 goldot.", MSG_COLOR_GREEN);
				 GossipHello(pObject, Plr, true);
				 break;
			case 6:		// VIP
				 objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 3874, Plr);
				 Menu->AddItem(0, "Conqueror of Naxxramas title", 7);
				 Menu->AddItem(0, "Warbringer title", 8);
				 Menu->AddItem(0, "Grand Marshal title", 9);
				 Menu->AddItem(0, "High Warlord title", 10);
				 Menu->AddItem(0, "Gladiator title", 11);
				 Menu->AddItem(0, "Brutal Gladiator title", 12);
				 Menu->AddItem(0, "the Supreme title", 13);
				 Menu->AddItem(0, "Bloodsail Admiral title", 19);
				 Menu->AddItem(0, "Champion of the Frozen Wastes title", 20);
				 Menu->AddItem(0, "[Vissza]", 14);
				 // e-mögé már semmit!


				 // TODO: add more
				 Menu->SendTo(Plr);
				 break;
			case 7:				 // cox
				 Plr->SetUInt32Value(PLAYER_CHOSEN_TITLE, 90);
				 Plr->BroadcastMessage("%sA Conqueror of Naxxramas rangot megkaptad. Ajanlott reloggolni ha nem latod a titlet.", MSG_COLOR_GREEN);
				 GossipHello(pObject, Plr, true);
				 break;
			case 8:
				 Plr->SetUInt32Value(PLAYER_CHOSEN_TITLE, 62);
				 Plr->BroadcastMessage("%sA Warbringer rangot megkaptad. Ajanlott reloggolni ha nem latod a titlet.", MSG_COLOR_GREEN);
				 GossipHello(pObject, Plr, true);
				 break;
			case 9:
				 Plr->SetUInt32Value(PLAYER_CHOSEN_TITLE, 14);
				 Plr->BroadcastMessage("%sA Grand Marshal rangot megkaptad. Ajanlott reloggolni ha nem latod a titlet.", MSG_COLOR_GREEN);
				 GossipHello(pObject, Plr, true);
				 break;
			case 10:
				 Plr->SetUInt32Value(PLAYER_CHOSEN_TITLE, 28);
				 Plr->BroadcastMessage("%sA High Warlord rangot megkaptad. Ajanlott reloggolni ha nem latod a titlet.", MSG_COLOR_GREEN);
				 GossipHello(pObject, Plr, true);
				 break;
			case 11:
				 Plr->SetUInt32Value(PLAYER_CHOSEN_TITLE, 29);
				 Plr->BroadcastMessage("%sA Gladiator rangot megkaptad. Ajanlott reloggolni ha nem latod a titlet.", MSG_COLOR_GREEN);
				 GossipHello(pObject, Plr, true);
				 break;
			case 12:
				 Plr->SetUInt32Value(PLAYER_CHOSEN_TITLE, 49);
				 Plr->BroadcastMessage("%sA Brutal Gladiator rangot megkaptad. Ajanlott reloggolni ha nem latod a titlet.", MSG_COLOR_GREEN);
				 GossipHello(pObject, Plr, true);
				 break;
			case 13:
				 Plr->SetUInt32Value(PLAYER_CHOSEN_TITLE, 53);
				 Plr->BroadcastMessage("%sA the Supreme rangot megkaptad. Ajanlott reloggolni ha nem latod a titlet.", MSG_COLOR_GREEN);
				 GossipHello(pObject, Plr, true);
				 break;
			case 14: // vissza gomb
				 GossipHello(pObject, Plr, true);
				 break;

			case 15:
				 Plr->SetUInt32Value(UNIT_FIELD_LEVEL, 80);
				 Plr->BroadcastMessage("%sLevel 80 vagy! Ha nem frissultek a statok, skillek normalisan akkor reloggolj!!", MSG_COLOR_GREEN);
				 Plr->SaveToDB(false);
				 GossipHello(pObject, Plr, true);
				 break;

			case 16:			// gurubashi teleport
				 Plr->SafeTeleport(0, 0, -13152.9f, 342.729f, 53.1328f, 3.730638f);
				 Plr->Gossip_Complete();
				 break;
			case 17:			// ring of trials
				 Plr->SafeTeleport(530, 0, -2043.35f, 6654.84f, 14.0532f, 3.730638f); 
				 Plr->Gossip_Complete();
				 break;
			case 18:
				 GossipHello(pObject, Plr, true);
				 break;
			case 19:
				Plr->SetUInt32Value(PLAYER_CHOSEN_TITLE, 111);
				Plr->BroadcastMessage("%sA Bloodsail Admiral rangot megkaptad. Ajanlott reloggolni ha nem latod a titlet.", MSG_COLOR_GREEN);
				GossipHello(pObject, Plr, true);
				break;
			case 20:
				Plr->SetUInt32Value(PLAYER_CHOSEN_TITLE, 97);
				Plr->BroadcastMessage("%sA Champion of the Frozen Wastes rangot megkaptad. Ajanlott reloggolni ha nem latod a titlet." MSG_COLOR_GREEN);
				GossipHello(pObject, Plr, true);

			}
	  }

};

void SetupCustomGossip(ScriptMgr * mgr)
{
	 GossipScript * mycustom = (CustomNPC*) new CustomNPC();

	 mgr->register_gossip_script(89000, mycustom);
	 
	 
}
