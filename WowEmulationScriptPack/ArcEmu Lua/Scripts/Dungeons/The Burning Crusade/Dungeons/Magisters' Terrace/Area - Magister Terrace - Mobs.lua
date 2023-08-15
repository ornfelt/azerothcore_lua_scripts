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

Area - Magister Terrace - Mobs.lua by Yerney
Report Bugs at www.lasp.forumotion.com
-- ]]


--SunBlade Magister
function SunbMag_OnCombat(Unit, Event)
  	Unit:RegisterEvent("SunbMag_AN", 15000, 1)
  	Unit:RegisterEvent("SunbMag_FrB", 3000, 29)
end

function SunbMag_FrB(pUnit, Event)
   pUnit:FullCastSpellOnTarget(46035, pUnit:GetRandomPlayer(0))
end

function SunbMag_AN(pUnit, Event)
   pUnit:FullCastSpell(46036)
end

function SunbMag_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function SunbMag_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24685, 1, "SunbMag_OnCombat")
RegisterUnitEvent(24685, 2, "SunbMag_LeaveCombat")
RegisterUnitEvent(24685, 4, "SunbMag_Died")



--Sunblade Warlock
function SunbWarlock_OnCombat(Unit, Event)
  	Unit:CastSpell(44517)
  	Unit:RegisterEvent("SunbWarlock_Incinerate", 8000, 0)
  	Unit:RegisterEvent("SunbWarlock_Immolate", 5600, 0)
end

function SunbWarlock_Incinerate(pUnit, Event)
   pUnit:FullCastSpellOnTarget(46043, pUnit:GetClosestPlayer())
end

function SunbWarlock_Immolate(pUnit, Event)
   pUnit:FullCastSpellOnTarget(46042, pUnit:GetClosestTank())
end

function SunbWarlock_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function SunbWarlock_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24686, 1, "SunbWarlock_OnCombat")
RegisterUnitEvent(24686, 2, "SunbWarlock_LeaveCombat")
RegisterUnitEvent(24686, 4, "SunbWarlock_Died")



--Sunblade Keeper
function SunbKpr_OnCombat(Unit, Event)
  	Unit:RegisterEvent("SunbKpr_Sb", 8000, 0)
end

function SunbKpr_Sb(pUnit, Event)
   pUnit:FullCastSpellOnTarget(15232, pUnit:GetRandomPlayer(0))
end

function SunbKpr_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function SunbKpr_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24762, 1, "SunbKpr_OnCombat")
RegisterUnitEvent(24762, 2, "SunbKpr_LeaveCombat")
RegisterUnitEvent(24762, 4, "SunbKpr_Died")


--Sister of Torment
function SoTorment_OnCombat(Unit, Event)
  	Unit:RegisterEvent("SoTorment_DdE", 6500, 0)
  	Unit:RegisterEvent("SoTorment_LoP",9000, 0)
end

function SoTorment_DdE(pUnit, Event)
   pUnit:FullCastSpellOnTarget(44547, pUnit:GetClosestPlayer())
end

function SoTorment_LoP(pUnit, Event)
   pUnit:CastSpellOnTarget(44640, pUnit:GetClosestPlayer())
end

function SoTorment_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function SoTorment_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24697, 1, "SoTorment_OnCombat")
RegisterUnitEvent(24697, 2, "SoTorment_LeaveCombat")
RegisterUnitEvent(24697, 4, "SoTorment_Died")


--Sunblade BloodKnight
function SunbBK_OnCombat(Unit, Event)
  	Unit:RegisterEvent("SunbBK_HL", 8000, 35)
end

function SunbBK_HL(Unit, Event)
  	Unit:FullCastSpell(27136)
end

function SunbBK_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function SunbBK_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(27136, 1, "SunbBK_OnCombat")
RegisterUnitEvent(27136, 2, "SunbBK_LeaveCombat")
RegisterUnitEvent(27136, 4, "SunbBK_Died")


--Sunblade MageGuard
function SunbladeMageGuard_OnCombat(Unit, Event)
  	Unit:RegisterEvent("SunbMg_Gt", 8500, 0)
end

function SunbMg_Gt(pUnit, Event)
   local FlipGt = math.random(1, 2)
   if FlipGt==1 then
      pUnit:CastSpellOnTarget(44478, pUnit:GetRandomPlayer(7))
   else
      pUnit:CastSpellOnTarget(46028, pUnit:GetRandomPlayer(7))
   end
end


function SunbladeMageGuard_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function SunbladeMageGuard_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24683, 1, "SunbladeMageGuard_OnCombat")
RegisterUnitEvent(24683, 2, "SunbladeMageGuard_LeaveCombat")
RegisterUnitEvent(24683, 4, "SunbladeMageGuard_Died")


--Ethereum Smuggler
function Ethsm_OnCombat(Unit, Event)
  	Unit:RegisterEvent("Ethsm_Arc", 9500, 10)
end

function Ethsm_Arc(pUnit, Event)
   pUnit:FullCastSpell(44538)
end

