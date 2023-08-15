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

local healing_ward = 14987
local powerful_healing = 24311
local hexxer = 11380
local delusions = 24306
local hexxer_hex = 17172
local shade = 14986
local shade_shock = 24458
local shade_visual = 24313
local coords = {
{x =-11582.373047, y=-1257.175781, z = 77.547829},
{x =-11585.643555, y=-1255.902100, z = 77.547829},
{x =-11587.205078, y=-1251.681641, z = 77.547829},
{x =-11586.676758, y=-1248.007202, z = 77.547829},
{x =-11579.822266, y=-1246.633545, z = 77.547424},
{x =-11578.796875, y=-1252.417603, z = 77.547424},
{x =-11580.839844, y=-1256.166626, z = 77.547699},
{x =-11584.952148, y=-1255.456299, z = 77.547699}
}

function Hexxer_OnCombat(Unit,event)
	setvars(Unit,{shades = {},skeles = {}})
	Unit:RegisterEvent("Hexxer_HealingWard", 5000, 1)
	Unit:RegisterEvent("Hexxer_Hex",15000,1)
	Unit:RegisterEvent("Hexxer_Delusions",10000, 1)
	Unit:RegisterEvent("Hexxer_Teleport", 30000, 1)
	Unit:RegisterEvent("Hexxer_SpawnTrolls", 500, 8)
end
function Hexxer_SpawnTrolls(Unit,event)
	Unit:SpawnCreature(14826,coords[x],coords[y],coords[z], 0, 16, 30000)
end
function Hexxer_OnWipe(Unit,event)
	Unit:RemoveEvents()
	local args = getvars(Unit)
	for k,v in pairs(args.shades) do
		v:RemoveFromWorld()
	end
	for k,v in pairs(args.skeles) do
		v:RemoveFromWorld()
	end
end
function Hexxer_OnDied(Unit,event)
	Unit:RemoveEvents()
	local args = getvars(Unit)
	for k,v in pairs(args.shades) do
		v:RemoveFromWorld()
	end
	for k,v in pairs(args.skeles) do
		v:RemoveFromWorld()
	end
end


RegisterUnitEvent(hexxer, 1, "Hexxer_OnCombat")
RegisterUnitEvent(hexxer, 2, "Hexxer_OnWipe")
RegisterUnitEvent(hexxer, 4, "Hexxer_OnDied")

-------------------------------------------------------------------------------
------------------------HOOKED EVENTS END_----------------------
-------------------------------------------------------------------------------

function Hexxer_HealingWard(Unit,event)
	Unit:FullCastSpell(24309) -- summon healing ward
	Unit:RegisterEvent("Hexxer_HealingWard", 5000, 1)
end
function Hexxer_Hex(Unit,event)
	local tank = Unit:GetMainTank()
	local offtank = Unit:GetAddTank()
	if tank ~= nil and offtank ~= nil then
		Unit:FullCastSpellOnTarget(hexxer_hex,tank)
		Unit:SetNextTarget(offtank)
	end
	Unit:RegisterEvent("Hexxer_Hex",15000,1)
end
function Hexxer_Delusions(Unit,event)
	local args = getvars(Unit)
	local plr = Unit:GetRandomPlayer(0)
	if plr ~= nil then
		Unit:FullCastSpellOnTarget(delusions,plr)
		table.insert(args.shades,Unit:SpawnCreature(shade,Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO(),Unit:GetUInt32Value(UNIT_FIELD_FACTIONTEMPLATE),0))
	end
	Unit:RegisterEvent("Hexxer_Delusions",10000, 1)
end
function Hexxer_Teleport(Unit,event)
	local plr = Unit:GetRandomPlayer(0)
	if plr ~= nil then
		Unit:FullCastSpellOnTarget(24466,plr)--teleport visual
		plr:Teleport(309, -11583.710938, -1250.584717, 77.546814)
	end
	Unit:RegisterEvent("Hexxer_Teleport", 30000, 1)
end
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------

function healing_wardspawn(Unit,event)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FIELD_NOT_ATTACKBLE_2)
	Unit:SetUInt32Value(UNIT_FIELD_FLAGS,UNIT_FIELD_NOT_SELECTABLE)
	Unit:SetCombatCapable(1)
	Unit:Root()
	Unit:RegisterEvent("healing_wardtick", 3000, 1)
end
function healing_wardtick(Unit, event)
	local tbl = Unit:GetInRangeFriends()
	for k,v in pairs(tbl) do
		if v ~= nil then
			if v:GetEntry() == hexxer then
				Unit:FullCastSpelOnTarget(powerful_healing,v)
			end
		end
		break
	end
	Unit:RegisterEvent("healing_wardtick", 3000, 1)
end
function healing_warddeath(Unit,event)
	Unit:RemoveEvents()
	Unit:RemoveFromWorld()
end

RegisterUnitEvent(healing_ward, 18, "healing_wardspawn")
RegisterUnitEvent(healing_ward, 4, "healing_warddeath")

-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

function Shade_OnSpawn(Unit,event)
	Unit:CastSpell(shade_visual)-- shadowish aura
	Unit:SetUInt32Value(UNIT_FIELD_MINDAMAGE, 1)
	Unit:SetUInt32Value(UNIT_FIELD_MAXDAMAGE, 1)
	Unit:RegisterEvent("ShadeUpdate", 20000,1)
end
function ShadeUpdate(Unit,event)
	Unit:WipeCurrentTarget()
	Unit:RegisterEvent("ShadeUpdate", 20000,1)
end
function Shade_Interrupt(Unit, event, pMisc)
	if pMisc:GetCurrentSpellId() ~= nil then
		pMisc:InterruptSpell()
	end
	if math.random(0,10) == 1 then
		Unit:FullCastSpellOnTarget(shade_shock,pMisc)
	end
end
function Shade_OnDeath(Unit,event)
	local args = getvars(Unit)
	for k,v in pairs(args.shades) do
		if v~= nil and v == Unit then
			table.remove(args.shades,v)
		end
		break
	end
end

RegisterUnitEvent(shade, 18, "Shade_OnSpawn")
RegisterUnitEvent(shade, 4, "Shade_OnDeath")
RegisterUnitEvent(shade, 13, "Shade_Interrupt")

---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
