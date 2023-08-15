local OrientationCoord = 0.000 -- Change with your Orientation. (Go In-game and use .GPS Command).
 
function Player_OnFirstEnterWorld(event, player)
        player:SetFacing(OrientationCoord)
        player:SetOrientation(OrientationCoord)
end
 
RegisterServerHook(3, "Player_OnFirstEnterWorld")