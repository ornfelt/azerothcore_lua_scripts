local function OnCommand(event, player, command)
    if(command == "test") then
    local plrs = GetPlayersInWorld()
    for i,v in pairs(plrs)do
        print(v:GetGUIDLow().." "..v:GetName())
    end
    end
end

RegisterPlayerEvent(42, OnCommand)