#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "Player.h"
#include "Chat.h"
#include "BattlegroundQueue.h"
#include "ObjectAccessor.h"

#define MSG_COLOR_LIGHTRED     "|cffff6060"
#define MSG_COLOR_LIGHTBLUE    "|cff00ccff"
#define MSG_COLOR_ANN_GREEN    "|c1f40af20"
#define MSG_COLOR_RED          "|cffff0000"
#define MSG_COLOR_GOLD         "|cffffcc00"
#define MSG_COLOR_SUBWHITE     "|cffbbbbbb"
#define MSG_COLOR_MAGENTA      "|cffff00ff"
#define MSG_COLOR_YELLOW       "|cffffff00"
#define MSG_COLOR_CYAN         "|cff00ffff"
#define MSG_COLOR_DARKBLUE     "|cff0000ff"

#define MSG_COLOR_GREY         "|cff9d9d9d"
#define MSG_COLOR_WHITE        "|cffffffff"
#define MSG_COLOR_GREEN        "|cff1eff00"
#define MSG_COLOR_BLUE         "|cff0080ff"
#define MSG_COLOR_PURPLE       "|cffb048f8"
#define MSG_COLOR_ORANGE       "|cffff8000"

#define MSG_COLOR_DRUID        "|cffff7d0a"
#define MSG_COLOR_HUNTER       "|cffabd473"
#define MSG_COLOR_MAGE         "|cff69ccf0"
#define MSG_COLOR_PALADIN      "|cfff58cba"
#define MSG_COLOR_PRIEST       "|cffffffff"
#define MSG_COLOR_ROGUE        "|cfffff569"
#define MSG_COLOR_SHAMAN       "|cff0070de"
#define MSG_COLOR_WARLOCK      "|cff9482c9"
#define MSG_COLOR_WARRIOR      "|cffc79c6e"
#define MSG_COLOR_DEATH_KNIGHT "|cffc41f3b"
#define MSG_COLOR_MONK         "|cff00ff96"

uint8 Unit::getRace(bool forceoriginal) const
{
    if (GetTypeId() == TYPEID_PLAYER)
    {
        Player* player = ((Player*)this);

        if (forceoriginal)
            return player->getORace();

        if (player->InArena())
            return GetByteValue(UNIT_FIELD_BYTES_0, 0);

        if (!player->IsPlayingNative())
            return player->getFRace();
    }

    return GetByteValue(UNIT_FIELD_BYTES_0, 0);
}

bool Player::SendRealNameQuery()
{
    if (IsPlayingNative())
        return false;

    WorldPacket data(SMSG_NAME_QUERY_RESPONSE, (8 + 1 + 1 + 1 + 1 + 1 + 10));
    data.appendPackGUID(GetGUID());                             // player guid
    data << uint8(0);                                       // added in 3.1; if > 1, then end of packet
    data << GetName();                                   // played name
    data << uint8(0);                                       // realm name for cross realm BG usage
    data << uint8(getORace());
    data << uint8(getGender());
    data << uint8(getClass());
    data << uint8(0);                                   // is not declined
    GetSession()->SendPacket(&data);

    return true;
}

void Player::SetFakeRaceAndMorph()
{
    m_FakeRace = GetOTeam() == ALLIANCE ? RACE_BLOODELF : RACE_HUMAN;
}

bool Player::SendBattleGroundChat(uint32 msgtype, std::string message)
{
    // Select distance to broadcast to.
    float distance = msgtype == CHAT_MSG_SAY ? sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY) : sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_YELL);

    if (Battleground* bg = GetBattleground())
    {
        if (bg->isArena()) // Only fake chat in BG's. CFBG should not interfere with arenas.
            return false;

        for (Battleground::BattlegroundPlayerMap::const_iterator itr = bg->GetPlayers().begin(); itr != bg->GetPlayers().end(); ++itr)
        {
            if (Player* player = ObjectAccessor::FindPlayer(itr->first))
            {
                if (GetDistance2d(player->GetPositionX(), player->GetPositionY()) <= distance)
                {
                    WorldPacket data(SMSG_MESSAGECHAT, 200);

                    if (GetTeam() == player->GetTeam())
                        BuildPlayerChat(&data, msgtype, message, LANG_UNIVERSAL);
                    else if (msgtype != CHAT_MSG_EMOTE)
                        BuildPlayerChat(&data, msgtype, message, player->GetTeam() == ALLIANCE ? LANG_ORCISH : LANG_COMMON);

                    player->GetSession()->SendPacket(&data);
                }
            }
        }
        return true;
    }
    else
        return false;
}

