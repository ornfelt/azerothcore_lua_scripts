// Spectator gossip
// Smolderforge 2013

#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "ArenaTeam.h"
#include "ScriptPCH.h"
#include "Chat.h"
#include "GameEventMgr.h"
#include "Player.h"
#include "ObjectMgr.h"
#include "WorldPacket.h"

#define GOSSIP_SENDER   11

std::string StrToInt(int number) // I have NO idea how to do this in another way...
{
    std::stringstream ss;
    ss << number;
    return ss.str();
}

char *GetClassName(uint8 _Class)
{
    switch (_Class)
    {
        case CLASS_WARRIOR: return "Warrior"; break;
        case CLASS_PALADIN: return "Paladin"; break;
        case CLASS_HUNTER:  return "Hunter";  break;
        case CLASS_ROGUE:   return "Rogue";   break;
        case CLASS_PRIEST:  return "Priest";  break;
        case CLASS_SHAMAN:  return "Shaman";  break;
        case CLASS_MAGE:    return "Mage";    break;
        case CLASS_WARLOCK: return "Warlock"; break;
        case CLASS_DRUID:   return "Druid";   break;
        default: return ""; break;
    }
}

bool GossipHello_spectator(Player *player, Creature *_Creature)
{
    if (player->InBattleGroundQueue())
    {
        player->GetSession()->SendNotification("Please leave queue(s) before spectating");
        player->CLOSE_GOSSIP_MENU();
        return false;
    }

    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,  "2v2 Rated"              , ARENA_TYPE_2v2, 0); // start listing at arena 0
    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,  "3v3 Rated"              , ARENA_TYPE_3v3, 0);
    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT,  "3v3 Solo Queue Rated"   , ARENA_TYPE_SOLO_3v3, 0);
    player->PlayerTalkClass->SendGossipMenu(66, _Creature->GetGUID());

    return true;
}

