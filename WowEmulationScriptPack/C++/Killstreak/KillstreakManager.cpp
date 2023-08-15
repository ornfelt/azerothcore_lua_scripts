#include "KillstreakManager.h"

using namespace Maelstrom;

// Constructor ============================================================================================================================================
KillstreakManager::KillstreakManager() : mKillstreakMap(), mMutex() {}
//=========================================================================================================================================================

// Private member functions ===============================================================================================================================
void KillstreakManager::ThrowNullPtrExceptionIfNecessary(void* ptr) const {
	if (ptr == nullptr)
		throw NullPointerException();
}


bool KillstreakManager::PlayerHasKS(Player* player) const  {
	ThrowNullPtrExceptionIfNecessary(player);

	auto it = mKillstreakMap.find(player->GetGUID());
	if (it == mKillstreakMap.end())
		return false;

	return true;
}
//=========================================================================================================================================================

// Public member functions ================================================================================================================================
void KillstreakManager::InsertNewPlayer(Player* player) {
	if (PlayerHasKS(player))
		return;

	mMutex.lock();
	std::lock_guard<std::mutex> lock(mMutex, std::adopt_lock);

	mKillstreakMap.insert({ player->GetGUID(), 0 });
}

void KillstreakManager::RemovePlayer(Player* player){
	ThrowNullPtrExceptionIfNecessary(player);

	mMutex.lock();
	std::lock_guard<std::mutex> lock(mMutex, std::adopt_lock);

	mKillstreakMap.erase(player->GetGUID());
}

void KillstreakManager::IncrementPlayerKS(Player* player) {
	if (!PlayerHasKS(player))
		return;

	mMutex.lock();
	std::lock_guard<std::mutex> lock(mMutex, std::adopt_lock);

	mKillstreakMap[player->GetGUID()] += 1;
}

uint64 KillstreakManager::GetPlayerKS(Player* player) const {
	if (!PlayerHasKS(player))
		return 0;

	return mKillstreakMap.at(player->GetGUID());
}

void KillstreakManager::ResetPlayerKS(Player* player) {
	if (!PlayerHasKS(player))
		return;

	mMutex.lock();
	std::lock_guard<std::mutex> lock(mMutex, std::adopt_lock);

	mKillstreakMap[player->GetGUID()] = 0;
}

void KillstreakManager::HandlePvPKill(Player* killer, Player* killed) {
	ThrowNullPtrExceptionIfNecessary(killer);
	ThrowNullPtrExceptionIfNecessary(killed);

	//Don't modify the two following instructions
	InsertNewPlayer(killer);
	InsertNewPlayer(killed);

	if (killer == killed){
		ResetPlayerKS(killer);
		return;
	}

	//We increase the killer's killstreak
	//If you want to do it under certain conditions only, wrap the two following instructions in a "if" block
	//For instance:
	//if(killer->GetAreaId() == 720) {
	// Maelstrom::sKillstreakMgr->IncrementPlayerKS(killer);
	// Maelstrom::sKillstreakMgr->ResetPlayerKS(killed);
	// } -> it will only count kills and reset killstreaks if the killer is in area 720

	IncrementPlayerKS(killer);
	//We reset the killed's killstreak
	ResetPlayerKS(killed);
}
//=========================================================================================================================================================