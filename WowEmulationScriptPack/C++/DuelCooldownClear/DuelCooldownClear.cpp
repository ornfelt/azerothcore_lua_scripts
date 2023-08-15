#include "ScriptMgr.h"
#include "ObjectExtension.cpp"
#include "Player.h"
#include "Spell.h"
#include "SpellInfo.h"
#include "SpellHistory.h"
#include "GameObject.h"
#include "Map.h"
#include "SpellMgr.h"

//#define MOVE_DUEL_TO_NEW_PHASE  // tis removes summons, so it's a nono until summons get moved also

class DuelSpellsStore
{
public:
    DuelSpellsStore()
    {
        IsDueling = false;
    }

    void OnDuelStart(Player *player, uint32 PhaseMask)
    {
        Spells.clear();
        StartHP = player->GetHealth();
        StartPower = player->GetPower(player->GetPowerType());
#ifdef MOVE_DUEL_TO_NEW_PHASE
        PrevPhaseMask = player->GetPhaseMask();

        GameObject* obj = player->GetMap()->GetGameObject(player->GetGuidValue(PLAYER_DUEL_ARBITER));
        if(obj)
            obj->SetPhaseMask(PhaseMask, true);
        player->SetPhaseMask(PhaseMask, true);
#endif
        IsDueling = true;
    }

    void OnCast(uint32 SpellId)
    {
        if(IsDueling)
            Spells.insert(SpellId);
    }

    void OnDuelEnd(Player *p)
    {
        //clear cooldown for each spell casted in duel
        for (std::set<uint32>::iterator i = Spells.begin(); i != Spells.end(); i++)
            if(p->GetSpellHistory()->GetRemainingCooldown(sSpellMgr->AssertSpellInfo(*i)) < 15 * 50 * 1000) // only clear spell cooldowns that are smaller than 15 minutes. Avoid strangely large spell cooldown reset abuse
            {
                p->GetSpellHistory()->ResetCooldown(*i, true);
                //double check ? Back in the days cooldown hystory bugged out sometimes
                WorldPacket data(SMSG_CLEAR_COOLDOWN, 4 + 8);
                data << uint32(*i);
                data << uint64(p->GetGUID());
                p->SendDirectMessage(&data);
            }
        //do not spam packets
        Spells.clear();

        //restpre HP if we need to
        if (p->GetHealth() < StartHP)
            p->SetHealth(StartHP);

        //restore power
        if (p->GetPower(p->GetPowerType()) < StartPower)
            p->SetPower(p->GetPowerType(), StartPower);

        //restore phase
#ifdef MOVE_DUEL_TO_NEW_PHASE
        p->SetPhaseMask(PrevPhaseMask, true);
#endif
        IsDueling = false;
    }
private:
    std::set<uint32>    Spells;
    uint32              StartHP;
    uint32              StartPower;
    uint32              PrevPhaseMask;
    bool                IsDueling;
};

DuelSpellsStore *GetDSPS(Player *p)
{
    DuelSpellsStore *dsp = p->GetCreateExtension<DuelSpellsStore>(OE_PLAYER_DUEL_COOLDOWN_STORE);
    return dsp;
}

class TC_GAME_API DuelClearCooldownsScript : public PlayerScript
{
public:
    DuelClearCooldownsScript() : PlayerScript("DuelClearCooldownsScript") {}

    void OnDuelStart(Player* player1, Player* player2)
    {
        if (player1 == NULL || player2 == NULL)
        {
            //            printf("Could not register duel dmg counter since players do not exist \n");
            return;
        }
//        printf("Starting a duel spellcast monitor\n");

        uint32 phase = 2;
#ifdef MOVE_DUEL_TO_NEW_PHASE
        Map* map = player1->GetMap();
        uint32 usedPhases = 0; // used phases
        Map::PlayerList const& players = map->GetPlayers();
        for (Map::PlayerList::const_iterator iter = players.begin(); iter != players.end(); ++iter)
        {
            Player* check = iter->GetSource();
            if (!check || !check->GetSession())
                continue;
            usedPhases |= check->GetPhaseMask(); // insert player's phases to used phases
        }

        for (; phase <= ULONG_MAX / 2; phase *= 2) // loop all unique phases
        {
            if (usedPhases & phase) // If phase in use
                continue;
            break;
        }
#endif

        if(player1)
            GetDSPS(player1)->OnDuelStart(player1, phase);
        if(player2)
            GetDSPS(player2)->OnDuelStart(player2, phase);
    }

    void OnDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
    {
        if (winner)
            GetDSPS(winner)->OnDuelEnd(winner);
        if (loser)
            GetDSPS(loser)->OnDuelEnd(loser);
    }

    void OnSpellCast(Player* player, Spell* spell, bool skipCheck)
    {
        if(player && spell)
            GetDSPS(player)->OnCast(spell->GetSpellInfo()->Id);
    }
};

void AddDuelCooldownClearScripts()
{
    new DuelClearCooldownsScript();
}
