#include "Player.h"
#include "PersonalInstance.h"
#include "ScriptedGossip.h"
#include "ScriptMgr.h"
#include "CreatureAI.h"
#include "Creature.h"
#include "Map.h"
#include "ObjectExtension.cpp"

#define CREATURE_ENTRY_ASISSTANT        123457  // auto spawn it once we enter our instance

void SpawnAssistant(Player *player, PersonalInstanceStore *Pi)
{
    //sanity checks
    if (player == NULL || player->FindMap() == NULL)
        return;

    uint32 MapId = player->GetMap()->GetId();

    //calculate default positioning for not yet handled maps
    Position pos = player->GetPosition();
    pos.RelocateOffset(Position(2, 2, 0, 0)); // spawn it in front of us
    pos.m_positionZ += 3.0f;    //lift it to avoid falling underground

    //hardcode some of the maps
    if (MapId == ENDURANCE_MAP)
        pos = Position(67.0f, 65.0f, -5.0f, 4.4f);

    Pi->SpawnCreature(player, CREATURE_ENTRY_ASISSTANT, &pos, true, true);
}

void SpawnEnduranceTarget(Player *player);
void FlightToggle(Player *player, bool Enable);
void AddGossipItemForArcemu(Player* player, uint32 icon, std::string const& text, uint32 MenuId);

class PersonalInstanceAssistantNPC : public CreatureScript
{
public:
    PersonalInstanceAssistantNPC() : CreatureScript("PersonalInstanceAssistantNPC") { }

    struct PersonalInstanceAssistantNPCAI : public CreatureAI
    {
        PersonalInstanceAssistantNPCAI(Creature* creature) : CreatureAI(creature) {}
        ~PersonalInstanceAssistantNPCAI()
        {
        }
        void UpdateAI(uint32 diff) override {}//does nothing unless we say so

                                              //construct gossip menu to show to player
        bool GossipHello(Player* Plr)
        {
            if (Plr->GetMap()->GetExtension<int64>(OE_MAP_IS_CUSTOM_INSTANCE) == NULL || *Plr->GetMap()->GetCreateIn64Extension(OE_MAP_IS_CUSTOM_INSTANCE_CREATOR) != (int64)Plr->GetGUID().GetRawValue())
            {
                Plr->BroadcastMessage("Command can only be used in personal instance");
                return true;
            }

            ClearGossipMenuFor(Plr);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, "Start endurance fight", 1);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, "Enable flight", 2);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_BATTLE, "Disable flight", 3);
            AddGossipItemForArcemu(Plr, GOSSIP_ICON_DOT, "Close", 4);
            SendGossipMenuFor(Plr, 3673, me->GetGUID());
            return true;
        }

        //when player clicks on a gossip menu, we call the callback function
        bool GossipSelect(Player* Plr, uint32 menuId, uint32 gossipListId)
        {
            uint32 const IntId = Plr->PlayerTalkClass->GetGossipOptionAction(gossipListId);

            if (IntId == 1)
                SpawnEnduranceTarget(Plr);
            else if (IntId == 2)
                FlightToggle(Plr, true);
            else if (IntId == 3)
                FlightToggle(Plr, false);
            CloseGossipMenuFor(Plr);
            return true;
        }
    };
    CreatureAI* GetAI(Creature* creature) const override
    {
        return new PersonalInstanceAssistantNPCAI(creature);
    }
};

void InitAssistant()
{
    new PersonalInstanceAssistantNPC();
}
