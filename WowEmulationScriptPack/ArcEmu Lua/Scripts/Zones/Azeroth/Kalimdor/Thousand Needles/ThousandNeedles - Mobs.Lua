--[[
*******************************************************
*          LASP - LUA AREA SCRIPTING PROJECT          *
*                      License                        *
*******************************************************
This software is provided as free and open source by the
staff of The Lua Area Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

-- This Lua by Ramor
-- Please visit our forum at: http://lasp.forumotion.com
-- And report bugs or any problems
-- ]]

--Pesterhide Snarler
function PesterS_OnCombat(Unit, Event)
	Unit:RegisterEvent("PesterS_Growl", 8000, 1)
end

function PesterS_Growl(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(6576, target)
end

function PesterS_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function PesterS_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function PesterS_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4249, 1, "PesterS_OnCombat")
RegisterUnitEvent(4249, 2, "PesterS_OnLeaveCombat")
RegisterUnitEvent(4249, 3, "PesterS_OnKilledTarget")
RegisterUnitEvent(4249, 4, "PesterS_OnDied")

--Thundering Boulderkin
function Thund_OnCombat(Unit, Event)
	Unit:RegisterEvent("Thund_Tremor", 5000, 1)
end

function Thund_Tremor(Unit, Event)
	Unit:CastSpell(6524)
end

function Thund_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Thund_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Thund_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4120, 1, "Thund_OnCombat")
RegisterUnitEvent(4120, 2, "Thund_OnLeaveCombat")
RegisterUnitEvent(4120, 3, "Thund_OnKilledTarget")
RegisterUnitEvent(4120, 4, "Thund_OnDied")

--Gravelsnout Digger
function GDig_OnCombat(Unit, Event)
	Unit:RegisterEvent("GDig_Crack", 5000, 1)
end

function GDig_Crack(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(3551, target)
end

function GDig_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GDig_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GDig_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4113, 1, "GDig_OnCombat")
RegisterUnitEvent(4113, 2, "GDig_OnLeaveCombat")
RegisterUnitEvent(4113, 3, "GDig_OnKilledTarget")
RegisterUnitEvent(4113, 4, "GDig_OnDied")

--Gravelsnout Surveyor
function GSurv_OnCombat(Unit, Event)
	Unit:RegisterEvent("GSurv_FBolt", 8000, 3)
end

function GSurv_FBolt(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(20806, target)
end

function GSurv_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GSurv_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GSurv_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4116, 1, "GSurv_OnCombat")
RegisterUnitEvent(4116, 2, "GSurv_OnLeaveCombat")
RegisterUnitEvent(4116, 3, "GSurv_OnKilledTarget")
RegisterUnitEvent(4116, 4, "GSurv_OnDied")

--Gravelsnout Forager
function GFor_OnCombat(Unit, Event)
	Unit:RegisterEvent("GFor_Acid", 5000, 1)
end

function GFor_Acid(Unit, Event)
	Unit:FullCastSpell(8245)
end

function GFor_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GFor_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GFor_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4114, 1, "GFor_OnCombat")
RegisterUnitEvent(4114, 2, "GFor_OnLeaveCombat")
RegisterUnitEvent(4114, 3, "GFor_OnKilledTarget")
RegisterUnitEvent(4114, 4, "GFor_OnDied")

--Gravelsnout Kobold
function GKo_OnCombat(Unit, Event)
	Unit:RegisterEvent("GKo_Strike", 3000, 1)
end

function GKo_Strike(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(11976, target)
end

function GKo_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GKo_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GKo_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4111, 1, "GKo_OnCombat")
RegisterUnitEvent(4111, 2, "GKo_OnLeaveCombat")
RegisterUnitEvent(4111, 3, "GKo_OnKilledTarget")
RegisterUnitEvent(4111, 4, "GKo_OnDied")

--Gravelsnout Vermin
function GVer_OnCombat(Unit, Event)
	Unit:RegisterEvent("GVer_Wound", 5000, 1)
end

function GVer_Wound(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(3427, target)
end

function GVer_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GVer_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GVer_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4112, 1, "GVer_OnCombat")
RegisterUnitEvent(4112, 2, "GVer_OnLeaveCombat")
RegisterUnitEvent(4112, 3, "GVer_OnKilledTarget")
RegisterUnitEvent(4112, 4, "GVer_OnDied")

--Venomous Cloud Serpent
function VCloud_OnCombat(Unit, Event)
	Unit:RegisterEvent("VCloud_Poison", 5000, 1)
end

function VCloud_Poison(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(3583, target)
end

function VCloud_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function VCloud_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function VCloud_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4118, 1, "VCloud_OnCombat")
RegisterUnitEvent(4118, 2, "VCloud_OnLeaveCombat")
RegisterUnitEvent(4118, 3, "VCloud_OnKilledTarget")
RegisterUnitEvent(4118, 4, "VCloud_OnDied")

--Screechig Roguefeather
function SR_OnCombat(Unit, Event)
	Unit:RegisterEvent("SR_Weak", 5000, 1)
end

function SR_Weak(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(6595, target)
end

function SR_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function SR_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function SR_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4101, 1, "SR_OnCombat")
RegisterUnitEvent(4101, 2, "SR_OnLeaveCombat")
RegisterUnitEvent(4101, 3, "SR_OnKilledTarget")
RegisterUnitEvent(4101, 4, "SR_OnDied")

--Screeching Harpy
function SH_OnCombat(Unit, Event)
	Unit:RegisterEvent("SH_Screech", 8000, 1)
end

function SH_Screech(Unit, Event)
	Unit:CastSpell(3589)
end

