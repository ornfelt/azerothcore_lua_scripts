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
   Original Code by DARKI
   Version 1
========================================]]--

-- Doors
function DoorOne(GameObject)
local FactoryDoor = GameObject
end

function DoorTwo(GameObject)
local MastDoor = GameObject
end

function DoorThree(GameObject)
local FoundryDoor = GameObject
end

RegisterGameObjectEvent(13965, 1, "DoorOne")
RegisterGameObjectEvent(16400, 1, "DoorTwo")
RegisterGameObjectEvent(16399, 1, "DoorThree")

-- Rhank'zor
function Rhankzor_Slam(pUnit)
local MainTank = pUnit:GetMainTank()
     if (MainTank ~= nil) then
        pUnit:FullCastSpellOnTarget(6304, MainTank)
	 end
end

function Rhankzor_OnCombat(pUnit)
    pUnit:SendChatMessage(12,0,"VanCleef pay big for your heads!")
	pUnit:PlaySoundToSet(5774)
	pUnit:RegisterEvent("Rhankzor_Slam", math.random(10000,13000), 0)
end

function Rhankzor_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

function Rhankzor_OnDied(pUnit)
    pUnit:RemoveEvents()
    FactoryDoor:ActivateGameObject()
end

RegisterUnitEvent(644, 1, "Rhankzor_OnCombat")
RegisterUnitEvent(644, 2, "Rhankzor_LeaveCombat")
RegisterUnitEvent(644, 4, "Rhankzor_OnDied")


-- Miner Johnson
function MinerJohnson_PierceArmor(pUnit)
local MainTank = pUnit:GetMainTank()
     if (MainTank ~= nil) then
	    pUnit:FullCastSpellOnTarget(6016, MainTank)
	end
end

function MinerJohnson_OnCombat(pUnit)
    pUnit:FullCastSpellOnTarget(6016, pUnit:GetMainTank())
    pUnit:RegisterEvent("MinerJohnson_PierceArmor", math.random(10000,15000), 0)
end

function MinerJohnson_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

function MinerJohnson_OnDied(pUnit)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(3586, 1, "MinerJohnson_OnCombat")
RegisterUnitEvent(3586, 2, "MinerJohnson_LeaveCombat")
RegisterUnitEvent(3586, 4, "MinerJohnson_OnDied")

-- Sneed Shreeder
function SneedShreeder_DistractingPain(pUnit)
local PlayerLowRange = pUnit:GetRandomPlayer(1)
     if (PlayerLowRange ~= nil) then
        pUnit:FullCastSpellOnTarget(3603, PlayerLowRange)
	 end
end

function SneedShreeder_Fear(pUnit)
local RandomPlayer = pUnit:GetRandomPlayer(0)
     if (RandomPlayer ~= nil) then
        pUnit:FullCastSpellOnTarget(7399, RandomPlayer)
     end
end

function SneedShreeder_OnCombat(pUnit)
    pUnit:RegisterEvent("SneedShreeder_DistractingPain", math.random(20000,30000), 0)
	pUnit:RegisterEvent("SneedShreeder_Fear", math.random(12000,18000), 0)
end

function SneedShreeder_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

function SneedShreeder_OnDied(pUnit)
local x = pUnit:GetX()
local y = pUnit:GetY()
local z = pUnit:GetZ()
    pUnit:RemoveEvents()
    pUnit:SpawnCreature(643, x+2, y+2, z, 0, 17, 0)
end

RegisterUnitEvent(642, 1, "SneedShreeder_OnCombat")
RegisterUnitEvent(642, 2, "SneedShreeder_LeaveCombat")
RegisterUnitEvent(642, 4, "SneedShreeder_OnDied")

-- Sneed
function Sneed_Disarm(pUnit)
local MainTank = pUnit:GetMainTank()
     if (MainTank ~= nil) then
        pUnit:FullCastSpellOnTarget(6713, MainTank)
     end
end

function Sneed_OnCombat(pUnit)
    pUnit:RegisterEvent("Sneed_Disarm", math.random(10000,15000), 0)
end

function Sneed_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
	pUnit:Despawn(5000, 0)
