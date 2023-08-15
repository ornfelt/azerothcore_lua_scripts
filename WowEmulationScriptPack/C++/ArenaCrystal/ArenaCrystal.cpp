#include "ScriptPCH.h"
#include "Player.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"

class Arena_Crystal : public GameObjectScript
{
public:
    Arena_Crystal() : GameObjectScript("Arena_Crystal") { }

    bool OnGossipHello(Player* player, GameObject* go)
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return false;

        if (Battleground *bg = player->GetBattleground())
            if (bg->isArena())
            {
                bg->ClickFastStart(player, go);
                return true;
            }
        return false;
    }
};

void AddSC_Arena_Crystal()
{
    new Arena_Crystal();
}