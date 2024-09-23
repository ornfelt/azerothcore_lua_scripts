--Owner: Didrik
--Purpose: On duel ending, the core code dictates that everyone who has visibility of the winning duelist gets a message. Since our visibility range is maxed out, this'll be super annoying.
-- We'll catch the SMSG_DUEL_WINNER packet and stop it from getting to players, just to avoid a core edit. Keep it simple - with ELUNA!

local SMSG_DUEL_WINNER = 363
local PACKET_EVENT_ON_PACKET_SEND = 7

local function CatchDuelWinnerPacket(event, packet, player)
    --print("Caught duel winner packet!")
    return false
end

RegisterPacketEvent( SMSG_DUEL_WINNER, PACKET_EVENT_ON_PACKET_SEND, CatchDuelWinnerPacket )
