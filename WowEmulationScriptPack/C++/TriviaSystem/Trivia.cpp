#include "ScriptMgr.h"
#include "GameEventCallbacks.h"
#include "DatabaseEnv.h"
#include "Player.h"
#include "Random.h"
#include "ChannelMgr.h"
#include "Channel.h"
#include "ObjectExtension.cpp"

#define WaitMSUntilPickNewQuestion  60000
#define GiveNewHintEveryMS          15000
#define TriviaChatChannel           "trivia"
#define TriviaPlayerGuid            ((uint64)(0x00FFFFFF-5))
#define TriviaPlayerName            "Trivia"

#ifndef toLower
    #define toLower(c) (((c >= 'A') && (c <= 'Z')) ? (c - 'A' + 'a') : c)
#endif

bool IsSameStrTrivia(const char *str1, const char *str2)
{
    int Index = 0;
    while (str1[Index] == str2[Index])
            Index++;

    //not even first letter matched
    if (Index == 0)
        return false;

    //full match ?
    if (str1[Index-1] == 0) 
        return true;

    return false;
}

void ReadLine(FILE *f, char *buff, uint32 MaxLen)
{
    *buff = 0;
    while (!feof(f))
    {
        size_t BytesRead = fread(buff, 1, 1, f);
        if (*buff == '\n')
        {
            *buff = 0;
            return;
        }
        buff++;
    }
}

class QuestionStore
{
public:
    bool LoadQuestionFromFile(FILE *f)
    {
        char ReadBuffer[3000];
        //read points
        ReadLine(f, ReadBuffer, (uint32)sizeof(ReadBuffer));
        Points = atoi(ReadBuffer);
        //read the question
        ReadLine(f, ReadBuffer, (uint32)sizeof(ReadBuffer));
        Question = strdup(ReadBuffer);
        //read multiple answers
        while (!feof(f))
        {
            ReadLine(f, ReadBuffer, (uint32)sizeof(ReadBuffer));
            if (ReadBuffer[0] == 0)
                break;
            Answers.push_back(strdup(ReadBuffer));
            HintLen = (uint32)strlen(ReadBuffer);
            Hint = (char*)malloc(HintLen + 1);
            Hint[HintLen] = 0;
        }
        //sanity checks
        if (Points == 0)
            return false;
        if (strlen(Question) < 5)
            return false;
        //all good
        return true;
    }
    const char *GetQuestion() { return Question; }
    const char *GetFirstAnswer() { return Answers.at(0); }
    uint32  GetPoints() { return Points; }
    bool IsAcceptedAnswer(const char *msg)
    {
        //convert msg to lower
        char lmsg[5000];
        int32 LenMsg;
        for (LenMsg = 0; msg[LenMsg] != 0 && LenMsg < sizeof(lmsg); LenMsg++)
            lmsg[LenMsg] = tolower(msg[LenMsg]);
        lmsg[LenMsg] = 0;

        for (auto i = Answers.begin(); i != Answers.end(); i++)
        {
            const char *answ = *i;
            //maybe there is a direct match
            if (IsSameStrTrivia(lmsg, answ))
                return true;

            int32 LenAnsw = (int32)strlen(answ);
            int32 LengthDifference = abs(LenAnsw - LenMsg);
            if (LengthDifference >= 2)
                return false;

            // check letter by letter if it matches
            uint32 MisMatchMatchingLetters = 0;
            for (int32 j1 = 0, j2 = 0; j1 < LenAnsw && j2 < LenMsg; j1++, j2++)
            {
                if (answ[j1] == lmsg[j1])
                    continue;
                //Answer has an extra letter here ?
                if (answ[j1] == lmsg[j2 + 1] || answ[j1] == lmsg[j2 + 2])
                    continue;
                //answer has a missing letter here ?
                if (answ[j1 + 1] == lmsg[j2] || answ[j1 + 2] == lmsg[j2])
                    continue;
                MisMatchMatchingLetters++;
            }
            float MatchPercent = 1.0f - (float)MisMatchMatchingLetters / LenAnsw;
            if (MisMatchMatchingLetters > 2) 
                return false;
            // the answer seem to have a few mistakes, but it's ok to accept it
            return true;
        }
        return false;
    }

    //hint will contain no letters at start. Will add more and more letters as time goes by
    void ResetHint()
    {
        for (int i = 0; i < (int)HintLen; i++)
            Hint[i] = '_';
        Hint[HintLen] = 0; // make sure we did not accidentally overwrite the null terminator
    }

