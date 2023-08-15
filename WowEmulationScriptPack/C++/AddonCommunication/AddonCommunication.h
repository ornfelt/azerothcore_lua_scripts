#pragma once
/*
When an addon message comes that can be taken as an addon message, we will trigger a callback function.
Addon function handlers can be registered by server scripts
*/
class Player;
#define MAX_MESSAGE_LENGTH					250         // this is limited by the wow client 
/*
This is how an addon packet handler should look like
*/
typedef void(*AddonPacketHandler)(Player *PacketSender, const char *msg);

namespace AddonComm
{
    /*
    Checks the list of taken opcodes and generates a new opcode to be used in the list of opcode enums
    */
    uint32 GenerateNewOpcode();
    /*
    Register an opcode handler. Only one handler can be used for each opcode. New calls to this function will update the handler
    */
//    bool RegisterOpcodeHandler(uint32 Opcode, AddonPacketHandler Handler);
    /*
    Register an opcode handler. Only one handler can be used for each opcode. New calls to this function will update the handler
    */
    bool RegisterOpcodeHandler(const char *StringCode, AddonPacketHandler Handler);
    /*
    Reply or send a packet to the client
    */
    void SendMessageToClient(Player *Sender, const char *StringCode, const char *msg);
};
