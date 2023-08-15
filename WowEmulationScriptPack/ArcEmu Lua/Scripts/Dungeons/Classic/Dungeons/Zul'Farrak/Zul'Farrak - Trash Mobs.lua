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
	 
-- Karabor Sewers
	 
function AqueousSpawn_Nova(Unit, event, miscUnit, misc)
	Unit:FullCastSpell(40103)
end

function AqueousSpawn_Heal(Unit, event, miscUnit, misc)
	local heal = math.random(1, 10)
	if (heal == 5) then
		local plr = Unit:GetRandomFriend()
		if plr then
		Unit:FullCastSpellOnTarget(38588, plr)
		end
	end
end

function AqueousSpawn_OnCombat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("AqueousSpawn_Nova", 20000, 0)
	Unit:RegisterEvent("AqueousSpawn_Heal", 15000, 0)
end

RegisterUnitEvent(230024, 1, "AqueousSpawn_OnCombat")

function CoilskarSeaCaller_Hurricane(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40090, Unit:GetRandomPlayer(0))
end

function CoilskarSeaCaller_ForkedLightning(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40088, Unit:GetRandomPlayer(0))
end

function CoilskarSeaCaller_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("CoilskarSeaCaller_Hurricane", 18000, 0)
	Unit:RegisterEvent("CoilskarSeaCaller_ForkedLightning", 10000, 0)
end

RegisterUnitEvent(230001, 1, "CoilskarSeaCaller_Combat")

function CoilskarWrangler_LightningProd(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40066, Unit:GetRandomPlayer(0))
end

function CoilskarWrangler_Frenzy(Unit, event, miscUnit, misc)
local buff = math.random(1, 5)
	if (buff == 2) then
	Unit:FullCastSpellOnTarget(27995, Unit:GetRandomFriend())
	end
end

function CoilskarWrangler_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("CoilskarWrangler_LightningProd", 10000, 0)
	Unit:RegisterEvent("CoilskarWrangler_Frenzy", 6000, 0)
end

RegisterUnitEvent(230025, 1, "CoilskarWrangler_Combat")

