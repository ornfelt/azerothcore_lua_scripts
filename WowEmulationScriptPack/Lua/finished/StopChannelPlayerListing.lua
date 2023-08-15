--Owner: Didrik
--Purpose: Not allowing players to see who is in a channel using the Social menu 'chat' tab. Also disable /who packets from being replied to.
-- We'll catch the SMSG_CHANNEL_LIST packet and stop it from getting to players, just to avoid a core edit. Same with SMSG_WHO (/who list, including online player count).
-- Keep it simple - with ELUNA!

local SMSG_CHANNEL_LIST = 155
local PACKET_EVENT_ON_PACKET_SEND = 7
local SMSG_WHO = 99
local ACCOUNT_LEVEL = 3

local function CatchChannelListPacket(event, packet, player)
    if (player:GetGMRank() < ACCOUNT_LEVEL) then
        --print("Caught channel list packet!")
        return false
    else
        return
    end
end

local function CatchWhoListPacket(event, packet, player)
    if (player:GetGMRank() < ACCOUNT_LEVEL) then
        --print("Caught who list packet!")
        return false
    else
        return
    end
end

RegisterPacketEvent( SMSG_CHANNEL_LIST, PACKET_EVENT_ON_PACKET_SEND, CatchChannelListPacket )
RegisterPacketEvent( SMSG_WHO, PACKET_EVENT_ON_PACKET_SEND, CatchWhoListPacket )