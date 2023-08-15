#include "ScriptMgr.h"
#include "AccountMgr.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "Player.h"




class dark : public CreatureScript
{
public: dark() : CreatureScript("dark"){ }

		bool OnGossipHello(Player *pPlayer, Creature* _creature)
		{
            Group* group = pPlayer->GetGroup();
            if(group){
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Unterstuetzt mich, Prinz! [4 Abzeichen]", GOSSIP_SENDER_MAIN, 0,"",0,false);
				pPlayer->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1,7, "Zeigt mir wo der Prinz haust.", GOSSIP_SENDER_MAIN, 1, "", 0, false);
            }

			if(!group){
				pPlayer->GetSession()->SendAreaTriggerMessage("Ohne Gruppe seid Ihr zu schwach um meinen Bruder zu besiegen!");
				pPlayer->PlayerTalkClass->SendGossipMenu(907, _creature->GetGUID());
				return true;
			}

			else {
				pPlayer->PlayerTalkClass->SendGossipMenu(907, _creature->GetGUID());
				return true;
			}
		}

		bool OnGossipSelect(Player * pPlayer, Creature * pCreature, uint32 /*uiSender*/, uint32 uiAction)
		{
			switch (uiAction)
			{
			case 0:
			{	
				if (pPlayer->HasItemCount(700518, 4)){
					pPlayer->DestroyItemCount(700518, 4, true);
					pPlayer->AddAura(48161, pPlayer);              // Power Word: Fortitude        
					pPlayer->AddAura(48073, pPlayer);              // Divine Spirit
					pPlayer->AddAura(20217, pPlayer);              // Blessing of Kings
					pPlayer->AddAura(48469, pPlayer);              // Mark of the wild
					pPlayer->AddAura(16609, pPlayer);              // Spirit of Zandalar
					pPlayer->AddAura(15366, pPlayer);              // Songflower Serenade
					pPlayer->AddAura(22888, pPlayer);              // Rallying Cry of the Dragonslayer
					pPlayer->AddAura(57399, pPlayer);              // Well Fed
					pPlayer->AddAura(17013, pPlayer);              // Agamaggan's Agility
					pPlayer->AddAura(16612, pPlayer);              // Agamaggan's Strength
					pPlayer->PlayerTalkClass->SendCloseGossip();
					return true;
				}

				else {
					pPlayer->GetSession()->SendAreaTriggerMessage("Leider hast du nicht genug Abzeichen um meine Hilfe anzufordern.");
					return true;
					pPlayer->PlayerTalkClass->SendCloseGossip();
				}
			}break;

			case 1:
			{
                
                    pPlayer->TeleportTo(0, -7138.54f, -4310.35f, 264.33f, 3.13f);
                    pCreature->SummonCreature(800064, -7139.58f, -4317.59f, 264.33f, 3.13f, TEMPSUMMON_TIMED_DESPAWN, 120000);
					return true;
			}break;


			}
			return true;
		}
};




void AddSC_dark()
{
	new dark();
}