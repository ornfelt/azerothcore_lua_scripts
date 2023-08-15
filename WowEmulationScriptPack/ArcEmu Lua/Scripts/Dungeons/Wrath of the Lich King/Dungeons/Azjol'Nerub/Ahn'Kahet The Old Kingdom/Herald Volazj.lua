--[[=========================================
 _     _    _
| |   | |  | |  /\                  /\
| |   | |  | | /  \   _ __  _ __   /  \   _ __ ___
| |   | |  | |/ /\ \ | '_ \| '_ \ / /\ \ | '__/ __|
| |___| |__| / ____ \| |_) | |_) / ____ \| | | (__
|______\____/_/    \_\ .__/| .__/_/    \_\_|  \___|
  Scripting Project  | |   | | Improved LUA Engine
                     |_|   |_|
   SVN: http://svn.burning-azzinoth.de/LUAppArc
   LOG: http://luapparc.burning-azzinoth.de/trac/timeline
   TRAC: http://luapparc.burning-azzinoth.de/trac
   ----------------------
   Boss -- Herald Volazj.lua
   Original Code by DARKI
   Version 1
========================================]]--

function HeraldVolazj_OnEnterCombat(pUnit, Event)
	pUnit:RegisterEvent("HeraldVolazj_Insanity",10000,0)
	pUnit:RegisterEvent("HeraldVolazj_Mindflay",20000,0)

end


function Insanity (pUnit, Event)
	pUnit:FullCastSpellOnTarget(57496,pUnit:GetRandomPlayer(0))
end 

function Mindflay (pUnit, Event)
	pUnit:FullCastSpellOnTarget(52586,pUnit:GetClosestPlayer(0))
end

function HeraldVolazj_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function HeraldVolazj_OnDied(pUnit, Event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(29311, 1, "HeraldVolazj_OnEnterCombat")
RegisterUnitEvent(29311, 2, "HeraldVolazj_OnLeaveCombat")
RegisterUnitEvent(29311, 4, "HeraldVolazj_OnDied")