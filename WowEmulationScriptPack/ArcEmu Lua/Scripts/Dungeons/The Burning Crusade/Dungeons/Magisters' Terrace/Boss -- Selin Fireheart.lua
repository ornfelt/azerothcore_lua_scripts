--[[ Boss -- Selin Fireheart.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, February 01, 2009. ]]
--[[
__--Sound Files--__
Unit:PlaySoundToSet(12378) - You only waste my time!
Unit:PlaySoundToSet(12382) - Yes! I am a god!
Unit:PlaySoundToSet(12383) - No! More...I must have more!
Unit:PlaySoundToSet(12381) - My hunger knows no bounds!
Unit:PlaySoundToSet(12388) - Enough distractions!
--]]

function SelinFireheart_OnSpawn(Unit,Event)
	Unit:SetMana(0)
	Unit:SetMaxMana(32310)
end

function SelinFireheart_OnEnterCombat(Unit,Event)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL, "You only waste my time!")
	Unit:PlaySoundToSet(12378)
	Unit:RegisterEvent("SelinFireheart_Phase1Move", 17000, 1)
end

function SelinFireheart_Phase1Move1(Unit,Event)
local plr = Unit:GetClosestPlayer()
 if plr == nil then -- nil check.
	return
	else
	Unit:SetCombatMeleeCapable(1)
-- Crystal 1 should be left (on stage)
-- Crystal 2 should be middle (on stage)
-- Crystal 3 should be right (on stage)
-- Crystal 4 should be left (on floor)
-- Crystal 5 should be right (on floor)
local Choice = math.random(1,5)
 if Choice == 1 then
	Unit:MoveTo(X,Y,Z,O)
	Unit:RegisterEvent("SelinFireheart_Crystal1", 4000, 0)
 end
 if Choice == 2 then
	Unit:MoveTo(X,Y,Z,O)
	Unit:RegisterEvent("SelinFireheart_Crystal2", 4000, 0)
 end
 if Choice == 3 then
	Unit:MoveTo(X,Y,Z,O)
	Unit:RegisterEvent("SelinFireheart_Crystal3", 4000, 0)
 end
 if Choice == 4 then
	Unit:MoveTo(X,Y,Z,O)
	Unit:RegisterEvent("SelinFireheart_Crystal4", 4000, 0)
 end
 if Choice == 5 then
	Unit:MoveTo(X,Y,Z,O)
	Unit:RegisterEvent("SelinFireheart_Crystal5", 4000, 0)
  end
 end
end

function SelinFireheart_Crystal1(Unit,Event)
	Unit:RemoveEvents()
	local X = Unit:GetX()
	local Y = Unit:GetY()
	local Z = Unit:GetZ()
	local crystal = Unit:GetCreatureNearestCoords(X,Y,Z,24722)
	Unit:SetCombatMeleeCapable(1)
	Unit:FullCastSpellOnTarget(44294,crystal)
	Unit:CastSpell(8358)
end

function SelinFireheart_Crystal2(Unit,Event)
	Unit:RemoveEvents()
	local X = Unit:GetX()
	local Y = Unit:GetY()
	local Z = Unit:GetZ()
	local crystal = Unit:GetCreatureNearestCoords(X,Y,Z,24722)
	Unit:SetCombatMeleeCapable(1)
	Unit:FullCastSpellOnTarget(44294,crystal)
	Unit:CastSpell(8358)
end

function SelinFireheart_Crystal3(Unit,Event)
	Unit:RemoveEvents()
	local X = Unit:GetX()
	local Y = Unit:GetY()
	local Z = Unit:GetZ()
	local crystal = Unit:GetCreatureNearestCoords(X,Y,Z,24722)
	Unit:SetCombatMeleeCapable(1)
	Unit:FullCastSpellOnTarget(44294,crystal)
	Unit:CastSpell(8358)
end

function SelinFireheart_Crystal4(Unit,Event)
	Unit:RemoveEvents()
	local X = Unit:GetX()
	local Y = Unit:GetY()
	local Z = Unit:GetZ()
	local crystal = Unit:GetCreatureNearestCoords(X,Y,Z,24722)
	Unit:SetCombatMeleeCapable(1)
	Unit:FullCastSpellOnTarget(44294,crystal)
	Unit:CastSpell(8358)
end

function SelinFireheart_Crystal5(Unit,Event)
	Unit:RemoveEvents()
	local X = Unit:GetX()
	local Y = Unit:GetY()
	local Z = Unit:GetZ()
	local crystal = Unit:GetCreatureNearestCoords(X,Y,Z,24722)
	Unit:SetCombatMeleeCapable(1)
	Unit:FullCastSpellOnTarget(44294,crystal)
	Unit:CastSpell(8358)
end


RegisterUnitEvent(24723, 1, "SelinFireheart_OnEnterCombat")
RegisterUnitEvent(24723, 2, "SelinFireheart_OnLeaveCombat")
RegisterUnitEvent(24723, 3, "SelinFireheart_OnKill")
RegisterUnitEvent(24723, 4, "SelinFireheart_OnDied")
RegisterUnitEvent(24723, 18, "SelinFireheart_OnSpawn")