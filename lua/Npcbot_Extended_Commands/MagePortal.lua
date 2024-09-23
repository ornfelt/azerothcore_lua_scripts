local function CapitalizeFirstLetter(str)
    return (str:gsub("^%l", string.upper))
end

local function MagePortalResponse(playerName, city, spellId, hasRune)
    local player = GetPlayerByName(playerName)
    if player then
        local objects = player:GetNearObjects(30, 3)
        for _, object in ipairs(objects) do
            local creature = object:ToCreature()
            if creature and creature:GetScriptName() == "mage_bot" then
                creature:SetFacingToObject(player)

                local capitalizedCity = CapitalizeFirstLetter(city)

                if hasRune then
                    local portalAnnouncements = {
                        "|cffffffffHang on to your helm, " .. playerName .. "! Portal to " .. capitalizedCity .. " coming right up!|r",
                        "|cffffffffOne-way ticket to " .. capitalizedCity .. " for " .. playerName .. ", coming up! Keep your arms and legs inside the portal at all times.|r",
                        "|cffffffffAbracadabra! Next stop for " .. playerName .. ": " .. capitalizedCity .. "!|r",
                        "|cffffffffBuckle up, " .. playerName .. "! This portal to " .. capitalizedCity .. " might get a bit... bumpy.|r",
                        "|cffffffffWho needs a flight path when you've got me? Portal to " .. capitalizedCity .. " for " .. playerName .. ", stat!|r",
                        "|cffffffffWith the magic word and a flick of the wrist, off to " .. capitalizedCity .. " you go, " .. playerName .. "! Just don't ask me to bring you back...|r",
                        "|cffffffffLet's hope this one doesn't go sideways, eh " .. playerName .. "? Portal to " .. capitalizedCity .. ", coming through!|r",
                        "|cffffffffWhoops! Last time I did this, I ended up in a murloc village... Just kidding, " .. playerName .. "! " .. capitalizedCity .. ", here you come!|r",
                    }
                    local announcement = portalAnnouncements[math.random(#portalAnnouncements)]
                    creature:SendUnitSay(announcement, 0)
                    creature:CastSpell(player, spellId, false)
                else
                    creature:SendUnitSay("|cffffffffSorry, I don't have any Rune of Portals on me... Go buy one and I'll gladly give you a port, " .. playerName .. ".|r", 0)
                end
                return 
            end
        end
    end
end

local function MageBotGreetingResponse(playerName, greeting)
    local player = GetPlayerByName(playerName)
    if player then
        local objects = player:GetNearObjects(30, 3)
        for _, object in ipairs(objects) do
            local creature = object:ToCreature()
            if creature and creature:GetScriptName():match("_bot$") then
                creature:SetFacingToObject(player)
                local personalizedGreeting = greeting:gsub("%%s", playerName)  
                creature:SendUnitSay(personalizedGreeting, 0)
                creature:PerformEmote(70)  
                return
            end
        end
    end
end

local function PaladinBotDivineIntervention(playerName)
    local player = GetPlayerByName(playerName)
    if player then
        local objects = player:GetNearObjects(60, 3) 
        for _, object in ipairs(objects) do
            local creature = object:ToCreature()
            if creature and creature:GetScriptName() == "paladin_bot" then
                creature:SetFacingToObject(player)
                creature:CastSpell(player, 19752, true) 
                return
            end
        end
        player:SendAreaTriggerMessage("No Paladin Bot found nearby!")
    end
end

local function CheckForDivineInterventionRequest(msg, player)
    local normalizedMsg = msg:lower()
    if normalizedMsg == "di me" then
        local playerName = player:GetName()
        player:RegisterEvent(function()
            PaladinBotDivineIntervention(playerName)
        end, 500, 1) 
    end
end

local function PaladinBotSalvation(playerName)
    local player = GetPlayerByName(playerName)
    if player then
        local objects = player:GetNearObjects(60, 3)  
        for _, object in ipairs(objects) do
            local creature = object:ToCreature()
            if creature and creature:GetScriptName() == "paladin_bot" then
                creature:SetFacingToObject(player)
                creature:CastSpell(player, 1038, true)  
                return
            end
        end
        player:SendAreaTriggerMessage("No Paladin Bot found nearby!")  
    end
end

local function CheckForSalvationRequest(msg, player)
    local normalizedMsg = msg:lower()
    if normalizedMsg == "salv me" then
        local playerName = player:GetName()
        player:RegisterEvent(function()
            PaladinBotSalvation(playerName)
        end, 500, 1)  
    end
end

local function MageBotOnPlayerChat(event, player, msg, Type, lang)
    CheckForDivineInterventionRequest(msg, player)
	CheckForSalvationRequest(msg, player)
	
    local greetings = {
        "|cffffffffHey there %s!|r",
        "|cffffffffHello, how can I assist you today?|r",
        "|cffffffffGreetings, %s!|r",
        "|cffffffffHi! Need something?|r",
        "|cffffffffYo %s! What's up?|r",
		"|cffffffffHey! Wanna do a quick dungeon run? I promise I won't ninja loot!|r",
        "|cffffffffHi %s! Doing some quests?|r",
        "|cffffffffHello! Fancy a dungeon run?|r",
        "|cffffffffHey, what's up?|r",
        "|cffffffffHowdy! What are you up to?|r",
		"|cffffffffYo %s! How's it going?|r",
		"|cffffffffHello %s! Up for some action?|r",
		"|cffffffffHeya %s! How's the grind?|r",
		"|cffffffffHeya! How's it hanging?|r",
		"|cffffffffWhat's up %s? Wanna grind some rep?|r",
		"|cffffffffYo! How's it going, %s?|r",  
        "|cffffffffWhat's up, %s?|r",
        "|cffffffffHeya %s! It's great to see you again!|r",
		"|cffffffffYo %s! What's the latest?|r",
	    "|cffffffffHeya %s! Still on the loot hunt?|r",
		"|cffffffffYo %s! Up for some skirmishes?|r",
		"|cffffffffYo %s, ready to crush some quests?|r",
        "|cffffffffWhat's good, %s? Dinged any levels lately?|r", 
		"|cffffffff%s, you up for some late-night raiding?|r",
		"|cffffffffYo %s, check out my new transmog! What do you think?|r",
        "|cffffffffSup %s, wanna team up for some PvP?|r",
        "|cffffffff%s, up for a dungeon crawl? Could use your skills!|r",
        "|cffffffffSup %s, heard any good jokes in Trade Chat?|r",
		"|cffffffffYo %s, if we wipe, it's totally not my fault... probably.|r",
        "|cffffffffWhat's up, %s? My last group was tougher than a raid boss!|r",
        "|cffffffffHey %s, let's not pull a Leeroy today, okay?|r",
        "|cffffffffYo %s, got any spare potions? I drank mine in the auction house...|r",
        "|cffffffffSup %s? If we get lost, it's the map's fault, not mine.|r",
        "|cffffffff%s, my last party was so slow, a turtle made it to the water before we did.|r",
        "|cffffffffWhat's the plan, %s? If it involves running, count me out. I'm allergic.|r",
        "|cffffffff%s, last time I said 'nothing could possibly go wrong,' it went wonderfully wrong.|r",
        "|cffffffffHey %s, if we see a big red button, I'm definitely not promising I won't push it.|r",
        "|cffffffffHey %s, got your Frost Resistance gear? Naxx is chilly this time of year.|r",
        "|cffffffffHey %s, avoid the Deeprun Tram rats. Heard they're as tough as raid bosses!|r",
        "|cffffffffYo %s, got your Onyxia attunement yet? Just kidding, who does?|r",
        "|cffffffffYo %s, remember when epic mounts felt fast? Pepperidge Farm remembers.|r",
        "|cffffffffHeya %s! I heard a rumor that Mankrik finally found his wife. Turns out she was in the Undercity Auction House all along.|r",
    }

    local function GetRandomGreeting()
        return greetings[math.random(#greetings)]
    end

local function IsGreeting(msg)
    local lowerMsg = msg:lower()
    return lowerMsg == "hi" or
           lowerMsg == "hello" or
           lowerMsg == "hey" or
		   lowerMsg == "heya" or
           lowerMsg == "sup" or
           lowerMsg == "yo" or
           lowerMsg == "hola" or  
           lowerMsg == "greetings" or
           lowerMsg == "good day" or
           lowerMsg == "what's up" or
           lowerMsg == "howdy" or
           lowerMsg == "what's good" or
           lowerMsg:find("what's up") or
           lowerMsg:find("how's it going") or
           lowerMsg:find("how are you") or
           lowerMsg:find("what's happening") or
           lowerMsg:find("hey there") or
           lowerMsg:find("hi there") or
           lowerMsg:find("yo yo") or
           lowerMsg:find("sup")  
end


    if IsGreeting(msg) then
        local playerName = player:GetName()
        local greeting = GetRandomGreeting()
        player:RegisterEvent(function()
            MageBotGreetingResponse(playerName, greeting)
        end, 1500, 1) 
        return
    end

 local lowerMsg = msg:lower()
    local runeOfPortals = 17032

    local alliancePortals = {
        ["stormwind"] = 10059,
		["sw"] = 10059,
        ["ironforge"] = 11416,
		["if"] = 11416,
        ["darnassus"] = 11419,
		["darn"] = 11419,
        ["exodar"] = 32266,
		["exo"] = 32266,
        ["theramore"] = 49360,
		["thera"] = 49360,
    }

    local hordePortals = {
        ["orgrimmar"] = 11417,
		["org"] = 11417,
        ["uc"] = 11418,
        ["undercity"] = 11418,
        ["thunder bluff"] = 11420,
		["tb"] = 11420,
        ["silvermoon"] = 32267,
        ["stonard"] = 49361,
		["ston"] = 49361,
    }

    local neutralPortals = {
        ["shattrath"] = 33691,
		["shatt"] = 33691,
		["shat"] = 33691,
        ["dala"] = 53142,
        ["dal"] = 53142,
        ["dalaran"] = 53142,
    }

    local factionPortals = player:IsAlliance() and alliancePortals or hordePortals
    for city, spellId in pairs(neutralPortals) do
        factionPortals[city] = spellId
    end

    for city, spellId in pairs(factionPortals) do
        local pattern = city:gsub("%s+", "%%s+")
        if lowerMsg:match(".-portal to " .. pattern .. "%.?") or
           lowerMsg:match(".-port to " .. pattern .. "%.?") or
           lowerMsg:match("wtb portal to " .. pattern .. "%.?") or
           lowerMsg:match("wtb port to " .. pattern .. "%.?") or
           lowerMsg:match("lf portal to " .. pattern .. "%.?") or
           lowerMsg:match("lf port to " .. pattern .. "%.?") or
           lowerMsg:match("can i get a portal to " .. pattern .. "%.?") or
           lowerMsg:match("can i get a port to " .. pattern .. "%.?") then
            local hasRune = player:HasItem(runeOfPortals, 1)
            if hasRune then
                player:RemoveItem(runeOfPortals, 1)
            end

            local playerName = player:GetName()
            player:RegisterEvent(function()
                MagePortalResponse(playerName, city, spellId, hasRune) 
            end, 1300, 1)

            break  
        end
    end
end

RegisterPlayerEvent(18, MageBotOnPlayerChat)
RegisterPlayerEvent(20, MageBotOnPlayerChat)
