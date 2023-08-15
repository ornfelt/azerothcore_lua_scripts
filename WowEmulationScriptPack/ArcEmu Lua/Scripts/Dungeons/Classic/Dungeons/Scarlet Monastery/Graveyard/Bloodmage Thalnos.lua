-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright© zdroid9770					 --
-------------------------------------------------------------------

function Thalnos_Shadowbolt(pUnit)
local target = pUnit:GetMainTank()
	if (target ~= nil) then
		pUnit:StopMovement(1000)
		pUnit:FullCastSpellOnTarget(9613, target)
	end
end

function Thalnos_Firespike(pUnit)
local maintank=pUnit:GetMainTank();
local x = maintank:GetX()
local y = maintank:GetY()
local z = maintank:GetZ()
	pUnit:RemoveEvents()
	pUnit:StopMovement(1000)
	pUnit:CastSpellAoF(x, y, z, 8814)
	pUnit:RegisterEvent("Thalnos_OnCombat2", 3500, 0)
end

function Thalnos_Firespike2(pUnit)
local maintank=pUnit:GetMainTank()
local x = maintank:GetX()
local y = maintank:GetY()
local z = maintank:GetZ()
	pUnit:RemoveEvents()
	pUnit:StopMovement(1000)
	pUnit:CastSpellAoF(x, y, z, 8814)
	pUnit:RegisterEvent("Thalnos_OnCombat3", 3500, 0)
end

function Thalnos_Aggro(pUnit)
    pUnit:SendChatMessage(13, 0, "We hunger for vengeance.")
	pUnit:PlaySoundToSet(5844)
end

function Thalnos_OnCombat(pUnit)
	pUnit:SendChatMessage(11, 0, "More... More souls!")
    pUnit:RegisterEvent("Thalnos_Aggro", 500, 1)
    pUnit:RegisterEvent("Thalnos_OnCombat2", 1000, 0)
end

function Thalnos_OnCombat2(pUnit)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("Thalnos_Shadowbolt", math.random(5000, 7000), 0)
	pUnit:RegisterEvent("Thalnos_Firespike", math.random(20000, 30000), 0)
	pUnit:RegisterEvent("Thalnos_Health", 1000, 0)
end

function Thalnos_Health(pUnit, event)
    if pUnit:GetHealthPct() <50 then
	    pUnit:RemoveEvents()
		pUnit:SendChatMessage(13, 0, "No rest, for the angry dead.")
		pUnit:PlaySoundToSet(5846)
		pUnit:RegisterEvent("Thalnos_OnCombat3", 1000, 0)
	end
end

function Thalnos_OnCombat3(pUnit)
	pUnit:RemoveEvents()
	pUnit:RegisterEvent("Thalnos_Shadowbolt", math.random(5000, 7000), 0)
	pUnit:RegisterEvent("Thalnos_Firespike", math.random(20000, 30000), 0)
end

function Thalnos_KillPlayer(pUnit)
    pUnit:SendChatMessage(13, 0, "More... More souls.")
	pUnit:PlaySoundToSet(5845)
end

function Thalnos_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(4543, 1, "Thalnos_OnCombat")
RegisterUnitEvent(4543, 2, "Thalnos_LeaveCombat")
RegisterUnitEvent(4543, 3, "Thalnos_KillPlayer")