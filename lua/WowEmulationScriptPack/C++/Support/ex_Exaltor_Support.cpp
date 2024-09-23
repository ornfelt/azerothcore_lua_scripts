#include "AccountMgr.h"
#include "time.h"
#include <stdio.h>
#include "Bag.h"
#include "Common.h"
#include "Config.h"
#include "DatabaseEnv.h"
#include "DBCStructure.h"
#include "Define.h"
#include "Field.h"
#include "GameEventMgr.h"
#include "Item.h"
#include "Language.h"
#include "Log.h"
#include "ObjectGuid.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QueryResult.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"
#include "Transaction.h"
#include "WorldSession.h"
#include <sstream>
#include <string>
#include <stdlib.h>
#include "ObjectGuid.h"
#include "ObjectMgr.h"
#include <Custom/Logic/CustomCharacterSystem.h>
#include <Custom/Logic/CustomPlayerLog.h>
#include <Custom/Logic/CustomCouponSystem.h>
#include <Custom/Logic/CustomTranslationSystem.h>


#define PROFESSION_COST 20

#define GROUPID 1

enum ExaltorMenuOptions {

	INFORMATIONANDHELP = 0,
	WHOAREUMENU = 1,
	FIRSTCHARACTERMENU = 2,
	GETFIRSTCHARACTER = 3,
	COUPONHELP = 4,
	COUPONSINGLE = 5,
	COUPONFRIEND = 6,
	PROFESSIONHELP = 7,
	MINING = 8,
	TAILORING = 9,
	BLACKSMITHING = 10,
	HERBALISM = 11,
	SKINING = 12,
	LEATHERWORKING = 13,
	JEWELCRAFTING = 14,
	ALCHEMY = 15,
	ENCHANTING = 16,
	INSCRIPTION = 17,
	ENGINEERING = 18,
	BACKTOFEATURES = 19,
	BUYLEVELMENU = 20,
	LEVEL80EQUIPMENU = 21,
	LEVELUPTO80 = 22,
	NEWCOMMANDSMENU = 23,
	HOWTOGETFIRSTCHARAKTERMENUE = 24,

	
};

enum HELPMESSAGES {


	NEWCOMMANDEXPLANATION = 2000,
	WHOAREUEXP = 2001,
	FIRSTCHARACTEREXP = 2002,
	HOWTOGETNEWFIRSTCHARAKTER = 2003,

};

enum ExaltorAIMessages {
	EMPTYFIRSTCHARACTER = 1000,
	BETATESTER = 1001,
	
};

class npc_first_char : public CreatureScript
{
		public: npc_first_char() : CreatureScript("npc_first_char"){ }
		
			
			
				struct npc_first_charAI : public ScriptedAI
				{
					npc_first_charAI(Creature* creature) : ScriptedAI(creature) { }
					
					uint32 ticktimer;
					uint32 actualplayer = 0;

					void Reset() {
						ticktimer = 1000;
					}


					void UpdateAI(uint32 diff) 
					{
						CustomTranslationSystem * TranslationSystem = 0;
						CustomCharacterSystem * CharacterSystem = 0;
						if (ticktimer <= diff) {
							if (sConfigMgr->GetBoolDefault("Exaltor.Activate", true)) {
								if (Player * player = me->SelectNearestPlayer(10.0f)) {
									if (actualplayer != player->GetGUID()) {
										if (sConfigMgr->GetBoolDefault("Exaltor.Character", true)) {
											bool playerisQualified = CharacterSystem->checkifPlayerisQualifiedforFirstCharacter(player->GetSession()->GetPlayer());

											if (playerisQualified) {
												std::string emptyfirstcharacter = TranslationSystem->getCompleteTranslationsString(GROUPID, EMPTYFIRSTCHARACTER, player->GetSession()->GetPlayer());
												std::ostringstream tt;
												tt << "Hi " << player->GetSession()->GetPlayerName() << "! " << emptyfirstcharacter;
												std::string msg = tt.str().c_str();
												me->Yell(msg, LANG_UNIVERSAL, nullptr);
												actualplayer = player->GetGUID();
												return;
											}
										}

										if (player->HasItemCount(34047, 1, false)) {
											std::string betatester = TranslationSystem->getCompleteTranslationsString(GROUPID, BETATESTER, player->GetSession()->GetPlayer());
											std::ostringstream tt;
											tt << "Hi " << player->GetSession()->GetPlayerName() << "! " << betatester;
											std::string msg = tt.str().c_str();
											me->Yell(msg, LANG_UNIVERSAL, nullptr);
											me->HandleEmoteCommand(EMOTE_STATE_KNEEL);
											actualplayer = player->GetGUID();
											return;
										}

										std::ostringstream tt;
										tt << "Hi " << player->GetSession()->GetPlayerName();
										std::string msg = tt.str().c_str();
										me->Yell(msg, LANG_UNIVERSAL, nullptr);
										actualplayer = player->GetGUID();
										return;
									}

								}
							}
							else {
								return;
							}
						}
						else {
							ticktimer -= diff;
						}
					}

				};

