#include "ScriptPCH.h" 
#include "Pet.h"
#include "Language.h"

class npc_trainer : public CreatureScript
{
public:
  npc_trainer() : CreatureScript("npc_trainer") { }

  bool OnGossipHello(Player* player, Creature* creature)
  {
      if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

    player->ADD_GOSSIP_ITEM(3, "|TInterface\\icons\\inv_misc_book_11:40:40:-18:0|t|r Train me / Max out skills", GOSSIP_SENDER_MAIN, 1);
    player->ADD_GOSSIP_ITEM(1, "|TInterface\\icons\\trade_engineering:40:40:-18:0|t|rReset Talents", GOSSIP_SENDER_MAIN, 3);
    if(player->getClass() == CLASS_HUNTER) 
        player->ADD_GOSSIP_ITEM(1, "|TInterface\\icons\\trade_engineering:40:40:-18:0|t|rReset |cffFF0000PET|r Talents", GOSSIP_SENDER_MAIN, 4);
    // @todo: player->ADD_GOSSIP_ITEM(1, "|TInterface\\icons\\inv_glyph_majorpaladin:40:40:-18:0|t|rGlyph Vendor.", GOSSIP_SENDER_MAIN, 2);
    player->SEND_GOSSIP_MENU(1, creature->GetGUID());
    return true;
  }

  bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
  {
    player->PlayerTalkClass->ClearMenus();
    
    if (sender == GOSSIP_SENDER_MAIN)
    {
      switch (action)
      {
      case 1: // Train Me.
        player->CastSpell(player,63680,true,NULL,NULL,player->GetGUID());
        player->CastSpell(player,63624,true,NULL,NULL,player->GetGUID());

        switch(player->getClass())
        {
        case CLASS_WARRIOR:
          player->learnSpell(264);
          player->learnSpell(5011);
          player->learnSpell(15590);
          player->learnSpell(266);
          player->learnSpell(200);
          player->learnSpell(227);
          player->learnSpell(199);
          player->UpdateSkillsToMaxSkillsForLevel();

          player->learnSpell(7384);
          player->learnSpell(47436);
          player->learnSpell(47450);
          player->learnSpell(11578);
          player->learnSpell(47465);
          player->learnSpell(47502);
          player->learnSpell(34428);
          player->learnSpell(1715);
          player->learnSpell(2687);
          player->learnSpell(71);
          player->learnSpell(7386);
          player->learnSpell(355);
          player->learnSpell(72);
          player->learnSpell(47437);
          player->learnSpell(57823);
          player->learnSpell(694);
          player->learnSpell(2565);
          player->learnSpell(676);
          player->learnSpell(47520);
          player->learnSpell(20230);
          player->learnSpell(12678);
          player->learnSpell(47471);
          player->learnSpell(1161);
          player->learnSpell(871);
          player->learnSpell(2458);
          player->learnSpell(20252);
          player->learnSpell(47475);
          player->learnSpell(18499);
          player->learnSpell(1680);
          player->learnSpell(6552);
          player->learnSpell(47488);
          player->learnSpell(1719);
          player->learnSpell(23920);
          player->learnSpell(47440);
          player->learnSpell(3411);
          player->learnSpell(64382);
          player->learnSpell(55694);
          player->learnSpell(57755);
          player->learnSpell(42459);
          player->learnSpell(750);
          player->learnSpell(5246);
          player->learnSpell(3127);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->HasSpell(12294)) 
            player->learnSpell(47486);
          if(player->HasSpell(20243)) 
            player->learnSpell(47498);
          player->SEND_GOSSIP_MENU(1, creature->GetGUID());
          player->PlayerTalkClass->SendCloseGossip();
          break;

        case CLASS_PALADIN:
          player->learnSpell(196);
          player->learnSpell(200);
          player->learnSpell(197);
          player->learnSpell(199);
          player->UpdateSkillsToMaxSkillsForLevel();

          player->learnSpell(3127);
          player->learnSpell(19746);
          player->learnSpell(19752);
          player->learnSpell(750);
          player->learnSpell(48942);
          player->learnSpell(48782);
          player->learnSpell(48932);
          player->learnSpell(20271);
          player->learnSpell(498);
          player->learnSpell(10308);
          player->learnSpell(1152);
          player->learnSpell(10278);
          player->learnSpell(48788);
          player->learnSpell(53408);
          player->learnSpell(48950);
          player->learnSpell(48936);
          player->learnSpell(31789);
          player->learnSpell(62124);
          player->learnSpell(54043);
          player->learnSpell(25780);
          player->learnSpell(1044);
          player->learnSpell(20217);
          player->learnSpell(48819);
          player->learnSpell(48801);
          player->learnSpell(48785);
          player->learnSpell(5502);
          player->learnSpell(20164);
          player->learnSpell(10326);
          player->learnSpell(1038);
          player->learnSpell(53407);
          player->learnSpell(48943);
          player->learnSpell(20165);
          player->learnSpell(48945);
          player->learnSpell(642);
          player->learnSpell(48947);
          player->learnSpell(20166);
          player->learnSpell(4987);
          player->learnSpell(48806);
          player->learnSpell(6940);
          player->learnSpell(48817);
          player->learnSpell(48934);
          player->learnSpell(48938);
          player->learnSpell(25898);
          player->learnSpell(32223);
          player->learnSpell(31884);
          player->learnSpell(54428);
          player->learnSpell(61411);
          player->learnSpell(53601);
          player->learnSpell(33388);
          player->learnSpell(33391);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->HasSpell(20925)) 
            player->learnSpell(48952);
          if(player->HasSpell(31935)) 
            player->learnSpell(48827);
          if(player->HasSpell(20911)) 
            player->learnSpell(25899); 
          if(player->HasSpell(20473)) 
            player->learnSpell(48825);
          if(player->GetTeamId() == ALLIANCE)
          {
            player->learnSpell(31801); 
            player->learnSpell(13819); 
            player->learnSpell(23214); 
          }
          if(player->GetTeamId() == HORDE)
          {
            player->learnSpell(53736); 
            player->learnSpell(34769); 
            player->learnSpell(34767); 
          }
          
          player->SEND_GOSSIP_MENU(1, creature->GetGUID());
          player->PlayerTalkClass->SendCloseGossip();
          break;

        case CLASS_HUNTER:
          player->learnSpell(5011);
          player->learnSpell(15590);
          player->learnSpell(266);
          player->learnSpell(200);
          player->learnSpell(227);
          player->learnSpell(2567);
          player->learnSpell(202);
          player->UpdateSkillsToMaxSkillsForLevel();
          
          player->learnSpell(3043);
          player->learnSpell(3127);
          player->learnSpell(3045);
          player->learnSpell(3034);
          player->learnSpell(8737);
          player->learnSpell(1494);
          player->learnSpell(13163);
          player->learnSpell(48996);
          player->learnSpell(49001);
          player->learnSpell(49045);
          player->learnSpell(53338);
          player->learnSpell(5116);
          player->learnSpell(27044);
          player->learnSpell(883);
          player->learnSpell(2641);
          player->learnSpell(6991);
          player->learnSpell(982);
          player->learnSpell(1515);
          player->learnSpell(19883);
          player->learnSpell(20736);
          player->learnSpell(48990);
          player->learnSpell(2974);
          player->learnSpell(6197);
          player->learnSpell(1002);
          player->learnSpell(14327);
          player->learnSpell(5118);
          player->learnSpell(49056);
          player->learnSpell(53339);
          player->learnSpell(49048);
          player->learnSpell(19884);
          player->learnSpell(34074);
          player->learnSpell(781);
          player->learnSpell(14311);
          player->learnSpell(1462);
          player->learnSpell(19885);
          player->learnSpell(19880);
          player->learnSpell(13809);
          player->learnSpell(13161);
          player->learnSpell(5384);
          player->learnSpell(1543);
          player->learnSpell(19878);
          player->learnSpell(49067);
          player->learnSpell(3034);
          player->learnSpell(13159);
          player->learnSpell(19882);
          player->learnSpell(58434);
          player->learnSpell(49071);
          player->learnSpell(49052);
          player->learnSpell(19879);
          player->learnSpell(19263);
          player->learnSpell(19801);
          player->learnSpell(34026);
          player->learnSpell(34600);
          player->learnSpell(34477);
          player->learnSpell(61006);
          player->learnSpell(61847);
          player->learnSpell(53271);
          player->learnSpell(60192);
          player->learnSpell(62757);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->HasSpell(19386)) 
            player->learnSpell(49012);
          if(player->HasSpell(53301)) 
            player->learnSpell(60053);
          if(player->HasSpell(19306)) 
            player->learnSpell(48999);
          if(player->HasSpell(19434)) 
            player->learnSpell(49050);
          
          player->SEND_GOSSIP_MENU(1, creature->GetGUID());
          player->PlayerTalkClass->SendCloseGossip();
          break;

        case CLASS_MAGE:
          player->learnSpell(1180);
          player->learnSpell(201);
          player->UpdateSkillsToMaxSkillsForLevel();

          player->learnSpell(42921);
          player->learnSpell(42842);
          player->learnSpell(42995);
          player->learnSpell(42833);
          player->learnSpell(27090);
          player->learnSpell(33717);
          player->learnSpell(42873);
          player->learnSpell(42846);
          player->learnSpell(12826);
          player->learnSpell(28271);
          player->learnSpell(61780);
          player->learnSpell(61721);
          player->learnSpell(28272);
          player->learnSpell(42917);
          player->learnSpell(43015);
          player->learnSpell(130);
          player->learnSpell(42926);
          player->learnSpell(43017);
          player->learnSpell(475);
          player->learnSpell(1953);
          player->learnSpell(42940);
          player->learnSpell(12051);
          player->learnSpell(43010);
          player->learnSpell(43020);
          player->learnSpell(43012);
          player->learnSpell(42859);
          player->learnSpell(2139);
          player->learnSpell(42931);
          player->learnSpell(42985);
          player->learnSpell(43008);
          player->learnSpell(45438);
          player->learnSpell(43024);
          player->learnSpell(43002);
          player->learnSpell(43046);
          player->learnSpell(42897);
          player->learnSpell(42914);
          player->learnSpell(66);
          player->learnSpell(58659);
          player->learnSpell(30449);
          player->learnSpell(42956);
          player->learnSpell(47610);
          player->learnSpell(61316);
          player->learnSpell(61024);
          player->learnSpell(55342);
          player->learnSpell(53142);
          player->learnSpell(7301);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->GetTeamId() == ALLIANCE)
          {
            player->learnSpell(32271); // Teleport: Exodar.
            player->learnSpell(49359); // Teleport: Theramore.
            player->learnSpell(3565); // Teleport: Darnassus.
            player->learnSpell(33690); // Teleport: Shattrath.
            player->learnSpell(3562); // Teleport: Ironforge.
            player->learnSpell(3561); // Teleport: Stormwind.
            player->learnSpell(53140); // Teleport: Dalaran.
            player->learnSpell(53142); // Portal: Dalaran.
            player->learnSpell(10059); // Portal: Stormwind.
            player->learnSpell(11419); // Portal: Darnassus.
            player->learnSpell(32266); // Portal: Exodar.
            player->learnSpell(11416); // Portal: Ironforge.
            player->learnSpell(33691); // Portal: Shattrath.
            player->learnSpell(49360); // Portal: Theramore.
          }
          if(player->GetTeamId() == HORDE)
          {
            player->learnSpell(3567); // Teleport: Orgrimmar.
            player->learnSpell(35715); // Teleport: Shattrath.
            player->learnSpell(3566); // Teleport: Thunder Bluff.
            player->learnSpell(49358); // Teleport: Stonard.
            player->learnSpell(32272); // Teleport: Silvermoon.
            player->learnSpell(3563); // Teleport: Undercity.
            player->learnSpell(53140); // Teleport: Dalaran.
            player->learnSpell(53142); // Portal: Dalaran.
            player->learnSpell(11417); // Portal: Orgrimmar.
            player->learnSpell(35717); // Portal: Shattrath.
            player->learnSpell(32267); // Portal: Silvermoon.
            player->learnSpell(49361); // Portal: Stonard.
            player->learnSpell(11420); // Portal: Thunder Bluff.
            player->learnSpell(11418); // Portal: Undercity.
          }
          if(player->HasSpell(11366)) 
            player->learnSpell(42891);
          if(player->HasSpell(11426)) 
            player->learnSpell(43039);
          if(player->HasSpell(44457)) 
            player->learnSpell(55360);
          if(player->HasSpell(31661)) 
            player->learnSpell(42950);
          if(player->HasSpell(11113)) 
            player->learnSpell(42945);
          if(player->HasSpell(44425)) 
            player->learnSpell(44781);
          
