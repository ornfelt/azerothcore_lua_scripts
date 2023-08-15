--//Durotar - Normal Mobs Lua Script//Made by LASP - Yerney// Thank you for using our scripts.
--If you find / see any bugs, please report by contacting one of our scripters.
--                           luaprojectleader@hotmail.com

--Vile Familiar, The demon things in the cave by Yerney
function Vile_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Vile_Fire", 3000, 0)
end

function Vile_Fire(pUnit, Event)
	pUnit:FullCastSpellOnTarget(11921, 	pUnit:GetClosestPlayer(0))
end

function Vile_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Vile_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3101, 1, "Vile_OnCombat")
RegisterUnitEvent(3101, 2, "Vile_LeaveCombat")
RegisterUnitEvent(3101, 4, "Vile_Dead")



--Thunder Lizard by Yerney
function TL_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("TL_cast", 8000, 0)
end

function TL_cast(pUnit, Event)
	pUnit:FullCastSpellOnTarget(5401, 	pUnit:GetClosestPlayer())
end

function TL_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function TL_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3130, 1, "TL_OnCombat")
RegisterUnitEvent(3130, 2, "TL_LeaveCombat")
RegisterUnitEvent(3130, 4, "TL_Dead")




--VenomTail by Yerney
function VT_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("VT_cast", 7500, 0)
end

function VT_cast(pUnit, Event)
	pUnit:FullCastSpellOnTarget(5416, 	pUnit:GetClosestPlayer())
end

function VT_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function VT_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3127, 1, "VT_OnCombat")
RegisterUnitEvent(3127, 2, "VT_LeaveCombat")
RegisterUnitEvent(3127, 4, "VT_Dead")




--Kolkar Drudge by Yerney
function drudge_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("drudge_cloud", 10000, 1)
end

function drudge_cloud(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7272, 	pUnit:GetClosestPlayer())
end

function drudge_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function drudge_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3119, 1, "drudge_OnCombat")
RegisterUnitEvent(3119, 2, "drudge_LeaveCombat")
RegisterUnitEvent(3119, 4, "drudge_Dead")




--Kolkar Outrunner by Yerney
function Outrunner_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Outrunner_Shoot", 4000, 0)
end

function Outrunner_Shoot(pUnit, Event)
	pUnit:FullCastSpellOnTarget(6660, 	pUnit:GetClosestPlayer())
end

function Outrunner_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Outrunner_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3120, 1, "Outrunner_OnCombat")
RegisterUnitEvent(3120, 2, "Outrunner_LeaveCombat")
RegisterUnitEvent(3120, 4, "Outrunner_Dead")




--Lightning Hide by Yerney
function LH_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("LH_cast", 6000, 0)
end

function LH_cast(pUnit, Event)
	pUnit:FullCastSpellOnTarget(5401, 	pUnit:GetClosestPlayer())
end

function LH_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function LH_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3131, 1, "LH_OnCombat")
RegisterUnitEvent(3131, 2, "LH_LeaveCombat")
RegisterUnitEvent(3131, 4, "LH_Dead")




--Corrupted BloodTalon Scythemaw by Yerney
function BS_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BS_cast", 12000, 0)
end

function BS_cast(pUnit, Event)
	pUnit:FullCastSpell(6268)
end

function BS_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function BS_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3227, 1, "BS_OnCombat")
RegisterUnitEvent(3227, 2, "BS_LeaveCombat")
RegisterUnitEvent(3227, 4, "BS_Dead")




--Corrupted Dreadmaw Croco by Yerney
function DC_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("DC_cast", 6000, 1)
end

function DC_cast(pUnit, Event)
	pUnit:FullCastSpellOnTarget(7901, 	pUnit:GetClosestPlayer())
end

function DC_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function DC_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3110, 1, "DC_OnCombat")
RegisterUnitEvent(3110, 2, "DC_LeaveCombat")
RegisterUnitEvent(3110, 4, "DC_Dead")



--Corrupted Scorpid by Yerney
function CS_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("CS_Poison", 6000, 1)
	pUnit:RegisterEvent("CS_Nox", 3000, 1)
end

function CS_Poison(pUnit, Event)
	pUnit:FullCastSpellOnTarget(24640, 	pUnit:GetClosestPlayer())
end

function CS_Nox(pUnit, Event)
	pUnit:FullCastSpellOnTarget(5413, 	pUnit:GetClosestPlayer())
end

function CS_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function CS_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3226, 1, "CS_OnCombat")
RegisterUnitEvent(3226, 2, "CS_LeaveCombat")
RegisterUnitEvent(3226, 4, "CS_Dead")



--Dustwind Pillager (Harpie)
function Pill_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("Pill_Fire", 5000, 0)
end

