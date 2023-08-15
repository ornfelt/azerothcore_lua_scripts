#include <Custom/Logic/CustomCouponSystem.h>
#include <Custom/Logic/CustomGMLogic.h>
#include <Custom/Logic/CustomCharacterSystem.h>
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomWorldSystem.h>

#include "ScriptPCH.h"
#include "CustomCouponSystem.h"
#include "Config.h"


enum Belohnungen
{
	ASTRALER_KREDIT = 38186,
	FROSTMARKEN = 49426,
	TRIUMPHMARKEN = 47241,
	TITANSTAHLBARREN = 37663,
	SARONITBARREN = 36913,
	GOLDBARREN = 3577,
	EISENBARREN = 3575,
	URSARONIT = 49908,
	TRAUMSPLITTER = 34052,
	AKRTISCHERPELZ = 44128
};


void CustomCouponSystem::insertNewCouponCodeinDB(std::string code, int itemid, int itemquantity, int used, int useablequantity)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ITEMCODE);
	stmt->setString(0, code);
	stmt->setUInt32(1, itemid);
	stmt->setUInt32(2, itemquantity);
	stmt->setUInt32(3, used);
	stmt->setUInt32(4, useablequantity);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);

}

std::string CustomCouponSystem::createNewCouponCode()
{
	auto randchar = []() -> char
	{
		const char charset[] =
			"0123456789"
			"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
			"abcdefghijklmnopqrstuvwxyz";
		const size_t max_index = (sizeof(charset) - 1);
		return charset[rand() % max_index];
	};
	std::string str(10, 0);
	std::generate_n(str.begin(), 10, randchar);


	return str;
}

void CustomCouponSystem::insertNewPlayerUsedCode(std::string charactername, int accountid, std::string couponcode)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_ITEMCODEACCOUNT);
	stmt->setString(0, charactername);
	stmt->setUInt32(1, accountid);
	stmt->setString(2, couponcode);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

PreparedQueryResult CustomCouponSystem::getRequestedCodeData(std::string couponcode)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEMCODE);
	stmt->setString(0, couponcode);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return NULL;
	}

	return result;
}

bool CustomCouponSystem::hasPlayeralreadyUsedCode(std::string couponcode, int accountid)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEMCODEACCOUNT);
	stmt->setString(0, couponcode);
	stmt->setInt32(1, accountid);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return false;
	}

	return true;
}

bool CustomCouponSystem::isItemCodeStillValid(std::string couponcode)
{
	PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_ITEMCODE);
	stmt->setString(0, couponcode);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return false;
	}

	Field* ergebnis = result->Fetch();
	uint8 couponcodebenutzt = ergebnis[3].GetUInt8();
	uint32 couponcodebenutztbar = ergebnis[4].GetUInt32();

	if (couponcodebenutzt < couponcodebenutztbar) {
		return true;
	}
	
	return false;
	
}

void CustomCouponSystem::updateCouponCodeUsed(int used, std::string couponcode)
{
	SQLTransaction trans = CharacterDatabase.BeginTransaction();
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_ITEMCODEUSED);
	stmt->setInt32(0, used);
	stmt->setString(1, couponcode);
	trans->Append(stmt);
	CharacterDatabase.CommitTransaction(trans);
}