void Player::MorphFit(bool value)
{
    if (!IsPlayingNative() && value)
    {
        if (GetOTeam() == HORDE)
        {
            if (getGender() == GENDER_MALE)
            {
                SetDisplayId(19723);
                SetNativeDisplayId(19723);
            }
            else
            {
                SetDisplayId(19724);
                SetNativeDisplayId(19724);
            }
        }
        else
        {
            if (getGender() == GENDER_MALE)
            {
                SetDisplayId(20578);
                SetNativeDisplayId(20578);
            }
            else
            {
                SetDisplayId(20579);
                SetNativeDisplayId(20579);
            }
        }
    }
    else
        InitDisplayIds();
}

void Player::FitPlayerInTeam(bool action, Battleground* bg)
{
    if (!bg)
        bg = GetBattleground();

    if ((!bg || bg->isArena()) && action)
        return;

    if (!IsPlayingNative() && action)
        setFactionForRace(getRace());
    else
        setFactionForRace(getORace());

    if (action)
        SetForgetBGPlayers(true);
    else
        SetForgetInListPlayers(true);

    MorphFit(action);

    if (bg && action)
        SendChatMessage("%sCrossFaction System: You are playing for the %s%s in this %s", MSG_COLOR_WHITE, GetTeam() == ALLIANCE ? MSG_COLOR_DARKBLUE"Alliance" : MSG_COLOR_RED"Horde", MSG_COLOR_WHITE, bg->GetName().c_str());
}

void Player::DoForgetPlayersInList()
{
    // m_FakePlayers is filled from a vector within the battleground
    // they were in previously so all players that have been in that BG will be invalidated.
    for (FakePlayers::const_iterator itr = m_FakePlayers.begin(); itr != m_FakePlayers.end(); ++itr)
    {
        WorldPacket data(SMSG_INVALIDATE_PLAYER, 8);
        data << *itr;
        GetSession()->SendPacket(&data);
        if (Player* player = ObjectAccessor::FindPlayer(ObjectGuid(*itr)))
            GetSession()->SendNameQueryOpcode(player->GetGUID());
    }
    m_FakePlayers.clear();
}

void Player::DoForgetPlayersInBG(Battleground* bg)
{
    for (Battleground::BattlegroundPlayerMap::const_iterator itr = bg->GetPlayers().begin(); itr != bg->GetPlayers().end(); ++itr)
    {
        // Here we invalidate players in the bg to the added player
        WorldPacket data1(SMSG_INVALIDATE_PLAYER, 8);
        data1 << itr->first;
        GetSession()->SendPacket(&data1);

        if (Player* player = ObjectAccessor::FindPlayer(itr->first))
        {
            GetSession()->SendNameQueryOpcode(player->GetGUID()); // Send namequery answer instantly if player is available
                                                                  // Here we invalidate the player added to players in the bg
            WorldPacket data2(SMSG_INVALIDATE_PLAYER, 8);
            data2 << GetGUID();
            player->GetSession()->SendPacket(&data2);
            player->GetSession()->SendNameQueryOpcode(GetGUID());
        }
    }
}

bool BattlegroundQueue::CheckCrossFactionMatch(BattlegroundBracketId bracket_id, Battleground* bg)
{
    if (!sWorld->getBoolConfig(CONFIG_CROSSFACTION_ENABLE) || bg->isArena())
        return false; // Only do this if crossbg's are enabled.

                      // Here we will add all players to selectionpool, later we check if there are enough and launch a bg.
    FillXPlayersToBG(bracket_id, bg, true);

    if (sBattlegroundMgr->isTesting() && (m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() || m_SelectionPools[TEAM_HORDE].GetPlayerCount()))
        return true;

    uint8 MPT = bg->GetMinPlayersPerTeam();
    if (m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() < MPT || m_SelectionPools[TEAM_HORDE].GetPlayerCount() < MPT)
        return false;

    return true;
}

