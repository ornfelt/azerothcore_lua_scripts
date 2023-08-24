--PLEASE NOTE THAT RAID BUFFS ARE DISABLED IN RAIDS BY DEFAULT
------------------------------------------------------------------------------------------------
-- COMMAND GUIDE  
-- .raidbuff ony 
-- .raidbuff rend 
-- .raidbuff fengus 
-- .raidbuff moldar 
-- .raidbuff slipkik 
-- .raidbuff zg 
-- .raidbuff serenade 
------------------------------------------------------------------------------------------------

------------------------------------------
-- Begin of config section
------------------------------------------

local TEAM_ALLIANCE = 0
local TEAM_HORDE = 1
local TEAM_NEUTRAL = 2

local message = 'Hope you guys enjoy the repack!'

local function splitString(inputstr, seperator)
    if seperator == nil then
        seperator = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..seperator.."]+)") do
        table.insert(t, str)
    end
    return t
end

local function buffPlayers(event, player, command)
    local commandArray = splitString(command)
    if commandArray[1] ~= 'raidbuff' then
        return
    end

    if player ~= nil then
        if player:GetGMRank() < 3 then
            return
        end
    end

    local allyPlayers = GetPlayersInWorld(TEAM_ALLIANCE)
    local hordePlayers = GetPlayersInWorld(TEAM_HORDE)
    local spell

    if commandArray[2] == nil then
        return false
    elseif commandArray[2] == 'ony' then
        spell = 22888
    elseif commandArray[2] == 'rend' then
        spell = 16609
    elseif commandArray[2] == 'fengus' then
        spell = 22817
    elseif commandArray[2] == 'moldar' then
        spell = 22818
    elseif commandArray[2] == 'slipkik' then
        spell = 22820
    elseif commandArray[2] == 'zg' then
        spell = 24425
    elseif commandArray[2] == 'serenade' then
        spell = 15366
    end


    for n = 1, #allyPlayers do
        if allyPlayers[n]:IsAlive() then
            allyPlayers[n]:CastSpell(allyPlayers[n], spell)
            allyPlayers[n]:AddAura(spell, allyPlayers[n])
            allyPlayers[n]:PlayDirectSound(2847, allyPlayers[n])
            allyPlayers[n]:SendBroadcastMessage( message )
        end
    end

    for n = 1, #hordePlayers do
        if hordePlayers[n]:IsAlive() then
            hordePlayers[n]:CastSpell(hordePlayers[n], spell)
            hordePlayers[n]:AddAura(spell, hordePlayers[n])
            hordePlayers[n]:PlayDirectSound(2847, hordePlayers[n])
            hordePlayers[n]:SendBroadcastMessage( message )
        end
    end

    return false
end

local PLAYER_EVENT_ON_COMMAND = 42          -- (event, player, command) - player is nil if command used from console. Can return false
RegisterPlayerEvent(PLAYER_EVENT_ON_COMMAND, buffPlayers)