int CustomCouponSystem::getFortuneItem()
{
	srand(time(NULL));
	int r = rand();
	
	if (r % 25 == 0) {
		int reward = CustomCouponSystem::getCouponRewardbyID(0);
		return reward;
	}

	if (r % 25 == 1) {
		int reward = CustomCouponSystem::getCouponRewardbyID(1);
		return reward;
	}

	if (r % 25 == 2) {
		int reward = CustomCouponSystem::getCouponRewardbyID(2);
		return reward;
	}

	if (r % 25 == 3) {
		int reward = CustomCouponSystem::getCouponRewardbyID(3);
		return reward;
	}

	if (r % 25 == 4) {
		int reward = CustomCouponSystem::getCouponRewardbyID(4);
		return reward;
	}

	if (r % 25 == 5) {
		int reward = CustomCouponSystem::getCouponRewardbyID(5);
		return reward;
	}

	if (r % 25 == 6) {
		int reward = CustomCouponSystem::getCouponRewardbyID(6);
		return reward;
	}

	if (r % 25 == 7) {
		int reward = CustomCouponSystem::getCouponRewardbyID(7);
		return reward;
	}

	if (r % 25 == 8) {
		int reward = CustomCouponSystem::getCouponRewardbyID(8);
		return reward;
	}

	if (r % 25 == 9) {
		int reward = CustomCouponSystem::getCouponRewardbyID(9);
		return reward;
	}

	if (r % 25 == 10) {
		int reward = CustomCouponSystem::getCouponRewardbyID(10);
		return reward;
	}

	if (r % 25 == 11) {
		int reward = CustomCouponSystem::getCouponRewardbyID(11);
		return reward;
	}

	if (r % 25 == 12) {
		int reward = CustomCouponSystem::getCouponRewardbyID(12);
		return reward;
	}

	if (r % 25 == 13) {
		int reward = CustomCouponSystem::getCouponRewardbyID(13);
		return reward;
	}

	if (r % 25 == 14) {
		int reward = CustomCouponSystem::getCouponRewardbyID(14);
		return reward;
	}

	if (r % 25 == 15) {
		int reward = CustomCouponSystem::getCouponRewardbyID(15);
		return reward;
	}

	if (r % 25 == 16) {
		int reward = CustomCouponSystem::getCouponRewardbyID(16);
		return reward;
	}

	if (r % 25 == 17) {
		int reward = CustomCouponSystem::getCouponRewardbyID(17);
		return reward;
	}

	if (r % 25 == 18) {
		int reward = CustomCouponSystem::getCouponRewardbyID(18);
		return reward;
	}

	if (r % 25 == 19) {
		int reward = CustomCouponSystem::getCouponRewardbyID(19);
		return reward;
	}

	if (r % 25 == 20) {
		int reward = CustomCouponSystem::getCouponRewardbyID(20);
		return reward;
	}

	if (r % 25 == 21) {
		int reward = CustomCouponSystem::getCouponRewardbyID(21);
		return reward;
	}

	if (r % 25 == 22) {
		int reward = CustomCouponSystem::getCouponRewardbyID(22);
		return reward;
	}

	if (r % 25 == 23) {
		int reward = CustomCouponSystem::getCouponRewardbyID(23);
		return reward;
	}

	if (r % 25 == 24) {
		int reward = CustomCouponSystem::getCouponRewardbyID(24);
		return reward;
	}

	return 100;

}

int CustomCouponSystem::getCouponRewardbyID(int modulo)
{
	PreparedStatement * stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_COUPON_REWARD);
	stmt->setInt32(0,modulo);
	PreparedQueryResult result = CharacterDatabase.Query(stmt);

	if (!result) {
		return 5263;
	}

	Field* ergebnis = result->Fetch();
	int itemid = ergebnis[0].GetInt32();

	return itemid;
}

