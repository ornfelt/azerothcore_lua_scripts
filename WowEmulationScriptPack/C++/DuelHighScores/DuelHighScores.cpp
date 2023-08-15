#include "SharedDefines.h"
#include "ScriptMgr.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "Player.h"
#include "DatabaseEnv.h"
#include "Creature.h"
#include "Map.h"

void DuelHighscoreDMGHandler(void *p, void *)
{
    CP_DMG_DONE_RECEIVED *params = PointerCast(CP_DMG_DONE_RECEIVED, p);
    //in case this is called more than once
    if (params->OriDamage == 0 || params->Attacker == NULL)
    {
//         printf("No dmg, attacker or victim\n");
        return;
    }
//    if (params->Attacker->ToPlayer())
//        printf("Player %s did %d dmg\n",params->Attacker->ToPlayer()->GetName().c_str(), *params->damage);
    //register all damage done. This damage is before resistances
    *params->Attacker->GetCreateIn64Extension(OE_PLAYER_DUEL_DAMAGE_DONE) += params->GetDamage();
}

bool CanPlayerAwardKillReward(Player *Killer, Player *Victim);

class TC_GAME_API DuelHighScoresRegisterScript : public PlayerScript
{
public:
    DuelHighScoresRegisterScript() : PlayerScript("DuelHighScoresRegisterScript") {}

    enum PVPKillHighscoreTYPE
    {
        PVP_KILL_DUEL = 0,
        PVP_KILL_ARENA,
        PVP_KILL_BG,
        PVP_KILL_FFA,
        PVP_KILL_OPENWORLD,
    };

