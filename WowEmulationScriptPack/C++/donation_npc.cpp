/////////////////////////////////////////////////////////////////////////////
//        ____        __  __  __     ___                                   //
//       / __ )____ _/ /_/ /_/ /__  /   |  ________  ____  ____ ______     //
//      / __  / __ `/ __/ __/ / _ \/ /| | / ___/ _ \/ __ \/ __ `/ ___/     //
//     / /_/ / /_/ / /_/ /_/ /  __/ ___ |/ /  /  __/ / / / /_/ (__  )      //
//    /_____/\__,_/\__/\__/_/\___/_/  |_/_/   \___/_/ /_/\__,_/____/       //
//         Developed by Natureknight for BattleArenas.no-ip.org            //
//             Copyright (C) 2015 Natureknight/JessiqueBA                  //
//                      battlearenas.no-ip.org                             //
/////////////////////////////////////////////////////////////////////////////

#include "ScriptPCH.h"

// IMPORTANT: Write your definitions here:

std::string website = "fusioncms_new";       // FusionCMS database name

// Those are already in the item_template (db) so dont need to touch them:
const uint32 DONOR_TOKEN = 49927;            // Define the donor token Item ID
const uint32 ONE_CHARACTER_VIP = 4992700;    // Define one-character vip Item ID

// DONATION POINTS PRICES:
const uint32 accVipPrice = 30;               // VIP account price (in donation points)
const uint32 charVipPrice = 7;               // Character VIP price (in donation points)
const uint32 titlePrice = 1;                 // Donation title price (in donation points)

// VOTE POINTS PRICES:
const uint32 arenaPtsPrice = 50;             // Price for 1000 arena points (in vote points)
const uint32 honorPtsPrice = 30;             // Price for 2000 honor points (in vote points)

class Donation_NPC_AT : public CreatureScript
{
public:
	Donation_NPC_AT() : CreatureScript("Donation_NPC_AT"){}

	uint32 SelectDPoints(Player* pPlayer)
	{
		QueryResult select = LoginDatabase.PQuery("SELECT dp FROM %s.account_data WHERE id = '%u'", website.c_str(), pPlayer->GetSession()->GetAccountId());

		if (!select) // Just in case, but should not happen
		{
			pPlayer->CLOSE_GOSSIP_MENU();
			return 0;
		}

		Field* fields = select->Fetch();
		uint32 dp = fields[0].GetUInt32();

		return dp;
	}

	uint32 SelectVPoints(Player* pPlayer)
	{
		QueryResult select = LoginDatabase.PQuery("SELECT vp FROM %s.account_data WHERE id = '%u'", website.c_str(), pPlayer->GetSession()->GetAccountId());

		if (!select) // Just in case, but should not happen
		{
			pPlayer->CLOSE_GOSSIP_MENU();
			return 0;
		}

		Field* fields = select->Fetch();
		uint32 vp = fields[0].GetUInt32();

		return vp;
	}

	void RewardTitle(Player* pPlayer, uint32 entry)
	{
		if (pPlayer->HasTitle(sCharTitlesStore.LookupEntry(entry)))
		{
			pPlayer->GetSession()->SendAreaTriggerMessage("You already have this title.");
			pPlayer->CLOSE_GOSSIP_MENU();
		}
		else
		{
			LoginDatabase.PExecute("UPDATE %s.account_data SET dp = '%u' -%u WHERE id = '%u'", website.c_str(), SelectDPoints(pPlayer), titlePrice, pPlayer->GetSession()->GetAccountId());
			pPlayer->GetSession()->SendAreaTriggerMessage("Successfully earned this title! Thanks for the support!");
			pPlayer->SetTitle(sCharTitlesStore.LookupEntry(entry));
			pPlayer->SaveToDB();
		}
	}