void CustomCouponSystem::playerRedeemCommand(Player * player, const char * args)
{

	CustomCouponSystem * CouponSystem = 0;
	CustomCharacterSystem * CharacterSystem = 0;
	CustomPlayerLog* PlayerLog = 0;

	//Player *player = handler->GetSession()->GetPlayer();

	std::string couponCode = std::string((char*)args);

	if (couponCode == "")
	{
		player->GetSession()->SendNotification("Without Code we cannot send you a Reward!");
		return;
	}

	if (couponCode == "GOLD") {
		return;
	}


	//Check if Code does exist and is still valid!
	bool couponCodeStillValid = false;
	couponCodeStillValid = CouponSystem->isItemCodeStillValid(couponCode);


	if (!couponCodeStillValid) {
		if (player->GetSession()->GetSecurity() >= 2) {
			ChatHandler(player->GetSession()).PSendSysMessage("Debug: Couponstillvalidvalue: %s", couponCodeStillValid);
		}
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		ChatHandler(player->GetSession()).PSendSysMessage("Couponcode is invalid or has reached maximum uses!");
		ChatHandler(player->GetSession()).PSendSysMessage("Couponcode: %s", couponCode);
		ChatHandler(player->GetSession()).PSendSysMessage("Please check your Couponcode %s", player->GetSession()->GetPlayerName());
		ChatHandler(player->GetSession()).PSendSysMessage("If you type the correct Couponcode the Couponcodecharges are empty! Sorry for that!");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		return;
	}


	//Check if Player used Code already
	//"SELECT accid, code from item_codes_account where code = ? and accid = ?"
	bool hasPlayeralreadyUsedCode = false;
	hasPlayeralreadyUsedCode = CouponSystem->hasPlayeralreadyUsedCode(couponCode, player->GetSession()->GetAccountId());
	if (player->GetSession()->GetSecurity() >= 2) {
		ChatHandler(player->GetSession()).PSendSysMessage("Debug: HasPLayerUsedcode %s", hasPlayeralreadyUsedCode);
		ChatHandler(player->GetSession()).PSendSysMessage("Debug: Couponcode %s", couponCode);
		ChatHandler(player->GetSession()).PSendSysMessage("Debug: AccountID %u", player->GetSession()->GetAccountId());
	}

	if (hasPlayeralreadyUsedCode) {
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		ChatHandler(player->GetSession()).PSendSysMessage("You have already used this Coupon: %s", couponCode);
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		return;
	}


	PreparedQueryResult result = CouponSystem->getRequestedCodeData(couponCode);

	Field* fields = result->Fetch();
	uint32 belohnung = fields[1].GetUInt32();
	uint32 anzahl = fields[2].GetUInt32();
	uint8 benutzt = fields[3].GetUInt8();
	CouponSystem->updateCouponCodeUsed(benutzt + 1, couponCode);
	CouponSystem->insertNewPlayerUsedCode(player->GetSession()->GetPlayerName(), player->GetSession()->GetAccountId(), couponCode);
	CharacterSystem->sendPlayerMailwithItem(belohnung, anzahl, "Congratulation", "Your Couponcode was valid. \nHere is your Reward! \nKind Regards your Serverteam.", player->GetSession()->GetPlayer());
	ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
	ChatHandler(player->GetSession()).PSendSysMessage("Congratulation %s!", player->GetSession()->GetPlayerName());
	ChatHandler(player->GetSession()).PSendSysMessage("Your Couponcode %s was valid!", couponCode);
	ChatHandler(player->GetSession()).PSendSysMessage("Please check your Mails %s!", player->GetSession()->GetPlayerName());
	ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");

	//ChatHandler(player->GetSession()).PSendSysMessage("This is your %u Incident. Beware!", newcounter,player->GetName());

	std::ostringstream tt;
	tt << "Coupon redeem with code : " << couponCode;
	std::string reason = tt.str().c_str();
	PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(),reason);
	return;

}

void CustomCouponSystem::couponGenerationperCommand(Player * player, const char * args)
{

	CustomWorldSystem * WorldSystem = 0;
	CustomCouponSystem * CouponSystem = 0;
	CustomReportSystem * ReportSystem = 0;
	CustomGMLogic * GMLogic = 0;
	CustomCharacterSystem * CharacterSystem = 0;

	char* itemchar = strtok((char*)args, " ");
	if (!itemchar) {
		player->GetSession()->SendNotification("Without ItemID command will not work!");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		ChatHandler(player->GetSession()).PSendSysMessage("Without ItemID command will not work!");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		return;
	}

	uint32 itemid = atoi((char*)itemchar);
	bool itemexist = WorldSystem->doesItemExistinDB(itemid);

	if (!itemexist) {
		player->GetSession()->SendNotification("Item not in DB!");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		ChatHandler(player->GetSession()).PSendSysMessage("Item does not exist in DB!");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		return;
	}

	char* itemanzahl = strtok(NULL, " ");
	if (!itemanzahl || !atoi(itemanzahl)) {
		player->GetSession()->SendNotification("Without Quantity command will not work !");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		ChatHandler(player->GetSession()).PSendSysMessage("Without Quantity command will not work !");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		return;
	}


	char* anzahlnutzer = strtok(NULL, " ");
	if (!anzahlnutzer) {
		player->GetSession()->SendNotification("Without usability the command will not work!");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		ChatHandler(player->GetSession()).PSendSysMessage("Without usability the command will not work!");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		return;
	}


	uint32 quantity = atoi((char*)itemanzahl);
	uint32 codeuseable = atoi((char*)anzahlnutzer);


	bool checkifitemisforbidden = ReportSystem->checkIfItemisForbidden(itemid);

	if (checkifitemisforbidden) {

		std::string accountname = "";
		accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
		GMLogic->addCompleteGMCountLogic( player->GetSession()->GetPlayer(), "Tries to create a forbidden Coupon!");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		ChatHandler(player->GetSession()).PSendSysMessage("Warning: GM should be a supporter not a cheater!");
		ChatHandler(player->GetSession()).PSendSysMessage("This incident has been logged in DB.");
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
		return;
	}


	std::string couponcode = "";
	couponcode = CouponSystem->createNewCouponCode();
	std::string itemname = "";
	std::string accountname = "";
	accountname = CharacterSystem->getAccountName(player->GetSession()->GetAccountId());
	itemname = WorldSystem->getItemNamebyItemId(itemid);
	GMLogic->addGMLog(player->GetSession()->GetPlayerName(), player->GetGUID(), accountname, player->GetSession()->GetAccountId(), "GM created CouponCode. More Details in gm_actions_coupon_details!");
	GMLogic->insertNewCouponGMLog(player->GetSession()->GetPlayerName(), player->GetGUID(), itemid, couponcode, quantity);
	CouponSystem->insertNewCouponCodeinDB(couponcode, itemid, quantity, 0, codeuseable);
	ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");
	ChatHandler(player->GetSession()).PSendSysMessage("The generated couponcode is: %s", couponcode);
	ChatHandler(player->GetSession()).PSendSysMessage("The ItemID is: %u", itemid);
	ChatHandler(player->GetSession()).PSendSysMessage("The Item Name is: %s", itemname);
	ChatHandler(player->GetSession()).PSendSysMessage("Coupon Useable: %u", codeuseable);
	ChatHandler(player->GetSession()).PSendSysMessage("##########################################################");

	return;
}

