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

phase = 0

function PhaseCheck(Unit, event, miscUnit, misc)
	if ((Unit:GetHealthPct() <= 60) and (phase == 0)) then
		phase = 1
		UnitRegisterEvent("GuardianKidlic_Phase1", 3000, 1)
	elseif ((Unit:GetHealthPct() <= 40) and (phase == 1)) then
		phase = 2
		Unit:RegisterEvent("GuardianKidlic_Phase2", 3000, 1)
	end
end

-- phase 1

function GuardianKidlic_MortalWound(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(28467, GetMainTank())
end

function GuardianKidlic_EnragingStrike(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(37974, GetClosestPlayer())
end

function GuardianKidlic_Phase1(Unit, event, miscUnit, misc)
	Unit:RemoveEvents()
	Unit:SendChatMessage(12, 0, "You wont succeed!")
	Unit:RegisterEvent("PhaseCheck", 3000, 0)
	Unit:RegisterEvent("GuardianKidlic_MortalWound", 8000, 0)
	Unit:RegisterEvent("GuardianKidlic_EnragingStrike", 5000, 0)
end

-- phase 2

function GuardianKidlic_MightyBlow(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(43673, GetClosestPlayer())
	Unit:ClearThreadList()
end

function GuardianKidlic_Phase2(Unit, event, miscUnit, misc)
	Unit:RemoveEvents()
	Unit:SendChatMessage(12, 0, "Lord! Give me strengh!")
	Unit:RegisterEvent("GuardianKidlic_MortalWound", 8000, 0)
	Unit:RegisterEvent("GuardianKidlic_EnragingStrike", 5000, 0)
	Unit:RegisterEvent("GuardianKidlic_MightyBlow", 10000, 0)
end

function GuardianKidlic_OnEnterCombat(Unit, event, miscUnit, misc)
	Unit:SendChatMessage(12, 0, "I will crush you!")
	Unit:RegisterEvent("PhaseCheck", 3000, 0)
end

function GuardianKidlic_OnWipe(Unit, event, miscUnit, misc)
	Unit:RemoveEvents()
	Unit:SendChatMessage(12, 0, "As i said...")
end

function GuardianKidlic_Kill(Unit, event, miscUnit, misc)
	Unit:RemoveEvents()
	Unit:SendChatMessage(12, 0, "Noooooo!")
end

RegisterUnitEvent(230070, 4, "GuardianKidlic_Kill")
RegisterUnitEvent(230070, 2, "GuardianKidlic_OnWipe")
RegisterUnitEvent(230070, 1, "GuardianKidlic_OnEnterCombat")