    //try to add a random letter to the empty hint string. If it fails in X tries, it will skip giving a hint
    const char *GetHint()
    {
        //copy 1 letter from answer and "zero" out the rest
        auto i = Answers.begin();
        const char *Answer = *i;
        //pick a random position and copy another char to it
        for (int Try = 0; Try < 10; Try++)
        {
            uint32 RandLoc = rand32() % HintLen;
            if (Hint[RandLoc] == '_')
            {
                Hint[RandLoc] = Answer[RandLoc];
                return Hint;
            }
        }
        return NULL;
    }

private:
    char                *Question;
    std::vector<char *> Answers;
    char                *Hint;
    uint32              HintLen;
    uint32              Points;
};

class TriviaSytem
{
public:
    TriviaSytem()
    {
        QuestionCount = 0;
        CurrentQuestion = 0x07FFFFFF;
        TimePassedSinceCurrentQuestion = 0;
    }

    //load questions from file
    void LoadQuestions(const char *FileName)
    {
        FILE *f = fopen(FileName, "rt");
        if (f == NULL)
        {
            printf("Could not open input file for trivia system. TriviaQuestions.txt missing ?\n");
            return;
        }

        //load all questions from file
        while (!feof(f))
        {
            QuestionStore *qs = new QuestionStore;
            if (qs->LoadQuestionFromFile(f) == false)
            {
                delete qs;
                break;
            }
            Qestions.push_back(qs);
            QuestionCount++;
        }
        fclose(f);

        //init the system
        PickNewQuestion();
    }

    void PostChannelMessage(const char *what)
    {
        //post it on the "trivia" channel
        ChannelMgr* cMgr = ChannelMgr::forTeam(TEAM_ALLIANCE);
        if (cMgr == NULL)
            return;

        Channel *ch = cMgr->GetChannel(0, TriviaChatChannel, NULL, false);
        if (ch == NULL)
            return;

        ch->SayOfflinePlayer(ObjectGuid(TriviaPlayerGuid), what);
    }

    //pick a random question
    void PickNewQuestion(bool IsTimeOut=false)
    {
        //avoid division by 0 crash
        if (QuestionCount == 0)
            return;

        //first give the answer to educate people
        if (IsTimeOut)
        {
            std::string answer = "Question timeout. The answer was:";
            answer += Qestions.at(CurrentQuestion)->GetFirstAnswer();
            PostChannelMessage(answer.c_str());
        }

        //pick a random question
        CurrentQuestion = rand32() % QuestionCount;
        TimePassedSinceCurrentQuestion = 0;
		TimePassedSincePreviousHint = 0;

        //post the new question
        std::string question = "Question:";
        question += Qestions.at(CurrentQuestion)->GetQuestion();
        PostChannelMessage(question.c_str());

        //generate new hint
        Qestions.at(CurrentQuestion)->ResetHint();
    }

    //update status if the current question has not been answered
    void UpdateStatus(uint32 TimeDiff)
    {
        //avoid division by 0 crash
        if (QuestionCount == 0)
            return;

        //update time spent on this question
        TimePassedSinceCurrentQuestion += TimeDiff;
        //enough time has passed, roll a new question
        if (TimePassedSinceCurrentQuestion > WaitMSUntilPickNewQuestion)
            PickNewQuestion(true);
        GiveHint(TimeDiff);
    }

    void OnMessageReceived(const char *msg, Player *plr)
    {
        if (Qestions.at(CurrentQuestion)->IsAcceptedAnswer(msg))
        {
            uint32 PointsReceived = Qestions.at(CurrentQuestion)->GetPoints();
            char itoastr[20];
            itoa(PointsReceived, itoastr, 10);
            int64 *PlayerPoints = plr->GetCreateIn64Extension(OE_PLAYER_TRIVIA_POINTS, false, 0);
            *PlayerPoints += PointsReceived;
            char itoastr2[20];
            itoa((int)*PlayerPoints, itoastr2, 10);
            std::string congratulation = "Player " + plr->GetName() + " guessed '" + Qestions.at(CurrentQuestion)->GetFirstAnswer() + "' and received " + itoastr + " points. Total " + itoastr2;
            PostChannelMessage(congratulation.c_str());
            PickNewQuestion();
        }
    }

    void GiveHint(uint32 TimeDiff)
    {
        TimePassedSincePreviousHint += TimeDiff;
        if (TimePassedSincePreviousHint > GiveNewHintEveryMS)
        {
            TimePassedSincePreviousHint = 0;
            const char *MangledAnswer = Qestions.at(CurrentQuestion)->GetHint();
            if(MangledAnswer)
                PostChannelMessage(MangledAnswer);
        }
    }
private:
    std::vector<QuestionStore*> Qestions;
    uint32                      QuestionCount;
    uint32                      CurrentQuestion;
    uint32                      TimePassedSinceCurrentQuestion;
    uint32                      TimePassedSincePreviousHint;
};

