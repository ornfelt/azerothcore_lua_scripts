
#include "StdAfx.h"
#include "Setup.h"

#ifdef WIN32
#pragma warning(disable:4305)        
#endif


class SCRIPT_DECL Morpher : public GossipScript
{
public:
    void GossipHello(Object * pObject, Player* Plr, bool AutoSend);
    void GossipSelectOption(Object * pObject, Player* Plr, uint32 Id, uint32 IntId, const char * Code);
    void GossipEnd(Object * pObject, Player* Plr);
    void Destroy()
    {
    delete this;
    }
};
    void Morpher::GossipHello(Object* pObject, Player * Plr, bool AutoSend)
    {
        GossipMenu *Menu;
        objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 2593, Plr);
        Menu->AddItem(0, "Morph Set 1", 1);
        Menu->AddItem(0, "Morph Set 2", 2);
        Menu->AddItem(0, "Morph Set 3", 3);
        Menu->AddItem(0, "Morph Set 4", 4);
        Menu->AddItem(2, "Demorph", 999);

           if(AutoSend)
            Menu->SendTo(Plr);
    }


//Defining Cases
void Morpher::GossipSelectOption(Object* pObject, Player* Plr, uint32 Id, uint32 IntId, const char * Code)
    {
        GossipMenu * Menu;
        switch(IntId)
        {
     case 1:
        {
            //Morph Set 1
objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 2593, Plr);
    Menu->AddItem(5,"The Ice Dwarf", 501);
    Menu->AddItem(5,"Onyxia", 502);
    Menu->AddItem(5,"Razorgore the Untamed", 503);
    Menu->AddItem(5,"Ebonroc", 504);
    Menu->AddItem(5,"Chromaggus", 505);
    Menu->AddItem(5,"Baron Rivendare", 506);
    Menu->AddItem(5,"Stitched Horror", 507);
    Menu->AddItem(5,"Hive'Zara Wasp", 508);
    Menu->AddItem(5,"Moam", 509);
    Menu->AddItem(5,"Golemagg the Incinerator", 510);
    Menu->AddItem(5,"Hovering Obelisk", 511);
    Menu->AddItem(5,"Blue Dragon", 512);
    Menu->AddItem(5,"Fiery Ghost", 513);
    Menu->AddItem(5,"Rocket Mount", 514);
    Menu->AddItem(5,"Ghostly Gryphon", 515);
    Menu->AddItem(5,"Robot", 516);
    Menu->SendTo(Plr);
}
        break;

     case 2:
        {
            //Morph Set 2
objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 2593, Plr);
    Menu->AddItem(5,"Doomwalker", 601);
    Menu->AddItem(5,"Kael'thas", 602);
    Menu->AddItem(5,"Illidan", 603);
    Menu->AddItem(5,"Dark Illidan", 604);
    Menu->AddItem(5,"Teron Gorefiend", 605);
    Menu->AddItem(5,"Lady VashJ", 606);
    Menu->AddItem(5,"Vazruden The Herald", 607);
    Menu->AddItem(5,"Archimonde", 608);
    Menu->AddItem(5,"Terestian Illhoof", 609);
    Menu->AddItem(5,"The Curator", 610);
    Menu->AddItem(5,"Draenei Phoenix", 611);
    Menu->AddItem(5,"Icy Ragnaros", 612);
    Menu->AddItem(5,"Lava Golem", 613);
    Menu->AddItem(5,"Ghostly Frost Wyrm", 614);
    Menu->AddItem(5,"Dyriad", 615);
    Menu->AddItem(5,"Frog Dragon", 616);
    Menu->SendTo(Plr);
}
        break;
       
     case 3:
        {
            //Morph Set 3
objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 2593, Plr);
    Menu->AddItem(5,"Lich King", 701);
    Menu->AddItem(5,"Lich King (No Helmet)", 702);
    Menu->AddItem(5,"Stone Giant", 703);
    Menu->AddItem(5,"Scourage Zombie", 704);
    Menu->AddItem(5,"Loatheb", 705);
    Menu->AddItem(5,"Gluth", 706);
    Menu->AddItem(5,"Instructor Razuvious", 707);
    Menu->AddItem(5,"Gothik the Harvester", 708);
    Menu->AddItem(5,"Novos the Summoner", 709);
    Menu->AddItem(5,"King Dred", 710);
    Menu->AddItem(5,"Varos Cloudstrider", 711);
    Menu->AddItem(5,"Mom Polar Bear", 712);
    Menu->AddItem(5,"Red Draenei Prince", 713);
    Menu->AddItem(5,"Sand Tower", 714);
    Menu->AddItem(5,"Turkey", 715);
    Menu->SendTo(Plr);
}
        break;

     case 4:
        {
            //Morph Set 4
objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 2593, Plr);
    Menu->AddItem(5,"Spirit Healer", 801);
    Menu->AddItem(5,"Skeleton", 802);
    Menu->AddItem(5,"Infernal", 803);
    Menu->AddItem(5,"Felguard", 804);
    Menu->AddItem(5,"Super Cow", 805);
    Menu->AddItem(5,"Panda", 806);
    Menu->AddItem(5,"Hogger", 807);
    Menu->AddItem(5,"Baby Blizzard Bear (Cute)", 808);
    Menu->AddItem(5,"Mammoth", 809);
    Menu->AddItem(5,"Sand Gnome", 810);
    Menu->AddItem(5,"Female Ghost Angel", 811);
    Menu->AddItem(5,"Clockwork Gnome", 812);
    Menu->AddItem(5,"Frost Nymph", 813);
    Menu->AddItem(5,"Baby Crocodile", 814);
    Menu->SendTo(Plr);
}
        break;

            
        //Ice Giant
        case 501:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24531);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.2);
                Plr->Gossip_Complete();
            }break;
        
        //Onyxia
        case 502:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 8570);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.1);
                Plr->Gossip_Complete();
            }break;
        
        //Razorgore the Untamed
        case 503:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 10115);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                Plr->Gossip_Complete();
            }break;
        
        //Ebonroc
        case 504:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 6377);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.3);
                Plr->Gossip_Complete();
            }break;
        
        
        //Chromaggus
        case 505:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 14367);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.2);
                Plr->Gossip_Complete();
            }break;
        
        //Baron Rivendare
        case 506:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 6380);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
        //Stitched Horror
        case 507:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 1693);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
        //Hive'Zara Wasp
        case 508:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 11142);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
        //Moam
        case 509:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 15392);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.3);
                Plr->Gossip_Complete();
            }break;
        
        //Golemagg the Incinerator
        case 510:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 11986);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.2);
                Plr->Gossip_Complete();
            }break;

        //Hovering Obelisk
        case 511:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24470);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                Plr->Gossip_Complete();
            }break;

        //Blue Dragon
        case 512:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24620);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 2.5);
                Plr->Gossip_Complete();
            }break;

        //Fiery Ghost
        case 513:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24905);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;

        //Rocket Mount
        case 514:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24710);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;

        //Ghost Gryphon
        case 515:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24447);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;

        //Robot
        case 516:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 23411);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                Plr->Gossip_Complete();
            }break;

        //Baby Crocodile
        case 814:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 23495);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
        //Doomwalker
        case 601:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 21435);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.2);
                Plr->Gossip_Complete();
            }break;
        
        //Kael'thas
        case 602:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 20023);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                Plr->Gossip_Complete();
            }break;
        
        //Illidan
        case 603:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 21135);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.3);
                Plr->Gossip_Complete();
            }break;
        
        //Dark Illidan
        case 604:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 21322);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.1);
                Plr->Gossip_Complete();
            }break;
        
        //Teron Gorefiend - shows as an orc for some reason, display ID is right.
        case 605:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 21254);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                Plr->Gossip_Complete();
            }break;
        
        //Lady VashJ
        case 606:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 20748);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                Plr->Gossip_Complete();
            }break;
        
        //Vazruden The Herald
        case 607:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 18944);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.3);
                Plr->Gossip_Complete();
            }break;
        
        //Archimonde
        case 608:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 20939);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.1);
                Plr->Gossip_Complete();
            }break;
        
        //Terestian Illhoof
        case 609:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 11343);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.6);
                Plr->Gossip_Complete();
            }break;
        
        //The Curator
        case 610:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 16958);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.2);
                Plr->Gossip_Complete();
            }break;
        
            //Draenei Phoenix
        case 611:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 23523);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 3.0);
                Plr->Gossip_Complete();
            }break;
        
            //Icy Ragnaros
        case 612:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 23707);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.2);
                Plr->Gossip_Complete();
            }break;
        
            //Lava Golem
        case 613:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 23817);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.8);
                Plr->Gossip_Complete();
            }break;
        
            //Ghostly Frost Wyrm
        case 614:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 23315);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                Plr->Gossip_Complete();
            }break;
        
            //Dyriad
        case 615:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 25082);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
            //Frog Dragon
        case 616:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 23351);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
            //Turkey
        case 715:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 21774);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 3.0);
                Plr->Gossip_Complete();
            }break;
        
        //Lich King
        case 701:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 22234);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.7);
                Plr->Gossip_Complete();
            }break;
        
        //Lich King (NO HELM)
        case 702:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 22235);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.7);
                Plr->Gossip_Complete();
            }break;
        
        //Stone Giant
        case 703:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 23356);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.4);
                Plr->Gossip_Complete();
            }break;
        
        //Scourage Zombie
        case 704:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24992);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
        //Loatheb
        case 705:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 16110);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.3);
                Plr->Gossip_Complete();
            }break;
        
        //Gluth
        case 706:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 16064);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.2);
                Plr->Gossip_Complete();
            }break;
        
        //Instructor Razuvious
        case 707:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 16582);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.7);
                Plr->Gossip_Complete();
            }break;
        
        //Gothik the Harvester
        case 708:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 16279);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.4);
                Plr->Gossip_Complete();
            }break;
        
        //Novos the Summoner
        case 709:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 26292);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.3);
                Plr->Gossip_Complete();
            }break;
        
        
        //King Dred
        case 710:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 5240);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.2);
                Plr->Gossip_Complete();
            }break;

        
        //Varos Cloudstrider
        case 711:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 27033);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.3);
                Plr->Gossip_Complete();
            }break;
        
            //Mom Polar Bear
        case 712:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 22708);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
            //Red Draenei Prince
        case 713:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 23334);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.6);
                Plr->Gossip_Complete();
            }break;
        
            //Sand Tower
        case 714:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24868);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
        //Spirit Healer
        case 801:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 5233);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.4);
                Plr->Gossip_Complete();
            }break;
        
        //Skeleton
        case 802:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 17970);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.6);
                Plr->Gossip_Complete();
            }break;
        
        //Infernal
        case 803:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 169);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.7);
                Plr->Gossip_Complete();
            }break;
        
        //Felguard
        case 804:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 14152);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                Plr->Gossip_Complete();
            }break;
        
        //Super Cow
        case 805:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 1060);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
        //Panda
        case 806:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 10990);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 5.0);
                Plr->Gossip_Complete();
            }break;
        
        //Hogger
        case 807:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 384);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
        //Blizzard Bear
        case 808:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 16189);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 3.0);
                Plr->Gossip_Complete();
            }break;
        
        //Mammoth
        case 809:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 27235);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.5);
                Plr->Gossip_Complete();
            }break;
        
            //Sand Gnome
        case 810:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 21027);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 2.5);
                Plr->Gossip_Complete();
            }break;
        
            //Female Ghost Angel
        case 811:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 25517);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        
            //Clockwork Gnome
        case 812:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24111);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 3.0);
                Plr->Gossip_Complete();
            }break;
        
            //Frost Nymph
        case 813:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 24072);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 0.6);
                Plr->Gossip_Complete();
            }break;
        
        //Demorph
        case 999:
            {
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->DeMorph();
                Plr->SetFloatValue(OBJECT_FIELD_SCALE_X, 1.0);
                Plr->Gossip_Complete();
            }break;
        }
};
 


void Morpher::GossipEnd(Object * pObject, Player* Plr)
{
GossipScript::GossipEnd(pObject, Plr);
}

void SetupMorpher(ScriptMgr * mgr)
{
GossipScript * gs = (GossipScript*) new Morpher();
mgr->register_item_gossip_script(99999,gs);
}