function Leviathan_TailSwipe(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(35333, Unit:GetClosestPlayer())
end

function Leviathan_PoisonSpit(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40078, Unit:GetRandomPlayer(0))
end

function Leviathan_DebilitatingSpray(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40079, Unit:GetRandomPlayer(0))
end

function Leviathan_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("Leviathan_TailSwipe", 15000, 0)
	Unit:RegisterEvent("Leviathan_PoisonSpit", 9000, 0)
	Unit:RegisterEvent("Leviathan_DebilitatingSpray", 12000, 0)
end

RegisterUnitEvent(230026, 1, "Leviathan_Combat")

function AuqeousLord_Summon(Unit, event, miscUnit, misc)
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
local o = Unit:GetO()
	Unit:SpawnCreature(22883, x, y, z, o, 14, 0)
	Unit:SpawnCreature(22883, x ,y, z, o, 14, 0)
end

function AqueousLord_VileSlime(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40099, Unit:GetRandomPlayer(0))
end

function AqueousLord_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("AqueousLord_Summon", 1000, 1)
	Unit:RegisterEvent("AqueousLord_VileSlime", 8000, 0)
end

RegisterUnitEvent(230002, 1, "AqueousLord_Combat")

function CoilskarSoothsayer_HolyNova(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(38589, Unit:GetClosestPlayer())
end

function CoilskarSoothsayer_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("CoilskarSoothsayer_HolyNova", 7000, 0)
end

RegisterUnitEvent(230031, 1, "CoilskarSoothsayer_Combat")

function CoilskarHarpooner_Throw(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40083, Unit:GetRandomPlayer(0))
end

function CoilskarHarpooner_HookedNet(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40082, Unit:GetRandomPlayer(0))
end

function CoilskarHarpooner_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("CoilskarHarpooner_Throw", 6000, 0)
	Unit:RegisterEvent("CoilskarHarpooner_HookedNet", 8000, 0)
end

RegisterUnitEvent(230032, 1, "CoilskarHarpooner_Combat")

function DragonTurtle_WaterSpit(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40086, Unit:GetClosestPlayer())
end

function DragonTurtle_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("DragonTurtle_WaterSpit", 9000, 0)
end
	
RegisterUnitEvent(230033, 1, "DragonTurtle_Combat")

-- Sanctuary of Shadow

function AshtongueBattlelord_Cleave(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(31043, Unit:GetClosestPlayer())
end

function AshtongueBattlelord_ConcussiveThrow(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(41182, Unit:GetClosestPlayer())
end

function AshtongueBattlelord_ConcussionBlow(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(22427, Unit:GetClosestPlayer())
end

function AshtongueBattlelord_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("AshtongueBattlelord_Cleave", 9000, 0)
	Unit:RegisterEvent("AshtongueBattlelord_ConcussiveThrow", 6000, 0)
	Unit:RegisterEvent("AshtongueBattlelord_ConcussionBlow", 14000, 0)
end

RegisterUnitEvent(230011, 1, "AshtongueBattlelord_Combat")

function AshtongueFeralSpirit_Charge(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(38907, Unit:GetRandomPlayer(0))
	Unit:ClearThreadList()
end

function AshtongueFeralSpirit_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("AshtongueFeralSpirit_Charge", 10000, 0)
end

RegisterUnitEvent(230012, 1, "AshtongueFeralSpirit_Combat")

function AshtongueStormcaller_LightningShield(Unit, event, miscUnit, misc)
	Unit:FullCastSpell(39067)
end

function AshtongueStormcaller_LightningBolt(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(42024, Unit:GetRandomPlayer(0))
end

function AshtongueStormcaller_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("AshtongueStormcaller_LightningShield", 4000, 0)
	Unit:RegisterEvent("AshtongueStormcaller_LightningBolt", 8000, 0)
end

RegisterUnitEvent(230013, 1, "AshtongueStormcaller_Combat")

function AshtonguePrimalist_WingClip(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(39584, Unit:GetClosestPlayer())
end

function AshtonguePrimalist_Cyclone(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(39594, Unit:GetRandomPlayer(0))
end

function AshtonguePrimalist_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("AshtonguePrimalist_WingClip", 7000, 0)
	Unit:RegisterEvent("AshtonguePrimalist_Cyclone", 10000, 0)
end

RegisterUnitEvent(230014, 1, "AshtonguePrimalist_Combat")

function AshtongueMystic_Flameshock(Unit, event, miscUnit, misc)
	local DidIt = 0
	local flag = math.random (1, 2)
	if (flag == 1) and (DidIt == 0) then
		Unit:FullCastSpellOnTarget(39590, Unit:GetRandomPlayer(0))
		local DidIt = 1
	end
end

function AshtongueMystic_FrostShock(Unit, event, miscUnit, misc)
	if (flag == 2) and (DidIt == 1) then
	Unit:FullCastSpellOnTarget(41116, Unit:GetRandomPlayer(0))
	end
end

function AshtongueMystic_Bloodlust(Unit, event, miscUnit, misc)
	Unit:FullCastSpell(41185)
end

function AshtongueMystic_Cyclone(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(39594, Unit:GetRandomPlayer(0))
end

function AshtongueMystic_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("AshtongueMystic_Flameshock", 5000, 0)
	Unit:RegisterEvent("AshtongueMystic_FrostShock", 5000, 0)
	Unit:RegisterEvent("AshtongueMystic_Bloodlust", 30000, 0)
	Unit:RegisterEvent("AshtongueMystic_Cyclone", 10000, 0)
end

RegisterUnitEvent(230015, 1, "AshtongueMystic_Combat")

function IllidariDefiler_RainOfChaos(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40946, Unit:GetRandomPlayer(0))
end

function IllidariDefiler_Banish(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40370, Unit:GetRandomPlayer(0))
end

function IllidariDefiler_CurseOfAgony(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(39672, Unit:GetRandomPlayer(0))
end

function IllidariDefiler_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("IllidariDefiler_RainOfChaos", 10000, 0)
	Unit:RegisterEvent("IllidariDefiler_Banish", 15000, 0)
	Unit:RegisterEvent("IllidariDefiler_CurseOfAgony", 6000, 0)
end

RegisterUnitEvent(230016, 1, "IllidariDefiler_Combat")

function IllidariCenturion_Cleave(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(31043, Unit:GetClosestPlayer())
end

function IllidariCenturion_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("IllidariCenturion_Cleave", 5000, 0)
end

RegisterUnitEvent(230003, 1, "IllidariCenturion_Combat")

function IllidariBoneslicer_Gouge(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(28456, Unit:GetMainTank())
	Unit:ClearThreadList()
end

function IllidariBonesclicer_WoundPoison(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(39665, Unit:GetMainTank())
end

function IllidariBoneslicer_CloakOfShadows(Unit, event, miscUnit, misc)
	Unit:FullCastSpell(39666)
end

function IllidariBoneslicer_Blind(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(43433, Unit:GetRandomPlayer(0))
end

function IllidariBoneslicer_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("IllidariBoneslicer_Gouge", 10000, 0)
	Unit:RegisterEvent("IllidariBoneslicer_WoundPoison", 7000, 0)
	Unit:RegisterEvent("IllidariBoneslicer_CloakOfShadows", 13000, 0)
	Unit:RegisterEvent("IllidariBoneslicer_Blind", 9000, 0)
end

RegisterUnitEvent(230004, 1, "IllidariBoneslicer_Combat")

function IllidariHeartseeker_RapidShot(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(41172, Unit:GetRandomPlayer(0))
end

function IllidariHeartseeker_SonicShot(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(41084, Unit:GetRandomPlayer(0))
end

function IllidariHeartseeker_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("IllidariHeartseeker_RapidShot", 3000, 0)
	Unit:RegisterEvent("IllidariHeartseeker_SonicShot", 5000, 0)
end

RegisterUnitEvent(230005, 1, "IllidariHeartseeker_Combat")

function IllidariNightlord_Hellfire(Unit, event, miscUnit, misc)
	Unit:FullCastSpell(39132)
end

function IllidariNightlord_Fear(Unit, event, miscUnit, misc)
	Unit:FullCastSpell(33547)
end

function IllidariNightlord_Shadowfiends(Unit, event, miscUnit, misc)
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
local o = Unit:GetO()
	Unit:SpawnCreature(22929, x, y, z, o, 14, 0)
	Unit:SpawnCreature(22929, x+3, y+3, z, o, 14, 0)
	Unit:SpawnCreature(22929, x+5, y, z, o, 14, 0)
	Unit:SpawnCreature(22929, x, y+5, z, o, 14, 0)
	Unit:SpawnCreature(22929, x+7, y, z, o, 14, 0)
	Unit:SpawnCreature(22929, x, y+7, z, o, 14, 0)
	Unit:SpawnCreature(22929, x+1, y, z, o, 14, 0)
	Unit:SpawnCreature(22929, x, y+6, z, o, 14, 0)
	Unit:SpawnCreature(22929, x+4, y, z, o, 14, 0)
	Unit:SpawnCreature(22929, x, y+8, z, o, 14, 0)
end

function IllidariNightlord_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("IllidariNightlord_Hellfire", 10000, 0)
	Unit:RegisterEvent("IllidariNightlord_Fear", 6000, 0)
	Unit:RegisterEvent("IllidariNightlord_Shadowfiends", 1000, 1)
end

RegisterUnitEvent(230006, 1, "IllidariNightlord_Combat")

-- Gorefiends Vigil

function ShadowmoonChampion_Whirlwind(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40236, Unit:GetClosestPlayer())
end

function ShadowmoonChampion_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("ShadowmoonChampion_Whirlwind", 5000, 0)
end

RegisterUnitEvent(230021, 1, "ShadowmoonChampion_Combat")

function ShadowmoonRidinghound_Charge(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(38907, Unit:GetRandomPlayer(0))
	Unit:ClearThreadList()
end

function ShadowmoonRidinghound_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("ShadowmoonRidinghoun_Charge", 8000, 0)
end

RegisterUnitEvent(230022, 1, "ShadowmoonRidinghound_Combat")

function ShadowmoonDeathshaper_RaiseDead(Unit, event, miscUnit, misc)
local x = Unit:GetX()
local y = Unit:GetY()
local z = Unit:GetZ()
local o = Unit:GetO()
	Unit:SpawnCreature(23371, x, y, z, o, 14, 0)
end

function ShadowmoonDeathshaper_Dreadbolt(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(40876, Unit:GetRandomPlayer(0))
end

function ShadowmoonDeathshaper_DeathCoil(Unit, event, miscUnit, misc)
	Unit:FullCastSpellOnTarget(33130, Unit:GetRandomPlayer(0))
end

function ShadowmoonDeathshaper_Combat(Unit, event, miscUnit, misc)
	Unit:RegisterEvent("ShadowmoonDeathshaper_RaiseDead", 4000, 0)
	Unit:RegisterEvent("ShadowmoonDeathshaper_Dreadbolt", 6000, 0)
	Unit:RegisterEvent("ShadowmoonDeathshaper_DeathCoil", 5000, 0)
end

RegisterUnitEvent(230023, 1, "ShadowmoonDeathshaper_Combat")