function Pill_Fire(pUnit, Event)
	pUnit:FullCastSpellOnTarget(3147, 	pUnit:GetClosestPlayer())
end

function Pill_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function Pill_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3116, 1, "Pill_OnCombat")
RegisterUnitEvent(3116, 2, "Pill_LeaveCombat")
RegisterUnitEvent(3116, 4, "Pill_Dead")



--Dustwind StormWitch (Harpie)
function SW_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("SW_Fire", 7500, 0)
end

function SW_Fire(pUnit, Event)
	pUnit:FullCastSpellOnTarget(9532, 	pUnit:GetClosestPlayer())
end

function SW_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function SW_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3118, 1, "SW_OnCombat")
RegisterUnitEvent(3118, 2, "SW_LeaveCombat")
RegisterUnitEvent(3118, 4, "SW_Dead")



--Hexed Troll (Echo Isle)
function hxt_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("hxt_Fire", 5000, 0)
end

function hxt_Fire(pUnit, Event)
	pUnit:FullCastSpellOnTarget(348, 	pUnit:GetClosestPlayer())
end

function hxt_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function hxt_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3207, 1, "hxt_OnCombat")
RegisterUnitEvent(3207, 2, "hxt_LeaveCombat")
RegisterUnitEvent(3207, 4, "hxt_Dead")



--Voodoo Troll (Echo Isle)
function vdt_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("vdt_Heal", 20000, 1)
	pUnit:RegisterEvent("vdt_Shield", 1000, 1)
	pUnit:RegisterEvent("vdt_Bolt", 8000, 0)
end

function vdt_Heal(pUnit, Event)
	pUnit:FullCastSpell(332)
end

function vdt_Shield(pUnit, Event)
	pUnit:FullCastSpell(324)
end

function vdt_Bolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(26364, 	pUnit:GetClosestPlayer())
end

function vdt_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function vdt_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3206, 1, "vdt_OnCombat")
RegisterUnitEvent(3206, 2, "vdt_LeaveCombat")
RegisterUnitEvent(3206, 4, "vdt_Dead")



-- Burning Blade Apprentice
function BBA_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BBA_Bolt", 7500, 2)
	pUnit:RegisterEvent("BBA_Summon", 15000, 1)
end

function BBA_Bolt(pUnit, Event)
	pUnit:FullCastSpellOnTarget(20791, 	pUnit:GetClosestPlayer())
end

function BBA_Summon(Unit, Event)
	Unit:CastSpell(5108)
end

function BBA_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function BBA_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3198, 1, "BBA_OnCombat")
RegisterUnitEvent(3198, 2, "BBA_LeaveCombat")
RegisterUnitEvent(3198, 4, "BBA_Dead")



-- Burning Blade Cultist
function BBC_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BBC_Immolate", 12000, 0)
end

function BBC_Immolate(pUnit, Event)
	pUnit:FullCastSpellOnTarget(11962, 	pUnit:GetClosestPlayer())
end

function BBC_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function BBC_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3199, 1, "BBC_OnCombat")
RegisterUnitEvent(3199, 2, "BBC_LeaveCombat")
RegisterUnitEvent(3199, 4, "BBC_Dead")



-- Burning Blade Fanatic
-- Spell Doesn't Work
function BBF_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BBF_Immolate", 7800, 0)
end

function BBF_Immolate(pUnit, Event)
	pUnit:FullCastSpellOnTarget(5267, 	pUnit:GetClosestPlayer())
end

function BBF_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function BBF_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3197, 1, "BBF_OnCombat")
RegisterUnitEvent(3197, 2, "BBF_LeaveCombat")
RegisterUnitEvent(3197, 4, "BBF_Dead")



-- Burning Blade Neophyte
function BBN_OnCombat(pUnit, Event)
	pUnit:RegisterEvent("BBN_Immolate", 15000, 0)
end

function BBN_Immolate(pUnit, Event)
	pUnit:FullCastSpellOnTarget(11962, 	pUnit:GetClosestPlayer())
end

function BBN_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function BBN_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3196, 1, "BBN_OnCombat")
RegisterUnitEvent(3196, 2, "BBN_LeaveCombat")
RegisterUnitEvent(3196, 4, "BBN_Dead")



--Boars
--Fixed Boar
function emb_OnCombat(pUnit, Event)
	pUnit:CastSpell(3385)
end

function emb_LeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()
end

function emb_Dead(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(3100, 1, "emb_OnCombat")
RegisterUnitEvent(3100, 2, "emb_LeaveCombat")
RegisterUnitEvent(3100, 4, "emb_Dead")
RegisterUnitEvent(3099, 1, "emb_OnCombat")
RegisterUnitEvent(3099, 2, "emb_LeaveCombat")
RegisterUnitEvent(3099, 4, "emb_Dead")