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
#pragma warning(disable:4305)		  //truncation int to char
#pragma warning(disable:4309)
void GmCheck(Player* pPlayer)
{

	// ha az illetõ admin
	if(pPlayer->GetSession()->CanUseCommand('az'))
	{
		char *message = new char[255];
		sprintf(message, "%s[NOTE] %s<Admin>%s %s is available!", MSG_COLOR_YELLOW, MSG_COLOR_RED, MSG_COLOR_CYAN, pPlayer->GetName());
		sWorld.SendWorldText(message);
		delete message;
	}
	
	// ha az illetõ gm
	else if(pPlayer->GetSession()->CanUseCommand('a'))
	{
		char *messagew = new char[255];
		sprintf(messagew, "%s[NOTE] %s<GM>%s %s is available!", MSG_COLOR_YELLOW, MSG_COLOR_RED, MSG_COLOR_CYAN, pPlayer->GetName());
		sWorld.SendWorldText(messagew);
		delete messagew;
	}
}

// regisztrálja a szkriptet
void SetupGMOnline(ScriptMgr * mgr)
{
	mgr->register_hook(SERVER_HOOK_EVENT_ON_ENTER_WORLD, (void*)GmCheck);
}
