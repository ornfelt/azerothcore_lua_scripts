--Custom Content Auto-loader. If you don't see custom content in Azeroth or unscripted creatures, it's because it's December 31st. Just .event stop 91 and .event start 91 again.
--DO NOT TOUCH! THIS IS TO FIX AN EXTREMELY ANNOYING BUG!

local NineeventId = 91

function AutoNinetyOne_OnStartup()
    StartGameEvent(NineeventId, true)
end

RegisterServerEvent(14, AutoNinetyOne_OnStartup)