	bool OnGossipHello(Player * pPlayer, Creature * pCreature)
	{
		std::stringstream purchaseHonor;
		std::stringstream purchaseArena;
		std::stringstream points;
		std::stringstream purchaseTitle;

		// TODO: Prevent exploiting the FusionCMS donate points
		if (pPlayer->GetSession()->GetSecurity() < 5 && SelectDPoints(pPlayer) > 50)
		{
			pPlayer->GetSession()->SendAreaTriggerMessage("You have large amount of Donation points: %u. This is probably a website related problem, please "
				"immediately contact the administrator via ticket about this issue.", SelectDPoints(pPlayer));
			pPlayer->CLOSE_GOSSIP_MENU();
			return false;
		}

		// Purchase VIP Account
		if (SelectDPoints(pPlayer) < accVipPrice)
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Purchase VIP Account (|cff980000Locked|r / Click for Information)", GOSSIP_SENDER_MAIN, 1);
		else if (SelectDPoints(pPlayer) >= 30)
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Purchase VIP Account (|cff009900Unlocked|r / Click to use)", GOSSIP_SENDER_MAIN, 2);

		// Purchase VIP only for current char
		if (SelectDPoints(pPlayer) < charVipPrice)
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "VIP only for current character (|cff980000Locked|r / Click for Information)", GOSSIP_SENDER_MAIN, 3);
		else if (SelectDPoints(pPlayer) >= 7)
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "VIP only for current character (|cff009900Unlocked|r / Click to use)", GOSSIP_SENDER_MAIN, 4);

		// Allow players to get honor points by using their voting points
		if (SelectVPoints(pPlayer) < honorPtsPrice)
		{
			purchaseHonor << "Purchase 2k Honor Points (|cff980000Locked|r / Min " << honorPtsPrice << " VP needed)";
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, purchaseHonor.str().c_str(), GOSSIP_SENDER_MAIN, 999);
		}
		else if (SelectVPoints(pPlayer) >= honorPtsPrice)
		{
			purchaseHonor << "Purchase 2k Honor Points (|cff009900Unlocked|r / Click to use)";
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, purchaseHonor.str().c_str(), GOSSIP_SENDER_MAIN, 5);
		}

		// Allow player to get arena points by using their voting points
		if (SelectVPoints(pPlayer) < arenaPtsPrice)
		{
			purchaseArena << "Purchase 1k Arena Points (|cff980000Locked|r / Min " << arenaPtsPrice << " VP needed)";
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, purchaseArena.str().c_str(), GOSSIP_SENDER_MAIN, 999);
		}
		else if (SelectVPoints(pPlayer) >= arenaPtsPrice)
		{
			purchaseArena << "Purchase 1k Arena Points (|cff009900Unlocked|r / Click to use)";
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, purchaseArena.str().c_str(), GOSSIP_SENDER_MAIN, 6);
		}


		// Allow player to get arena points by using their voting points
		if (SelectDPoints(pPlayer) < titlePrice)
		{
			purchaseTitle << "Purchase Character Title (|cff980000Locked|r / Min " << titlePrice << " DP needed)";
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, purchaseTitle.str().c_str(), GOSSIP_SENDER_MAIN, 7);
		}
		else if (SelectDPoints(pPlayer) >= titlePrice)
		{
			purchaseTitle << "Purchase Character Title (|cff009900Unlocked|r / Click to use)";
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, purchaseTitle.str().c_str(), GOSSIP_SENDER_MAIN, 7);
		}

		// Show Donate and Voting Points when GossipHello
		points << "My Donation Points amount: " << SelectDPoints(pPlayer);
		points << "\n" << "My Voting Points amount: " << SelectVPoints(pPlayer);

		pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, points.str().c_str(), GOSSIP_SENDER_MAIN, 100); // No action here, just to show points
		pPlayer->SEND_GOSSIP_MENU(60031, pCreature->GetGUID());
		return true;
	}

	bool OnGossipSelect(Player * pPlayer, Creature * pCreature, uint32 sender, uint32 uiAction)
	{
		pPlayer->PlayerTalkClass->ClearMenus();

		if (sender != GOSSIP_SENDER_MAIN)
			return false;

		uint32 dp = SelectDPoints(pPlayer);
		uint32 vp = SelectVPoints(pPlayer);

		switch (uiAction)
		{
		case 1: // Vip account - locked
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Back to Main Menu", GOSSIP_SENDER_MAIN, 1000);
			pPlayer->SEND_GOSSIP_MENU(60032, pCreature->GetGUID());
			break;

		case 2: // Vip account - unlocked
			if (pPlayer->GetSession()->GetSecurity() >= 1 || pPlayer->HasItemCount(ONE_CHARACTER_VIP, 1))
			{
				pPlayer->GetSession()->SendAreaTriggerMessage("You're already VIP or GM.");
				pPlayer->CLOSE_GOSSIP_MENU();
			}
			else
			{
				LoginDatabase.PExecute("UPDATE %s.account_data SET dp = '%u' -%u WHERE id = '%u'", website.c_str(), dp, accVipPrice, pPlayer->GetSession()->GetAccountId());
				LoginDatabase.PExecute("INSERT INTO `account_access` (`id`, `gmlevel`, `RealmID`) VALUES (%u, 1, -1);", pPlayer->GetSession()->GetAccountId());
				pPlayer->GetSession()->SendAreaTriggerMessage("Successfully upgraded your account to VIP. Close the game and login again for changes to take effect! Thanks for the support!");
				pPlayer->SaveToDB();
				pPlayer->CLOSE_GOSSIP_MENU();
			}
			break;

		case 3: // VIP only character - locked
			pPlayer->ADD_GOSSIP_ITEM(GOSSIP_ICON_INTERACT_1, "Back to Main Menu", GOSSIP_SENDER_MAIN, 1000);
			pPlayer->SEND_GOSSIP_MENU(60033, pCreature->GetGUID());
			break;

		case 4: // VIP only character - unlocked
			if (pPlayer->GetSession()->GetSecurity() >= 1 || pPlayer->HasItemCount(ONE_CHARACTER_VIP, 1))
			{
				pPlayer->GetSession()->SendAreaTriggerMessage("You're already VIP or GM.");
				pPlayer->CLOSE_GOSSIP_MENU();
			}
			else
			{
				LoginDatabase.PExecute("UPDATE %s.account_data SET dp = '%u' -%u WHERE id = '%u'", website.c_str(), dp, charVipPrice, pPlayer->GetSession()->GetAccountId());
				pPlayer->GetSession()->SendAreaTriggerMessage("Successfully upgraded this character to VIP! Thanks for the support!");
				pPlayer->AddItem(ONE_CHARACTER_VIP, 1);
				pPlayer->SaveToDB();
				pPlayer->CLOSE_GOSSIP_MENU();
			}
			break;

		case 5: // Honor Points - 2000
			LoginDatabase.PExecute("UPDATE %s.account_data SET vp = '%u' -%u WHERE id = '%u'", website.c_str(), vp, honorPtsPrice, pPlayer->GetSession()->GetAccountId());
			pPlayer->GetSession()->SendAreaTriggerMessage("Successfully earned 2000 Honor Points. Thanks for the support!");
			pPlayer->ModifyHonorPoints(2000);
			pPlayer->SaveToDB();
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 6: // Arena Points - 1000
			LoginDatabase.PExecute("UPDATE %s.account_data SET vp = '%u' -%u WHERE id = '%u'", website.c_str(), vp, arenaPtsPrice, pPlayer->GetSession()->GetAccountId());
			pPlayer->GetSession()->SendAreaTriggerMessage("Successfully earned 1000 Arena Points. Thanks for the support!");
			pPlayer->ModifyArenaPoints(1000);
			pPlayer->SaveToDB();
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 7: // Donation titles
			if (dp >= titlePrice)
			{
				pPlayer->ADD_GOSSIP_ITEM(4, "Conqueror (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 8);
				pPlayer->ADD_GOSSIP_ITEM(4, "Justicar (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 9);
				pPlayer->ADD_GOSSIP_ITEM(4, "Battlemaster (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 10);
				pPlayer->ADD_GOSSIP_ITEM(4, "Scarab Lord (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 11);
				pPlayer->ADD_GOSSIP_ITEM(4, "Brewmaster (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 12);
				pPlayer->ADD_GOSSIP_ITEM(4, "The Love Fool (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 13);
				pPlayer->ADD_GOSSIP_ITEM(4, "Matron (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 14);
				pPlayer->ADD_GOSSIP_ITEM(4, "Patron (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 15);
				pPlayer->ADD_GOSSIP_ITEM(4, "The Hallowed (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 16);
				pPlayer->ADD_GOSSIP_ITEM(4, "Merrymaker (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 17);
				pPlayer->ADD_GOSSIP_ITEM(4, "The Noble (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 18);
				pPlayer->ADD_GOSSIP_ITEM(4, "The Pilgrim (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 19);
				pPlayer->ADD_GOSSIP_ITEM(4, "Flame Keeper (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 20);
				pPlayer->ADD_GOSSIP_ITEM(4, "Flame Warden (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 21);
				pPlayer->ADD_GOSSIP_ITEM(4, "Elder (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 22);
				pPlayer->ADD_GOSSIP_ITEM(4, "Jenkins (|cff009900Unlocked|r)", GOSSIP_SENDER_MAIN, 23);
				pPlayer->ADD_GOSSIP_ITEM(4, "Back to Main Page", GOSSIP_SENDER_MAIN, 1000);
				pPlayer->SEND_GOSSIP_MENU(60013, pCreature->GetGUID());
			}
			else if (dp < titlePrice)
			{
				pPlayer->ADD_GOSSIP_ITEM(4, "Conqueror (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Justicar (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Battlemaster (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Scarab Lord (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Brewmaster (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "The Love Fool (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Matron (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Patron (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "The Hallowed (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Merrymaker (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "The Noble (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "The Pilgrim (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Flame Keeper (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Flame Warden (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Elder (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Jenkins (|cff980000Locked|r)", GOSSIP_SENDER_MAIN, 999);
				pPlayer->ADD_GOSSIP_ITEM(4, "Back to Main Page", GOSSIP_SENDER_MAIN, 1000);
				pPlayer->SEND_GOSSIP_MENU(60013, pCreature->GetGUID());
			}
			break;

		case 8: // Conqueror
			RewardTitle(pPlayer, 47);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 9: // Justicar
			RewardTitle(pPlayer, 48);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 10: // Battlemaster
			RewardTitle(pPlayer, 72);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 11: // Scarab Lord
			RewardTitle(pPlayer, 46);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 12: // Brewmaster
			RewardTitle(pPlayer, 133);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 13: // the Love Fool
			RewardTitle(pPlayer, 135);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 14: // Matron
			RewardTitle(pPlayer, 137);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 15: // Patron
			RewardTitle(pPlayer, 138);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 16: // The Hallowed
			RewardTitle(pPlayer, 124);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 17: // Merrymaker
			RewardTitle(pPlayer, 134);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 18: // The Noble
			RewardTitle(pPlayer, 155);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 19: // The Pilgrim
			RewardTitle(pPlayer, 168);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 20: // Flame Keeper
			RewardTitle(pPlayer, 76);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 21: // Flame Warden
			RewardTitle(pPlayer, 75);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 22: // Elder
			RewardTitle(pPlayer, 74);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 23: // Jenkins
			RewardTitle(pPlayer, 143);
			pPlayer->CLOSE_GOSSIP_MENU();
			break;

		case 999: // Not enought points
			pPlayer->GetSession()->SendAreaTriggerMessage("Not enought points.");
			OnGossipHello(pPlayer, pCreature);
			break;

		case 1000: // Back to main menu
			OnGossipHello(pPlayer, pCreature);
			break;
		}
		return true;
	}
};

void AddSC_Donation_NPC()
{
	new Donation_NPC_AT();
}
