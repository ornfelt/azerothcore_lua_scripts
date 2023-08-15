/*
 * Copyright (C) 2012 AvariusCore
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */
#include "AccountMgr.h"
#include "ScriptMgr.h"
#include "Chat.h"
#include "Common.h"
#include "Player.h"
#include "WorldSession.h"
#include "Language.h"
#include "Log.h"
#include "SpellAuras.h"
#include "World.h"
#include "Guild.h"
#include "GuildMgr.h"
#include "Config.h"
#include <iostream>
#include <iterator>
#include <vector>
#include <random>
#include <algorithm>

#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "SocialMgr.h"
#include <Custom/Logic/CustomCouponSystem.h>
#include <Custom/Logic/CustomCharacterSystem.h>
#include <Custom/Logic/CustomGMLogic.h>
#include <Custom/Logic/CustomWorldSystem.h>
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomQuestionAnswerSystem.h>


class custom_commandscript : public CommandScript
{
public:
	custom_commandscript() : CommandScript("custom_commandscript") { }

	std::vector<ChatCommand> GetCommands()  const override
	{

		static std::vector<ChatCommand> commandTable =
		{
			//{ "goname",         SEC_MODERATOR,      false, OldHandler<&ChatHandler::HandleAppearCommand>,              "" },				
			//{ "namego",         SEC_MODERATOR,      false, OldHandler<&ChatHandler::HandleSummonCommand>,              "" },				
			//Allows your players to gamble for fun and prizes
			//{ "gamble", SEC_PLAYER, false, &HandleGambleCommand, "" },
			//{ "roulette", SEC_PLAYER, false, &HandleRouletteCommand, "" },
			//Mall Teleporter
			//{ "mall", SEC_PLAYER, false, &HandleMallCommand, "" },
			//Dalaran Teleporter
			{ "dalaran", SEC_PLAYER, false, &HandleDalaCommand, "" },
			//Buffer
			//{ "buffs", SEC_PLAYER, false, &HandleBuffsCommand, ""},
			//GuildHouse Tele
			{ "gh", SEC_PLAYER, false, &HandleGHCommand, "" },
			//insel
			{ "insel", SEC_ADMINISTRATOR, false, &HandleInselCommand, "" },

			{ "werbung", SEC_ADMINISTRATOR, false, &HandleWerbungCommand, "" },
            
            { "frage", SEC_ADMINISTRATOR, false, &HandleFragenCommand, "" },



			//{ "tcrecon",        SEC_MODERATOR,      false, &HandleIRCRelogCommand,            "" },	

		};

		return commandTable;
	}

    
	static bool HandleInselCommand(ChatHandler* handler, const char* /*args*/)
	{
		//MALL command
		if (sConfigMgr->GetBoolDefault("Content.Patch", true)) {

			Player *chr = handler->GetSession()->GetPlayer();

			if (chr->IsInCombat())
			{
				handler->PSendSysMessage(LANG_YOU_IN_COMBAT);
				//SetSentErrorMessage(true);
				return false;
			}

			if (chr->IsInFlight())
			{
				handler->PSendSysMessage(LANG_YOU_IN_FLIGHT);
				//SetSentErrorMessage(true);
				return false;
			}

			if (chr->getLevel() == 80) {
				chr->TeleportTo(0, -9771.67f, 2127.04f, 15.07f, 3.75f);    // Insel Coords
			}

			else {
				handler->PSendSysMessage("You are not at Level 80");
				return true;
			}
			return true;
		}
		return true;
	}


    
    //Allow player to loss all their money.
    static bool HandleGambleCommand(ChatHandler* handler, const char* args)
    {

        Player *chr = handler->GetSession()->GetPlayer();
        
        char* px = strtok((char*)args, " ");
        
        if (!px)
            return false;
        
        uint32 money = (uint32)atoi(px);
        
        if (chr->GetMoney() < money)
        {
            handler->PSendSysMessage("Du kannst kein Gold setzen welches du nicht hast!");
            return true;
        }
        
        else
        {
            if (money > 0)
            {
                //if (rand()%100 < 50)
                if (rand() % 100 < 40)
                {
                    chr->ModifyMoney(money - (money / 10));
                    //chr->ModifyMoney(money*2);
                    handler->PSendSysMessage("Du hast gewonnen und deinen Einsatz verdoppelt");
                }
                else
                {
                    chr->ModifyMoney(-int(money));
                    handler->PSendSysMessage("Du hast verloren");
                }
            }
        }
        
        return true;
    }
    
    
    //Erstellt neue Fragen in der DB
    static bool HandleFragenCommand(ChatHandler* handler, const char* args)
    {
		CustomQuestionAnswerSystem * QuestionAnswerSystem = 0;
		QuestionAnswerSystem->insertNewQuestion(handler->GetSession()->GetPlayer(), args);
        return true;
        
    }
    
	

