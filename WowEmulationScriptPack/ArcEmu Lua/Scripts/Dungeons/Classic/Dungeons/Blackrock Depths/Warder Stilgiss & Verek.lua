-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright (c) zdroid9770                  --
-------------------------------------------------------------------

---------------------
--       		   --
-- Warder Stilgiss --
--       		   --
---------------------
--[[
----Quotes
----Spells-ID
Chilled-6136
Frost Armor-12544
Frost Nova-12674
Frost Ward-15044
Frostbolt-12675
]]--
function FDV_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("FDV_FrostArmor", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("FDV_Chilled", 10000, 0) --Time could be wrong
	pUnit:RegisterEvent("FDV_FrostNova", 20000, 0) --Time could be wrong
	pUnit:RegisterEvent("FDV_FrostWard", 25000, 0) --Time could be wrong
	pUnit:RegisterEvent("FDV_Frostbolt", 5000, 0) --Time could be wrong
end

function FDV_FrostArmor(pUnit, Event)
	pUnit:CastSpell(12544)
end

function FDV_Chilled(pUnit, Event)
	pUnit:FullCastSpell(6136)
end

function FDV_FrostNova(pUnit, Event)
	pUnit:CastSpell(12674)
end

function FDV_FrostWard(pUnit, Event)
	pUnit:FullCastSpell(15044)
end

function FDV_Frostbolt(pUnit, Event)
	pUnit:FullCastSpellonTarget(12675)
end

function FDV_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function FDV_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9041, 1, "FDV_OnCombat")
RegisterUnitEvent(9041, 2, "FDV_OnLeaveCombat")
RegisterUnitEvent(9041, 4, "FDV_OnDeath")

-----------
--       --
-- Verek --
--       --
-----------
--[[
----Quotes
----Spells-ID
Curse of Blood-15042
Enrage-8599
]]--
function Verek_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Verek_CurseOfBlood", 1000, 0) --Time could be wrong
	pUnit:RegisterEvent("Verek_Enrage", 5000, 0) --Time could be wrong
end

function Verek_CurseOfBlood(pUnit, Event)
	pUnit:CastSpell(15042)
end

function Verek_Enrage(pUnit, Event)
	pUnit:CastSpell(8599)
end

function Verek_OnLeaveCombat(pUnit, Event)
        pUnit:RemoveEvents()
end

function Verek_OnDeath(pUnit, Event)
        pUnit:RemoveEvents()
end

RegisterUnitEvent(9042, 1, "Verek_OnCombat")
RegisterUnitEvent(9042, 2, "Verek_OnLeaveCombat")
RegisterUnitEvent(9042, 4, "Verek_OnDeath")