// This function will invite players in the least populated faction, which makes battleground queues much faster.
// This function will return true if cross faction battlegrounds are enabled, otherwise return false,
// which is useful in FillPlayersToBG. Because then we can interrupt the regular invitation if cross faction bg's are enabled.
bool BattlegroundQueue::FillXPlayersToBG(BattlegroundBracketId bracket_id, Battleground* bg, bool start)
{
    uint8 queuedPeople = 0;
    for (GroupsQueueType::const_iterator itr = m_QueuedGroups[bracket_id][BG_QUEUE_MIXED].begin(); itr != m_QueuedGroups[bracket_id][BG_QUEUE_MIXED].end(); ++itr)
        if (!(*itr)->IsInvitedToBGInstanceGUID)
            queuedPeople += (*itr)->Players.size();

    if (sWorld->getBoolConfig(CONFIG_CROSSFACTION_ENABLE) && (sBattlegroundMgr->isTesting() || queuedPeople >= bg->GetMinPlayersPerTeam() * 2 || !start))
    {
        int32 aliFree = start ? bg->GetMaxPlayersPerTeam() : bg->GetFreeSlotsForTeam(ALLIANCE);
        int32 hordeFree = start ? bg->GetMaxPlayersPerTeam() : bg->GetFreeSlotsForTeam(HORDE);
        // Empty selection pools. They will be refilled from queued groups.
        m_SelectionPools[TEAM_ALLIANCE].Init();
        m_SelectionPools[TEAM_HORDE].Init();
        int32 valiFree = aliFree;
        int32 vhordeFree = hordeFree;
        int32 diff = 0;


        // Add teams to their own factions as far as possible.
        if (start)
        {
            QueuedGroupMap m_PreGroupMap_a, m_PreGroupMap_h;
            int32 m_SmallestOfTeams = 0;
            int32 queuedAlliance = 0;
            int32 queuedHorde = 0;

            for (GroupsQueueType::const_iterator itr = m_QueuedGroups[bracket_id][BG_QUEUE_MIXED].begin(); itr != m_QueuedGroups[bracket_id][BG_QUEUE_MIXED].end(); ++itr)
            {
                if ((*itr)->IsInvitedToBGInstanceGUID)
                    continue;

                bool alliance = (*itr)->OTeam == ALLIANCE;

                if (alliance)
                {
                    m_PreGroupMap_a.insert(std::make_pair((*itr)->Players.size(), *itr));
                    queuedAlliance += (*itr)->Players.size();
                }
                else
                {
                    m_PreGroupMap_h.insert(std::make_pair((*itr)->Players.size(), *itr));
                    queuedHorde += (*itr)->Players.size();
                }
            }

            m_SmallestOfTeams = std::min(std::min(aliFree, queuedAlliance), std::min(hordeFree, queuedHorde));

            valiFree -= PreAddPlayers(m_PreGroupMap_a, m_SmallestOfTeams, aliFree);
            vhordeFree -= PreAddPlayers(m_PreGroupMap_h, m_SmallestOfTeams, hordeFree);
        }

        QueuedGroupMap m_QueuedGroupMap;

        for (GroupsQueueType::const_iterator itr = m_QueuedGroups[bracket_id][BG_QUEUE_MIXED].begin(); itr != m_QueuedGroups[bracket_id][BG_QUEUE_MIXED].end(); ++itr)
            m_QueuedGroupMap.insert(std::make_pair((*itr)->Players.size(), *itr));

        for (QueuedGroupMap::reverse_iterator itr = m_QueuedGroupMap.rbegin(); itr != m_QueuedGroupMap.rend(); ++itr)
        {
            GroupsQueueType allypool = m_SelectionPools[TEAM_ALLIANCE].SelectedGroups;
            GroupsQueueType hordepool = m_SelectionPools[TEAM_HORDE].SelectedGroups;

            GroupQueueInfo* ginfo = itr->second;

            // If player already was invited via pre adding (add to own team first) or he was already invited to a bg, skip.
            if (ginfo->IsInvitedToBGInstanceGUID ||
                std::find(allypool.begin(), allypool.end(), ginfo) != allypool.end() ||
                std::find(hordepool.begin(), hordepool.end(), ginfo) != hordepool.end() ||
                (m_SelectionPools[TEAM_ALLIANCE].GetPlayerCount() >= bg->GetMinPlayersPerTeam() &&
                    m_SelectionPools[TEAM_HORDE].GetPlayerCount() >= bg->GetMinPlayersPerTeam()))
                continue;

            diff = abs(valiFree - vhordeFree);
            bool moreAli = valiFree < vhordeFree;

            if (diff > 0)
                ginfo->Team = moreAli ? HORDE : ALLIANCE;

            bool alliance = ginfo->Team == ALLIANCE;

            if (m_SelectionPools[alliance ? TEAM_ALLIANCE : TEAM_HORDE].AddGroup(ginfo, alliance ? aliFree : hordeFree))
                alliance ? valiFree -= ginfo->Players.size() : vhordeFree -= ginfo->Players.size();
        }

        return true;
    }
    return false;
}

int32 BattlegroundQueue::PreAddPlayers(QueuedGroupMap m_PreGroupMap, int32 MaxAdd, uint32 MaxInTeam)
{
    int32 LeftToAdd = MaxAdd;
    uint32 Added = 0;

    for (QueuedGroupMap::reverse_iterator itr = m_PreGroupMap.rbegin(); itr != m_PreGroupMap.rend(); ++itr)
    {
        int32 PlayerSize = itr->first;
        bool alliance = itr->second->OTeam == ALLIANCE;

        if (PlayerSize <= LeftToAdd && m_SelectionPools[alliance ? TEAM_ALLIANCE : TEAM_HORDE].AddGroup(itr->second, MaxInTeam))
            LeftToAdd -= PlayerSize, Added -= PlayerSize;
    }

    return LeftToAdd;
}

void Player::SendChatMessage(const char *format, ...)
{
    if (!IsInWorld())
        return;

    if (format)
    {
        va_list ap;
        char str[2048];
        va_start(ap, format);
        vsnprintf(str, 2048, format, ap);
        va_end(ap);

        ChatHandler(GetSession()).SendSysMessage(str);
    }
}