void SendSubMenu_spectator(Player *player, Creature *_Creature, uint32 arenaType, uint32 action)
{
    uint32 totalcount = sBattleGroundMgr->GetBattleGroundsCount();
    uint32 roomLeft = GOSSIP_MAX_MENU_ITEMS; // (not implemented) were gonna be cheap and always add a Back, Next and Refresh button, no matter if its needed or not.

    if (action < 0 || action >= totalcount) // reset to start of list if passed end or begin
        action = 0;

    BattleGroundSet::iterator itr = sBattleGroundMgr->GetBattleGroundsBegin();

    for(uint32 i = 0; i < action; i++) // is there any other way to increase a iterator by X amount?
        itr++;

    while(itr != sBattleGroundMgr->GetBattleGroundsEnd() && roomLeft > 0)
    {
        BattleGround * bg = itr->second;
        if (bg->GetArenaType() == arenaType && bg->isRated() && bg->GetStatus() == STATUS_IN_PROGRESS && bg->GetPlayersCountByTeam(ALLIANCE) + bg->GetPlayersCountByTeam(HORDE) > 0)
        {
            ArenaTeam *goldTeam = sObjectMgr->GetArenaTeamById(bg->GetArenaTeamIdForTeam(ALLIANCE));
            ArenaTeam *greenTeam = sObjectMgr->GetArenaTeamById(bg->GetArenaTeamIdForTeam(HORDE));
            if (!greenTeam || !goldTeam)
                continue;

            if (arenaType == ARENA_TYPE_2v2)
            {
                uint8 first = 0;
                uint8 second = 0;

                uint8 first2 = 0;
                uint8 second2 = 0;
                std::string firstName = "?";
                std::string secondName = "?";
                std::string firstName2 = "?";
                std::string secondName2 = "?";
                std::string firstClass;
                std::string secondClass;
                std::string firstClass2;
                std::string secondClass2;
                for (BattleGround::BattleGroundPlayerMap::const_iterator itr2 = bg->GetPlayers().begin(); itr2 != bg->GetPlayers().end(); ++itr2)
                {
                    if (Player *plr = sObjectMgr->GetPlayer(itr2->first))
                        if (plr->GetArenaTeamId(0) == goldTeam->GetId())
                        {
                            if (first == 0)
                            {
                                first = plr->getClass();
                                firstName = plr->GetName();
                                firstClass = GetClassName(first);
                            }
                            else if (second == 0)
                            {
                                second = plr->getClass();
                                secondName = plr->GetName();
                                secondClass = GetClassName(second);
                            }
                        }
                        else if (plr->GetArenaTeamId(0) == greenTeam->GetId())
                        {
                            if (first2 == 0)
                            {
                                first2 = plr->getClass();
                                firstName2 = plr->GetName();
                                firstClass2 = GetClassName(first2);
                            }
                            else if (second2 == 0)
                            {
                                second2 = plr->getClass();
                                secondName2 = plr->GetName();
                                secondClass2 = GetClassName(second2);
                            }
                        }
                }

                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, firstName + " " + firstClass + " " + secondName + " " + secondClass + " (" + StrToInt(goldTeam->GetRating()) + ") VS " +
                    firstName2 + " " + firstClass2 + " " + secondName2 + " " + secondClass2 + " (" + StrToInt(greenTeam->GetRating()) + ")",
                    GOSSIP_SENDER, itr->first);
            }
            else if (arenaType == ARENA_TYPE_3v3)
            {
                uint8 first = 0;
                uint8 second = 0;
                uint8 third = 0;

                uint8 first2 = 0;
                uint8 second2 = 0;
                uint8 third2 = 0;
                std::string firstName = "?";
                std::string secondName = "?";
                std::string thirdName = "?";
                std::string firstName2 = "?";
                std::string secondName2 = "?";
                std::string thirdName2 = "?";
                std::string firstClass;
                std::string secondClass;
                std::string thirdClass;
                std::string firstClass2;
                std::string secondClass2;
                std::string thirdClass2;
                for (BattleGround::BattleGroundPlayerMap::const_iterator itr2 = bg->GetPlayers().begin(); itr2 != bg->GetPlayers().end(); ++itr2)
                {
                    if (Player *plr = sObjectMgr->GetPlayer(itr2->first))
                    {
                        if (plr->GetArenaTeamId(1) == goldTeam->GetId())
                        {
                            if (first == 0)
                            {
                                first = plr->getClass();
                                firstName = plr->GetName();
                                firstClass = GetClassName(first);
                            }
                            else if (second == 0)
                            {
                                second = plr->getClass();
                                secondName = plr->GetName();
                                secondClass = GetClassName(second);
                            }
                            else if (third == 0)
                            {
                                third = plr->getClass();
                                thirdName = plr->GetName();
                                thirdClass = GetClassName(third);
                            }
                        }
                        else if (plr->GetArenaTeamId(1) == greenTeam->GetId())
                        {
                            if (first2 == 0)
                            {
                                first2 = plr->getClass();
                                firstName2 = plr->GetName();
                                firstClass2 = GetClassName(first2);
                            }
                            else if (second2 == 0)
                            {
                                second2 = plr->getClass();
                                secondName2 = plr->GetName();
                                secondClass2 = GetClassName(second2);
                            }
                            else if (third2 == 0)
                            {
                                third2 = plr->getClass();
                                thirdName2 = plr->GetName();
                                thirdClass2 = GetClassName(third2);
                            }
                        }
                    }
                }

                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, firstName + " " + firstClass + " " + secondName + " " + secondClass + " " + thirdName + " " + thirdClass + " (" + StrToInt(goldTeam->GetRating()) + ") VS " +
                    firstName2 + " " + firstClass2 + " " + secondName2 + " " + secondClass2 + " " + thirdName2 + " " + thirdClass2 +"(" + StrToInt(greenTeam->GetRating()) + ")",
                    GOSSIP_SENDER, itr->first);
            }
            else if (arenaType == ARENA_TYPE_SOLO_3v3)
            {
                // init variables for arena team A
                uint32 teamA = ALLIANCE;
                uint8 plrAOne = 0;
                uint8 plrATwo = 0;
                uint8 plrAThree = 0;
                std::string plrAOneClass = "?";
                std::string plrATwoClass = "?";
                std::string plrAThreeClass = "?";

                // init variables for arena team B
                uint32 teamB = HORDE;
                uint8 plrBOne = 0;
                uint8 plrBTwo = 0;
                uint8 plrBThree = 0;
                std::string plrBOneClass = "?";
                std::string plrBTwoClass = "?";
                std::string plrBThreeClass = "?";

                for (BattleGround::BattleGroundPlayerMap::const_iterator itr2 = bg->GetPlayers().begin(); itr2 != bg->GetPlayers().end(); ++itr2)
                {
                    if (Player *plr = sObjectMgr->GetPlayer(itr2->first))
                    {
                        if (itr2->second.Team == teamA)
                        {
                            if (plrAOne == 0)
                            {
                                plrAOne = plr->getClass();
                                plrAOneClass = GetClassName(plrAOne);
                            }
                            else if (plrATwo == 0)
                            {
                                plrATwo = plr->getClass();
                                plrATwoClass = GetClassName(plrATwo);
                            }
                            else if (plrAThree == 0)
                            {
                                plrAThree = plr->getClass();
                                plrAThreeClass = GetClassName(plrAThree);
                            }
                        }
                        else if (itr2->second.Team == teamB)
                        {
                            if (plrBOne == 0)
                            {
                                plrBOne = plr->getClass();
                                plrBOneClass = GetClassName(plrBOne);
                            }
                            else if (plrBTwo == 0)
                            {
                                plrBTwo = plr->getClass();
                                plrBTwoClass = GetClassName(plrBTwo);
                            }
                            else if (plrBThree == 0)
                            {
                                plrBThree = plr->getClass();
                                plrBThreeClass = GetClassName(plrBThree);
                            }
                        }
                    }
                }
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, plrAOneClass + " " + plrATwoClass + " " + plrAThreeClass + " (" + StrToInt(bg->GetSoloQueueRatingForTeam(ALLIANCE) / 3)  + ") VS " +
                    plrBOneClass + " " + plrBTwoClass + " " + plrBThreeClass + " (" + StrToInt(bg->GetSoloQueueRatingForTeam(HORDE) / 3) + ")",
                    GOSSIP_SENDER, itr->first);
            }
            else
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, goldTeam->GetName() + " (" + StrToInt(goldTeam->GetRating()) + ") VS " +
                greenTeam->GetName() + " (" + StrToInt(greenTeam->GetRating()) + ")",
                GOSSIP_SENDER, itr->first);
            // Looks like: GoldTeamName (rating) VS GreenTeamName (rating)
            roomLeft--;
        }
        itr++;
    }
    if (totalcount > 0)
    {
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "Reload", arenaType, action);
        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, "« Back", 1, 1);
    }

    player->SEND_GOSSIP_MENU(totalcount > 0 ? 66 : 67 ,_Creature->GetGUID());
}

