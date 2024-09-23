--[[ DO NOT EDIT ]] --
VIP = {}
VIP.Config = {}
VIP.Config.Actions = {}
VIP.Config.Texts = {}


-- [[ FROM HERE YOU CAN EDIT ]] --

-- Misc
-- ID of the Transmorgifier NPC
VIP.Config.TransmorgifierID = 190010
-- ItemID you entered in vip_item.sql
VIP.Config.ItemID = 100001

-- Texts
VIP.Config.Texts.YesVIP = "[VIP] Sos VIP <3."
VIP.Config.Texts.NoVIP = "[VIP] No sos VIP :("
VIP.Config.Texts.AuctioneerError = "[VIP] Error interno al spawnear subastador."
VIP.Config.Texts.CDReset = "Se reseteo el CD de la piedra."
VIP.Config.Texts.Repair = "Se han reparado todos tus items."

-- Actions
-- Format is {Enabled, Text, ListID(Unique)}

VIP.Config.Actions.Bank = {true, "Banco", 0}
VIP.Config.Actions.Auction = {true, "Subasta", 1}
VIP.Config.Actions.Mail = {true, "Correo", 2}
-- Requires https://github.com/azerothcore/mod-transmog
VIP.Config.Actions.Transmog = {false, "Transmog", 3}
--
VIP.Config.Actions.Hearthstone = {true, "Resetear CD Piedra", 4}
VIP.Config.Actions.Repair = {true, "Reparar Items", 5}
VIP.Config.Actions.NeutralAuction = {true, "Subasta Neutral", 6}
