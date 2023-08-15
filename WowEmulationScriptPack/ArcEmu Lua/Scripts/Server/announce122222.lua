    local message1 = "Welcome to World of the Damned Elite!"
    local message2 = "Please report any bugs onto the site."
    local message3 = "Please keep voting for vote points every 12 hours."
    local message4 = "Please do not try to go agaisnt any of the server rules."
 
function World_AutoAnnounce()
        Announce=math.random(1,4)
                if Announce==1 then
                        SendWorldMessage(message1, 2)
                if Announce==2 then
                        SendWorldMessage(message2, 2)
                end
                if Announce==3 then
                        SendWorldMessage(message3, 2)
                end
                if Announce==4 then
                        SendWorldMessage(message4, 2)
end
end
end
 
RegisterTimedEvent("World_AutoAnnounce", 1800000, 0)