	static bool HandleRouletteCommand(ChatHandler* handler, const char* args)
	{
		Player *chr = handler->GetSession()->GetPlayer();

		char* px = strtok((char*)args, " ");

		if (!px)
			return false;

		uint32 money = (uint32)atoi(px);

		if (chr->GetMoney() < money)
		{
			handler->PSendSysMessage("Du kannst kein Gold setzen welches du nicht hast!");
			return true;
		}

		else
		{
			if (money > 0)
			{
				//if (rand()%36 < 1)
				if (rand() % 42 < 1)
				{
					chr->ModifyMoney(money * 36);
					handler->PSendSysMessage("Du hast das 36x deines Einsatzes gewonnen, GZ!");
				}

				else
				{
					chr->ModifyMoney(-int(money));
					handler->PSendSysMessage("Du hast verloren");
				}
			}
		}

		return true;
	}

	//Mall Teleporter
	static bool HandleMallCommand(ChatHandler* handler, const char* /*args*/)
	{
		//MALL command

		Player *chr = handler->GetSession()->GetPlayer();

		if (chr->IsInCombat())
		{
			handler->PSendSysMessage(LANG_YOU_IN_COMBAT);
			//SetSentErrorMessage(true);
			return false;
		}
		if (chr->IsInFlight())
		{
			handler->PSendSysMessage(LANG_YOU_IN_FLIGHT);
			//SetSentErrorMessage(true);
			return false;
		}
		//Comment because of using it afk killing and buy Things at Vendor
		//chr->ResurrectPlayer(0.5, false);

		switch (chr->GetTeam())
		{
		case ALLIANCE:
			chr->TeleportTo(0, -8842.09f, 626.358f, 94.0867f, 0.0f);    // Insert Ally mall Cords here
			break;

		case HORDE:
			chr->TeleportTo(1, 1601.08f, -4378.69f, 9.9846f, 0.15315f);    // Insert Horde mall Cords here
			break;
		}
		return true;
	};

	//Dalaran Teleporter
	static bool HandleDalaCommand(ChatHandler* handler, const char* /*args*/)
	{
		//MALL command
		CustomPlayerLog * PlayerLog = 0;
		Player *chr = handler->GetSession()->GetPlayer();

		if (chr->IsInCombat())
		{
			handler->PSendSysMessage(LANG_YOU_IN_COMBAT);
			//SetSentErrorMessage(true);
			return false;
		}
		if (chr->IsInFlight())
		{
			handler->PSendSysMessage(LANG_YOU_IN_FLIGHT);
			//SetSentErrorMessage(true);
			return false;
		}

		if (chr->isDead()) {
			handler->PSendSysMessage("##########################################################");
			handler->PSendSysMessage("You are dead. Please resurrect yourself.");
			handler->PSendSysMessage("##########################################################");
			return true;
		}

		if (chr->getLevel() < 68) {
			handler->PSendSysMessage("##########################################################");
			handler->PSendSysMessage("You are not Level 68. Northrend is only for Level 68 Characters!");
			handler->PSendSysMessage("##########################################################");
			return true;
		}
	
		switch (chr->GetTeam())
		{
		case ALLIANCE:
			PlayerLog->addCompletePlayerLog(chr->GetSession()->GetPlayer(), "Ally Dalaran Port used");
			chr->TeleportTo(571, 5697.64f, 659.37f, 646.29f, 2.66f);    
			break;

		case HORDE:
			PlayerLog->addCompletePlayerLog(chr->GetSession()->GetPlayer(), "Horde Dalaran Port used");
			chr->TeleportTo(571, 5907.81f, 638.60f, 645.51f, 5.81f);    
			break;
		}

		//chr->TeleportTo(571, 5809.55f, 503.975f, 657.526f, 1.70185f);    // Insert Dala Coords

		return true;
	};

