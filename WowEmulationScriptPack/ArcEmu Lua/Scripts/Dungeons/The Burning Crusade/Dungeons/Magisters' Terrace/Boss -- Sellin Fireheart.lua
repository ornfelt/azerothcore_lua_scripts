--[[ Boss -- Sellin Fireheart.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, June 29, 2008. ]]

function Selin_OnEnterCombat(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SendChatMessage(14, 0, "You only waste my time!")
	pUnit:PlaySoundToSet(12378)
	pUnit:RegisterEvent("Selin_FelExplosion", 13000, 0)
	pUnit:RegisterEvent("Selin_DrainMana", 19000, 0)
	pUnit:RegisterEvent("Selin_DrainLife", 43000, 0)
end

function Selin_Empower(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Yes! I am a god!")
	pUnit:PlaySoundToSet(12382)
	pUnit:SetScale(2)
	pUnit:CastSpell(44314)
--	pUnit:FullCastSpellOnTarget(44314,pUnit:GetClosestPlayer())
end

function Selin_Depower(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "No! More... I must have more! ")
	pUnit:PlaySoundToSet(12383)
	pUnit:SetScale(1)
	pUnit:CastSpell(44314)
--	pUnit:FullCastSpellOnTarget(44314,pUnit:GetClosestPlayer())
end

function Selin_FelExplosion(pUnit,Event)
	pUnit:FullCastSpellOnTarget(44314,pUnit:GetClosestPlayer())
end

function Selin_DrainMana(pUnit,Event)
	pUnit:RegisterEvent("Selin_Empower", 6000, 1)
	pUnit:RegisterEvent("Selin_Depower", 15000, 1)
	pUnit:SendChatMessage(14, 0, "My hunger knows no bounds!")
	pUnit:PlaySoundToSet(12381)
	pUnit:SetScale(2)
	pUnit:FullCastSpellOnTarget(46153,pUnit:GetRandomFriend())
end

function Selin_DrainLife(pUnit,Event)
	pUnit:FullCastSpellOnTarget(44294,pUnit:GetClosestPlayer())
end

function Selin_OnKill(pUnit,Event)
	pUnit:SendChatMessage(14, 0, "Enough distractions!")
	pUnit:PlaySoundToSet(12388)
	pUnit:SetScale(1)
end

function Selin_OnLeaveCombat(pUnit,Event)
	pUnit:RemoveEvents()
	pUnit:SetScale(1)
end

function Selin_OnDeath(pUnit,Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(24723, 1, "Selin_OnEnterCombat")
RegisterUnitEvent(24723, 2, "Selin_OnLeaveCombat")
RegisterUnitEvent(24723, 3, "Selin_OnKill")
RegisterUnitEvent(24723, 4, "Selin_OnDeath")