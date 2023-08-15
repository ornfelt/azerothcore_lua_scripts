#include "SharedDefines.h"
#include "ScriptMgr.h"
#include "ObjectExtension.cpp"
#include "Player.h"
#include "DatabaseEnv.h"
#include "GameTime.h"

#define MAX_MILISECONDS_PAUSE_BETWEEN_KILLSTREAKS (2 * 60 * 1000)

bool CanPlayerAwardKillReward(Player *Killer, Player *Victim);

class KillStreakStore
{
public:
    //load data for player
    KillStreakStore(Player *player)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "select BestKillStreakNoDie,BestKillStreakNoPause,BestDuelWinsNoLoose,KillsWithoutDeath,DuelWinsNoLoose from character_KillStreakHighScore where guid=%d ", (uint32)player->GetGUID().GetRawValue());
        QueryResult result = CharacterDatabase.Query(Query);
        if (result && result->GetRowCount() == 1)
        {
            Field* fields = result->Fetch();
            BestKillsWithoutDeath = fields[0].GetUInt32();
            BestKillsNoPause = fields[1].GetUInt32();
            BestDuelWinsNoLoose = fields[2].GetUInt32();
            CurKillsWithoutDeath = fields[3].GetUInt32();
            CurDuelWinsNoLoose = fields[4].GetUInt32();
        }
        else
        {
            BestKillsWithoutDeath = 0;
            BestKillsNoPause = 0;
            BestDuelWinsNoLoose = 0;
            CurKillsWithoutDeath = 0;
            CurDuelWinsNoLoose = 0;
        }
        LastKillsStamp = 0;
        CurKillsNoPause = 0;
        ShouldUpdateDB = false;
    }

    void OnKillPlayer(Player *Killer, Player *Victim)
    {
        //sanity checks
        if (Killer == NULL || Victim == NULL)
            return;
        //anti farm protection
        if (CanPlayerAwardKillReward(Killer, Victim) == false)
            return;

        // kill streak without deaths
        CurKillsWithoutDeath++;
        // this is a new highscore. Advertise it and save it
        if (CurKillsWithoutDeath > BestKillsWithoutDeath)
        {
            BestKillsWithoutDeath = CurKillsWithoutDeath;
            ShouldUpdateDB = true;
            Killer->BroadcastMessage("Personal KillStreakWithoutDeath record of %d by killing %s", BestKillsWithoutDeath, Victim->GetName().c_str());
        }

        // kill streak no pause
        uint32 TimeNow = GameTime::GetGameTimeMS();
        uint32 TimePassedMS = (TimeNow - LastKillsStamp);
        LastKillsStamp = TimeNow;
        if (TimePassedMS < MAX_MILISECONDS_PAUSE_BETWEEN_KILLSTREAKS || TimePassedMS == TimeNow)
        {
            CurKillsNoPause++;
            // this is a new highscore. Advertise it and save it
            if (CurKillsNoPause > BestKillsNoPause)
            {
                BestKillsNoPause = CurKillsNoPause;
                ShouldUpdateDB = true;
                Killer->BroadcastMessage("Personal KillStreakWithTimer record of %d by killing %s", BestKillsNoPause, Victim->GetName().c_str());
            }
        }
    }

    void OnWinDuel(Player *Killer, Player *Victim)
    {
        //sanity checks
        if (Killer == NULL || Victim == NULL)
            return;
        //anti farm protection
        if (CanPlayerAwardKillReward(Killer, Victim) == false)
            return;
        CurDuelWinsNoLoose++;
        // this is a new highscore. Advertise it and save it
        if (CurDuelWinsNoLoose > BestDuelWinsNoLoose)
        {
            BestDuelWinsNoLoose = CurDuelWinsNoLoose;
            ShouldUpdateDB = true;
            Killer->BroadcastMessage("Personal DuelWinStreak record of %d by defeating %s", BestDuelWinsNoLoose, Victim->GetName().c_str());
        }
    }

    void OnLooseDuel(Player *Killer, Player *Victim)
    {
        if (CurDuelWinsNoLoose == BestDuelWinsNoLoose)
        {
            Victim->BroadcastMessage("%s ended your DuelWinStreak record", Killer->GetName().c_str());
            Killer->BroadcastMessage("You ended %s DuelWinStreak record of %d", Victim->GetName().c_str(), BestDuelWinsNoLoose);
        }
        CurDuelWinsNoLoose = 0;
    }

    void OnDie(Player *Killer, Player *Victim)
    {
        if (CurKillsWithoutDeath == BestKillsWithoutDeath)
        {
            Victim->BroadcastMessage("%s ended your KillStreakWithoutDeath record", Killer->GetName().c_str());
            Killer->BroadcastMessage("You ended %s KillStreakWithoutDeath record of %d", Victim->GetName().c_str(), BestDuelWinsNoLoose);
        }
        CurKillsWithoutDeath = 0;
    }

    void OnLogout(Player *player)
    {
        if (ShouldUpdateDB)
        {
            char Query[5000];
            sprintf_s(Query, sizeof(Query), "replace into character_KillStreakHighScore (GUID,BestKillStreakNoDie,BestKillStreakNoPause,BestDuelWinsNoLoose,KillsWithoutDeath,DuelWinsNoLoose)values(%d,%d,%d,%d,%d,%d)",
                (uint32)player->GetGUID().GetRawValue(), BestKillsWithoutDeath, BestKillsNoPause, BestDuelWinsNoLoose, CurKillsWithoutDeath, CurDuelWinsNoLoose);
            CharacterDatabase.Execute(Query);
        }
    }