          player->PlayerTalkClass->SendCloseGossip();
          break;

        case CLASS_WARLOCK:
          player->learnSpell(201);
          player->UpdateSkillsToMaxSkillsForLevel();

          player->learnSpell(696);
          player->learnSpell(47811);
          player->learnSpell(47809);
          player->learnSpell(688);
          player->learnSpell(47813);
          player->learnSpell(50511);
          player->learnSpell(57946);
          player->learnSpell(47864);
          player->learnSpell(6215);
          player->learnSpell(47878);
          player->learnSpell(47855);
          player->learnSpell(697);
          player->learnSpell(47856);
          player->learnSpell(47857);
          player->learnSpell(5697);
          player->learnSpell(47884);
          player->learnSpell(47815);
          player->learnSpell(47889);
          player->learnSpell(47820);
          player->learnSpell(698);
          player->learnSpell(712);
          player->learnSpell(126);
          player->learnSpell(5138);
          player->learnSpell(5500);
          player->learnSpell(11719);
          player->learnSpell(132);
          player->learnSpell(60220);
          player->learnSpell(18647);
          player->learnSpell(61191);
          player->learnSpell(47823);
          player->learnSpell(691);
          player->learnSpell(47865);
          player->learnSpell(47891);
          player->learnSpell(47888);
          player->learnSpell(17928);
          player->learnSpell(47860);
          player->learnSpell(47825);
          player->learnSpell(1122);
          player->learnSpell(47867);
          player->learnSpell(18540);
          player->learnSpell(47893);
          player->learnSpell(47838);
          player->learnSpell(29858);
          player->learnSpell(58887);
          player->learnSpell(47836);
          player->learnSpell(61290);
          player->learnSpell(48018);
          player->learnSpell(48020);
          player->learnSpell(33388);
          player->learnSpell(33391);
          player->learnSpell(23161);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->HasSpell(17877)) 
            player->learnSpell(47827);
          if(player->HasSpell(30283)) 
            player->learnSpell(47847);
          if(player->HasSpell(30108)) 
            player->learnSpell(47843);
          if(player->HasSpell(50796)) 
            player->learnSpell(59172);
          if(player->HasSpell(48181)) 
            player->learnSpell(59164);
          if(player->HasSpell(18220)) 
            player->learnSpell(59092);
          
          player->PlayerTalkClass->SendCloseGossip();
          break;

        case CLASS_ROGUE:
          player->learnSpell(196);
          player->learnSpell(264);
          player->learnSpell(5011);
          player->learnSpell(15590);
          player->learnSpell(266);
          player->learnSpell(198);
          player->learnSpell(201);
          player->UpdateSkillsToMaxSkillsForLevel();

          player->learnSpell(3127);
          player->learnSpell(42459);
          player->learnSpell(48668);
          player->learnSpell(48638);
          player->learnSpell(1784);
          player->learnSpell(48657);
          player->learnSpell(921);
          player->learnSpell(1776);
          player->learnSpell(26669);
          player->learnSpell(51724);
          player->learnSpell(6774);
          player->learnSpell(11305);
          player->learnSpell(1766);
          player->learnSpell(48676);
          player->learnSpell(48659);
          player->learnSpell(1804);
          player->learnSpell(8647);
          player->learnSpell(48691);
          player->learnSpell(51722);
          player->learnSpell(48672);
          player->learnSpell(1725);
          player->learnSpell(26889);
          player->learnSpell(2836);
          player->learnSpell(1833);
          player->learnSpell(1842);
          player->learnSpell(8643);
          player->learnSpell(2094);
          player->learnSpell(1860);
          player->learnSpell(57993);
          player->learnSpell(48674);
          player->learnSpell(31224);
          player->learnSpell(5938);
          player->learnSpell(57934);
          player->learnSpell(51723);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->HasSpell(16511)) 
            player->learnSpell(48660);
          if(player->HasSpell(1329)) 
            player->learnSpell(48666);
          
          player->PlayerTalkClass->SendCloseGossip();
          break;

        case CLASS_PRIEST:
          player->learnSpell(1180);
          player->UpdateSkillsToMaxSkillsForLevel();

          player->learnSpell(528);
          player->learnSpell(2053);
          player->learnSpell(48161);
          player->learnSpell(48123);
          player->learnSpell(48125);
          player->learnSpell(48066);
          player->learnSpell(586);
          player->learnSpell(48068);
          player->learnSpell(48127);
          player->learnSpell(48171);
          player->learnSpell(48168);
          player->learnSpell(10890);
          player->learnSpell(6064);
          player->learnSpell(988);
          player->learnSpell(48300);
          player->learnSpell(6346);
          player->learnSpell(48071);
          player->learnSpell(48135);
          player->learnSpell(48078);
          player->learnSpell(453);
          player->learnSpell(10955);
          player->learnSpell(10909);
          player->learnSpell(8129);
          player->learnSpell(48073);
          player->learnSpell(605);
          player->learnSpell(48072);
          player->learnSpell(48169);
          player->learnSpell(552);
          player->learnSpell(1706);
          player->learnSpell(48063);
          player->learnSpell(48162);
          player->learnSpell(48170);
          player->learnSpell(48074);
          player->learnSpell(48158);
          player->learnSpell(48120);
          player->learnSpell(34433);
          player->learnSpell(48113);
          player->learnSpell(32375);
          player->learnSpell(64843);
          player->learnSpell(64901);
          player->learnSpell(53023);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->HasSpell(34914)) 
            player->learnSpell(48160);
          if(player->HasSpell(47540)) 
            player->learnSpell(53007);
          if(player->HasSpell(724)) 
            player->learnSpell(48087);
          if(player->HasSpell(19236)) 
            player->learnSpell(48173);
          if(player->HasSpell(34861)) 
            player->learnSpell(48089);
          if(player->HasSpell(15407)) 
            player->learnSpell(48156);
          
          player->PlayerTalkClass->SendCloseGossip();
          break;

        case CLASS_DEATH_KNIGHT:
          player->learnSpell(198);
          player->learnSpell(199);
          player->UpdateSkillsToMaxSkillsForLevel();

          player->learnSpell(3127);
          player->learnSpell(50842);
          player->learnSpell(49941);
          player->learnSpell(49930);
          player->learnSpell(47476);
          player->learnSpell(45529);
          player->learnSpell(3714);
          player->learnSpell(56222);
          player->learnSpell(48743);
          player->learnSpell(48263);
          player->learnSpell(49909);
          player->learnSpell(47528);
          player->learnSpell(45524);
          player->learnSpell(48792);
          player->learnSpell(57623);
          player->learnSpell(56815);
          player->learnSpell(47568);
          player->learnSpell(49895);
          player->learnSpell(50977);
          player->learnSpell(49576);
          player->learnSpell(49921);
          player->learnSpell(46584);
          player->learnSpell(49938);
          player->learnSpell(48707);
          player->learnSpell(48265);
          player->learnSpell(61999);
          player->learnSpell(42650);
          player->learnSpell(53428);
          player->learnSpell(53331);
          player->learnSpell(54447);
          player->learnSpell(53342);
          player->learnSpell(54446);
          player->learnSpell(53323);
          player->learnSpell(53344);
          player->learnSpell(70164);
          player->learnSpell(62158);
          player->learnSpell(33391);
          player->learnSpell(48778);
          player->learnSpell(51425);
          player->learnSpell(49924);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->HasSpell(55050)) 
            player->learnSpell(55262);
          if(player->HasSpell(49143)) 
            player->learnSpell(55268);
          if(player->HasSpell(49184)) 
            player->learnSpell(51411);
          if(player->HasSpell(55090)) 
            player->learnSpell(55271);
          if(player->HasSpell(49158)) 
            player->learnSpell(51328);
          
          player->PlayerTalkClass->SendCloseGossip();
          break;

        case CLASS_SHAMAN:
          player->learnSpell(196);
          player->learnSpell(1180);
          player->learnSpell(15590);
          player->learnSpell(197);
          player->learnSpell(199);
          player->UpdateSkillsToMaxSkillsForLevel();

          player->learnSpell(2062);
          player->learnSpell(8737);
          player->learnSpell(49273);
          player->learnSpell(49238);
          player->learnSpell(10399);
          player->learnSpell(49231);
          player->learnSpell(58753);
          player->learnSpell(2484);
          player->learnSpell(49281);
          player->learnSpell(58582);
          player->learnSpell(49233);
          player->learnSpell(58790);
          player->learnSpell(58704);
          player->learnSpell(58643);
          player->learnSpell(49277);
          player->learnSpell(61657);
          player->learnSpell(8012);
          player->learnSpell(526);
          player->learnSpell(2645);
          player->learnSpell(57994);
          player->learnSpell(8143);
          player->learnSpell(49236);
          player->learnSpell(58796);
          player->learnSpell(58757);
          player->learnSpell(49276);
          player->learnSpell(57960);
          player->learnSpell(131);
          player->learnSpell(58745);
          player->learnSpell(6196);
          player->learnSpell(58734);
          player->learnSpell(58774);
          player->learnSpell(58739);
          player->learnSpell(58656);
          player->learnSpell(546);
          player->learnSpell(556);
          player->learnSpell(66842);
          player->learnSpell(51994);
          player->learnSpell(8177);
          player->learnSpell(58749);
          player->learnSpell(20608);
          player->learnSpell(36936);
          player->learnSpell(36936);
          player->learnSpell(58804);
          player->learnSpell(49271);
          player->learnSpell(8512);
          player->learnSpell(6495);
          player->learnSpell(8170);
          player->learnSpell(66843);
          player->learnSpell(55459);
          player->learnSpell(66844);
          player->learnSpell(3738);
          player->learnSpell(2894);
          player->learnSpell(60043);
          player->learnSpell(51514);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->GetTeamId() == ALLIANCE)
            player->learnSpell(32182);
          if(player->GetTeamId() == HORDE)
            player->learnSpell(2825); 
          if(player->HasSpell(61295)) 
            player->learnSpell(61301);
          if(player->HasSpell(974)) 
            player->learnSpell(49284);
          if(player->HasSpell(30706)) 
            player->learnSpell(57722);
          if(player->HasSpell(51490)) 
            player->learnSpell(59159);
          
          player->PlayerTalkClass->SendCloseGossip();
          break;

        case CLASS_DRUID:
          player->learnSpell(1180);
          player->learnSpell(15590);
          player->learnSpell(200);
          player->learnSpell(199);
          player->UpdateSkillsToMaxSkillsForLevel();

          player->learnSpell(48378);
          player->learnSpell(48469);
          player->learnSpell(48461);
          player->learnSpell(48463);
          player->learnSpell(48441);
          player->learnSpell(53307);
          player->learnSpell(53308);
          player->learnSpell(5487);
          player->learnSpell(48560);
          player->learnSpell(6795);
          player->learnSpell(48480);
          player->learnSpell(53312);
          player->learnSpell(18960);
          player->learnSpell(5229);
          player->learnSpell(48443);
          player->learnSpell(50763);
          player->learnSpell(8983);
          player->learnSpell(8946);
          player->learnSpell(1066);
          player->learnSpell(48562);
          player->learnSpell(783);
          player->learnSpell(770);
          player->learnSpell(16857);
          player->learnSpell(18658);
          player->learnSpell(768);
          player->learnSpell(1082);
          player->learnSpell(16979);
          player->learnSpell(49376);
          player->learnSpell(5215);
          player->learnSpell(48477);
          player->learnSpell(49800);
          player->learnSpell(48465);
          player->learnSpell(48572);
          player->learnSpell(26995);
          player->learnSpell(48574);
          player->learnSpell(2782);
          player->learnSpell(50213);
          player->learnSpell(2893);
          player->learnSpell(33357);
          player->learnSpell(5209);
          player->learnSpell(48575);
          player->learnSpell(48447);
          player->learnSpell(48577);
          player->learnSpell(48579);
          player->learnSpell(5225);
          player->learnSpell(22842);
          player->learnSpell(49803);
          player->learnSpell(9634);
          player->learnSpell(20719);
          player->learnSpell(48467);
          player->learnSpell(29166);
          player->learnSpell(62600);
          player->learnSpell(22812);
          player->learnSpell(48470);
          player->learnSpell(48564);
          player->learnSpell(48566);
          player->learnSpell(33943);
          player->learnSpell(49802);
          player->learnSpell(48451);
          player->learnSpell(48568);
          player->learnSpell(33786);
          player->learnSpell(40120);
          player->learnSpell(62078);
          player->learnSpell(52610);
          player->learnSpell(50464);
          player->learnSpell(48570);
          player->learnSpell(34093);
          player->learnSpell(33392);
          if(player->HasSpell(50516)) 
            player->learnSpell(61384);
          if(player->HasSpell(48505)) 
            player->learnSpell(53201);
          if(player->HasSpell(48438)) 
            player->learnSpell(53251);
          if(player->HasSpell(5570)) 
            player->learnSpell(48468);
          
          player->PlayerTalkClass->SendCloseGossip();
          break;
        }
        break;

        case 2: // Glyph Vendor.
          break;
        case 3:
                player->resetTalents();
                player->SendTalentsInfoData(false);
            break;
        case 4:
            if(Pet * petche = player->ToPet())
            {
                player->SendTalentsInfoData(true);
                Pet::resetTalentsForAllPetsOf(player, petche);
            }
            break;
        }
            }
      return true;
  }
};

void AddSC_OneClickTrainerNPC()
{
    new npc_trainer; 
}