				CreatureAI * GetAI(Creature * creature) const 
				{
					return new npc_first_charAI(creature);
				}



				bool OnGossipHello(Player *player, Creature* creature)
				{
					CustomCharacterSystem * CharacterSystem = 0;
					CustomTranslationSystem * TranslationSystem = 0;

					std::string informationandhelp = TranslationSystem->getCompleteTranslationsString(GROUPID, INFORMATIONANDHELP, player->GetSession()->GetPlayer());
					std::string getfirstcharacter = TranslationSystem->getCompleteTranslationsString(GROUPID, GETFIRSTCHARACTER, player->GetSession()->GetPlayer());
			
					if (creature->IsQuestGiver()) 
						player->PrepareQuestMenu(creature->GetGUID());
					

					//test if this is possible in Fucntion
					if (sConfigMgr->GetBoolDefault("Exaltor.Activate", true)) {
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, informationandhelp, GOSSIP_SENDER_MAIN, 0, "", 0, false);
						if (sConfigMgr->GetBoolDefault("Exaltor.Character", true)) {
							bool qualified = CharacterSystem->checkifPlayerisQualifiedforFirstCharacter(player->GetSession()->GetPlayer()); 
							if(qualified){
								player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, getfirstcharacter, GOSSIP_SENDER_MAIN, 1, "", 0, false);
							}
							
						}

						if (sConfigMgr->GetBoolDefault("Exaltor.Features", true)) {
							player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Features", GOSSIP_SENDER_MAIN, 3, "", 0, false);
						}
						
