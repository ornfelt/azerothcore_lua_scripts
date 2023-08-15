ACCOUNT_LEVEL = 3

local function SetSkin(event, player, command)
        if (command:find("setskin") ~= 1) then
                return
        elseif (player:GetGMRank() < ACCOUNT_LEVEL) then
                return false
        end

        local pattern = "%S+" -- Separate by spaces
        local parameters = {}
        local parameters = getCommandParameters(command)
        local target = player:GetSelection()
        local customizetype = tostring(parameters[2])
        local customizeid = tonumber(parameters[3])

        if (customizetype == nil) then
                player:SendBroadcastMessage("Invalid type. You can change: face, skin, hairstyle, haircolor, facialstyle")
                return false
        elseif (customizeid == nil) then
                player:SendBroadcastMessage("You need to specify an ID to set the type to.")
                return false
        end


        if (target == nil) then
                player:SendBroadcastMessage("You must have a target.")
                return false
        elseif (target:ToPlayer() == nil) then
                player:SendBroadcastMessage("You must target a player.")
                return false
        end


        if (customizetype == "face") then
                target:SetFace(customizeid)
                player:SendBroadcastMessage("Set Face to " .. customizeid .. ".")
                return false
        elseif (customizetype == "skin") then
                target:SetSkin(customizeid)
                player:SendBroadcastMessage("Set Skin to " .. customizeid .. ".")
                return false
        elseif (customizetype == "hairstyle") then
                target:SetHair(customizeid)
                player:SendBroadcastMessage("Set Hair to " .. customizeid .. ".")
                return false
        elseif (customizetype == "haircolor") then
                target:SetHairColor(customizeid)
                player:SendBroadcastMessage("Set HairColor to " .. customizeid .. ".")
                return false
        elseif (customizetype == "facialstyle") then
                target:SetFacial(customizeid)
                player:SendBroadcastMessage("Set FacialStyle to " .. customizeid .. ".")
                return false
        end


end

local function GetSkin(event, player, command)
        if (command:find("getskin") ~= 1) then
                return
        elseif (player:GetGMRank() < ACCOUNT_LEVEL) then
                return false
        end

        local pattern = "%S+" -- Separate by spaces
        local parameters = {}
        local parameters = getCommandParameters(command)
        local target = player:GetSelection()
        local customizetype = tostring(parameters[2])

        if (customizetype == nil) then
                player:SendBroadcastMessage("Invalid type. You can change: face, skin, hairstyle, haircolor, facialstyle")
                return false
        end

        if (target == nil) then
                player:SendBroadcastMessage("You must have a target.")
                return false
        elseif (target:ToPlayer() == nil) then
                player:SendBroadcastMessage("You must target a player.")
                return false
        end


        if (customizetype == "face") then
                player:SendBroadcastMessage("Player Face ID is: " .. target:GetFace())
                return false
        elseif (customizetype == "skin") then
                player:SendBroadcastMessage("Player Skin ID is: " .. target:GetSkin())
                return false
        elseif (customizetype == "hairstyle") then
                player:SendBroadcastMessage("Player HairStyle ID is: " .. target:GetHair())
                return false
        elseif (customizetype == "haircolor") then
                player:SendBroadcastMessage("Player HairColor ID is: " .. target:GetHairColor())
                return false
        elseif (customizetype == "facialstyle") then
                player:SendBroadcastMessage("Player FacialStyle ID is: " .. target:GetFacial())
                return false
        else
                player:SendBroadcastMessage("Invalid type. You can query for: face, skin, hairstyle, haircolor, facialstyle")
                return false
        end


end

RegisterPlayerEvent(42, SetSkin)
RegisterPlayerEvent(42, GetSkin)