protected:
    uint32  BestKillsWithoutDeath;  
    uint32  CurKillsWithoutDeath;   

    uint32  LastKillsStamp;
    uint32  BestKillsNoPause;
    uint32  CurKillsNoPause;

    uint32  BestDuelWinsNoLoose;
    uint32  CurDuelWinsNoLoose;

    bool    ShouldUpdateDB;
};

class TC_GAME_API KillStreakRegisterScript : public PlayerScript
{
public:
    KillStreakRegisterScript() : PlayerScript("KillStreakRegisterScript") {}

    //save to DB if there is something to be saved
    void OnLogout(Player* player)
    {
        KillStreakStore *ks = player->GetExtension<KillStreakStore>(OE_PLAYER_KILL_STREAK_STORE);
        if (ks != NULL)
            ks->OnLogout(player);
    }

    void OnPVPKill(Player* killer, Player* killed)
    {
        //sanity checks
        if (killer == killed || killer == NULL || killed == NULL)
            return;

        //increase killer highscores
        KillStreakStore *ks = killer->GetExtension<KillStreakStore>(OE_PLAYER_KILL_STREAK_STORE);
        if (ks == NULL)
        {
            ks = new KillStreakStore(killer);
            killer->SetExtension<KillStreakStore>(OE_PLAYER_KILL_STREAK_STORE, ks);
        }
        ks->OnKillPlayer(killer, killed);

        //we only need to register death if this player has a highscore at all. No need to spam DB
        ks = killed->GetExtension<KillStreakStore>(OE_PLAYER_KILL_STREAK_STORE);
        if (ks != NULL)
            ks->OnDie(killer, killed);
    }

    void OnDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
    {
        //sanity checks
        if (winner == loser || winner == NULL || loser == NULL || type != DUEL_WON)
            return;

        //increase killer highscores
        KillStreakStore *ks = winner->GetExtension<KillStreakStore>(OE_PLAYER_KILL_STREAK_STORE);
        if (ks == NULL)
        {
            ks = new KillStreakStore(winner);
            winner->SetExtension<KillStreakStore>(OE_PLAYER_KILL_STREAK_STORE, ks);
        }
        ks->OnWinDuel(winner, loser);

        //we only need to register death if this player has a highscore at all. No need to spam DB
        ks = loser->GetExtension<KillStreakStore>(OE_PLAYER_KILL_STREAK_STORE);
        if (ks != NULL)
            ks->OnLooseDuel(winner, loser);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_KillStreakHighScore where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void AddKillStreakCounterScripts()
{
    //CREATE TABLE `character_KillStreakHighScore` ( `GUID` INT NULL, `BestKillStreakNoDie` INT NULL, `BestKillStreakNoPause` INT NULL, `BestDuelWinsNoLoose` INT NULL, `KillsWithoutDeath` INT NULL, `DuelWinsNoLoose` INT NULL );
    //ALTER TABLE `character_KillStreakHighScore` ADD INDEX `GUID` (`GUID`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON character_KillStreakHighScore (GUID);

    new KillStreakRegisterScript();
}
