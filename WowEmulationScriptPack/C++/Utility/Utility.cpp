#include "Utility.h"
#include "WorldSession.h"
#include "Map.h"
#include "Chat.h"

using namespace Maelstrom;


Utility::SupportedLanguage Utility::getLanguage(Player* player){
	if (!player || player == nullptr)
		return SupportedLanguage::OTHER;

	LocaleConstant locale = player->GetSession()->GetSessionDbLocaleIndex();
	if (locale == LOCALE_enUS)
		return SupportedLanguage::ENGLISH;
	if (locale == LOCALE_frFR)
		return SupportedLanguage::FRENCH;

	return SupportedLanguage::ENGLISH;
}

void Utility::SendAreaTriggerMessage(Player* player, const LangTextMap& langTextMap){
	if (player == nullptr)
		return;

	SupportedLanguage lang = Utility::getLanguage(player);

	auto iterator = langTextMap.find(lang);
	if (iterator != langTextMap.end()){
		player->GetSession()->SendAreaTriggerMessage((iterator->second).c_str());
	}
}

void Utility::AddGossipItem(Player* player, uint32 icon, const LangTextMap& messages, uint32 gossipSender, uint32 action){
	if (player == nullptr)
		return;

	SupportedLanguage lang = Utility::getLanguage(player);

	auto it = messages.find(lang);
	if (it != messages.end()){
		const char* message = (it->second).c_str();
		player->ADD_GOSSIP_ITEM(icon, message, gossipSender, action);
	}
}

void Utility::AddGossipItemExtended(Player* player, uint32  icon, const LangTextMap& messages, uint32 gossipSender, uint32 action, const LangTextMap& boxMessages, uint32 money, bool input)
{
	if(player == nullptr)
		return;

	SupportedLanguage lang = Utility::getLanguage(player);

	auto it = messages.find(lang);
	auto itBox = boxMessages.find(lang);
	if (it != messages.end() && itBox != boxMessages.end()){
		player->ADD_GOSSIP_ITEM_EXTENDED(icon, (it->second).c_str(), gossipSender, action, (itBox->second).c_str(), money, input);
	}
}

std::string Utility::GetAreaName(Player* player, uint32 areaId){
	if (player == nullptr)
		return "ERROR";

	AreaTableEntry const* data = GetAreaEntryByAreaID(areaId);
	std::string name = std::string(data->area_name[player->GetSession()->GetSessionDbLocaleIndex()]);

	return name;
}

void Utility::SendMessageToPlayer(Player* player, const char* color, const LangTextMap& messages) {
	if (player == nullptr)
		return;

	SupportedLanguage lang = Utility::getLanguage(player);
	if (lang == OTHER)
		lang = ENGLISH;

	auto it = messages.find(lang);
	if (it != messages.end()){
		std::string message = it->second;
		std::string str;
		str = std::string(color) + " " + message;
		WorldPacket data;
		ChatHandler::BuildChatPacket(data, CHAT_MSG_SYSTEM, Language(0), player, player, str);
		player->SendMessageToSetInRange(&data, 0, true);

		//ChatHandler(player->GetSession()).PSendSysMessage((it->second).c_str());
	}
}

Utility::SupportedLanguage Utility::getLanguage(LocaleConstant loc){
	if (loc == LOCALE_enUS)
		return SupportedLanguage::ENGLISH;
	if (loc == LOCALE_frFR)
		return SupportedLanguage::FRENCH;

	return SupportedLanguage::ENGLISH;
}

void Utility::Whisper(Player* sender, Player* receiver, const LangTextMap& message){
	if (sender == nullptr || receiver == nullptr)
		return;

	SupportedLanguage lg = Utility::getLanguage(sender);

	auto it = message.find(lg);
	if (it == message.end())
		return;


	sender->Whisper(message.at(lg), LANG_UNIVERSAL, receiver, true);
}

