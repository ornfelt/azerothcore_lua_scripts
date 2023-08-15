local WorldMessages = {
"Hello, this is the first message!", 
"Hello, this is the second message!",
"Hello, this is the third message!"
}

function World_AutoAnnounce()
        Announce=math.random(1,3) -- Change it if you gonna add more, just change 3 with last number of announces.
                if Announce==1 then
                        SendWorldMessage(WorldMessages[1], 2) -- [1] is for first Message from the Table. 2 is for Chatbox message, if you want WideScreen, use 1.
                end
                if Announce==2 then
                        SendWorldMessage(WorldMessages[2], 2) -- [2] is for first Message from the Table. 2 is for Chatbox message, if you want WideScreen, use 1.
                end
		if Announce==3 then
			SendWorldMessage(WorldMessages[3], 2) -- [3] is for first Message from the Table. 2 is for Chatbox message, if you want WideScreen, use 1.
end
 
RegisterTimedEvent("World_AutoAnnounce", 60000, 0) -- 60000 means 1 minute, it's in miliseconds. You can change it!