						player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
						return true;

					}


					else {
						creature->SetPhaseMask(2, true);
						player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
						return true;
					}
				}

			
				bool OnGossipSelect(Player * player, Creature * creature, uint32 /*uiSender*/, uint32 uiAction)
				{
					CustomCharacterSystem* CharacterSystem = 0;
					CustomCouponSystem * CouponSystem = 0;
					CustomTranslationSystem * TranslationSystem = 0;
					switch (uiAction)
					{

					//Information Help
					case 0:
					{
						std::string whoareu = TranslationSystem->getCompleteTranslationsString(GROUPID, WHOAREUMENU, player->GetSession()->GetPlayer());
						std::string firstcharacter = TranslationSystem->getCompleteTranslationsString(GROUPID, FIRSTCHARACTERMENU, player->GetSession()->GetPlayer());
						std::string newfirstcharacter = TranslationSystem->getCompleteTranslationsString(GROUPID, HOWTOGETFIRSTCHARAKTERMENUE, player->GetSession()->GetPlayer());
						std::string newcommandmenue = TranslationSystem->getCompleteTranslationsString(GROUPID, NEWCOMMANDSMENU, player->GetSession()->GetPlayer());
						

						player->PlayerTalkClass->SendGossipMenu(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
						player->PlayerTalkClass->ClearMenus();

						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, whoareu, GOSSIP_SENDER_MAIN, 10000, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, firstcharacter, GOSSIP_SENDER_MAIN, 10001, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, newfirstcharacter, GOSSIP_SENDER_MAIN, 10003, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, newcommandmenue, GOSSIP_SENDER_MAIN, 10002, "", 0, false);

						player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
						return true;
					}break;

					//First Character  Complete
					case 1:
					{
						CharacterSystem->playerGiveFirstCharacter(player->GetSession()->GetPlayer());
						return true;

					}break;

					
				
					case 3:
					{
						player->PlayerTalkClass->ClearMenus();
						std::string level80equipment = TranslationSystem->getCompleteTranslationsString(GROUPID, LEVEL80EQUIPMENU, player->GetSession()->GetPlayer());
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, level80equipment, GOSSIP_SENDER_MAIN, 4, "", 0, false);
						if (sConfigMgr->GetBoolDefault("Exaltor.Professions", true)) {
							std::string proffesionsstring = TranslationSystem->getCompleteTranslationsString(GROUPID, PROFESSIONHELP, player->GetSession()->GetPlayer());
							player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, proffesionsstring, GOSSIP_SENDER_MAIN, 5, "", 0, false);
						}

						if (sConfigMgr->GetBoolDefault("Exaltor.Coupon.Generate", true)) {
							std::string singlecoupon = TranslationSystem->getCompleteTranslationsString(GROUPID, COUPONSINGLE, player->GetSession()->GetPlayer());
							std::string friendcoupon = TranslationSystem->getCompleteTranslationsString(GROUPID, COUPONFRIEND, player->GetSession()->GetPlayer());
							player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, singlecoupon, GOSSIP_SENDER_MAIN, 6, "", 0, false);
							player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, friendcoupon, GOSSIP_SENDER_MAIN, 7, "", 0, false);
						}

						if (sConfigMgr->GetBoolDefault("Exaltor.Level", true)) {
							std::string buylevel = TranslationSystem->getCompleteTranslationsString(GROUPID, BUYLEVELMENU, player->GetSession()->GetPlayer());
							player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, buylevel, GOSSIP_SENDER_MAIN, 8, "", 0, false);
						}

						bool checkifPlayerhasGetLob = false;
						checkifPlayerhasGetLob = CharacterSystem->checkIfPlayerGetPlayTimeReward(200, player->GetGUID());

						if (player->GetSession()->GetSecurity() == 3) {
							player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Aufwertungen einsehen", GOSSIP_SENDER_MAIN, 10, "", 0, false);
							player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "Wandervolk", GOSSIP_SENDER_MAIN, 9504, "", 11, false);
						}


						player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
						return true;
					}break;


					case 4:
					{
						return true;
					}break;

					case 5:
					{
						std::string mining = TranslationSystem->getCompleteTranslationsString(GROUPID, MINING, player->GetSession()->GetPlayer());
						std::string tailoring = TranslationSystem->getCompleteTranslationsString(GROUPID, TAILORING, player->GetSession()->GetPlayer());
						std::string blacksmithing = TranslationSystem->getCompleteTranslationsString(GROUPID, BLACKSMITHING, player->GetSession()->GetPlayer());
						std::string herbalism = TranslationSystem->getCompleteTranslationsString(GROUPID, HERBALISM, player->GetSession()->GetPlayer());
						std::string skinning = TranslationSystem->getCompleteTranslationsString(GROUPID, SKINING, player->GetSession()->GetPlayer());
						std::string leatherworking = TranslationSystem->getCompleteTranslationsString(GROUPID, LEATHERWORKING, player->GetSession()->GetPlayer());
						std::string jewelcrafting = TranslationSystem->getCompleteTranslationsString(GROUPID, JEWELCRAFTING, player->GetSession()->GetPlayer());
						std::string alchemy = TranslationSystem->getCompleteTranslationsString(GROUPID, ALCHEMY, player->GetSession()->GetPlayer());
						std::string enchanting = TranslationSystem->getCompleteTranslationsString(GROUPID, ENCHANTING, player->GetSession()->GetPlayer());
						std::string inscription = TranslationSystem->getCompleteTranslationsString(GROUPID, INSCRIPTION, player->GetSession()->GetPlayer());
						std::string engineering = TranslationSystem->getCompleteTranslationsString(GROUPID, ENGINEERING, player->GetSession()->GetPlayer());
						std::string backtofeatures = TranslationSystem->getCompleteTranslationsString(GROUPID, BACKTOFEATURES, player->GetSession()->GetPlayer());

						player->PlayerTalkClass->SendGossipMenu(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
						player->PlayerTalkClass->ClearMenus();

						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, mining, GOSSIP_SENDER_MAIN, 200, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, tailoring, GOSSIP_SENDER_MAIN, 201, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, blacksmithing, GOSSIP_SENDER_MAIN, 202, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, herbalism, GOSSIP_SENDER_MAIN, 203, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, skinning, GOSSIP_SENDER_MAIN, 204, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, leatherworking, GOSSIP_SENDER_MAIN, 205, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, jewelcrafting, GOSSIP_SENDER_MAIN, 206, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, alchemy, GOSSIP_SENDER_MAIN, 207, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, enchanting, GOSSIP_SENDER_MAIN, 208, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, inscription, GOSSIP_SENDER_MAIN, 209, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, engineering, GOSSIP_SENDER_MAIN, 210, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, backtofeatures, GOSSIP_SENDER_MAIN, 211, "", 0, false);

						player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
						return true;
					}break;

					case 6:
					{
						CouponSystem->playerCouponGenerationAndRedeeming(player->GetSession()->GetPlayer(), "Generate and Redeem code at Exaltor");
						
					}break;


					case 7:
					{
						CouponSystem->playerCouponGerationForAFriend(player->GetSession()->GetPlayer(), "Generate a couponcode for a friend a Exaltor!");
						return true;
					}break;


					case 8:
					{
						player->PlayerTalkClass->SendGossipMenu(DEFAULT_GOSSIP_MESSAGE, creature->GetGUID());
						player->PlayerTalkClass->ClearMenus();
						std::string levelupto80 = TranslationSystem->getCompleteTranslationsString(GROUPID, LEVELUPTO80, player->GetSession()->GetPlayer());
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "1 Level", GOSSIP_SENDER_MAIN, 300, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, "5 Level", GOSSIP_SENDER_MAIN, 301, "", 0, false);
						player->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, 7, levelupto80, GOSSIP_SENDER_MAIN, 302, "", 0, false);
						player->PlayerTalkClass->SendGossipMenu(907, creature->GetGUID());
						return true;
						
					}break;

					case 300:
					{
						CharacterSystem->givePlayerLevelWithCurrency(player->GetSession()->GetPlayer(), 2, 1,"Buy 1 Level at Exaltor!");
						return true;
					}break;


					case 301:
					{
						CharacterSystem->givePlayerLevelWithCurrency(player->GetSession()->GetPlayer(), 4, 5,"Buy 5 Level at Exaltor!");
						return true;
					}break;

					case 302:
					{
						CharacterSystem->givePlayerLevelWithCurrency(player->GetSession()->GetPlayer(), 10,  79, "Buy full Levelup to 80 at Exaltor!");
						return true;
					}break;



					//Bergbau
					case 200:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_MINING,"Learned Mining");
						return true;

					}break;

					//Schneiderei
					case 201:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_TAILORING, "Learned Tailoring");
						return true;

					}break;


					//Schmiedekunst
					case 202:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_BLACKSMITHING, "Learned Blacksmithing");
						return true;
					}break;


					//Kraeuterkunde
					case 203:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_HERBALISM, "Learned Herbalism");
						return true;
					}break;


					//Kürschner
					case 204:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_SKINNING, "Learned Skinning");
						return true;

					}break;


					//Lederer
					case 205:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_LEATHERWORKING, "Learned Leatherworking");
						return true;

					}break;


					//Juwe
					case 206:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_JEWELCRAFTING, "Learned Jewelcrafting");
						return true;
					}break;



					//Alchemie
					case 207:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_ALCHEMY, "Learned Alchemy");
						return true;
					}break;


					//VZ
					case 208:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_ENCHANTING, "Learned Enchanting");
						return true;
					}break;

					//Inschriftler
					case 209:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_INSCRIPTION, "Learned Inscription");
						return true;


					}break;

					//Ingi
					case 210:
					{
						CharacterSystem->completeLearnProffesion(player->GetSession()->GetPlayer(), SKILL_ENGINEERING, "Learned Engineering");
						return true;
					}break;


					case 10000: {
						std::string whoareu = TranslationSystem->getCompleteTranslationsString(GROUPID, WHOAREUEXP, player->GetSession()->GetPlayer());
						ChatHandler(player->GetSession()).PSendSysMessage("%s", whoareu,
							player->GetName());
						ChatHandler(player->GetSession()).PSendSysMessage("########################################",
							player->GetName());
						
					}break;

					case 10001:
					{
						std::string firstcharacterexp = TranslationSystem->getCompleteTranslationsString(GROUPID, FIRSTCHARACTEREXP, player->GetSession()->GetPlayer());
						ChatHandler(player->GetSession()).PSendSysMessage("%s", firstcharacterexp,
							player->GetName());
						return true;
						
					}break;

					case 10002:
					{
						std::string newcommands = TranslationSystem->getCompleteTranslationsString(GROUPID, NEWCOMMANDEXPLANATION, player->GetSession()->GetPlayer());
						ChatHandler(player->GetSession()).PSendSysMessage("%s", newcommands,
							player->GetName());
						return true;
						
					}break;


					case 10003:
					{
						std::string newfirstcharacter = TranslationSystem->getCompleteTranslationsString(GROUPID, HOWTOGETNEWFIRSTCHARAKTER, player->GetSession()->GetPlayer());
						ChatHandler(player->GetSession()).PSendSysMessage("%s", newfirstcharacter,
							player->GetName());
						return true;

					}break;

					return true;

					}

					return true;
				}
        			
};
				






void AddSC_npcfirstchar()
{
	new npc_first_char();
}