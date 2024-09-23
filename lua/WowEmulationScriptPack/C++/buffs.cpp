#include "ScriptMgr.h"
#include "Cell.h"
#include "CellImpl.h"
#include "GameEventMgr.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "Unit.h"
#include "GameObject.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "InstanceScript.h"
#include "CombatAI.h"
#include "PassiveAI.h"
#include "Chat.h"
#include "DBCStructure.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"



uint32 auras[] = { 24705, 16609, 22888, 24425, 15366, 43223, 48100 };

class buff_commandscript : public CommandScript
{
public:
    buff_commandscript() : CommandScript("buff_commandscript") { }

	ChatCommand* GetCommands() const
    {
        static ChatCommand IngameCommandTable[] =
        {
			{ "buff",            SEC_PLAYER,  false, &HandleBuffCommand,             "", NULL },
            { NULL,             0,                  false, NULL,                              "", NULL }
        };
		 return IngameCommandTable;
    }

	static bool HandleBuffCommand(ChatHandler * handler, const char * args)
    {
        Player * me = handler->GetSession()->GetPlayer();
	
		me->RemoveAurasByType(SPELL_AURA_MOUNTED);
		for(int i = 0; i < 11; i++)
		    me->AddAura(auras[i], me);
		handler->PSendSysMessage("You're buffed now!   --Kription WoW--");
		return true;
    }
};

void AddSC_buff_commandscript()
{
    new buff_commandscript();
}