function SH_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function SH_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function SH_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4100, 1, "SH_OnCombat")
RegisterUnitEvent(4100, 2, "SH_OnLeaveCombat")
RegisterUnitEvent(4100, 3, "SH_OnKilledTarget")
RegisterUnitEvent(4100, 4, "SH_OnDied")

--Screeching Windcaller
function SWind_OnCombat(Unit, Event)
	Unit:RegisterEvent("SWind_Gust", 5000, 1)
end

function SWind_Gust(Unit, Event)
	Unit:FullCastSpell(6982)
end

function SWind_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function SWind_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function SWind_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4104, 1, "SWind_OnCombat")
RegisterUnitEvent(4104, 2, "SWind_OnLeaveCombat")
RegisterUnitEvent(4104, 3, "SWind_OnKilledTarget")
RegisterUnitEvent(4104, 4, "SWind_OnDied")

--Cloud Serpent
function CSerp_OnCombat(Unit, Event)
	Unit:RegisterEvent("CSerp_Bolt", 5000, 2)
end

function CSerp_Bolt(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(8246, target)
end

function CSerp_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function CSerp_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function CSerp_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4117, 1, "CSerp_OnCombat")
RegisterUnitEvent(4117, 2, "CSerp_OnLeaveCombat")
RegisterUnitEvent(4117, 3, "CSerp_OnKilledTarget")
RegisterUnitEvent(4117, 4, "CSerp_OnDied")

--Elder Cloud Serpent
function ECSerp_OnCombat(Unit, Event)
	Unit:RegisterEvent("ECSerp_Bolt", 5000, 2)
end

function ECSerp_Bolt(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(8246, target)
end

function ECSerp_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function ECSerp_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function ECSerp_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4119, 1, "ECSerp_OnCombat")
RegisterUnitEvent(4119, 2, "ECSerp_OnLeaveCombat")
RegisterUnitEvent(4119, 3, "ECSerp_OnKilledTarget")
RegisterUnitEvent(4119, 4, "ECSerp_OnDied")

--Gibblesnik
function Gib_OnCombat(Unit, Event)
	Unit:RegisterEvent("Gib_Sunder", 3000, 0)
end

function Gib_Sunder(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(11971, target)
end

function Gib_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function Gib_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function Gib_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(14427, 1, "Gib_OnCombat")
RegisterUnitEvent(14427, 2, "Gib_OnLeaveCombat")
RegisterUnitEvent(14427, 3, "Gib_OnKilledTarget")
RegisterUnitEvent(14427, 4, "Gib_OnDied")

--Galak Assassin

function GAss_OnCombat(Unit, Event)
	Unit:RegisterEvent("GAss_Net", 4000, 1)
end

function GAss_Net(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpell(6533, target)
end

function GAss_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GAss_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GAss_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(10720, 1, "GAss_OnCombat")
RegisterUnitEvent(10720, 2, "GAss_OnLeaveCombat")
RegisterUnitEvent(10720, 3, "GAss_OnKilledTarget")
RegisterUnitEvent(10720, 4, "GAss_OnDied")

--Galak Flame Guard
function GFlame_OnCombat(Unit, Event)
	Unit:RegisterEvent("GFlame_Shout", 5000, 2)
end

function GFlame_Shout(Unit, Event)
	Unit:CastSpell(13730)
end


function GFlame_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GFlame_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GFlame_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(7404, 1, "GFlame_OnCombat")
RegisterUnitEvent(7404, 2, "GFlame_OnLeaveCombat")
RegisterUnitEvent(7404, 3, "GFlame_OnKilledTarget")
RegisterUnitEvent(7404, 4, "GFlame_OnDied")

--Galak Marauder
function GMar_OnCombat(Unit, Event)
	Unit:RegisterEvent("GMar_Charge", 10, 1)
end

function GMar_Charge(Unit, Event)
	Unit:CastSpell(6268)
end


function GMar_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GMar_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GMar_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4099, 1, "GMar_OnCombat")
RegisterUnitEvent(4099, 2, "GMar_OnLeaveCombat")
RegisterUnitEvent(4099, 3, "GMar_OnKilledTarget")
RegisterUnitEvent(4099, 4, "GMar_OnDied")

--Galak Mauler
function GMaul_OnCombat(Unit, Event)
	Unit:RegisterEvent("GMaul_Shout", 5000, 2)
end

function GMaul_Shout(Unit, Event)
	Unit:CastSpell(13730)
end

function GMaul_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GMaul_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GMaul_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4095, 1, "GMaul_OnCombat")
RegisterUnitEvent(4095, 2, "GMaul_OnLeaveCombat")
RegisterUnitEvent(4095, 3, "GMaul_OnKilledTarget")
RegisterUnitEvent(4095, 4, "GMaul_OnDied")

--Galak Stormer
function GStorm_OnCombat(Unit, Event)
	Unit:RegisterEvent("GStorm_Bolt", 5000, 2)
end

function GStorm_Bolt(Unit, Event)
target =	Unit:GetMainTank()
	Unit:FullCastSpellOnTarget(9532, target)
end

function GStorm_OnDied(Unit, Event)
	Unit:RemoveEvents();
end

function GStorm_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents();
end

function GStorm_OnKilledTarget(Unit, Event)
	Unit:RemoveEvents();
end

RegisterUnitEvent(4097, 1, "GStorm_OnCombat")
RegisterUnitEvent(4097, 2, "GStorm_OnLeaveCombat")
RegisterUnitEvent(4097, 3, "GStorm_OnKilledTarget")
RegisterUnitEvent(4097, 4, "GStorm_OnDied")

--Galak Winchaser NOT POSSIBLE, the spell casts over and over and over even with a set limit
