--[[
    Used to learn a random spell within the players current range. 

    Need logic for pre-req level requirements

    NEED TO ADD LOGIC FOR CURRENCY, act like ascension and deduct a currency each level if the player has it
        if they dont, dont learn the spell.
]]

require "RandomSpell/rollstable"

local AIO = AIO or require("AIO")
local AioHandler = AIO.AddHandlers("RandomSpell", {})
isServer = AIO.IsServer()

local PLAYER_EVENT_ON_LEVEL_CHANGE = 13

local function CheckSpell(player, curspell, curlvl, curspelllvl)
    if (player:HasSpell(curspell) == false) then
        local currentpos = 0
        if (curspelllvl == curlvl) then 
            currentpos = curspell
            return currentpos
        elseif(curspelllvl <= curlvl) then
            currentpos = curspell
            return currentpos
        end
    end
end

-- Will check prereqs in the rollstable file, if there are any found, add them to a table and roll to learn one instead of the original curspell
-- Otherwise just returns the curspell. NOT PERFECT, doesnt check the prereq level requirements
local function CheckPreReq(player, curspell, curlvl, curspelllvl, prereqs)
    local rollprereq = {}
    local int = 1
    for m, n in pairs(prereqs)do
        local hspell = prereqs[m]
        if (player:HasSpell(hspell) == false) then
            if (curspelllvl <= curlvl) then 
                rollprereq[int] = hspell
                int = int + 1
            end
        else return curspell end
    end
    if (rollprereq[1] ~= nil) then
        local rolledreq = rollprereq[math.random(#rollprereq)]
        return rolledreq
    end
end


local function DingSpell (event, player, oldlvl)
    local curlvl = player:GetLevel()
    local curlvlspells = {}
    local int = 1 -- used for he curlvlspells table for indexing
    if (curlvl >= oldlvl and curlvl % 2 == 0) then
        --Roll spells
        for i,v in pairs(spelltable) do -- Iterates through classes in spelltable
            for e, d in pairs(v) do -- Iterates through spell-infos in classtable
                local curspell = d[1][1] -- SpellID
                local prereqs = d[5] -- Pre-req spell for roll
                local curspelllvl = d[2][1] -- Spell ReqLevel
                if (prereqs[1] == 0) then
                    local checked = CheckSpell(player, curspell, curlvl, curspelllvl)
                    if (checked ~= nil) then
                        curlvlspells[int] = checked
                        int = int + 1
                    end
                else
                    local chkreq = CheckPreReq(player, curspell, curlvl, curspelllvl, prereqs)
                    if (chkreq ~= nil) then
                        curlvlspells[int] = chkreq
                        int = int + 1
                    end
                end
            end
        end
    end
    if (next(curlvlspells) == nil) then 
        return 
    else
        RollSpell(player, curlvlspells)
    end
end

local function toTable(string)
    local t = {}
    if string ~= "" then
        for i in string.gmatch(string, "([^,]+)") do
            table.insert(t, tonumber(i))
        end
    end
    return t
end

local function toString(tbl)
    local string = ""
    if #tbl > 1 then
        string = table.concat(tbl, ",")
    elseif #tbl == 1 then
        string = tbl[1]
    end
    return string
end

function RollSpell(player, torollspells)
    local roll = torollspells[math.random(#torollspells)]
    AIO.Handle(player, "RandomSpell", "LoadMsg", roll)
    AIO.Handle(player, "RandomSpell", "ShowFrame")
    -- DB QUERY JUNK------------------
    local pguid =player:GetGUIDLow()
    local qspells = CharDBQuery("SELECT spells FROM character_classless WHERE guid = " .. tostring(pguid))
    local qspellstr = qspells:GetString(0)
    knownspells = toTable(qspellstr)
    lastspell = #knownspells + 1
    knownspells[lastspell] = roll
    stringspell = toString(knownspells)
    CharDBQuery("UPDATE character_classless SET spells ='" .. stringspell .. "' WHERE guid = " .. tostring(pguid))
    ----------------------------------
    player:LearnSpell(roll)
    player:SaveToDB()
    roll = nil
end

RegisterPlayerEvent(PLAYER_EVENT_ON_LEVEL_CHANGE, DingSpell)