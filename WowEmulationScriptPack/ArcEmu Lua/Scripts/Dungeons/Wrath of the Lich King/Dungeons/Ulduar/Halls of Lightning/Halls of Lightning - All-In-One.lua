--[[ Halls of Lightning - All-In-One.lua

This script was written and is protected
by the GPL v2. This script was released
by BrantX of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- BrantX, October 26, 2008. ]]

function BlisteringSteamrager_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("BlisteringSteamrager_SteamBlast", 24000, 0)
end

function BlisteringSteamrager_SteamBlast(Unit,Event)
	Unit:FullCastSpellOnTarget(52531,Unit:GetClosestPlayer())
end

function BlisteringSteamrager_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function BlisteringSteamrager_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(28583, 1, "BlisteringSteamrager_OnEnterCombat")
RegisterUnitEvent(28583, 2, "BlisteringSteamrager_OnLeaveCombat")
RegisterUnitEvent(28583, 3, "BlisteringSteamrager_OnDied")

function HardenedSteelBerserker_OnEnterCombat(Unit,Event)
	Unit:RegisterEvent("HardenedSteelBerserker_Enrage", 60000, 1)
	Unit:RegisterEvent("HardenedSteelBerserker_HurlWeapon", 42000, 0)
end

function HardenedSteelBerserker_Enrage(Unit,Event)
	Unit:FullCastSpellOnTarget(50420,Unit:GetClosestPlayer())
end

function HardenedSteelBerserker_HurlWeapon(Unit,Event)
	Unit:FullCastSpellOnTarget(52740,Unit:GetClosestPlayer())
end

function HardenedSteelBerserker_OnLeaveCombat(Unit,Event)
	Unit:RemoveEvents()
end

function HardenedSteelBerserker_OnDied(Unit,Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(28579, 1, "HardenedSteelBerserker_OnEnterCombat")
RegisterUnitEvent(28579, 2, "HardenedSteelBerserker_OnLeaveCombat")
RegisterUnitEvent(28579, 3, "HardenedSteelBerserker_OnDied")