TriviaSytem ServerWideTrivia;

bool IsSameStrInsensitive2(const char *str1, const char *str2);
//every time an ingame player sends a message to the server, this function will trigger
void TriviaOnChatMessageReceived(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //skip GM messages
    if (params->Msg->c_str()[0] == '.')
        return;

    //is this message directed to channel we want to link ?
    if (IsSameStrInsensitive2(TriviaChatChannel, (*params->Channel).c_str()) == false)
        return;

    ServerWideTrivia.OnMessageReceived(params->Msg->c_str(), params->SenderPlayer);

#ifdef _DEBUG
    if (params->Msg->c_str()[0] == '#' && params->Msg->c_str()[1] == 'r' && params->Msg->c_str()[2] == 't')
        ServerWideTrivia.PickNewQuestion(true);
#endif
}

//this is a periodic tick function to update our trivia system
void TriviaPeriodUpdateQuestion(void *p, void *context)
{
    CP_MAP_PERIODIC_UPDATE *params = PointerCast(CP_MAP_PERIODIC_UPDATE, p);
    if (params->map == NULL || params->map->GetId() != 0)
        return;

    ServerWideTrivia.UpdateStatus(params->TimeDiff);
}

void SendFakeNameQuery(uint64 Guid, const char *Name, Player *Destination);
//if a player is curious about who is sending the trivia questions, we answer to him
void HandleNameQueryTriviaPlayer(void *p, void *)
{
    CP_NAME_QUERY *params = PointerCast(CP_NAME_QUERY, p);

    if (params->GUID != TriviaPlayerGuid)
        return;

    SendFakeNameQuery(params->GUID, TriviaPlayerName, params->Player);

    params->DenyDefaultParsing = 1;
}

class TC_GAME_API TriviaPlayerLoaderRegisterScript : public PlayerScript
{
public:
    TriviaPlayerLoaderRegisterScript() : PlayerScript("TriviaPlayerLoaderRegisterScript") {}
    // load points for player when he logs in
    void OnLogin(Player* player, bool firstLogin)
    {
        int64 *TP = player->GetCreateIn64Extension(OE_PLAYER_TRIVIA_POINTS);
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "SELECT PointsAquired from character_TriviaPoints where GUID = %d", (uint32)player->GetGUID().GetRawValue());
        QueryResult result = CharacterDatabase.Query(Query);
        if (!result || result->GetRowCount() == 0)
            return;
        Field* fields = result->Fetch();
        *TP = fields[0].GetUInt32();
    }
    //save points when he logs out
    void OnLogout(Player* player)
    {
        int64 *TP = player->GetExtension<int64>(OE_PLAYER_TRIVIA_POINTS);
        if (TP == NULL)
            return;
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "replace into character_TriviaPoints values(%d,%d)", (uint32)player->GetGUID().GetRawValue(),(uint32)*TP);
        CharacterDatabase.Execute(Query);
    }
    //ditch points when he quits the game
    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        char Query[5000];
        sprintf_s(Query, sizeof(Query), "delete from character_TriviaPoints where GUID=%d", (uint32)guid.GetRawValue());
        CharacterDatabase.Execute(Query);
    }
};

void AddTriviaSystemScripts()
{
    /*
    CREATE TABLE IF NOT EXISTS `character_TriviaPoints` (
    `GUID` int(11) NOT NULL,
    `PointsAquired` int(11) DEFAULT NULL,
    UNIQUE KEY `relation` (`GUID`),
    KEY `RowUniqueId` (`GUID`) USING BTREE
    ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
    */
    //cache the questions
    ServerWideTrivia.LoadQuestions("TriviaQuestions.txt");

    //we need something to periodically update the state of the system. Hook a map update
    RegisterCallbackFunction(CALLBACK_TYPE_MAP_PERIODIC_UPDATE, TriviaPeriodUpdateQuestion, NULL);

    //client might deny all posted messages unless comming form a real player
    RegisterCallbackFunction(CALLBACK_TYPE_NAME_QUERY, HandleNameQueryTriviaPlayer, NULL);

    //register listner that will check if message is an answer we are looking for
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, TriviaOnChatMessageReceived, NULL);

    new TriviaPlayerLoaderRegisterScript();
}