function Ethsm_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function Ethsm_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24698, 1, "Ethsm_OnCombat")
RegisterUnitEvent(24698, 2, "Ethsm_LeaveCombat")
RegisterUnitEvent(24698, 4, "Ethsm_Died")


--Fizzle
function Fizzle_OnCombat(Unit, Event)
  	Unit:RegisterEvent("Fizzle_Fireball", 5000, 0)
end

function Fizzle_Fireball(pUnit, Event)
   pUnit:FullCastSpellOnTarget(44164, pUnit:GetRandomPlayer(0))
end

function Fizzle_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function Fizzle_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24656, 1, "Fizzle_OnCombat")
RegisterUnitEvent(24656, 2, "Fizzle_LeaveCombat")
RegisterUnitEvent(24656, 4, "Fizzle_Died")


--Sunblade Imp
function SunbImp_OnCombat(Unit, Event)
  	Unit:RegisterEvent("SunbImp_Fireball", 7500, 0)
end

function SunbImp_Fireball(pUnit, Event)
   local flipfire = math.random(1, 2)
   if flipfire==1 then
      pUnit:FullCastSpellOnTarget(44577, pUnit:GetRandomPlayer(0))
   else
      pUnit:FullCastSpellOnTarget(46044, pUnit:GetRandomPlayer(0))
   end
end


function SunbImp_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function SunbImp_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24815, 1, "SunbImp_OnCombat")
RegisterUnitEvent(24815, 2, "SunbImp_LeaveCombat")
RegisterUnitEvent(24815, 4, "SunbImp_Died")


--Sunblade Physician
--It could be that they need core / db support tho xD
function SunbPh_OnCombat(Unit, Event)
  	Unit:RegisterEvent("SunbPh_Poision", 8500, 40)
end

function SunbPh_Poision(Unit, Event)
   local FlipPh = math.random(1, 2)
   if FlipPh==1 then
     	Unit:FullCastSpell(46046)
   else
     	Unit:FullCastSpell(44599)
   end
end

function SunbPh_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function SunbPh_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24687, 1, "SunbPh_OnCombat")
RegisterUnitEvent(24687, 2, "SunbPh_LeaveCombat")
RegisterUnitEvent(24687, 4, "SunbPh_Died")


--Wretched Bruiser
function WretchedBruiser_OnCombat(Unit, Event)
  	Unit:RegisterEvent("WretchedBruiser_Potion", 1000, 1)
  	Unit:RegisterEvent("WretchedBruiser_Strike", 6800, 0)
end

function WretchedBruiser_Potion(Unit, Event)
   if	Unit:GetHealthPct() < 15 then
     	Unit:FullCastSpell(44505)
   end
end


function WretchedBruiser_Strike(pUnit, Event)
   pUnit:FullCastSpellOnTarget(44534, pUnit:GetClosestPlayer())
end

function WretchedBruiser_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function WretchedBruiser_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24689, 1, "WretchedBruiser_OnCombat")
RegisterUnitEvent(24689, 2, "WretchedBruiser_LeaveCombat")
RegisterUnitEvent(24689, 4, "WretchedBruiser_Died")


--Wretched Husk
function WretchedHesk_OnCombat(Unit, Event)
  	Unit:RegisterEvent("WretchedHesk_Potion", 1000, 1)
  	Unit:RegisterEvent("WretchedHesk_Ball", 4000, 0)
end

function WretchedHesk_Potion(Unit, Event)
   if	Unit:GetHealthPct() < 15 then
     	Unit:FullCastSpell(44505)
   end
end

function WretchedHesk_Hesk(pUnit, Event)
   local Flipball = math.random(1, 2)
   if Flipball==1 then
      pUnit:FullCastSpellOnTarget(44503, pUnit:GetRandomPlayer())
   else
      pUnit:FullCastSpellOnTarget(44504, pUnit:GetRandomPlayer())
   end
end


function WretchedHesk_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function WretchedHesk_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24690, 1, "WretchedHesk_OnCombat")
RegisterUnitEvent(24690, 2, "WretchedHesk_LeaveCombat")
RegisterUnitEvent(24690, 4, "WretchedHesk_Died")


--Wretched Skulker
function WretchedSkulker_OnCombat(Unit, Event)
  	Unit:RegisterEvent("WretchedSkulker_Potion", 1000, 1)
  	Unit:RegisterEvent("WretchedSkulker_Strike", 6800, 0)
end

function WretchedSkulker_Potion(Unit, Event)
   if	Unit:GetHealthPct() < 15 then
     	Unit:FullCastSpell(44505)
   end
end


function WretchedSkulker_Strike(pUnit, Event)
   pUnit:FullCastSpellOnTarget(44533, pUnit:GetClosestPlayer())
end

function WretchedSkulker_LeaveCombat(Unit, Event)
  	Unit:RemoveEvents()
end

function WretchedSkulker_Died(Unit, Event)
  	Unit:RemoveEvents()
end

RegisterUnitEvent(24688, 1, "WretchedSkulker_OnCombat")
RegisterUnitEvent(24688, 2, "WretchedSkulker_LeaveCombat")
RegisterUnitEvent(24688, 4, "WretchedSkulker_Died")