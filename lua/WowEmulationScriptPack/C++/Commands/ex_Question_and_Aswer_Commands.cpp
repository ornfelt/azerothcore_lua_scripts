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



class question_commandscript : public CommandScript
{
public:
	question_commandscript() : CommandScript("question_commandscript") { }

	std::vector<ChatCommand> GetCommands()  const override
	{

		static std::vector<ChatCommand> questiontable =
		{
			{ "set", SEC_ADMINISTRATOR, false, &HandleSetQuestionCommand, "" },
			{ "get", SEC_PLAYER, false, &HandleGetQuestionCommand, "" }

		};



		static std::vector<ChatCommand> commandTable =
		{
		
			{ "question", SEC_ADMINISTRATOR, false, NULL, "",questiontable },

		};

		return commandTable;
	}


	//Create new Questions in DB!
	static bool HandleSetQuestionCommand(ChatHandler* handler, const char* args)
	{
		Player* player = handler->GetSession()->GetPlayer();
		CustomQuestionAnswerSystem * QuestionAnswerSystem = 0;

		QuestionAnswerSystem->insertNewQuestion(player->GetSession()->GetPlayer(), args);
		return true;
	}


	static bool HandleGetQuestionCommand(ChatHandler* handler, const char* /*args*/)
	{
		Player* player = handler->GetSession()->GetPlayer();
		CustomQuestionAnswerSystem * QuestionAnswerSystem = 0;

		QuestionAnswerSystem->getQuestionForPlayer(player->GetSession()->GetPlayer());
		return true;
	}

};


void AddSC_Question_and_Answer_Commands()
{
	new question_commandscript();
}