	//Buffer
	static bool HandleBuffsCommand(ChatHandler* handler, const char* /*args*/)
	{
		Player *chr = handler->GetSession()->GetPlayer();

		if (chr->IsInCombat())
		{
			handler->PSendSysMessage("Du kannst dich nicht waehrend eines Kampfes buffen");
			//SetSentErrorMessage(true);
			return false;
		}
		if (chr->IsInFlight())
		{
			handler->PSendSysMessage("Du kannste dich nicht waehrend des Fliegens buffen");
			//SetSentErrorMessage(true);
			return false;
		}

		if (chr->GetMoney() >= 2000000)
		{
			chr->Dismount();
			chr->RemoveAurasByType(SPELL_AURA_MOUNTED);
			chr->AddAura(48161, chr);              // Power Word: Fortitude        
			chr->AddAura(48073, chr);              // Divine Spirit
			chr->AddAura(20217, chr);              // Blessing of Kings
			chr->AddAura(48469, chr);              // Mark of the wild
			chr->AddAura(16609, chr);              // Spirit of Zandalar
			chr->AddAura(15366, chr);              // Songflower Serenade
			chr->AddAura(22888, chr);              // Rallying Cry of the Dragonslayer
			chr->AddAura(57399, chr);              // Well Fed
			chr->AddAura(17013, chr);              // Agamaggan's Agility
			chr->AddAura(16612, chr);              // Agamaggan's Strength
			chr->ModifyMoney(-2000000);
			handler->PSendSysMessage("Du bist jetzt gebufft!");
			return false;
		}
		else
		{
			handler->PSendSysMessage("Du hast nicht genug Gold!");
		}
		return false;
	}

	//GuildHouse Tele
	static bool HandleGHCommand(ChatHandler* handler, const char* /*args*/)
	{
		Player *chr = handler->GetSession()->GetPlayer();

		if (chr->IsInFlight())
		{
			//pokud hrac leti
			handler->PSendSysMessage(LANG_YOU_IN_FLIGHT);
			//SetSentErrorMessage(true);
			return false;
		}

		if (chr->IsInCombat())
		{
			//pokud je hrac v combatu
			handler->PSendSysMessage(LANG_YOU_IN_COMBAT);
			//SetSentErrorMessage(true);
			return false;
		}

		if (chr->GetGuildId() == 0)
		{
			//pokud hrac nema guildu
			return false;
		}

		QueryResult result;
		result = CharacterDatabase.PQuery("SELECT `x`, `y`, `z`, `map` FROM `guildhouses` WHERE `guildId` = %u", chr->GetGuildId());
		if (!result)
		{
			//pokud guilda nema guildhouse zapsany v tabulce guildhouses
			handler->PSendSysMessage("GH Port");
			return false;
		}


		float x, y, z;
		uint32 map;

		Field *fields = result->Fetch();
		x = fields[0].GetFloat();
		y = fields[1].GetFloat();
		z = fields[2].GetFloat();
		map = fields[3].GetUInt32();


		chr->SaveRecallPosition();
		chr->TeleportTo(map, x, y, z, 0);
		chr->SaveToDB();
		return true;
	}



	static bool HandleWerbungCommand(ChatHandler* handler, const char* args)
	{
		Player* player = handler->GetSession()->GetPlayer();

		std::string eingabe = std::string((char*)args);

		if (eingabe == "")
		{
			player->GetSession()->SendNotification("Ohne Eingabe eines Namens geht das leider nicht.");
			return true;
		}

		if (eingabe == "Gutschein"){
			return true;
		}

    
		QueryResult result = CharacterDatabase.PQuery("SELECT `id`, `nachricht`, `player`, `guid`,`accid` FROM `fremdwerbung` WHERE `player` = '%s'", eingabe);

		if (result)
		{

			Field* fields = result->Fetch();
			//uint32 id = fields[0].GetUInt32();
			std::string nachricht = fields[1].GetCString();
			std::string player = fields[2].GetCString();
			//uint32 guid = fields[3].GetUInt32();
			//uint32 accid = fields[4].GetUInt32();


			QueryResult ergebnis = CharacterDatabase.PQuery("SELECT count(guid) FROM `fremdwerbung` WHERE `player` = '%s'", eingabe);
			Field* felder = ergebnis->Fetch();
			uint32 anzahl = felder[0].GetUInt32();

			std::ostringstream uu;
			std::ostringstream tt;

			uu << "Eintrag mit dem Namen: " << eingabe << " vorhanden.";
			tt << "Es sind: " << anzahl << " Eintraege vorhanden. Uberpruefung ist sinnvoll.";
			
			sWorld->SendGMText(LANG_GM_BROADCAST, uu.str().c_str());
			sWorld->SendGMText(LANG_GM_BROADCAST, tt.str().c_str());
			
			return true;
		}

		else {
			std::ostringstream uu;
			uu << "Keinen Eintrag des Spielers " << eingabe << " vorhanden.";
			sWorld->SendGMText(LANG_GM_BROADCAST, uu.str().c_str());
			return true;
		}


	}


};


void AddSC_custom_commandscript()
{
    new custom_commandscript();
}