void CustomCouponSystem::playerCouponGerationForAFriend(Player * player, std::string logmessage)
{
	CustomCharacterSystem * CharacterSystem = 0;
	CustomPlayerLog * PlayerLog = 0;

	int32 couponcost = sConfigMgr->GetIntDefault("Coupon.Generate.Cost", 5000);


	if (player->HasEnoughMoney(couponcost * GOLD)) {
		player->ModifyMoney(-couponcost * GOLD);
		std::string couponcode = "";
		couponcode = createNewCouponCode();
		int rewarditem = getFortuneItem();
		uint32 quantity = 1 + (std::rand() % (15 - 1 + 1));
		insertNewCouponCodeinDB(couponcode, rewarditem, quantity,0,1);
		std::ostringstream mailmessage;
		mailmessage << "Your created CouponCode is: " << couponcode << " \nThe CouponCode Price was" << couponcost << " Gold. \nThe Server Team wish you a nice Day!";
		CharacterSystem->sendPlayerMailwithoutanyhing(player->GetSession()->GetPlayer(), "Your Coupon Details", mailmessage.str().c_str());
		PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), logmessage);
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Your Coupon was created. CouponCode: %s", couponcode,
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("You should have Mail now with all Details.",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Have fun with it, %s", player->GetSession()->GetPlayerName(),
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################",
			player->GetName());

		return;
	}



	else {
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Your Bag seems to be very empty! Come again if you had enoungh money to pay me!",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Actual Price is: %u", couponcost,
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################",
			player->GetName());
		return;
	}
	return;
}

void CustomCouponSystem::playerCouponGenerationAndRedeeming(Player * player, std::string logmessage)
{
	CustomCharacterSystem * CharacterSystem = 0;
	CustomPlayerLog * PlayerLog = 0;

	int32 couponcost = sConfigMgr->GetIntDefault("Coupon.Generate.Cost", 5000);

	if (player->HasEnoughMoney(couponcost * GOLD)) {
		player->ModifyMoney(-couponcost * GOLD);
		std::string couponCode = "";
		couponCode = createNewCouponCode();
		int rewarditem = getFortuneItem();
		uint32 quantity = 1 + (std::rand() % (15 - 1 + 1));
		insertNewCouponCodeinDB(couponCode, rewarditem, quantity, 1, 1);
		insertNewPlayerUsedCode(player->GetSession()->GetPlayerName(), player->GetSession()->GetAccountId(), couponCode);
		CharacterSystem->sendPlayerMailwithItem(rewarditem, quantity, "Your CouponCode", "Here is your CouponCode\n Have fun with your Reward. \n Feel free to do all what you want with it!", player->GetSession()->GetPlayer());
		PlayerLog->addCompletePlayerLog(player->GetSession()->GetPlayer(), logmessage);
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Your Coupon was created and redeemed.",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("You should have Mail right now.",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Have fun with it, %s", player->GetSession()->GetPlayerName(),
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################",
			player->GetName());

		return;
	}

	else {
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Your Bag seems to be very empty! Come again if you had enoungh money to pay me!",
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("Actual Price is: %u",couponcost,
			player->GetName());
		ChatHandler(player->GetSession()).PSendSysMessage("##########################################################",
			player->GetName());
		return;
	}
	return;
}