end

function Sneed_OnDie(pUnit)
    pUnit:RemoveEvents()
    MastDoor:ActivateGameObject(1)
end

RegisterUnitEvent(643, 1, "Sneed_OnCombat")
RegisterUnitEvent(643, 2, "Sneed_LeaveCombat")
RegisterUnitEvent(643, 4, "Sneed_OnDie")

-- Gilnid
function Gilnid_MoltenMetal(pUnit)
local MainTank = pUnit:GetMainTank()
     if (MainTank ~= nil) then
        pUnit:FullCastSpellOnTarget(5213, MainTank) 
	end
end

function Gilnid_MoltenOre(pUnit)
	pUnit:FullCastSpell(5159)
end

function Gilnid_RandomYell(pUnit)
local GRandomYell = math.random(1,3)
    if (GRandomYell == 1) then
	    pUnit:SendChatMessage(12, 0, "Anyone want to take a break? Well too bad! Get to work you oafs!")
	end
	if (GRandomYell == 2) then
	    pUnit:SendChatMessage(12, 0, "Get those parts moving down to the ship!")
    end
	if (GRandomYell == 3) then
	    pUnit:SendChatMessage(12, 0, "The cannons must be finished soon.")
	end
end


function Gilnid_OnCombat(pUnit)
    pUnit:RegisterEvent("Gilnid_MoltenMetal", math.random(12000,16000), 0)
	pUnit:RegisterEvent("Gilnid_MoltenOre", math.random(15000,20000), 0)
	pUnit:RegisterEvent("Gilnid_RandomYell", math.random(15000,30000), 0)
end

function Gilnid_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

function Gilnid_OnDie(pUnit)
    pUnit:RemoveEvents()
    FoundryDoor:ActivateGameObject(1)
end

RegisterUnitEvent(1763, 1, "Gilnid_OnCombat")
RegisterUnitEvent(1763, 2, "Gilnid_LeaveCombat")
RegisterUnitEvent(1763, 4, "Gilnid_OnDie")

--Mr. Smite
--local MoveToChest=pUnit:MoveTo(1.100060, -780.026367, 9.811194, 5.452218)

function MrSmiteSlam(pUnit)
local MainTank = pUnit:GetMainTank()
     if (MainTank ~= nil) then
	    pUnit:FullCastSpellOnTarget(6435, MainTank)
	 end
end

function MrSmitePhase1(pUnit)
    if (pUnit:GetHealthPct() <= 66) then
	    pUnit:RemoveEvents()
        pUnit:FullCastSpell(6432)
		pUnit:SendChatMessage(12, 0, "You landlubbers are tougher than i thought. I'll have to improvise!")
		pUnit:PlaySoundToSet(5778)
--		pUnit:MoveTo(1.100060, -780.026367, 9.811194, 5.452218)
		pUnit:RegisterEvent("MrSmitePhase2", 1000, 0)
	    pUnit:RegisterEvent("MrSmiteSlam", math.random(10000,20000), 0)
    end
end

function MrSmitePhase2(pUnit)
    if (pUnit:GetHealthPct() <= 33) then
	    pUnit:RemoveEvents()
        pUnit:FullCastSpell(6432)
		pUnit:SendChatMessage(12, 0, "D'ah! Now you're making me angry!")
		pUnit:PlaySoundToSet(5779)
		pUnit:RegisterEvent("MrSmiteSlam", math.random(10000,20000), 0)
--		pUnit:MoveTo(1.100060, -780.026367, 9.811194, 5.452218)
    end
end
	
function MrSmite_OnCombat(pUnit)
    pUnit:RegisterEvent("MrSmiteSlam",math.random(10000,20000),0)
	pUnit:RegisterEvent("MrSmitePhase1",1000,0)
end

function MrSmite_LeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

function MrSmite_OnDied(pUnit)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(646, 1, "MrSmite_OnCombat")
RegisterUnitEvent(646, 2, "MrSmite_LeaveCombat")
RegisterUnitEvent(646, 4, "MrSmite_OnDied")

