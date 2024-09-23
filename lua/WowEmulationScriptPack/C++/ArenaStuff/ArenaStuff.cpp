#include "ScriptPCH.h"
 
class ArenaClickables : public PlayerScript
{
public:
    ArenaClickables() : PlayerScript("ArenaClickables") { }
 
    void OnUpdateZone(Player* player, uint32 zone, uint32 area)
    {
        if (!sWorld->getBoolConfig(CUSTOM_SCRIPTS_ENABLED_OR_NOT))
            return;

        uint32 entry = 0;
        if (player->getClass() == CLASS_MAGE)
            entry = 193061;
        if (player->getClass() == CLASS_WARLOCK)
            entry = 193169;
 
        if (!entry)
            return;
 
        if (zone == 3698 ||
            zone == 3702 ||
            zone == 4378 ||
            zone == 3968 ||
            zone == 4406)
        {
            if (player->FindNearestGameObject(entry, SIZE_OF_GRIDS))
                return;
 
            float x, y, z, ang;
            player->GetPosition(x, y, z, ang);
            z = player->GetMap()->GetHeight(player->GetPhaseMask(), x, y, z);
            float rot2 = std::sin(ang / 2);
            float rot3 = std::cos(ang / 2);

			player->SummonGameObject(entry, x, y + (entry == 193061 ? 1 : -1), z, ang, 0, 0, rot2, rot3, 60);
        }
    }
};

void AddSC_ArenaClickables()
{
    new ArenaClickables;
}