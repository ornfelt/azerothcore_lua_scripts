#include "ScriptMgr.h"
#include "ScriptedGossip.h"
#include "Player.h"
#include "gridnotifiers.h"
#include "Map.h"

static int WelcomeGossipMenuTextId = 100; // this should be where your realm description lies
static char *ShortCommand = "Talk to the taxi!";


Object *GetClosesObject(Player *p)
{
    std::vector<WorldObject*> targets;
    Trinity::AllWorldObjectsInRange u_check(p, 30);
    Trinity::WorldObjectListSearcher<Trinity::AllWorldObjectsInRange> searcher(p, targets, u_check);
    Cell::VisitAllObjects(p, searcher, 30);

    Object *ret = NULL;
    double BestDist = 999;
    for (auto i = targets.begin(); i != targets.end(); i++)
    {
        if ((*i)->GetGUID().IsCreature() == false && (*i)->GetGUID().IsGameObject() == false)
            continue;
        double CurDist = p->GetDistance((*i));
        if (CurDist < BestDist)
        {
            BestDist = CurDist;
            ret = *i;
        }
    }
    return ret;
}

void PeriodicShowWelcomeMenu(void *p, void *NOTUSED)
{
    Player *Plr = (Player*)p;
    //not active in BG or arena
    if (Plr->FindMap() == NULL)
    {
        return;
    }
    Object *ClosestObject = GetClosesObject(Plr);
    if (ClosestObject == NULL)
        return;
    //this is a non functional menu. Player will not be able to click on any of the options !
    ClearGossipMenuFor(Plr);
    Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, ShortCommand, GOSSIP_SENDER_MAIN, 1, "", 0);
    Plr->PlayerTalkClass->GetGossipMenu().AddMenuItem(-1, GOSSIP_ICON_CHAT, "Stop showing this menu", Plr->GetGUID().GetRawValue(), 2, "", 0); // avoid auto close
    SendGossipMenuFor(Plr, WelcomeGossipMenuTextId, ClosestObject->GetGUID());
}

void PeriodicCheckDisableWelcomeMenu(void *p, void *)
{
    CP_GOSSIP_SELECT *params = PointerCast(CP_GOSSIP_SELECT, p);
    GossipMenu& gossipMenu = params->player->PlayerTalkClass->GetGossipMenu();
    GossipMenuItem const* item = gossipMenu.GetItem(params->gossipListId);
    if (!item)
        return;

    //suicide if we got the proper 
    if (item->Sender == params->player->GetGUID().GetRawValue())
    {
        params->player->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, PeriodicShowWelcomeMenu);
        params->player->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_GOSSIP_SELECT, PeriodicCheckDisableWelcomeMenu);
        CloseGossipMenuFor(params->player);
    }
}

class TC_GAME_API RegisterWelcomeMenuScript : public PlayerScript
{
public:
    RegisterWelcomeMenuScript() : PlayerScript("RegisterWelcomeMenuScript") {}
    void OnLogin(Player* Plr, bool firstLogin)
    {
        //send gossip menu to player. We do not expect any reply
        if (firstLogin == false)
            return;
        // periodically show this menu. Can only be canceled
        Plr->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, PeriodicShowWelcomeMenu);
        Plr->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_GOSSIP_SELECT, PeriodicCheckDisableWelcomeMenu);
    }
};

void ReadLine(FILE *f, char *buff, uint32 MaxLen);
void AddWelcomeMenuScripts()
{
    // INSERT INTO npc_text (id,text0_0) VALUES (102,"Welcome new player. This server has multiple game modes. Please talk to the Taxi NPC to choose between instant 80 with gear or slow leveling and special reward mode");

    //try to open our config file
    FILE *f;
    errno_t t = fopen_s(&f, "WelcomeMenu.txt", "rt");
    if (f)
    {
        uint32 WelcomeGossipMenuTextId2 = 0;
        char MenuTextId[500];
        // what should be the realm description text ID ?
        ReadLine(f, MenuTextId, sizeof(MenuTextId));
        WelcomeGossipMenuTextId2 = atoi(MenuTextId);
        if (WelcomeGossipMenuTextId2 != 0)
            WelcomeGossipMenuTextId = WelcomeGossipMenuTextId2;
        //what should be the 1 line menu text be ?
        ReadLine(f, MenuTextId, sizeof(MenuTextId));
        ShortCommand = strdup(MenuTextId);
        fclose(f);
    }
    new RegisterWelcomeMenuScript();
}
