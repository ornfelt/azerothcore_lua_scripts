--[[ Boss -- Herald Volazj.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, October 24, 2008. ]]

function HeraldVolazj_OnEnterCombat(Unit, Event)
	Unit:RegisterEvent("HeraldVolazj_Insanity",10000,0)
	Unit:RegisterEvent("HeraldVolazj_Mindflay",20000,0)

end


function Insanity (Unit, Event)
	Unit:FullCastSpellOnTarget(57496,Unit:GetRandomPlayer(0))
end 

function Mindflay (Unit, Event)
	Unit:FullCastSpellOnTarget(52586,Unit:GetClosestPlayer(0))
end

function HeraldVolazj_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()	
end

function HeraldVolazj_OnDied(Unit, Event)
	Unit:RemoveEvents()
end

RegisterUnitEvent(29311, 1, "HeraldVolazj_OnEnterCombat")
RegisterUnitEvent(29311, 2, "HeraldVolazj_OnLeaveCombat")
RegisterUnitEvent(29311, 4, "HeraldVolazj_OnDied")

--[[ Boss -- ElderNadox.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, October 24, 2008. ]]
--[[
	DEFINES
	]]
local CHAT_MSG_MONSTER_YELL = 14 -- Do this because if enums where to change again, we would just update this.
local LANG_UNIVERSAL = 0

function ElderNadox_OnCombat(Unit,Event)
	math.randomseed(os.time()) -- to help randomize the function.
	Unit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"The secrets of the deep shall remain hidden.")
	Unit:RegisterEvent("ElderNadox_Summon",20000, 1)
	Unit:RegisterEvent("ElderNadox_BroodPlague",8000, 1)
end

function ElderNadox_Summon(Unit,Event)
	Unit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"The young must not grow hungry.")
	local x,y,z,o =	Unit:GetX(),Unit:GetY(),Unit:GetZ(),Unit:GetO() -- save some reading space here ^ ^
	Unit:SpawnCreature(30176 , x, y, z, o, 14, 60000)
end

function ElderNadox_BroodPlague(Unit,Event) -- if closest plr happens to be nil then console will spam error messages of this.
	if	Unit:IsInCombat() == true then -- to prevent spamming whilst the unit isn't in combat.
		local plr =	Unit:GetClosestPlayer()
		if type(plr) == "userdata" and plr:IsAlive() == true then
			Unit:FullCastSpellOnTarget(56130,plr)
			Unit:RegisterEvent("ElderNadox_BroodPlague",8000, 1)
		elseif type(plr) ~= "userdata" then
			ElderNadox_BroodPlague(Unit,Event) -- call it again.
		end
	end
end

function ElderNadox_OnKilledTarget(Unit, Event) -- might aswell call it a few times to randomize it
	if math.random(3) ==1 then
		Unit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"Sleep now, in the cold dark.")
	elseif math.random(3)==2 then	
		Unit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"For the Lich King!")
	elseif math.random(3)==3 then
		Unit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL,"Perhaps we will be allies soon. ")	
	end
end

function ElderNadox_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()	
end

function ElderNadox_OnDied(Unit, event, player)
	Unit:SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "Master, is my service complete?")	
	Unit:RemoveEvents()
end

RegisterUnitEvent(29309, 1, "ElderNadox_OnCombat")
RegisterUnitEvent(29309, 2, "ElderNadox_OnLeaveCombat")
RegisterUnitEvent(29309, 4, "ElderNadox_OnDied")
RegisterUnitEvent(29309, 3, "ElderNadox_OnKilledTarget")

--[[ Boss -- Prince Taldaram.lua

This script was written and is protected
by the GPL v2. This script was released
by Azolex of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

~~End of License Agreement
-- Azolex, October 24, 2008. ]]

function PrinceTaldaram_OnEnterCombat(Unit, Event)
	Unit:SendChatMessage(14, 0, "I will feast on your remains.")
	Unit:RegisterEvent("PrinceTaldaram_Bloodthirst",17000, 0)
	Unit:RegisterEvent("PrinceTaldaram_Vasnih",24000, 0)
	Unit:RegisterEvent("PrinceTaldaram_Conjure",35000, 0)
	Unit:RegisterEvent("PrinceTaldaram_Vampyr",40000, 0)
end

function PrinceTaldaram_Bloodthirst(Unit,Event)
	Unit:FullCastSpell(55968)
end

function PrinceTaldaram_Vasnih(Unit,Event)
	Unit:FullCastSpell(55964)
	local vchoice=math.random(1, 2)
	if vchoice==1 then
		Unit:SendChatMessage(14, 0,"Your heartbeat is music to my ears.")
	elseif vchoice==2 then
		Unit:SendChatMessage(14, 0,"I am nowhere. I am everywhere. I am the watcher, unseen.")
	end
end

-- Core Script required it might crash server as well...worked on mine i will post patch
function PrinceTaldaram_Conjure(Unit,Event)
	Unit:FullCastSpellOnTarget(55931,Unit:GetClosestPlayer(0))
end

function PrinceTaldaram_Vampyr(Unit,Event)
	Unit:FullCastSpellOnTarget(55959,Unit:GetClosestPlayer(0))
	local vamchoice=math.random(1, 2)
	if vamchoice==1 then
		Unit:SendChatMessage(14, 0,"So appetizing.")
	elseif vamchoice==2 then
		Unit:SendChatMessage(14, 0,"Fresh, warm blood. It has been too long. ")
	end
end

function PrinceTaldaram_OnKilledTarget (Unit, Event)
	local Choice=math.random(1, 2)
	if Choice==1 then
		Unit:SendChatMessage(14, 0,"I will drink no blood before it's time.")
	elseif Choice==2 then	
		Unit:SendChatMessage(14, 0,"One final embrace.")
end		
end

function PrinceTaldaram_OnLeaveCombat(Unit, Event)
	Unit:RemoveEvents()	
end

function PrinceTaldaram_OnDied(Unit, event, player)
	Unit:SendChatMessage(14, 0, "Still I hunger, still I thirst.")	
	Unit:RemoveEvents()
end

RegisterUnitEvent(29308, 1, "PrinceTaldaram_OnEnterCombat")
RegisterUnitEvent(29308, 2, "PrinceTaldaram_OnLeaveCombat")
RegisterUnitEvent(29308, 4, "PrinceTaldaram_OnDied")
RegisterUnitEvent(29308, 3, "PrinceTaldaram_OnKilledTarget")