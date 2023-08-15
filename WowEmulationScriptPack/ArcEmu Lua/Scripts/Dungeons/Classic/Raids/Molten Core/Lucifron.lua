--[[********************************
*                                                            *
* The LUA++ Scripting Project        *
*                                                            *
********************************

This software is provided as free and open source by the
staff of The LUA++ Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- LUA++ staff, March 26, 2008. ]]
--[[
	LUCIFRON's AI
]]
function Lucifron_OnCombat(Unit,event)
	Unit:RegisterEvent("LucifronSpells", math.random(18000, 21000), 0)
	Unit:RegisterEvent("ShadowShock", 7000, 0)
end

function Lucifron_OnDeath(Unit,event)
	Unit:RemoveEvents()
end

function Lucifron_OnWipe(Unit,event)
	Unit:RemoveEvents()
end

function LucifronSpells(Unit,event)
	if (math.random(0,1) < 0.5) then
		Unit:CastSpell(19702)
	else
		Unit:CastSpell(19703)
	end
end

function ShadowShock(Unit,event)
	Unit:FullCastSpellOnTarget(19460,Unit:GetRandomPlayer(0))
end

RegisterUnitEvent(12118, 1, "Lucifron_OnCombat")
RegisterUnitEvent(12118, 4, "Lucifron_OnDeath")
RegisterUnitEvent(12118, 2, "Lucifron_OnWipe")

--[[
	FLAMEWALKER's AI
]]

function LucifronProtector_OnCombat(Unit,event)
	Unit:RegisterEvent("LucifronProtector_Cleave", math.random(12000, 16000), 1)
end

function LucifronProtector_Cleave(Unit,event)
	Unit:FullCastSpellOnTarget(39047, Unit:GetMainTank())
	Unit:RegisterEvent("LucifronProtector_Cleave", math.random(12000, 16000), 0)
end

function LucifronProtector_OnDied(Unit,event)
	Unit:RemoveEvents()
end

function LucifronProtector_OnWipe(Unit,event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(12119, 1, "LucifronProtector_OnCombat")
RegisterUnitEvent(12119, 2, "LucifronProtector_OnWipe")
RegisterUnitEvent(12119, 4, "LucifronProtector_OnDied")