--Cookie 
function Cookie_OnCombat(pUnit)
    pUnit:FullCastSpell(6306)
    pUnit:RegisterEvent("Cookie_AcidSplash", 30000, 0)
    pUnit:RegisterEvent("Cookie_Cooking", math.random(15000,25000), 0)
end

function Cookie_AcidSplash(pUnit)
    pUnit:FullCastSpell(6306)
end

function Cookie_Cooking(pUnit)
    pUnit:FullCastSpell(5174)
end

function Cookie_OnLeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

function Cookie_OnDied(pUnit)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(645, 1, "Cookie_OnCombat")
RegisterUnitEvent(645, 2, "Cookie_OnLeaveCombat")
RegisterUnitEvent(645, 4, "Cookie_OnDied")

-- Captain Greenskin 
function Greenskin_Cleave(pUnit)
    pUnit:FullCastSpell()
end

function Greenskin_Poisoned(pUnit)
local MainTank = pUnit:GetMainTank()
     if (MainTank ~= nil) then
	    pUnit:FullCastSpellOnTarget(5208, MainTank)
	end
end

function Greenskin_OnCombat(pUnit)
    pUnit:RegisterEvent("Greenskin_Cleave", math.random(8000, 16000), 0)
	pUnit:RegisterEvent("Greenskin_Poisoned", math.random(7000,14000), 0)
end

function Greenskin_OnLeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

function Greenskin_OnDied(pUnit)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(647, 1, "Greenskin_OnCombat")
RegisterUnitEvent(647, 2, "Greenskin_OnLeaveCombat")
RegisterUnitEvent(647, 4, "Greenskin_OnDied")
        

--Edwin VanCleef by Project eXa
function VanCleef_OnCombat(pUnit)
local x = pUnit:GetX()
local y = pUnit:GetY()
local z = pUnit:GetZ()
local o = pUnit:GetO()
	pUnit:SendChatMessage(12,0,"Niemand kann die Bruderschaft herausfordern!")
	pUnit:PlaySoundToSet(5780)
	pUnit:RegisterEvent("VanCleef_Phase2",1000,0)
	pUnit:SpawnCreature(636,x+2,y,z,o,17,600000)
	pUnit:SpawnCreature(636,x-2,y,z,o,17,600000)
end

function VanCleef_Phase2(pUnit)
    if (pUnit:GetHealthPct() <= 75) then
        pUnit:RemoveEvents()
        pUnit:SendChatMessage(12, 0, "Lapdogs, all of you!")
        pUnit:PlaySoundToSet(5782)
        pUnit:RegisterEvent("VanCleef_Phase3", 1000, 0)
    end
end

function VanCleef_Phase3(pUnit)
local x = pUnit:GetX()
local y = pUnit:GetY()
local z = pUnit:GetZ()
local o = pUnit:GetO()
    if (pUnit:GetHealthPct() <= 50) then
        pUnit:RemoveEvents()
        pUnit:SendChatMessage(12, 0, "Fools! Our cause is righteous!")
        pUnit:PlaySoundToSet(5783)
        pUnit:SpawnCreature(636, x-2, y, z, o, 17, 600000)
        pUnit:SpawnCreature(636, x+2, y, z, o, 17, 600000)
     end
end

function VanCleef_Phase4(pUnit)
    if (pUnit:GetHealthPct() <= 25) then
        pUnit:RemoveEvents()
        pUnit:SendChatMessage(12, 0, "The Brotherhood shall prevail!")
        pUnit:PlaySoundToSet(5784)
    end
end

function VanCleef_OnKilledTarget(pUnit)
    pUnit:SendChatMessage(12, 0, "And stay seated!")
    pUnit:PlaySoundToSet(5781)
end

function VanCleef_OnLeaveCombat(pUnit)
    pUnit:RemoveEvents()
end

function VanCleef_OnDied(pUnit)
    pUnit:RemoveEvents()
end

RegisterUnitEvent(639, 1, "VanCleef_OnCombat")
RegisterUnitEvent(639, 2, "VanCleef_OnLeaveCombat")
RegisterUnitEvent(639, 3, "VanCleef_OnKilledTarget")
RegisterUnitEvent(639, 4, "VanCleef_OnDied")