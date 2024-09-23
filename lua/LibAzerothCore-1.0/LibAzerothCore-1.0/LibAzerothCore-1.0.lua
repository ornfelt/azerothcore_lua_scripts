local L = LibStub and LibStub:NewLibrary("LibAzerothCore-1.0",6)
if not L then return end

local print, ipairs, assert, floor, tinsert =
      print, ipairs, assert, math.floor, table.insert

local DEBUG = false -- set this to true for debug output

local function dummyfunc() end
local log_debug, log_debug_f
if DEBUG then
  log_debug = print
  log_debug_f = function(m, ...) print(m:format(...)) end
else
  log_debug = dummyfunc
  log_debug_f = dummyfunc
end

local isAzeroth
local expectedCommands = {}
local recvBuffers = {}
local loaders = {}
local function doLoaders() for _,l in ipairs(loaders) do l() end loaders = {} end

local commandCounter = 1
local counterChars = { '0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z' }
local numCounterChars = #counterChars
local function CommandCounterToString(counter)
  local char4,char3,char2,char1
  char4 = counter % numCounterChars
  counter = floor(counter/numCounterChars)
  char3 = counter % numCounterChars
  counter = floor(counter/numCounterChars)
  char2 = counter % numCounterChars
  counter = floor(counter/numCounterChars)
  char1 = counter % numCounterChars
  return ("%s%s%s%s"):format(counterChars[char1+1], counterChars[char2+1], counterChars[char3+1], counterChars[char4+1])
end

local frame = CreateFrame("Frame")
frame:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
  if event == "PLAYER_ENTERING_WORLD" then
    self:UnregisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("CHAT_MSG_ADDON")
    SendAddonMessage("AzerothCore", "p0000", "WHISPER", (UnitName("player")))
    return
  end
  assert(event == "CHAT_MSG_ADDON")
  if prefix ~= "AzerothCore" then return end
  if sender ~= UnitName("player") then return end
  if isAzeroth == nil then
    if message == "p0000" then
      isAzeroth = false
      log_debug("not Azerothcore, got ping back")
      self:UnregisterEvent("CHAT_MSG_ADDON")
      doLoaders()
    elseif message == "a0000" then
      isAzeroth = true
      log_debug("Azerothcore detected")
      doLoaders()
    else
      log_debug_f("got unknown message '%s' before ping reply - unknown source, maybe from before reload?", message)
    end
    return
  end
  
  local op, counter, text = message:match("^([afom])([0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z])(.*)$")
  if not op then
    log_debug_f("Unknown message '%s' - unknown opcode or server error?", message)
    return
  end
  if not expectedCommands[counter] then -- not ours
    return
  end
  if op == "a" then -- a Command Acknowledged
    if recvBuffers[counter] then
      log_debug_f("Duplicate Ack opcode for %s", counter)
      return
    end
    recvBuffers[counter] = {}
  elseif op == "m" then -- m Command Message
    if not recvBuffers[counter] then
      log_debug_f("Message opcode out of sequence for %s", counter)
      return
    end
    tinsert(recvBuffers[counter], text)
  elseif op == "o" or op == "f" then -- o Command End OK, f Command End Failed
    if not recvBuffers[counter] then
      log_debug_f("End opcode out of sequence for %s", counter)
      return
    end
    expectedCommands[counter](op == "o", recvBuffers[counter])
    expectedCommands[counter] = nil
    recvBuffers[counter] = nil
  end
end)
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- nil if unknown, true if AzerothCore, false if not AzerothCore (or unsupported version)
function L:IsAzerothCore() return isAzeroth end
-- passed func will be called with no arguments once a supported AzerothCore version is detected
function L:RegisterLoader(func) if isAzeroth == nil then tinsert(loaders,func) else func() end end
-- Issue command to server. Callback will receive (success, array of lines) on command finish.
function L:DoCommand(cmd, callback, humanReadable)
  if isAzeroth == nil then
    self:RegisterLoader(function() L:DoCommand(cmd,callback,humanReadable) end) -- delay until detection finishes
    return
  end
  if isAzeroth == false then
    callback(false, {"Server is not running a supported AzerothCore version"})
    return
  else
    callback(false, {"Server is running a supported AzerothCore version"})
  end
  local counter = CommandCounterToString(commandCounter)
  expectedCommands[counter] = callback or dummyfunc
  SendAddonMessage("AzerothCore", (humanReadable and "h%s%s" or "i%s%s"):format(counter,cmd), "WHISPER", (UnitName("player")))
  commandCounter = commandCounter+1
end
