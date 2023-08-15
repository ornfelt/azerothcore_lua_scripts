#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include "Bag.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStructure.h"
#include "Define.h"
#include "Field.h"
#include "GameEventMgr.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "ObjectGuid.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QueryResult.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Transaction.h"
#include "WorldSession.h"
#include <sstream>
#include <string>
#include <stdlib.h>
#include <Custom/Logic/CustomQuestionAnswerSystem.h>

#include <Custom/Logic/CustomCharacterSystem.h>

#define ANSWER_NOT_CORRECT "Your Answer is not correct! Try it again!"
#define ANSWER_ALREADY_ANSWERED "You have already answered this Question!"

class codenpc : public CreatureScript
{
 

public:
    codenpc() : CreatureScript("codenpc") { }
    
        
    
   
    bool OnGossipHello(Player *player, Creature* creature)
    {
		if (creature->IsQuestGiver())
			player->PrepareQuestMenu(creature->GetGUID());

        player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Please insert your Answer!" , GOSSIP_SENDER_MAIN, 2, "Type your answer: ", 0,true);
        player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
        return true;
    }
    
    
    bool OnGossipSelectCode(Player * player, Creature* creature, uint32 /*sender*/, uint32 action, const char* code){
        
        switch(action){
            
            
            case 2:
                {
				CustomQuestionAnswerSystem * QuestionAnswerSystem = 0;
                    std::string codes = code;
                
                    if(codes == "Easteregg"){
						creature->Say("Yeah. The Easter Egg is found!. Here get your Reward!", LANG_UNIVERSAL, nullptr);
                        player->GetSession()->SendNotification("Viel Spass mit dem Easteregg");
                        return true;
                    }
                    
					QuestionAnswerSystem->checkPlayerAnswer(player->GetSession()->GetPlayer(), code);
					return true;
                    
                
                }break;
        
                return true;
        
            }
    
        return true;
    }
    
};


void AddSC_codenpc()
{
    new codenpc();
}