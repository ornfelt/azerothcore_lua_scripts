--Credits go to Dinkledork
--This script was made for someone who wanted to receive xp for low level mobs. 
--The Calculations are based on these results online, but they're probably too high so change them to whatever you want.:
--XP = (Char Level * 5) + 45, where Char Level = Mob Level, for mobs in Azeroth
--XP = (Char Level * 5) + 235, where Char Level = Mob Level, for mobs in Outland
--XP = (Char Level * 5) + 580, where Char Level = Mob Level, for mobs in Northrend
--XP = (Char Level * 5) + 1878, where Char Level = Mob Level, for mobs in Cataclysm

local ENABLED = false --change to true or false depending on whether or not you want the script enabled.
local XP_MODIFIER = 0.05 --change me to be whatever you want
local BASE_XP = 15

--You don't need to modify anything below.

-- Function to be called when a player kills a creature
local function OnKillCreature(event, player, creature)
  -- Check if the experience calculation and award is enabled
  if ENABLED then
    -- Check if the creature's level is not equal to 1
    if creature:GetLevel() ~= 1 then
      -- Check if the creature's level is 5 levels or lower than the player's level
      if creature:GetLevel() <= player:GetLevel() - 5 then
        -- Calculate the experience value
        local xp = (player:GetLevel() * XP_MODIFIER) + BASE_XP
        -- Give the player the experience
        player:GiveXP(xp, creature)
      end
    end
  end
end

-- Function to enable or disable the experience calculation and award
function EnableXPAward(enable)
  ENABLED = enable
end

-- Register the OnKillCreature function for the player event 7
RegisterPlayerEvent(7, OnKillCreature)
