--Owner: Didrik
--Purpose: Disables ticket creation in-game. We want all tickets to be created through Discord.

local CMSG_GMTICKET_CREATE = 517
local SMSG_GMTICKET_CREATE = 518
local PACKET_EVENT_ON_PACKET_RECEIVE = 5
local PACKET_EVENT_ON_PACKET_SEND = 7

local function CatchNewTicketPacket(event, packet, player)
    player:SendBroadcastMessage("Tickets are disabled in-game. Create a ticket through Discord by using the #help-desk channel.")
    return false
end

RegisterPacketEvent( CMSG_GMTICKET_CREATE, PACKET_EVENT_ON_PACKET_SEND, CatchNewTicketPacket )