    void OnDuelStart(Player* player1, Player* player2)
    {
        if (player1 == NULL || player2 == NULL)
        {
//            printf("Could not register duel dmg counter since players do not exist \n");
            return;
        }
//        printf("Starting a duel monitor\n");
        *player1->GetCreateIn64Extension(OE_PLAYER_DUEL_DAMAGE_DONE) = 0;
        *player2->GetCreateIn64Extension(OE_PLAYER_DUEL_DAMAGE_DONE) = 0;
        player1->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, &DuelHighscoreDMGHandler);
        player2->RegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, &DuelHighscoreDMGHandler);
    }

    void OnDuelEnd(Player* winner, Player* loser, DuelCompleteType type)
    {
        //sanity checks
        if (winner == NULL || loser == NULL || type != DUEL_WON)
        {
//            printf("Duel did not end with a win\n");
            return;
        }

        //remove event handlers. They are no longer required until next fight
        winner->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, &DuelHighscoreDMGHandler);
        loser->UnRegisterCallbackFunc(CALLBACK_TYPE_DMG_DONE, &DuelHighscoreDMGHandler);

        //ignore dmg test duels
        if (*winner->GetCreateIn64Extension(OE_PLAYER_DUEL_DAMAGE_DONE) == 0 || *loser->GetCreateIn64Extension(OE_PLAYER_DUEL_DAMAGE_DONE) == 0)
        {
//            printf("Duel was only a dmg test or kill farm. Ignore it\n");
            return;
        }

        //run query to register kill
        OnPVPKill(PVP_KILL_DUEL, (uint32)winner->GetGUID().GetRawValue(), (uint32)loser->GetGUID().GetRawValue());
    }

    void OnPVPKill(uint32 Type, uint64 GUID1, uint64 GUID2)
    {
        char *TableName;
        if (Type == PVP_KILL_DUEL)
            TableName = "character_DuelWins";
        else if (Type == PVP_KILL_ARENA)
            TableName = "character_ArenaWins";
        else if (Type == PVP_KILL_BG)
            TableName = "character_BGWins";
        else if (Type == PVP_KILL_FFA)
            TableName = "character_FFAWins";
        else if (Type == PVP_KILL_OPENWORLD)
            TableName = "character_WorldWins";
        else
            return;
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "INSERT INTO %s VALUES(%d, %d, 1) ON DUPLICATE KEY UPDATE Player1GUID = %d, Player2GUID = %d, Player1Wins = Player1Wins + 1", TableName, (uint32)GUID1, (uint32)GUID2, (uint32)GUID1, (uint32)GUID2);
        CharacterDatabase.Execute(Query);
    }

    void OnPVPKill(Player* killer, Player* killed)
    {
        //sanity checks
        if (killer == NULL || killer->GetMap() == NULL || killer == killed)
            return;
        //anti farm protection
        if (CanPlayerAwardKillReward(killer, killed) == false)
        {
//            printf("Player might be kill farmed. No reward awarded\n");
            killer->BroadcastMessage("Player might be kill farmed. No reward awarded");
            return;
        }
        // are we in an arena ?
        if( killer->GetMap()->IsBattleArena() )
            OnPVPKill(PVP_KILL_ARENA, (uint32)killer->GetGUID().GetRawValue(), (uint32)killed->GetGUID().GetRawValue());
        // are we in a BG ?
        else if(killer->GetMap()->IsBattleground())
            OnPVPKill(PVP_KILL_BG, (uint32)killer->GetGUID().GetRawValue(), (uint32)killed->GetGUID().GetRawValue());
        // are we FFA flagged
        else if( killer->IsFFAPvP())
            OnPVPKill(PVP_KILL_FFA, (uint32)killer->GetGUID().GetRawValue(), (uint32)killed->GetGUID().GetRawValue());
        // are we in open world
        else 
            OnPVPKill(PVP_KILL_OPENWORLD, (uint32)killer->GetGUID().GetRawValue(), (uint32)killed->GetGUID().GetRawValue());
    }

    //just in case player summons or pets do not register for kills. Worst case this will count as double
    void OnPlayerKilledByCreature(Creature* killer, Player* killed)
    {
        Player *Killer2 = killer->GetCharmerOrOwnerPlayerOrPlayerItself();
        if (Killer2)
            OnPVPKill(Killer2, killed);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_DuelWins where Player1GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
        sprintf_s(Query, sizeof(Query), "delete from character_BGWins where Player1GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
        sprintf_s(Query, sizeof(Query), "delete from character_FFAWins where Player1GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
        sprintf_s(Query, sizeof(Query), "delete from character_WorldWins where Player1GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
        sprintf_s(Query, sizeof(Query), "delete from character_ArenaWins where Player1GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }

};

void AddDuelHighScoresScripts()
{
    //CREATE TABLE `character_DuelWins` ( `Player1GUID` INT NULL, `Player2GUID` INT NULL, `Player1Wins` INT NULL );
    //ALTER TABLE `character_DuelWins` ADD INDEX `AcctId` (`Player1GUID`, `Player2GUID`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON character_DuelWins (Player1GUID, Player2GUID);
    //CREATE TABLE `character_BGWins` ( `Player1GUID` INT NULL, `Player2GUID` INT NULL, `Player1Wins` INT NULL );
    //ALTER TABLE `character_BGWins` ADD INDEX `AcctId` (`Player1GUID`, `Player2GUID`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON character_BGWins (Player1GUID, Player2GUID);
    //CREATE TABLE `character_FFAWins` ( `Player1GUID` INT NULL, `Player2GUID` INT NULL, `Player1Wins` INT NULL );
    //ALTER TABLE `character_FFAWins` ADD INDEX `AcctId` (`Player1GUID`, `Player2GUID`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON character_FFAWins (Player1GUID, Player2GUID);
    //CREATE TABLE `character_WorldWins` ( `Player1GUID` INT NULL, `Player2GUID` INT NULL, `Player1Wins` INT NULL );
    //ALTER TABLE `character_WorldWins` ADD INDEX `AcctId` (`Player1GUID`, `Player2GUID`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON character_WorldWins (Player1GUID, Player2GUID);
    //CREATE TABLE `character_ArenaWins` ( `Player1GUID` INT NULL, `Player2GUID` INT NULL, `Player1Wins` INT NULL );
    //ALTER TABLE `character_ArenaWins` ADD INDEX `AcctId` (`Player1GUID`, `Player2GUID`) USING BTREE;
    //CREATE UNIQUE INDEX relation ON character_ArenaWins (Player1GUID, Player2GUID);

    new DuelHighScoresRegisterScript();
}
