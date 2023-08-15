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
   Arcanist_Doan.lua
   Original Code by DARKI
   Version 1
========================================]]--

--Arcanist Doan says: The Ashbringer...
--Arcanist Doan says: What do you propose, Mograine?


-- Arcanist Doan
function ArcanistDoan_Silence(pUnit)
    if (math.random(1,10) < 3) then
		pUnit:FullCastSpell(8988)
	end
end

function ArcanistDoan_Polymoprh(pUnit)
	if (pUnit:GetRandomPlayer(7) ~= nil) then
		if ( math.random(1,10) < 4) then
			pUnit:FullCastSpellOnTarget(13323,pUnit:GetRandomPlayer(7))
		end
	end
end

function ArcanistDoan_ArcaneExplosion(pUnit)
    pUnit:FullCastSpell(27082)
end

function ArcanistDoan_Detonation(pUnit)
    pUnit:StopMovement(1000)
    pUnit:FullCastSpell(9435)
end

function ArcanistDoan_OnCombat(pUnit)
    pUnit:SendChatMessage(13, 0, "You will not defile these mysteries!")
    pUnit:PlaySoundToSet(5842)
    pUnit:RegisterEvent("ArcanistDoan_ArcaneExplosion",math.random(8000,14000),0)
	pUnit:RegisterEvent("ArcanistDoan_Polymoprh",15000,0)
	pUnit:RegisterEvent("ArcanistDoan_Silence",20000,0)
	pUnit:RegisterEvent("ArcanistDoan_Phase2",1000,0)
end

function ArcanistDoan_Phase2(pUnit)
    if pUnit:GetHealthPct() <= 50 then
		pUnit:RemoveEvents()
		pUnit:SendChatMessage(13,0,"Burn in righteous fire!")
		pUnit:PlaySoundToSet(5843)
		pUnit:FullCastSpell(ArcaneBubble)
		pUnit:RegisterEvent("ArcanistDoan_Detonation",2000,1)
		pUnit:RegisterEvent("ArcanistDoan_ArcaneExplosion",math.random(8000,14000),0)
		pUnit:RegisterEvent("ArcanistDoan_Polymoprh",15000,0)
		pUnit:RegisterEvent("ArcanistDoan_Silence",20000,0)
	end
end

function ArcanistDoan_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(20352, 1, "ArcanistDoan_OnCombat")
RegisterUnitEvent(20352, 2, "ArcanistDoan_LeaveCombat") 