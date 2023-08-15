#include "Chat.h"
#include "WorldSession.h"
#include "GameEventCallbacks.h"
#include "AddonCommunication.h"

namespace AddonComm
{
    #define OpcodeStartChar0 '.'
    #define OpcodeStartChar1 '#'

    struct PacketHandlerHolder
    {
        uint32 Opcode;
        AddonPacketHandler HandlerFunc; // function that will be called in case we receive a message from the client that can be interpreted
    };

    std::map<uint32, PacketHandlerHolder*> AddonPacketHandlers;

    uint32 GenerateNewOpcode()
    {
        //we can only use bytes that can be interpreted into ascii chars
        const char *PickableBytes = " !#$%&'()*+,-./0123456789:;<=>?`ABCDEFGHIJKLMOPQRSTUVWXYZ[~]^_@abcdefghijklmnopqrstuvwxyz{|}\"\\";
        const int NumberOfUsableChars = (int)strlen(PickableBytes);
        char NewOpcodeIndexes[4];        
        for (int i = 0; i < 4; i++)
            NewOpcodeIndexes[i] = 0;
        do {
            //convert the combinatory vector to a result
            char NewOpcode[4];
            for (int i = 0; i < 4; i++)
                NewOpcode[i] = PickableBytes[NewOpcodeIndexes[i]];

            //the actual Opcode
            uint32 Opcode = *(uint32*)&NewOpcode[0];

            //is this combo good ?
            auto itr = AddonPacketHandlers.find(Opcode);
            bool OpcodeIsTaken = false;
            if (itr != AddonPacketHandlers.end())
                OpcodeIsTaken = true;
            if (OpcodeIsTaken == false)
                return Opcode;

            //try to generate a new combo
            NewOpcodeIndexes[3]++;
            for (int i = 3; i > 0; i--)
                if (NewOpcodeIndexes[i] >= NumberOfUsableChars)
                {
                    NewOpcodeIndexes[i - 1]++;
                    NewOpcodeIndexes[i] = 0;
                }
        } while (1);
        return 0;
    }

    bool RegisterOpcodeHandler(uint32 Opcode, AddonPacketHandler Handler)
    {
        auto itr = AddonPacketHandlers.find(Opcode);
        if (itr != AddonPacketHandlers.end())
        {
#ifdef _DEBUG
            ASSERT(false);
#endif
            itr->second->HandlerFunc = Handler;
            return true;
        }
        PacketHandlerHolder *ph = new PacketHandlerHolder;
        ph->Opcode = Opcode;
        ph->HandlerFunc = Handler;
        AddonPacketHandlers[Opcode] = ph;
        return false;
    }

    bool RegisterOpcodeHandler(const char *StringCode, AddonPacketHandler Handler)
    {
        ASSERT(StringCode[4] == 0);
        uint32 Opcode = *(uint32*)&StringCode[0];
        return RegisterOpcodeHandler(Opcode, Handler);
    }

    void SendMessageToClient(Player *p, const char *StringCode, const char *msg)
    {
        ASSERT(strlen(StringCode) == 4);
        ASSERT(strlen(msg) < 250);
        char NewOpcode[7];
        sprintf_s(NewOpcode, sizeof(NewOpcode), "%c%c%s", OpcodeStartChar0, OpcodeStartChar1, StringCode);
        std::string srpl(msg);
        std::string schnl(NewOpcode);
        WorldPacket data;
        ChatHandler::BuildChatPacket(data, CHAT_MSG_CHANNEL, LANG_UNIVERSAL, p, p, srpl, 0, schnl);
        p->GetSession()->SendPacket(&data);
    }

    void AddonComChatMessageReceived(void *p, void *)
    {
        CP_CHAT_RECEIVED *params = PointerCast(CP_CHAT_RECEIVED, p);
        if (params->MsgType != CHAT_MSG_GUILD)
            return;
        const char *msg = params->Msg->c_str();
        //our opcodes will 
        if (msg[1] != OpcodeStartChar0 || msg[2] != OpcodeStartChar1)
            return;
        uint32 Opcode = *(uint32*)&msg[3];
        auto itr = AddonPacketHandlers.find(Opcode);
        if (itr == AddonPacketHandlers.end())
            return;
        itr->second->HandlerFunc(params->SenderPlayer, &msg[7]);
        params->DenyDefaultParsing = 1;
    }
}

void AddAddonCommunicationScripts()
{
    RegisterCallbackFunction(CALLBACK_TYPE_CHAT_RECEIVED, AddonComm::AddonComChatMessageReceived, NULL);
}
