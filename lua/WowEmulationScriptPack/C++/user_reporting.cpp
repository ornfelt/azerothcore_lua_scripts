////////////////////////////////////////////////////////////////////////////////
//
//  MILLENIUM-STUDIO
//  Copyright 2016 Millenium-studio SARL
//  All Rights Reserved.
//
////////////////////////////////////////////////////////////////////////////////

#include <ScriptPCH.h>
#include <ScriptMgr.h>

namespace MS { namespace UserReporting
{

    enum State
    {
        CreateChar = 6,
        LoadScreen = 7,
        InWorld    = 8
    };

    /*
     * Update user step in user_reporting table
     * It's only update if the step provided is higher than previous step
     * @p_Player : Instance of player to update
     * @p_State  : User state (see @UserState enum)
     */
    void UpdateUserStep(WorldSession* p_Session, State p_State)
    {
        PreparedStatement* l_Statement = LoginDatabase.GetPreparedStatement(LOGIN_UPD_USER_REPORTING_STEP);
        l_Statement->setUInt32(0, p_State);
        l_Statement->setString(1, p_Session->GetRemoteAddress().c_str());
        l_Statement->setUInt32(2, p_Session->GetAccountId());
        l_Statement->setUInt32(3, p_State);

        LoginDatabase.Execute(l_Statement);
    }

    class PlayerUserReporting : public PlayerScript
    {
        public:
            PlayerUserReporting() : PlayerScript("PlayerUserReporting") {}

            void OnCreate(Player* p_Player) override
            {
                UpdateUserStep(p_Player->GetSession(), State::CreateChar);
            }

            void OnLogin(Player* p_Player) override
            {
                UpdateUserStep(p_Player->GetSession(), State::InWorld);
            }
    };

    class ServerUserReporting : public ServerScript
    {
        public :
            ServerUserReporting() : ServerScript("ServerUserReporting") {}

            void OnPacketReceive(WorldSocket* /*p_Socket*/, WorldPacket& p_Packet, WorldSession* p_Session) override
            {
                if (p_Session != nullptr && p_Packet.GetOpcode() == CMSG_LOAD_SCREEN)
                    UpdateUserStep(p_Session, State::LoadScreen);
            }
    };
} ///< UserReporting
} ///< MS

#ifndef __clang_analyzer__
void AddSC_user_reporting()
{
    new MS::UserReporting::PlayerUserReporting();
    new MS::UserReporting::ServerUserReporting();
};
#endif
