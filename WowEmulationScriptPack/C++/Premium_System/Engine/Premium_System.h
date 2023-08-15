#ifndef PREMIUM_SYSTEM_H
#define PREMIUM_SYSTEM_H

#include <unordered_map>

struct PremiumElements
{
	uint32 id;
	bool dndappear;
	uint8 premium;
	uint32 hp;
	uint32 power_max;
	uint64 time;
	bool chat;
	uint64 chat_time;
	std::string last_message;
};

struct PremiumItemElements
{
	uint32 id;
	uint8 premium;
};

struct PremiumLocationElements
{
	uint8 id;
	uint32 map_id;
	float x;
	float y;
	float z;
	float o;
};

struct PremiumPlayerLocationElements
{
	uint32 guid;
	uint32 map_id;
	float x;
	float y;
	float z;
	float o;
};

struct PremiumTeamLocationElements
{
	uint8 team;
	uint32 map_id;
	float x;
	float y;
	float z;
	float o;
};

struct ClassSpells
{
	uint64 id;
	uint8 class_id;
	uint32 spell_id;
};

class PREM
{
private:
	PREM();
	~PREM();

public:
	static PREM* instance();

	// Toolz
	uint64 ConvertStringToNumber(std::string arg);
	std::string ConvertNumberToString(uint64 numberX);

	// Global
	// Getterz
	static std::string GetAmountInString(uint32 amount);
	uint8 GetPremiumType() { return PREMIUM_TYPE; }
	float GetPremiumModifier() { return PREMIUM_MODIFIER; }
	bool IsPremiumTimed() { return PREMIUM_TIMER_ENABLE != 0; }
	uint8 GetGMMinimumRank() { return PREMIUM_GM_MINIMUM_RANK; }
	uint32 GetPremiumUgradeItem() { return PREMIUM_UPGRADE_ITEM; }
	bool CanWaterBreathe() { return PREMIUM_WATER_BREATHE != 0; }
	bool CanDecreaseSpellCost() { return PREMIUM_SPELL_COST_DECREASE != 0; }
	uint64 GetPremiumDurationInSeconds() { return ((((PREMIUM_TIMER_DURATION) * 60) * 60) * 24); }
	uint32 GetPremiumDurationInDays() { return PREMIUM_TIMER_DURATION; }
	bool IsPremiumItemsEnabled() { return PREMIUM_ITEMS_ENABLE != 0; }
	bool IsPremiumTalentPointBonusEnabled() { return PREMIUM_TP_ENABLE != 0; }
	uint32 GetPremiumTalentPointBonus() { return PREMIUM_TP_BONUS; }
	bool IsPremiumHealthPointBonusEnabled() { return PREMIUM_HP_ENABLE != 0; }
	bool IsPremiumManaPointBonusEnabled() { return PREMIUM_MANA_ENABLE != 0; }
	bool IsPremiumRagePointBonusEnabled() { return PREMIUM_RAGE_ENABLE != 0; }
	uint32 GetPremiumTitleId() { return PREMIUM_TITLE_ID; }
	uint32 GetPremiumTitleMaskId() { return PREMIUM_TITLE_MASK_ID; }
	uint32 SetPremiumChatDelay() { return PREMIUM_CHAT_DELAY; }
	bool GetPremiumChatTeam() { return PREMIUM_CHAT_TEAM != 0; }
	
	// Setters
	void SetPremiumType(uint8 v) { PREMIUM_TYPE = v; }
	void SetPremiumModifier(float v) { PREMIUM_MODIFIER = v; }
	void SetPremiumTimed(bool v) { PREMIUM_TIMER_ENABLE = v; }
	void SetPremiumDuration(uint32 v) { PREMIUM_TIMER_DURATION = v; }
	void SetGMMinimumRank(uint8 v) { PREMIUM_GM_MINIMUM_RANK = v; }
	void SetPremiumUgradeItem(uint32 v) {PREMIUM_UPGRADE_ITEM = v; }
	void SetWaterBreathe(bool v) { PREMIUM_WATER_BREATHE = v; }
	void SetDecreaseSpellCost(bool v) { PREMIUM_SPELL_COST_DECREASE = v; }
	void SetPremiumItemsEnabled(bool v) { PREMIUM_ITEMS_ENABLE = v; }
	void SetPremiumTalentPointBonusEnabled(bool v) { PREMIUM_TP_ENABLE = v; }
	void SetPremiumTalentPointBonus(uint32 v) { PREMIUM_TP_BONUS = v; }
	void SetPremiumHealthPointBonusEnabled(bool v) { PREMIUM_HP_ENABLE = v; }
	void SetPremiumManaPointBonusEnabled(bool v) { PREMIUM_MANA_ENABLE = v; }
	void SetPremiumRagePointBonusEnabled(bool v) { PREMIUM_RAGE_ENABLE = v; }
	void SetPremiumTitleId(uint32 v) { PREMIUM_TITLE_ID = v; }
	void SetPremiumTitleMaskId(uint32 v) { PREMIUM_TITLE_MASK_ID = v; }
	void SetPremiumChatDelay(uint32 v) { PREMIUM_CHAT_DELAY = v; }
	void SetPremiumChatTeam(uint8 v) { PREMIUM_CHAT_TEAM = v; }

