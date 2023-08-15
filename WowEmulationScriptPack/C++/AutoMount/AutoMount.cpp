#include "ScriptMgr.h"
#include "Player.h"
#include "GameEventCallbacks.h"
#include "ObjectExtension.cpp"
#include "GameTime.h"
#include "SpellMgr.h"
#include "ScriptSettings\ScriptSettingsAPI.h"

#define TIMEOUT_PREVIOUS_CONDITION_CHECKS   5000
#define DISTANCE_MOVE_SQ                    (10*10)
#define TIMEOUT_PREVIOUS_CAST               15000

class AutoMountStore
{
public:
    AutoMountStore()
    {
        LastMountCheckStamp = 0;
        MountId = 0;
    }
    uint32 GetPlayerMount(Player *p)
    {
        //player has no mounts
        if (MountId == 1)
            return 0;

        //we already found a mount id last time, we can use that
        if (MountId != 0)
            return MountId;

        uint32 LandMount = 0;
        int32 LandMountSpeed = 0;
        uint32 AirMount = 0;
        int32 AirMountSpeed = 0;
        //search all player spells until we find the best mount ( highest mount speed, can fly )
        for (PlayerSpellMap::const_iterator itr = p->GetSpellMap().begin(); itr != p->GetSpellMap().end(); itr++)
        {
            if (itr->second->state == PLAYERSPELL_REMOVED)
                continue;

            SpellInfo const* i_spellInfo = sSpellMgr->GetSpellInfo(itr->first);
            if (!i_spellInfo)
                continue;

            if (i_spellInfo->HasAura(SPELL_AURA_MOUNTED))
            {
                uint32 zone, area;
                p->GetZoneAndAreaId(zone, area);

                SpellCastResult locRes = i_spellInfo->CheckLocation(p->GetMapId(), zone, area, p->ToPlayer());
                if (locRes != SPELL_CAST_OK)
                    continue;

                for (int i = 0; i < MAX_SPELL_EFFECTS; i++)
                {
                    if (i_spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_MOUNTED_SPEED)
                    {
                        if (LandMountSpeed < i_spellInfo->Effects[i].BasePoints)
                        {
                            LandMount = itr->first;
                            LandMountSpeed = i_spellInfo->Effects[i].BasePoints;
                        }
                    }
                    if (i_spellInfo->Effects[i].ApplyAuraName == SPELL_AURA_MOD_INCREASE_MOUNTED_FLIGHT_SPEED)
                    {
                        if (AirMountSpeed < i_spellInfo->Effects[i].BasePoints)
                        {
                            AirMount = itr->first;
                            AirMountSpeed = i_spellInfo->Effects[i].BasePoints;
                        }
                    }
                }
            }
        }
        //if we have a fly mount, use that
        if (AirMount != 0)
        {
            MountId = AirMount;
            return MountId;
        }

        //maybe we have a land mount ?
        MountId = LandMount;

        //player has no mounts ? Stop searching for it
        if (MountId == 0)
        {
            MountId = 1;
            return 0;
        }

        return MountId;
    }

    uint32      LastMountCheckStamp;
    uint32      MountId;
    Position    pos;
};

void PeriodicCheckAutomount(void *p, void *NOTUSED)
{
    Player *player = (Player*)p;
    //not active in BG or arena
    if (player->FindMap() == NULL || player->GetMap()->IsBattlegroundOrArena() || player->GetMap()->IsDungeon())
    {
        return;
    }
    //not available while in combat
    if (player->IsInCombat())
    {
        return;
    }
    if (player->m_stealth.GetFlags() != 0)
    {
        return;
    }
    if (player->m_invisibility.GetFlags() != 0)
    {
        return;
    }
    if (player->HasUnitState(UNIT_STATE_CASTING) == true)
    {
        return;
    }
    AutoMountStore *ms = player->GetCreateExtension<AutoMountStore>(OE_PLAYER_AUTOMOUNT_STORE);
    //no longer need to monitor status
    if (player->IsMounted())
    {
        return;
    }
    uint32 TickNow = GameTime::GetGameTimeMS();
    //if it is a good condition, than we should start counting seconds and distances
    if (ms->LastMountCheckStamp + TIMEOUT_PREVIOUS_CONDITION_CHECKS < TickNow)
    {
        ms->LastMountCheckStamp = TickNow + TIMEOUT_PREVIOUS_CONDITION_CHECKS;
        ms->pos = player->GetPosition();
        return;
    }
    //not yet time to cast the mount spell
    if (ms->LastMountCheckStamp > TickNow)
    {
        return;
    }
    //we should not mount yet
    ms->LastMountCheckStamp = TickNow;
    //we are standing still or running short distances ?
    if (ms->pos.GetExactDist2dSq(player->GetPosition()) < DISTANCE_MOVE_SQ)
    {
        return;
    }
    //mount the player
    if (ms->GetPlayerMount(player))
    {
        //do not spam remounts
        ms->LastMountCheckStamp += TIMEOUT_PREVIOUS_CAST;
        ms->pos = player->GetPosition();
        //mount while moving
        CastSpellExtraArgs ef;
        ef.TriggerFlags = TriggerCastFlags(TRIGGERED_FULL_MASK | TRIGGERED_IGNORE_MOVE_CHECK | TRIGGERED_IGNORE_CAST_TIME);
        player->CastSpell(player, ms->MountId, ef);
    }
}

void EnableAutoMount(Player *player)
{
    SetScripVariableInt32(SSV_Player_Automount, (uint32)player->GetGUID().GetRawValue(), 1);
    player->RegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, PeriodicCheckAutomount);
}

void DisableAutoMount(Player *player)
{
    DelScripVariableInt32(SSV_Player_Automount, (uint32)player->GetGUID().GetRawValue());
    player->UnRegisterCallbackFunc(CALLBACK_TYPE_PLAYER_PERIODIC_TICK, PeriodicCheckAutomount);
}

class TC_GAME_API RegisterAutoMountScript : public PlayerScript
{
public:
    RegisterAutoMountScript() : PlayerScript("RegisterAutoMountScript") {}
    void OnLogin(Player* player, bool firstLogin)
    {
        int32 Eanbled = 0;
        Eanbled = GetScripVariableInt32(SSV_Player_Automount, (uint32)player->GetGUID().GetRawValue(), NULL);
        if(Eanbled==1)
            EnableAutoMount(player);
    }

    void OnDelete(ObjectGuid guid, uint32 accountId)
    {
        DelScripVariableInt32(SSV_Player_Automount, (uint32)guid.GetRawValue());
    }
};

bool CheckValidClientCommand(const char *cmsg, int32 type, const char * channel);

void TParseClientUserCommand2(Player* player, uint32 type, const char *cmsg)
{
    if (CheckValidClientCommand(cmsg, type, NULL) == false)
        return;
    if (strstr(cmsg, "#csDisableAutoMount") == cmsg)
    {
        DisableAutoMount(player);
    }
}

void TOnChatMessageReceived2(void *p, void *)
{
    CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);

    //check for strings that might be our commands
    TParseClientUserCommand2(params->SenderPlayer, params->MsgType, params->Msg->c_str());
}

void AddAutoMountScripts()
{
    new RegisterAutoMountScript();
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, TOnChatMessageReceived2, NULL);
}
