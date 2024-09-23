#ifndef DEF_KS
#define DEF_KS

#include <iostream>
#include <exception>
#include <mutex>

#include "Player.h"

// Exceptions =====================================================================================================================================================
class NullPointerException : public std::exception {

	virtual const char* what() const throw() {
		return "A Null Pointer Exception was thrown";
	}

};
//=================================================================================================================================================================

namespace Maelstrom {

	class KillstreakManager {

		// OVERVIEW: The KillstreakManager handles the killstreak system
		// A typical KillstreakManager is (KILLSTREAKS)
		// Where KILLSTREAKS stores the player's killstreaks
		// For instance, KILLSTREAKS[10] represents the killstreak of the player who has 10 as GUID
		//
		// Mutable types

	public:

		// Constructor ============================================================================================================================================
		KillstreakManager();
		//=========================================================================================================================================================

		// Singleton ==============================================================================================================================================
		static KillstreakManager* instance()
		{
			static KillstreakManager instance;
			return &instance;
		}
		//=========================================================================================================================================================

		// Public member functions ================================================================================================================================
		void InsertNewPlayer(Player* player);
		//REQUIRES: player != nullptr
		//MODIFIES: this.KILLSTREAKS
		//EFFECTS: this_post.KILLSTREAKS = this.KILLSTREAKS U { guid of player, 0 }
		//         if player == nullptr, a NullPointerException is thrown
		//         if the player is already in this.KILLSTREAKS, we do nothing

		void RemovePlayer(Player* player);
		//REQUIRES: player != nullptr
		//MODIFIES: this.KILLSTREAKS
		//EFFECTS: The player "player" is removed from this.KILLSTREAKS
		//         If player == nullptr, a NullPointerException is thrown
		//         If the player was not in this.KILLSTREAKS, nothing happens

		void IncrementPlayerKS(Player* player);
		//REQUIRES: player != nullptr
		//MODIFIES: this.KILLSTREAKS
		//EFFECTS: this_post.KILLSTREAKS[guid of "player"] = this.KILLSTREAKS[guid of "player"]+1
		//         if the player was not in this.KILLSTREAKS, nothing happens

		void ResetPlayerKS(Player* player);
		//REQUIRES: player != nullptr
		//MODIFIES: this.KILLSTREAKS
		//EFFECTS: if player == nullptr, a NullPointerException is Thrown
		//         if player is not in this.KILLSTREAKS, nothing happens
		//         if player is in this.KILLSTREAKS, this_post.KILLSTREAKS[guid of "player"] = 0

		uint64 GetPlayerKS(Player* player) const;
		//REQUIRES: player != nullptr
		//MODIFIES: /
		//EFFECTS: if player == nullptr, a NullPointerException is thrown
		//         otherwise returns this.KILLSTREAKS[guid of "player"]

		void HandlePvPKill(Player* killer, Player* killed);
		//REQUIRES: killer != killed && killer != nullptr && killed != nullptr
		//MODIFIES: this.KILLSTREAKS
		//EFFECTS:  if killer == nullptr || killed == nullptr, a NullPointerException is thrown
		//			if killer == killed: reset the killer(and killed, which are the same) killstreaks
		//          Otherwhise, this_post.KILLSTREAKS[guid of "killer"] = this.KILLSTREAKS[guid of "killer"]+1 AND this_post.KILLSTREAKS[guid of "killed"] = 0

		//=========================================================================================================================================================

		// Private member functions ===============================================================================================================================
		void ThrowNullPtrExceptionIfNecessary(void* ptr) const;
			//REQUIRES: /
			//MODIFIES: /
			//EFFECTS: if ptr == nullptr, a NullPointerException is thrown

		bool PlayerHasKS(Player* player) const;
			//REQUIRES: player != nullptr
			//MODIFIES: /
			//EFFECTS: if player == nullptr, a NullPointerException is thrown
			//         else if the player is in this.KILLSTREAKS returns true
			//         else if the player is not in this.KILLSTREAKS returns false
		//=========================================================================================================================================================
			
	private:

		// Rep ====================================================================================================================================================
		std::unordered_map<ObjectGuid, uint64> mKillstreakMap;
		std::mutex mMutex;
		//=========================================================================================================================================================

	};

	#define sKillstreakMgr KillstreakManager::instance()

}

#endif