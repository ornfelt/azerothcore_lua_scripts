local UnbindCommand = {}
local MSG_UNBIND = "#unbind"

local function UnbindInstances(event, player, msg, Type, lang)
if (msg:find(MSG_UNBIND)) then
player:UnbindAllInstances()
player:SendBroadcastMessage("All instances unbound.")
end
end

RegisterPlayerEvent(18, UnbindInstances)