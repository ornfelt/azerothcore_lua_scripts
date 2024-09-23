#include "Config.h"
#include <Custom/Logic/CustomCharacterSystem.h>
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomXPSystem.h>

class ex_customxpcommands : public CommandScript
{
public:
	ex_customxpcommands() : CommandScript("ex_customxpcommands") { }

	std::vector<ChatCommand> GetCommands() const
	{

		static std::vector<ChatCommand> commandTable =
		{
			{ "xprate", SEC_ADMINISTRATOR , false, &HandleXPRate, "" },

		};

		return commandTable;
	}


	static bool HandleXPRate(ChatHandler* handler, const char* args) {
		CustomXP * XPSystem = 0;
		XPSystem->setXPRate(handler->GetSession()->GetPlayer(), args);
		return true;
	}

	
};

void AddSC_ex_customxpcommands()
{
	new ex_customxpcommands();
}
