--[[ Boss -- Sellin Fireheart.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, June 29, 2008. ]]

function Selin_OnEnterCombat(Unit,Event)
	Unit:RemoveEvents()
	Unit:SendChatMessage(14, 0, "You only waste my time!")
	Unit:PlaySoundToSet(12378)
	Unit:RegisterEvent("Selin_FelExplosion", 13000, 0)
	Unit:RegisterEvent("Selin_DrainMana", 19000, 0)
	Unit:RegisterEvent("Selin_DrainLife", 43000, 0)
end

function Selin_Empower(Unit,Event)
	Unit:SendChatMessage(14, 0, "Yes! I am a god!")
	Unit:PlaySoundToSet(12382)
	Unit:SetScale(2)
	Unit:CastSpell(44314)
--	Unit:FullCastSpellOnTarget(44314,Unit:GetClosestPlayer())
end

function Selin_Depower(Unit,Event)
	Unit:SendChatMessage(14, 0, "No! More... I must have more! ")
	Unit:PlaySoundToSet(12383)
	Unit:SetScale(1)
	Unit:CastSpell(44314)
--	Unit:FullCastSpellOnTarget(44314,Unit:GetClosestPlayer())
end

function Selin_FelExplosion(Unit,Event)
	Unit:FullCastSpellOnTarget(44314,Unit:GetClosestPlayer())
end

function Selin_DrainMana(Unit,Event)
	Unit:RegisterEvent("Selin_Empower", 6000, 1)
	Unit:RegisterEvent("Selin_Depower", 15000, 1)
	Unit:SendChatMessage(14, 0, "My hunger knows no bounds!")
	Unit:PlaySoundToSet(12381)
	Unit:SetScale(2)
	Unit:FullCastSpellOnTarget(46153,Unit:GetRandomFriend())
end

function Selin_DrainLife(Unit,Event)
	Unit:FullCastSpellOnTarget(44294,Unit:GetClosestPlayer())
end

function Selin_OnKill(Unit,Event)
	Unit:SendChatMessage(14, 0, "Enough distractions!")
	Unit:PlaySoundToSet(12388)
	Unit:SetScale(1)
end

function Selin_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
	Unit:SetScale(1)
end

function Selin_OnDeath(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(24723, 1, "Selin_OnEnterCombat")
RegisterUnitEvent(24723, 2, "Selin_OnLeaveCombat")
RegisterUnitEvent(24723, 3, "Selin_OnKill")
RegisterUnitEvent(24723, 4, "Selin_OnDeath")