void SendMenu_spectator(Player *player, Creature *_Creature, uint32 action)
{
    if (player->InBattleGroundQueue())
    {
        player->GetSession()->SendNotification("Please leave queue(s) before spectating.");
        player->CLOSE_GOSSIP_MENU();
        return;
    }

    player->CLOSE_GOSSIP_MENU();
    BattleGround *bg = sBattleGroundMgr->GetBattleGround(action);
    if (bg && bg->isArena() && bg->isRated() && bg->GetStatus() == STATUS_IN_PROGRESS && bg->GetPlayersCountByTeam(ALLIANCE) + bg->GetPlayersCountByTeam(HORDE) > 0)
    {
        if (player->IsMounted())
            player->RemoveSpellsCausingAura(SPELL_AURA_MOUNTED);
        bg->AddSpectator(player);
        player->SetBattleGroundId(action);
        player->SetBattleGroundEntryPoint();
        player->setSpectator(true);
        bg->HandlePlayerUnderMap(player); // very cheap but awesome working way to teleport the player to the middle of the bg

        WorldPacket data;
        sBattleGroundMgr->BuildBattleGroundStatusPacket(&data, bg, 0, 0, STATUS_IN_PROGRESS, 0, 0, 0, 0);
        player->GetSession()->SendPacket(&data); // make the client generate a PvP icon on the minimap, allowing the player to leave.
    }
    else
    {
        ChatHandler(player).PSendSysMessage("An error occurred while trying to connect to the game (probably just ended).");
    }
}

bool GossipSelect_spectator(Player *player, Creature *_Creature, uint32 sender, uint32 action)
{
    switch (sender)
    {
        case ARENA_TYPE_2v2:            SendSubMenu_spectator(player, _Creature, sender, action); break;
        case ARENA_TYPE_3v3:            SendSubMenu_spectator(player, _Creature, sender, action); break;
        case ARENA_TYPE_SOLO_3v3:       SendSubMenu_spectator(player, _Creature, sender, action); break;
        case GOSSIP_SENDER:             SendMenu_spectator(player, _Creature, action); break;
    }
    switch (action)
    {
        case 1:
            player->PlayerTalkClass->ClearMenus();
            GossipHello_spectator(player, _Creature);
        break;
    }
    return true;
}

void AddSC_spectator()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name="spectator";
    newscript->pGossipHello = &GossipHello_spectator;
    newscript->pGossipSelect = &GossipSelect_spectator;
    newscript->RegisterSelf();
}
