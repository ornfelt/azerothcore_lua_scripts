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
   Boss -- Elder Nadox.lua
   Original Code by DARKI
   Version 1
========================================]]--

local CHAT_MSG_MONSTER_YELL = 14 -- Do this because if enums where to change again, we would just update this.
local LANG_UNIVERSAL = 0

function ElderNadox_OnEnterCombat(pUnit,Event)
	math.randomseed(os.time()) -- to help randomize the function.
	pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"The secrets of the deep shall remain hidden.")
	pUnit:RegisterEvent("ElderNadox_Summon",20000, 1)
	pUnit:RegisterEvent("ElderNadox_BroodPlague",8000, 1)
end

function ElderNadox_Summon(pUnit,Event)
	pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"The young must not grow hungry.")
	local x,y,z,o = pUnit:GetX(),pUnit:GetY(),pUnit:GetZ(),pUnit:GetO() -- save some reading space here ^ ^
	pUnit:SpawnCreature(30176 , x, y, z, o, 14, 60000)
end

function ElderNadox_BroodPlague(pUnit,Event) -- if closest plr happens to be nil then console will spam error messages of this.
	if Unit:IsInCombat() == true then -- to prevent spamming whilst the unit isn't in combat.
		local plr = Unit:GetClosestPlayer()
		if type(plr) == "userdata" and plr:IsAlive() == true then
			pUnit:FullCastSpellOnTarget(56130,plr)
			pUnit:RegisterEvent("ElderNadox_BroodPlague",8000, 1)
		elseif type(plr) ~= "userdata" then
			ElderNadox_BroodPlague(pUnit,Event) -- call it again.
		end
	end
end

function ElderNadox_OnKilledTarget(pUnit, Event) -- might aswell call it a few times to randomize it
	if math.random(3) ==1 then
		pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"Sleep now, in the cold dark.")
	elseif math.random(3)==2 then	
		pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"For the Lich King!")
	elseif math.random(3)==3 then
		pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"Perhaps we will be allies soon. ")	
	end
end

function ElderNadox_OnLeaveCombat(pUnit, Event)
	pUnit:RemoveEvents()	
end

function ElderNadox_OnDied(pUnit, event, player)
	pUnit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "Master, is my service complete?")	
	pUnit:RemoveEvents()
end

RegisterUnitEvent(29309, 1, "ElderNadox_OnEnterCombat")
RegisterUnitEvent(29309, 2, "ElderNadox_OnLeaveCombat")
RegisterUnitEvent(29309, 4, "ElderNadox_OnDied")
RegisterUnitEvent(29309, 3, "ElderNadox_OnKilledTarget")