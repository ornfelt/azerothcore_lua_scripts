#ifndef DEF_UTILITY
#define DEF_UTILITY

#include "ScriptedGossip.h"
#include "Player.h"

#define COLOR_GREEN  "|cff00ff00"
#define COLOR_RED    "|cffff0000"
#define COLOR_YELLOW "|cffffff00"

namespace Maelstrom {

	class Utility {

		// Infos ---------------------------------------------------------------------------------------------------------------------------------------------
		// OVERVIEW: Utility contains a set of utilities related to projects with multiple realms of different languages. Even if you have a unique realm or several realms
		//           With the same language, it can be useful for you.
		//           Here are the features offered by this class:
		//            * Send a message to a player, in the realm language
		//            * Send an areatrigger message, in the realm language
		//            * Get the name of an area, in the realm language
		//            * Add a gossip (extended) item, in the realm language
		//            * Send a specific message as a whisp from one player to another, in the realm language
		//
		//          It is really convenient. It allows you to code once for all your realms if they are of different language.
		//          The language in which messages will be sent / displayed is the one of the server's DBC directory
		//          WARNING: In order for this to work properly, the DBC language of the server must the same as the one of the client !
		//
		// This class only contains static functions and do not require to be instantiated to be used !

	public:

		// Enumerations --------------------------------------------------------------------------------------------------------------------------------------
		// Languages supported by your realms
		// Feel free to adapt this enumeration so that it fits your needs !
		// If you need to do so, you will have to modify the implementation of Utility::getLanguage(Player* player) [Game < Utility.cpp], it's quite intuitive !
		enum SupportedLanguage {
			FRENCH,
			ENGLISH,

			OTHER
		};

		// Typedefs ------------------------------------------------------------------------------------------------------------------------------------------
		typedef std::map<SupportedLanguage, std::string>  LangTextMap; //It is used to store texts in different languages and display the right text to the players
		                                                               //WARNING: you have to set the texts for every supported language when you use it !
		typedef std::pair<SupportedLanguage, std::string> Message;     //A single message in a particular supported language


	public:

		// Public static functions ---------------------------------------------------------------------------------------------------------------------------
		static void SendAreaTriggerMessage(Player* player, const LangTextMap& langTextMap);
		//REQUIRES: player != nullptr
		//MODIFIES: /
		//EFFECTS: sends an "AreaTriggerMessage" to the player in the language of the server, if it is supported. If not, the message is sent in English. (see enumerations above)

		static void AddGossipItem(Player* player, uint32 icon, const LangTextMap& messages, uint32 gossipSender, uint32 action);
		//REQUIRES: player != nullptr
		//MODIFIES: /
		//EFFECTS: adds an item into the gossip menu of the player "player", in the language of the realm. The gossip item will be in English if the realm language is not supported (see enumerations above)
		//N.B: this function replaces the player->ADD_GOSSIP_ITEM macro, but you still have to call player->SEND_GOSSIP_MENU in order for the menu to be displayed.

		static void AddGossipItemExtended(Player* player, uint32  icon, const LangTextMap& messages, uint32 gossipSender, uint32 action, const LangTextMap& boxMessages, uint32 money, bool input);
		//REQUIRES: player != nullptr
		//MODIFIES: /
		//EFFECTS: Same idea that AddGossipItem but with a textbox.
		//N.B: this function replaces the player->ADD_GOSSIP_ITEM macro, but you still have to call player->SEND_GOSSIP_MENU in order for the menu to be displayed.
		

		static std::string GetAreaName(Player* player, uint32 areaId);
		//REQUIRES: player != nullptr
		//MODIFIES: /
		//EFFECTS: Returns the name of the area which has "areaId" as id, in the language of the player.

		static void SendMessageToPlayer(Player* player, const char* color, const LangTextMap& messages);
		//REQUIRES: player != nullptr
		//MODIFIES: /
		//EFFECTS: Sends a message to the player "player", in the color "color" and in the language of the realm
		//N.B: WARNING: Depending on where you call this function from, the message might not display ! If it is the case, it means your message is too long !

		static void Whisper(Player* sender, Player* receiver, const LangTextMap& message);
		//REQUIRES: sender != nullptr && receiver != nullptr
		//MODIFIES: /
		//EFFECTS: sender sends a whisper message to receiver and the message is contained "message" and will be sent in the language of the realm.
		//N.B: use this function if you want a player to send a whisp to another, with a defined message.

		static SupportedLanguage getLanguage(Player* player);
		//REQUIRES: player != nullptr
		//MODIFIES: /
		//EFFECTS: returns the language of the player's client. If it's not supported, returns OTHER.

	private:

		// Private static functions --------------------------------------------------------------------------------------------------------------------------
		static SupportedLanguage getLanguage(LocaleConstant loc);
		//REQUIRES: player != nullptr
		//MODIFIES: /
		//EFFECTS: returns the language of the player's client. If it's not supported, returns OTHER.
	};

}

#endif
