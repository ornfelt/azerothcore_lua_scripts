#include "Chat.h"
#include "Player.h"
#include "Creature.h"
#include "ObjectGuid.h"
#include "Group.h"
#include "GossipDef.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "Util.h"
#include "ScriptedCreature.h"
#include "ScriptMgr.h"
#include "Configuration/Config.h"
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
#include "Item.h"
#include "DBCStructure.h"
#include "DBCStores.h"
#include "ObjectMgr.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "ScriptPCH.h"

enum PlayerNotSpeak_Locale
{
    RECEIVER_NOT_SPEAK = 13000
};

class KargatumSC_PlayerNotSpeak : public PlayerScript
{
public:
	KargatumSC_PlayerNotSpeak() : PlayerScript("KargatumSC_PlayerNotSpeak") {}

    void OnChat(Player* player, uint32 /*type*/, uint32 /*lang*/, std::string& /*msg*/, Player* receiver) override
	{
        if (!sConfigMgr->GetBoolDefault("PlayerNotSpeak.Enable", false))
            return;

        if (receiver->GetSession()->CanSpeak())
            return;

        uint64 MuteTime = receiver->GetSession()->m_muteTime;

        if (MuteTime == 0)
            return;

        std::string MuteTimeStr = secsToTimeString(MuteTime - time(NULL));
        std::string NameLink = ChatHandler(receiver->GetSession()).playerLink(receiver->GetName());

        ChatHandler(player->GetSession()).PSendSysMessage(RECEIVER_NOT_SPEAK, NameLink.c_str(), MuteTimeStr.c_str());
	}
};

void AddPlayerNotSpeakScripts()
{
	new KargatumSC_PlayerNotSpeak();
}
