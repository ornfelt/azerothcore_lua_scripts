#include "ScriptPCH.h"

    class VIP_AREA : public PlayerScript 
    {
            public:
            VIP_AREA() : PlayerScript("VIP_AREA") { }
     
			void VIPZONE(Player * me, ChatHandler * handler)       
			{
				if(me->GetAreaId() == 10)
                
					switch(me->GetSession()->GetSecurity())
						{
							case SEC_PLAYER:
								{
									handler->PSendSysMessage("Welcome to the VIP Zone");
									me->TeleportTo(571, 6182.615234f, 5738.993652f, 1.402846f, 5.567000f); // Where you get teleported.
									return;
								}	
							case 1:
								{
									handler->PSendSysMessage("Welcome to the VIP Zone %s!"), me->GetName();
									return;
								}
							default:
								{
									return;
								}
						}
			}
	
	};
 
void AddSC_VIP_AREA()
{
    new VIP_AREA();
}