	// Player Getterz
	static uint32 GetPlayerPremiumId(Player* player);
	bool IsPlayerPremium(Player* player) { return Premium[GetPlayerPremiumId(player)].premium != 0; }
	bool DnDAppear(Player* player) { return Premium[GetPlayerPremiumId(player)].dndappear != 0; }
	static void UpdatePlayerCustomHomeTeleport(uint32 guid, uint32 map_id, float x, float y, float z, float o);
	uint64 GetPlayerPremiumStartTimeInSeconds(Player* player) { return ((((Premium[GetPlayerPremiumId(player)].time) / 60) / 60) / 24); }
	static uint64 GetPlayerPremiumRemainingTimeInSeconds(Player* player);
	static std::string GetPlayerPremiumTimeLeftInString(Player* player);
	uint32 GetPlayerPremiumTimeInDays(Player* player) { return (((Premium[GetPlayerPremiumId(player)].time / 60) / 60) / 24); }
	static void DepositGoldToPlayerGuildBank(Player* player, uint32 amount);
	static uint32 IncreaseValueWithModifier(Player* player, uint32 value);
	static uint32 DecreaseValueWithModifier(Player* player, uint32 value);

	// Player Setterz
	static void AddPremiumToPlayer(Player* player);
	static void RemovePremiumFromPlayer(Player* player);
	static void UpdatePlayerPremiumValue(Player* player, uint8 value, uint64 time);

	// Item Getters
	bool IsItemPremium(Item* item) { return PremiumItem[item->GetEntry()].premium != 0; };
	// Item Setterz
	static void UpdateItemPremiumValue(uint32 item_id, uint8 value);

	// Public Tables
	std::unordered_map<uint32, PremiumElements>Premium;
	std::unordered_map<uint32, PremiumItemElements>PremiumItem;
	std::unordered_map<uint32, PremiumLocationElements>PremiumLocations;
	std::unordered_map<uint32, PremiumLocationElements>PremiumMallLocations;
	std::unordered_map<uint32, PremiumLocationElements>PremiumPublicMallLocations;
	std::unordered_map<uint32, PremiumPlayerLocationElements>PremiumPlayerLocations;
	std::unordered_map<uint32, PremiumTeamLocationElements>PremiumTeamLocations;
	std::unordered_map<uint8, ClassSpells>PremiumClassSpells;

private:
	// Private Variables
	uint8 PREMIUM_TYPE;
	uint8 PREMIUM_TIMER_ENABLE;
	uint64 PREMIUM_TIMER_DURATION = (((1 * 60) * 60) * 24); // Defining day in ms. 1000 = 1 second. 1 second * 60 = 1 minute. 1 min * 60 = 1 hour. 1 hour * 24 = 1 day. we then will call from the conf and get x for days.
	uint8 PREMIUM_GM_MINIMUM_RANK;
	uint32 PREMIUM_UPGRADE_ITEM;
	uint8 PREMIUM_ITEMS_ENABLE;
	float PREMIUM_MODIFIER;
	uint32 PREMIUM_CHAT_DELAY;
	uint8 PREMIUM_CHAT_TEAM;
	uint8 PREMIUM_TP_ENABLE;
	uint32 PREMIUM_TP_BONUS;
	uint8 PREMIUM_HP_ENABLE;
	uint8 PREMIUM_MANA_ENABLE;
	uint8 PREMIUM_RAGE_ENABLE;
	uint32 PREMIUM_TITLE_ID;
	uint32 PREMIUM_TITLE_MASK_ID;
	uint8 PREMIUM_WATER_BREATHE;
	uint8 PREMIUM_SPELL_COST_DECREASE;

	// Tools
	static bool CheckIfPlayerInCombatOrDead(Player* player);
	static void TeleportPlayer(Player* player, uint8 id);
	static void RemoveItem(uint32 id, Player* player);
};

#define sPREM PREM::instance()
#endif