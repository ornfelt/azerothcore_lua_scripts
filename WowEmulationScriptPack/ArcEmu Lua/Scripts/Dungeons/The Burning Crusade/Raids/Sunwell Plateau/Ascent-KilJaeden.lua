
--[[
	THIS SCRIPT WAS WRITTEN BY zdroid9770. :)
		]]

local kiljaeden = 25315
local cn_kiljaeden = nil
local kiljaedendummy = nil
local handofkiljaeden = 25588
local handaddtable = {}
local anveena = nil
local blueorbs = {}
local startbl = {}
local spawnpts = {}
local activatedorbs = {}
local justspawned = {}
local spawnedorbs = false
spawnpts.x = {1747.962891,1695.568115,1652.105713,1705.071899}
spawnpts.y = {620.713135,676.063477,635.099670,582.911438 }
spawnpts.z = {28.050375,28.050201,28.125195,28.141369 }
spawnpts.o = {2.964534,4.755246,6.129690,1.743238}
--Fill table w/ dummy values
for i = 1, 3 do 
	handaddtable[i] = 1
end
startbl[1] = 1
blueorbs[1] = 1

function Kiljaeden_SpawnOrbs(Unit)
	if spawnedorbs == false then
		spawnedorbs = true
		Unit:SpawnGameObject(188116,spawnpts.x[1],spawnpts.y[1],spawnpts.z[1],spawnpts.o[1],0)
		Unit:SpawnGameObject(187869,spawnpts.x[2],spawnpts.y[2],spawnpts.z[2],spawnpts.o[2],0)
		Unit:SpawnGameObject(188114,spawnpts.x[3],spawnpts.y[3],spawnpts.z[3],spawnpts.o[3],0)
		Unit:SpawnGameObject(188115,spawnpts.x[4],spawnpts.y[4],spawnpts.z[4],spawnpts.o[4],0)
	end
	if spawnedorbs == true then
		spawnedorbs = false
	end
end
function HandOfKil_OnSpawn(Unit)
	if Unit:GetEntry() == 25588 then
		Unit:DisableRespawn()
		for k,v in pairs(handaddtable) do
			if v == 1 then
				table.remove(handaddtable,k)
				table.insert(handaddtable,Unit)
				break
			end
		end
		for k,v in pairs(startbl) do
			if v == 1 then
				table.remove(startbl,k)
				table.insert(startbl,Unit:SpawnCreature(25608,1699.204712,628.331482,27.618011,Unit:GetO(),Unit:GetUInt32Value(UnitField.UNIT_FIELD_FACTIONTEMPLATE),0))
				table.insert(startbl,Unit:SpawnCreature(26046,1698.896729,629.173546,55.558176,Unit:GetO(), 35,0))
				break
			end
		end
		for k,v in pairs(blueorbs) do
			if v == 1 then
				table.remove(blueorbs,k)
				--Spawn the blue orbs --
				Kiljaeden_SpawnOrbs(Unit)
				break;
			end
		end
		
		for k,v in pairs(startbl) do
			if v~= nil and v:GetEntry() == 25608 then
				kiljaedendummy = v;
			elseif v~=nil and v:GetEntry() == 26046 then
				anveena = v;
			end
		end
		for k,v in pairs(blueorbs) do
			if v == 1 then
				table.remove(blueorbs,k)
				break
			end
		end
		for k,v in pairs(handaddtable) do
			if v~= nil and type(v) ~= "number" then
				v:SetUInt32Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT,kiljaedendummy:GetGUID())
				v:SetUInt32Value(UnitField.UNIT_CHANNEL_SPELL,46757)
			end
		end
	end
end
function HandOfKil_OnCombat(Unit)
	Unit:RemoveFlag(UnitField.UNIT_FIELD_CHANNEL_OBJECT,Unit:GetUInt32Value(UnitField.UNIT_FIELD_CHANNEL_OBJECT));
	Unit:RemoveFlag(UnitField.UNIT_CHANNEL_SPELL,Unit:GetUInt32Value(UnitField.UNIT_CHANNEL_SPELL))
	Unit:RegisterEvent("HandOfKil_ShadowBoltVolley",15000, 0)
	Unit:RegisterEvent("HandOfKil_FelFirePortal", 20000, 0)
	Unit:RegisterAIUpdateEvent(1000)
end
function HandOfKil_OnDeath(Unit)
	Unit:RemoveEvents()
	Unit:RemoveAIUpdateEvent()
	for k,v in pairs(handaddtable) do
		if v ==  Unit then
			table.remove(handaddtable, k)
		end
	end
end
function HandOfKil_OnWipe(Unit)
	for k,v in pairs(handaddtable) do
		if v == Unit then
			table.remove(handaddtable,k)
		end
	end
	Unit:RemoveEvents()
	Unit:RemoveAIUpdateEvent()
	Unit:RemoveFromWorld()
end
function HandOfKil_ShadowBoltVolley(Unit)
	if Unit:GetRandomPlayer(0) then
		Unit:FullCastSpell(45770)
	end
end
function HandOfKil_FelFirePortal(Unit)
	Unit:FullCastSpell(46875)
end

function HandOfKil_AIUpdate(Unit)
	if Unit:GetHealthPct() <= 25 then
		Unit:FullCastSpell(45772)
		Unit:RemoveAIUpdateEvent()
	end
end

RegisterUnitEvent(handofkiljaeden,18,"HandOfKil_OnSpawn")
RegisterUnitEvent(handofkiljaeden, 1, "HandOfKil_OnCombat")
RegisterUnitEvent(handofkiljaeden, 2, "HandOfKil_OnWipe")
RegisterUnitEvent(handofkiljaeden, 4, "HandOfKil_OnDeath")


function KilJaedenDummy_OnSpawn(Unit)
	Unit:EnableFlight()
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE+UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_MAXHEALTH,1000000)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_HEALTH,1000000)
	Unit:DisableRespawn()
	Unit:SetCombatCapable(1)
	Unit:SetCombatTargetingCapable(1)
	Unit:RegisterAIUpdateEvent(1000)
	Unit:RegisterEvent("KilJaeden_PeriodicOrders", 2000, 1)
	Unit:RegisterEvent("InitializeKilJaedenDummy",1000,1)
end
function InitializeKilJaedenDummy(Unit)
	Unit:FullCastSpell(46410)
end
function KilJaeden_PeriodicOrders(Unit)
	local rand = tonumber(math.random(5))
	if rand == 1 then
		Unit:PlaySoundToSet(12495)
		return
	end
	if rand == 2 then	
		Unit:PlaySoundToSet(12496)
		return
	end
	if rand == 3 then
		Unit:PlaySoundToSet(12497)
		return
	end
	if rand == 4 then
		Unit:PlaySoundToSet(12498)
		return
	end
	if rand == 5 then
		Unit:PlaySoundToSet(12499)
		return
	end
	Unit:RegisterEvent("KilJaeden_PeriodicOrders", 20000, 1)
end
function KilJaedenDummy_AIUpdate(Unit)
	if Unit:GetEntry() == 25608 then
		Unit:WipeThreatList()
		local no = table.getn(handaddtable)
		if no ~= nil and no == 0 then
			cn_kiljaeden = Unit:SpawnCreature(kiljaeden,1699.204712,628.331482,Unit:GetZ(),Unit:GetO(),Unit:GetUInt32Value(UnitField.UNIT_FIELD_FACTIONTEMPLATE),0)
			Unit:RemoveEvents()
			Unit:RemoveAIUpdateEvent()
			Unit:RemoveFromWorld()
		end
	end
end

RegisterUnitEvent(handofkiljaeden, 21, "HandOfKil_AIUpdate")
RegisterUnitEvent(25608, 18, "KilJaedenDummy_OnSpawn")
RegisterUnitEvent(25608, 21, "KilJaedenDummy_AIUpdate")

function AnveenaOnSpawn(Unit)
	Unit:EnableFlight()
	Unit:SetCombatMeleeCapable(1)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:RegisterEvent("InitializeAnveena",500,1)
end

RegisterUnitEvent(26046,18,"AnveenaOnSpawn")

function InitializeAnveena(Unit)
	Unit:FullCastSpell(46367)
	Unit:MoveTo(Unit:GetX(),Unit:GetY(),Unit:GetZ()+1,Unit:GetO())
end
--[[
	FEL FIRE PORTAL
		]]

function InitializeFelFirePortal(Unit)
	Unit:SetCombatTargetingCapable(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:FullCastSpell(46464)
	Unit:WipeThreatList()
end

RegisterUnitEvent(25603,18,"InitializeFelFirePortal")

--[[	
	VOLATILE FELFIRE FIEND
		]]

function VolatileFiend_OnSpawn(Unit)
	Unit:RegisterEvent("InitializeFiend",500,1)
end
function InitializeFiend(Unit)
	Unit:DisableRespawn()
	Unit:SetCombatCapable(1)
	Unit:RegisterAIUpdateEvent(500)
	local plr = Unit:GetRandomPlayer(0)
	if plr~= nil then
		Unit:SetNextTarget(plr)
		Unit:SetUnitToFollow(plr,3,45)
	end
end
function VolatileFiend_AIUpdate(Unit)
	local tar = Unit:GetNextTarget()
	if tar ~= nil and Unit:CalcDistance(tar) <= 5 then
		Unit:FullCastSpell(45779)
		Unit:RemoveFromWorld()
	end
end
function VolatileFied_OnDeath(Unit)
	Unit:FullCastSpell(45779)
	Unit:RemoveAIUpdateEvent()
end

RegisterUnitEvent(25598,18,"VolatileFiend_OnSpawn")
RegisterUnitEvent(25598,21,"VolatileFiend_AIUpdate")
RegisterUnitEvent(25598,4,"VolatileFied_OnDeath")

--[[
	KIL JAEDEN
	]]

local legion_light =nil
local soul_flay = nil
local fire_bloom =nil
local shadow_spike = nil
local flame_dart =nil
local meteor_timer = nil
local shield_orbs = nil
local shield_orbtable = {}
local shield_orbtimer = nil
local soul_darkness = nil
local cancast = true
local castmeteor = false
local m_phase = nil
local meteors = 0
local sinister_reflect = false;
local kalec = nil
local saytable = {phase3say = false,phase4say = false,phase5say = false, orbsay1 = false, orbsay2 = false, orbsay3 = false, kalecsay1 = false,kalecsay2 = false,kalecsay3 = false,kalecsay4 = false, anveenasay1 = false,anveenasay2 = false,
anveenasay3 = false, anveenasay4 = false,kalecsay5 = false,kalecintrosay = false,introsay = false}
--[[
	HOOKED EVENTS
	]]
function KilJaeden_OnSpawn(Unit)
	Unit:RegisterEvent("InitializeKilJaeden",500,1)
	Unit:EnableFlight()
	Unit:StopMovement(100)
	Unit:DisableRespawn()
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE + UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:SetCombatMeleeCapable(1)
	Unit:RegisterEvent("KiljaedenBattleReady", 10500, 1)-- 10 secs should be enough to fully play birth animation
end
function InitializeKilJaeden(Unit)
	Unit:FullCastSpell(26586) -- birth emote
	Unit:CastSpell(47115)
end
function KiljaedenBattleReady(Unit)
	Unit:RemoveFlag(UnitField.UNIT_FIELD_FLAGS, UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE+UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:SetCombatCapable(0)
	 local plr = Unit:GetRandomPlayer(0)
	 Unit:AttackReaction(plr,1)
end
function KilJaeden_OnCombat(Unit)
	Unit:RemoveEvents()
	Unit:RegisterAIUpdateEvent(1000)
	m_phase = 1
	KilJaeden_PhaseCheck(Unit)
	saytable.introsay = true
	KilJaeden_Gossip(Unit)
	saytable.kalecintrosay = true
	Unit:RegisterEvent("KilJaeden_Gossip",25000,1 )
	kalec = Unit:SpawnCreature(25319,1699.204712,628.331482,27.558220+100.000000,Unit:GetO(),35,0)
end
function KilJaeden_OnKill(Unit,event,pMisc)
	if pMisc:IsPlayer() then
		if math.random(2) == 1 then
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Another step towards destruction!")
			Unit:PlaySoundToSet(12501)
		else
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Anak'kiri")
			Unit:PlaySoundToSet(12502)
		end
	end
end
function KilJaeden_OnDeath(Unit)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Nooooooooooooo!")
	Unit:RemoveEvents()
	Unit:RemoveAIUpdateEvent()
	for k,v in pairs(shield_orbtable) do 
		if v ~= nil and v:IsInWorld() == true then
			v:RemoveFromWorld()
		end
	end
end
function KilJaeden_OnWipe(Unit)
	Unit:RemoveAIUpdateEvent()
	Unit:RemoveEvents()
	if Unit:IsAlive() == true then
		Unit:RemoveFromWorld()
	end
	for k,v in pairs(shield_orbtable) do 
		if v ~= nil and v:IsInWorld() == true then
			v:RemoveFromWorld()
		end
	end
end



--[[
	~HOOK EVENTS
		]]
function KilJaeden_Gossip(Unit)
	if saytable.introsay == true and m_phase == 1 then
		saytable.introsay = false
		Unit:PlaySoundToSet(12500)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"The expendible have perished... So be it! Now I shall succeed where Sargeras could not! I will bleed this wretched world and secure my place as the true master of the Burning Legion. The end has come! Let the unraveling of this world commence!")
	end
	if saytable.kalecintrosay == true and kalec ~= nil and m_phase == 1 then
		Unit:PlaySoundToSet(12438)
		kalec:SetMovementType(3)
		kalec:MoveToWaypoint(1);
		kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You are not alone. The Blue Dragonflight shall help you vanquish the Deceiver.")
		saytable.kalecintrosay = false
	end
	if saytable.kalecsay1 == true and saytable.anveenasay1 == false and saytable.phase3say == false and kalec ~= nil and m_phase == 2 then
		saytable.anveenasay1 = true
		Unit:PlaySoundToSet(12445)
		kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Anveena, you must awaken, this world needs you!")
		Unit:RegisterEvent("KilJaeden_Gossip",5000,1)
	elseif saytable.kalecsay1 == true and saytable.anveenasay1 == true and saytable.phase3say == false and anveena ~= nil and m_phase == 2 then
		saytable.phase3say = true
		Unit:PlaySoundToSet(12511)
		anveena:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I serve only the master now.")
		Unit:RegisterEvent("KilJaeden_Gossip",5000,1)
	elseif saytable.kalecsay1 == true and saytable.anveenasay1 == true and saytable.phase3say == true and m_phase == 2 then
		saytable.phase3say = false
		saytable.kalecsay1 = false
		saytable.anveenasay1 = false
		saytable.orbsay1 = true
		Unit:PlaySoundToSet(12508)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I will not be denied! This world shall fall!")
		Unit:RegisterEvent("KilJaeden_Gossip",7000,1)
	elseif saytable.orbsay1 == true and kalec ~= nil and m_phase == 2 then
		Unit:PlaySoundToSet(12440)
		kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I will channel my power into the orbs, be ready!")
		saytable.orbsay1 = false
		kalec:SetMovementType(3)
		kalec:MoveToWaypoint(1)
		local chosenorb = blueorbs[math.random(1,table.getn(blueorbs))]
		if chosenorb ~= nil and chosenorb:IsInWorld() == true then
			local addy = tostring(chosenorb)
			activatedorbs[addy] = true
			chosenorb:SpawnCreature(25640,chosenorb:GetX(),chosenorb:GetY(),chosenorb:GetZ(),chosenorb:GetO(),14,0)
		end
	end
	if saytable.kalecsay2 == true and saytable.anveenasay2 == false and saytable.phase4say == false and kalec ~= nil and m_phase == 3 then
		Unit:PlaySoundToSet(12446)
		kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You must let go! You must become what you were always meant to be! The time is now, Anveena!")
		saytable.anveenasay2 = true
		Unit:RegisterEvent("KilJaeden_Gossip",8000,1)
	elseif saytable.kalecsay2 == true and saytable.anveenasay2 == true and saytable.phase4say == false and anveena ~= nil and m_phase == 3  then
		Unit:PlaySoundToSet(12512)
		anveena:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"But I'm... lost. I cannot find my way back.")
		saytable.phase4say = true
		Unit:RegisterEvent("KilJaeden_Gossip",6000,1)
	elseif saytable.kalecsay2 == true and saytable.anveenasay2 == true and saytable.phase4say == true and m_phase == 3  then
		Unit:PlaySoundToSet(12509)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Do not harbor false hope. You cannot win!")
		saytable.kalecsay2 = false
		saytable.anveenasay2 = false
		saytable.phase4say = false
		saytable.orbsay2 = true
		Unit:RegisterEvent("KilJaeden_Gossip",7000,1)
	elseif saytable.orbsay2 == true and kalec ~= nil and m_phase == 3  then
		if math.random(2) == 1 then
			kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I have empowered another orb! Use it quickly!")
			Unit:PlaySoundToSet(12441)
			kalec:SetMovementType(3)
			kalec:MoveToWaypoint(2)
			local chosenorb = blueorbs[math.random(1,table.getn(blueorbs))]
			if chosenorb ~= nil and type(chosenorb) == "userdata" and chosenorb:IsInWorld() == true  then
				local addy = tostring(chosenorb)
				activatedorbs[addy] = true
				chosenorb:SpawnCreature(25640,chosenorb:GetX(),chosenorb:GetY(),chosenorb:GetZ(),chosenorb:GetO(),14,0)
			end
		else
			kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Another orb is ready! Make haste!")
			Unit:PlaySoundToSet(12442)
			kalec:SetMovementType(3)
			kalec:MoveToWaypoint(2)
			local chosenorb = blueorbs[math.random(1,table.getn(blueorbs))]
			if chosenorb ~= nil and type(chosenorb) == "userdata" and chosenorb:IsInWorld() == true then
				local addy = tostring(chosenorb)
				activatedorbs[addy] = true
				chosenorb:SpawnCreature(25640,chosenorb:GetX(),chosenorb:GetY(),chosenorb:GetZ(),chosenorb:GetO(),14,0)
			end
		end
		saytable.orbsay2 = false
	end
	if saytable.kalecsay3 == true and saytable.anveenasay3 == false and saytable.phase5say == false and m_phase == 4 and kalec ~= nil then
		Unit:PlaySoundToSet(12447)
		kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Anveena, I love you! Focus on my voice, come back for me now! Only you can cleanse the Sunwell!")
		saytable.anveenasay3 = true
		Unit:RegisterEvent("KilJaeden_Gossip",10000,1)
	elseif saytable.kalecsay3 == true and saytable.anveenasay3 == true and saytable.phase5say == false and anveena ~= nil then
		Unit:PlaySoundToSet(12513)
		anveena:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Kalec...? Kalec?")
		saytable.kalecsay3 = false
		saytable.kalecsay4 = true
		saytable.anveenasay3 = false
		Unit:RegisterEvent("KilJaeden_Gossip",2200,1)
	elseif saytable.kalecsay4 == true and saytable.anveenasay4 == false and kalec ~= nil then
		Unit:PlaySoundToSet(12448)
		kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Yes, Anveena! Let fate embrace you now!")
		saytable.anveenasay4 = true
		Unit:RegisterEvent("KilJaeden_Gossip",6500,1)
	elseif saytable.kalecsay4 == true and saytable.anveenasay4 == true and saytable.phase5say == false and anveena ~= nil then
		Unit:PlaySoundToSet(12514)
		anveena:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"The nightmare is over, the spell is broken! Goodbye, Kalec, my love!")
		saytable.phase5say = true
		Unit:RegisterEvent("KilJaeden_Gossip",6000,1)
	elseif saytable.kalecsay4 == true and saytable.anveenasay4 == true and saytable.phase5say == true and anveena ~= nil then
		Unit:RegisterEvent("KilJaeden_CanCast",5000,1)
		Unit:PlaySoundToSet(12510)
		Unit:Emote(409,0)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Aggghh! The powers of the Sunwell... turn... against me! What have you done? What have you done???")
		Unit:FullCastSpellOnTarget(46474,Unit)
		anveena:RemoveFromWorld()
		saytable.orbsay3 = true
		saytable.kalecsay4 = false
		saytable.anveenasay4 = false
		saytable.phase5say = false
		Unit:RegisterEvent("KilJaeden_Gossip",11000,1)
	elseif saytable.orbsay3 == true and saytable.kalecsay4 == false and kalec ~= nil then
		kalec:SetMovementType(3)
		kalec:MoveToWaypoint(4)
		kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I have channeled all I can! The power is in your hands!")
		Unit:PlaySoundToSet(12443)
		saytable.orbsay3 = false
		saytable.kalecsay4 = false
		saytable.kalecsay5 = true
		for k,v in pairs(blueorbs) do
			if v ~= nil and type(v) == "userdata" and v:IsInWorld() == true then
				local addy = tostring(v)
				activatedorbs[addy] = true
				v:SpawnCreature(25640,v:GetX(),v:GetY(),v:GetZ(),v:GetO(),14,0)
			end
		end
		Unit:RegisterEvent("KilJaeden_Gossip",6000,1)
	elseif saytable.kalecsay5 == true and saytable.orbsay3 == false and kalec ~= nil then
		if math.random(2) == 1 then
			Unit:PlaySoundToSet(12449)
			kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Strike now, heroes, while he is weakened! Vanquish the Deceiver!")
		else
			Unit:PlaySoundToSet(12450)
			kalec:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Goodbye, Anveena, my love. Few will remember your name, yet this day you change the course of destiny. What was once corrupt is now pure. Heroes, do not let her sacrifice be in vain.")			
		end
	end
end
function KilJaeden_CanCast(Unit)
	if cancast == false then
		cancast = true
	end
	if castmeteor == false then
		castmeteor = true
	end
end
function KilJaeden_PhaseCheck(Unit)
	if m_phase == 1 then
		shield_orbs = 1
		shield_orbtimer = 15
		soul_flay = 4
		legion_light = 0
		fire_bloom = 0
	end
	if m_phase == 2 then
		shield_orbs = 2
		shield_orbtimer = 0
		shadow_spike = true
		flame_dart = 0
		soul_darkness = 0
		soul_flay = 0
		legion_light = 0
		fire_bloom = 0
	end
	if m_phase == 3 then
		shield_orbtimer = 0
		fire_bloom = 0
		legion_light = 0
		soul_flay = 0
		soul_darkness = 0
		flame_dart = 0
		meteors = 0
		shield_orbs = 3
		shadow_spike = true
		castmeteor = true
		meteor_timer = 0;
	end
	if m_phase == 4 then
		shield_orbtimer = nil
		shield_orbs = nil
		shield_spawn = nil
		meteor_timer = 0
		meteors = 0
		shadow_spike = true
		shield_orbs = 0
		legion_light = 0
		soul_flay = 0
		soul_darkness = 0
		flame_dart = 0
		fire_bloom = 0
	end
end
function KilJaeden_AIUpdate(Unit)
	if m_phase == 1 then
		legion_light = legion_light +1
		soul_flay = soul_flay +1
		fire_bloom = fire_bloom +1
		shield_orbtimer = shield_orbtimer+1
	end
	if m_phase == 2 then
		flame_dart =  flame_dart +1
		soul_darkness = soul_darkness +1
		legion_light = legion_light +1
		soul_flay = soul_flay +1
		fire_bloom = fire_bloom +1
		shield_orbtimer = shield_orbtimer+1
	end
	if m_phase == 3 then
		flame_dart =  flame_dart +1
		soul_darkness = soul_darkness +1
		legion_light = legion_light +1
		soul_flay = soul_flay +1
		fire_bloom = fire_bloom +1
		meteor_timer = meteor_timer+1
		shield_orbtimer = shield_orbtimer+1
	end
	if m_phase == 4 then
		flame_dart =  flame_dart +1
		soul_darkness = soul_darkness +1
		legion_light = legion_light +1
		soul_flay = soul_flay +1
		fire_bloom = fire_bloom +1
		meteor_timer = meteor_timer+1
	end
	local hp = Unit:GetHealthPct()
	local plr = Unit:GetRandomPlayer(0)
	local tank = Unit:GetMainTank()
	if hp > 85 then
		if soul_flay == 5 and cancast == true and tank~= nil then
			cancast = false
			Unit:FullCastSpellOnTarget(45442, tank)
			soul_flay = 0
			Unit:RegisterEvent("KilJaeden_CanCast",3500, 1)
		elseif soul_flay == 5 and cancast == false then
			soul_flay = soul_flay-1
		end
		if shield_orbtimer == 30 and table.getn(shield_orbtable) == 0 then
			for i = 1,shield_orbs do
				local angle = nil
				local radius = 10
				if math.random(math.random(2)) == 1 then
					angle = -math.pi
				else
					angle = math.pi
				end
				local newx,newy = math.cos(angle)*radius,math.sin(angle)*radius
				table.insert(shield_orbtable,Unit:SpawnCreature(25502,Unit:GetX()+newx,Unit:GetY()+newy,Unit:GetZ(),Unit:GetO(),16,0))
			end
			shield_orbtimer = 0
		elseif shield_orbtimer == 30 and table.getn(shield_orbtable) ~= 0 then
			shield_orbtimer = shield_orbtimer - 5
		end
		if legion_light == 10 and cancast == true and plr ~=nil then
			cancast = false
			Unit:FullCastSpellOnTarget(45664,plr)
			legion_light = 0
			Unit:RegisterEvent("KilJaeden_CanCast",3000,1)
		elseif legion_light == 10 and cancast == false and plr ~=nil then
			legion_light = legion_light-1
		end
		if fire_bloom == 30 and cancast == true then
			cancast = false
			Unit:FullCastSpell(45641)
			fire_bloom = 0
			Unit:RegisterEvent("KilJaeden_CanCast", 2000, 1)
		elseif fire_bloom == 30 and cancast == false then
			fire_bloom = fire_bloom-1
		end
	elseif hp <= 85 and hp > 55 then
		if m_phase < 2 then
			m_phase = 2
			KilJaeden_PhaseCheck(Unit)
			sinister_reflect = true
		end
		if sinister_reflect == true and cancast == true then
			sinister_reflect = false
			cancast = false
			Unit:RegisterEvent("KilJaeden_SinisterReflect",1000,1)
		end
		if shadow_spike == true and cancast == true and plr ~=nil then
			cancast = false
			shadow_spike = false
			saytable.kalecsay1 = true
			Unit:FullCastSpell(46680)
			Unit:RegisterEvent("KilJaeden_CanCast", 29000, 1)
			Unit:RegisterEvent("KilJaeden_Gossip",18000, 1)
		end
		if shield_orbtimer == 30 and table.getn(shield_orbtable) == 0 then
			for i = 1,shield_orbs do
				local angle = nil
				local radius = 10
				if math.random(math.random(2)) == 1 then
					angle = -math.pi
				else
					angle = math.pi
				end
				local newx,newy = math.cos(angle)*radius,math.sin(angle)*radius
				table.insert(shield_orbtable,Unit:SpawnCreature(25502,Unit:GetX()+newx,Unit:GetY()+newy,Unit:GetZ(),Unit:GetO(),16,0))
			end
			shield_orbtimer = 0
		elseif shield_orbtimer == 30 and table.getn(shield_orbtable) ~= 0 then
			shield_orbtimer = shield_orbtimer - 5
		end
		if legion_light >= 15 and plr ~=nil and cancast == true then
			cancast = false
			Unit:FullCastSpellOnTarget(45664,plr)
			legion_light = 0
			Unit:RegisterEvent("KilJaeden_CanCast",3000, 1)
		elseif legion_light >= 15 and plr ~=nil and cancast == false then
			legion_light = legion_light-1
		end
		if soul_flay >= 5 and cancast == true and tank~= nil then
			cancast = false
			Unit:FullCastSpellOnTarget(45442,tank)
			Unit:RegisterEvent("KilJaeden_CanCast",3500, 1)
			soul_flay = 0
		elseif soul_flay >= 5 and cancast == false then
			soul_flay = soul_flay-1
		end
		if fire_bloom >= 30 and cancast == true then
			cancast = false
			Unit:FullCastSpell(45641)
			fire_bloom = 0
			Unit:RegisterEvent("KilJaeden_CanCast",2000, 1)
		elseif fire_bloom >= 30 and cancast == false then
			fire_bloom = fire_bloom-1
		end
		if flame_dart >= 20 and cancast == true and plr ~=nil then
			cancast = false
			Unit:FullCastSpellOnTarget(45737, plr)
			flame_dart = 0
			Unit:RegisterEvent("KilJaeden_CanCast",2000, 1)
		elseif  flame_dart >= 20 and cancast == false then
			flame_dart = flame_dart - 1
		end
		if soul_darkness >= 40 and cancast == true then
			cancast = false
			Unit:FullCastSpell(46605)
			Unit:SendChatMessage(ChatField.CHAT_MSG_TEXT_EMOTE,LangField.LANG_UNIVERSAL,tostring(Unit:GetName()).." begins to channel dark energy!")
			soul_darkness = 0
			Unit:RegisterEvent("KilJaeden_CanCast",10000, 1)
			Unit:RegisterEvent("KilJaeden_SoulDarkness",8800,1)
		elseif soul_darkness >= 40 and cancast == false then
			soul_darkness = soul_darkness-1
		end
	elseif hp <= 55 and hp > 25 then
		if m_phase < 3 then
			m_phase = 3
			KilJaeden_PhaseCheck(Unit)
			sinister_reflect = true
		end
		if sinister_reflect == true and cancast == true then
			sinister_reflect = false
			cancast = false
			Unit:RegisterEvent("KilJaeden_SinisterReflect",1000,1)
		end
		if shield_orbtimer == 30 and table.getn(shield_orbtable) == 0 then
			for i = 1,shield_orbs do
				if math.random(math.random(2)) == 1 then
					angle = math.pi
				else
					angle = -math.pi
				end
				local newx,newy = math.cos(angle)*math.random(15,17),math.sin(angle)*math.random(15,17)
				table.insert(shield_orbtable,Unit:SpawnCreature(25502,Unit:GetX()+newx,Unit:GetY()+newy,Unit:GetZ(),Unit:GetO(),16,0))
			end
			shield_orbtimer = 0
		elseif shield_orbtimer == 30 and table.getn(shield_orbtable) ~= 0 then
			shield_orbtimer = shield_orbtimer - 5
		end
		if meteor_timer >= 3 and meteors <= 3 and castmeteor == true and plr ~=nil then
			Unit:SpawnCreature(25735,plr:GetX(),plr:GetY(),plr:GetZ()+30,plr:GetO(),16,8000)
			Unit:SpawnCreature(60000,plr:GetX(),plr:GetY(),plr:GetZ(),plr:GetO(),16,8000)
			meteors = meteors + 1
			meteor_timer = 0
		elseif meteor_timer >= 3 and castmeteor == false then
			meteor_timer = meteor_timer-1
		end
		if shadow_spike == true and cancast == true and plr~= nil then
			cancast = false
			Unit:FullCastSpell(46680)
			shadow_spike = false
			saytable.kalecsay2 = true
			Unit:RegisterEvent("KilJaeden_CanCast",29000, 1)
			Unit:RegisterEvent("KilJaeden_Gossip",15000,1)
		end
		if legion_light >= 15 and cancast == true and plr~= nil then
			cancast = false
			Unit:FullCastSpellOnTarget(45664,Unit:GetRandomPlayer(0))
			legion_light = 0
			Unit:RegisterEvent("KilJaeden_CanCast",3000, 1)
		elseif legion_light >= 15 and Unit:GetRandomPlayer(0) and cancast == false then
			legion_light = legion_light-1
		end
		if soul_flay >= 5 and cancast == true and tank~= nil then
			cancast = false
			Unit:FullCastSpellOnTarget(45442, tank)
			soul_flay = 0
			Unit:RegisterEvent("KilJaeden_CanCast",3500, 1)
		elseif soul_flay >= 5 and cancast == false and tank~= nil then
			soul_flay = soul_flay-1
		end
		if fire_bloom >= 20 and cancast == true then
			cancast = false
			Unit:FullCastSpell(45641)
			fire_bloom = 0
			Unit:RegisterEvent("KilJaeden_CanCast", 2000, 1)
		elseif fire_bloom >= 20 and cancast == false then
			fire_bloom = fire_bloom-1
		end
		if flame_dart >= 15 and cancast == true then
			cancast = false
			Unit:FullCastSpell(45737)
			flame_dart = 0
			Unit:RegisterEvent("KilJaeden_CanCast", 2000, 1)
		elseif  flame_dart >= 15 and cancast == false then
			flame_dart = flame_dart - 1
		end
		if soul_darkness >= 40 and cancast == true then
			cancast = false
			castmeteor = false
			Unit:FullCastSpell(46605)
			Unit:SendChatMessage(ChatField.CHAT_MSG_TEXT_EMOTE,LangField.LANG_UNIVERSAL,tostring(Unit:GetName()).." begins to channel dark energy!")
			soul_darkness = 0
			Unit:RegisterEvent("KilJaeden_CanCast",10000, 1)
			Unit:RegisterEvent("KilJaeden_SoulDarkness",8800,1)
		elseif soul_darkness >= 40 and cancast == false then
			soul_darkness = soul_darkness-1
		end
	elseif hp  <= 25 then
		if m_phase < 4 then
			m_phase = 4
			KilJaeden_PhaseCheck(Unit)
			sinister_reflect = true
		end
		if sinister_reflect == true and cancast == true then
			sinister_reflect = false
			cancast = false
			Unit:RegisterEvent("KilJaeden_SinisterReflect",1000,1)
		end
		if shadow_spike == true and cancast == true and plr~= nil then
			cancast = false
			Unit:FullCastSpell(46680)
			shadow_spike = false
			saytable.kalecsay3 = true
			Unit:RegisterEvent("KilJaeden_Gossip",6000,1)
		end
		if meteor_timer >= 3 and meteors <= 5 and castmeteor == true and plr~= nil then
			Unit:SpawnCreature(25735,plr:GetX(),plr:GetY(),plr:GetZ()+30,plr:GetO(),16,8000)
			Unit:SpawnCreature(60000,plr:GetX(),plr:GetY(),plr:GetZ(),plr:GetO(),16,8000)
			meteors = meteors + 1
			meteor_timer = 0
		elseif meteor_timer >= 3 and castmeteor == false then
			meteor_timer = meteor_timer-1
		end
		if cancast == true and soul_flay >= 5 and tank~= nil then
			cancast = false
			Unit:FullCastSpellOnTarget(45442,tank)
			soul_flay = 0
			Unit:RegisterEvent("KilJaeden_CanCast",3500, 1)
		elseif soul_flay >= 5 and cancast == false and tank~= nil then
			soul_flay = soul_flay-1
		end
		if legion_light >= 15 and cancast == true and plr~= nil then
			cancast = false
			Unit:FullCastSpellOnTarget(45664,plr)
			legion_light = 0
			Unit:RegisterEvent("KilJaeden_CanCast",3000, 1)
		elseif legion_light >= 15 and cancast == false and plr~= nil then
			legion_light = legion_light-1
		end
		if fire_bloom >= 30 and cancast == true then
			cancast = false
			Unit:FullCastSpell(45641)
			fire_bloom = 0
			Unit:RegisterEvent("KilJaeden_CanCast", 2500, 1)
		elseif fire_bloom >= 30 and cancast == false then
			fire_bloom = fire_bloom-1
		end
		if flame_dart >= 15 and cancast == true then
			cancast = false
			Unit:FullCastSpell(45737)
			flame_dart = 0
			Unit:RegisterEvent("KilJaeden_CanCast", 2500, 1)
		elseif  flame_dart >= 15 and cancast == false then
			flame_dart = flame_dart - 1
		end
		if soul_darkness >= 25 and cancast == true then
			cancast = false
			Unit:FullCastSpell(46605)
			Unit:SendChatMessage(ChatField.CHAT_MSG_TEXT_EMOTE,LangField.LANG_UNIVERSAL, tostring(Unit:GetName()).." begins to channel dark energy!")
			soul_darkness = 0
			Unit:RegisterEvent("KilJaeden_CanCast",10000, 1)
			Unit:RegisterEvent("KilJaeden_SoulDarkness",8800,1)
		elseif soul_darkness >= 25 and cancast == false then
			soul_darkness = soul_darkness-1
		end
	end
end
function KilJaeden_SinisterReflect(Unit)
	for i = 1,4,1 do
		local plr = Unit:GetRandomPlayer(0)
		if plr ~= nil then
			plr:CastSpell(45891) -- Using no. iterator seems to spawn more than 4.
		end
	end
	Unit:Emote(404,0)
	Unit:RegisterEvent("KilJaeden_SinisterReflectdeux",1500,1) -- the Wing fling thing
	Unit:RegisterEvent("KilJaeden_CanCast",2500,1)
	local rand = math.random(2)
	if rand == 1 then
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Who can you trust?")
		Unit:PlaySoundToSet(12503)
	else
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"The enemy is among you.")
		Unit:PlaySoundToSet(12504)
	end
end
function KilJaeden_SinisterReflectdeux(Unit)
	Unit:Emote(405,0)
end
function KilJaeden_SoulDarkness(Unit)
	Unit:FullCastSpell(45657)
	local rand = math.random(3)
	if rand == 1 then
		Unit:PlaySoundToSet(12505)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Chaos!")
	end
	if rand == 2 then
		Unit:PlaySoundToSet(12506)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Destruction!")
	end
	if rand == 3 then
		Unit:PlaySoundToSet(12507)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Oblivion!")
	end
end

RegisterUnitEvent(kiljaeden,1, "KilJaeden_OnCombat")
RegisterUnitEvent(kiljaeden,2, "KilJaeden_OnWipe")
RegisterUnitEvent(kiljaeden,3, "KilJaeden_OnKill")
RegisterUnitEvent(kiljaeden,4, "KilJaeden_OnDeath")
RegisterUnitEvent(kiljaeden,18, "KilJaeden_OnSpawn")
RegisterUnitEvent(kiljaeden,21,"KilJaeden_AIUpdate")
RegisterUnitEvent(kiljaeden,22,"KilJaeden_SoulDarkness")


function KilJaeden_InitiliazeMeteor(Unit)
	Unit:EnableFlight()
	--Unit:SetUInt32Value(UnitField.UNIT_FIELD_DISPLAYID, 22814)
	Unit:MoveTo(Unit:GetX(),Unit:GetY(),Unit:GetZ()+1,Unit:GetO())
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9+UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE)
	Unit:DisableRespawn()
	Unit:SetCombatCapable(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:WipeThreatList()
	Unit:MonsterMove(Unit:GetX(),Unit:GetY(),Unit:GetZ()-25,8000,768)
	Unit:RegisterEvent("KilJaeden_MeteorStormFinish",8000,1)
end
function KilJaeden_MeteorStormFinish(Unit)
	Unit:SetPosition(Unit:GetX(),Unit:GetY(),Unit:GetZ()-40)
	Unit:StopMovement(0)
	Unit:RemoveEvents()
	Unit:RemoveFromWorld()
	meteors = meteors-1
end
function KilJaeden_OrbDummy(Unit)
	--Unit:SetUInt32Value(UnitField.UNIT_FIELD_DISPLAYID,22452)
	Unit:EnableFlight()
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9+UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetCombatCapable(1)
	Unit:WipeCurrentTarget()
	Unit:RegisterAIUpdateEvent(1000)
	--Unit:CastSpell(45911)
	Unit:RegisterEvent("KilJaeden_OrbFinish",9000,1)
end
function KilJaeden_OrbUpdate(Unit)
	Unit:PlaySpellVisual(Unit,844)
end
function KilJaeden_OrbFinish(Unit)
	Unit:RemoveEvents()
	Unit:RemoveAIUpdateEvent()
	Unit:RegisterEvent("KilJaeden_OrbFinish2",100,1)
end
function KilJaeden_OrbFinish2(Unit)
	Unit:CastSpell(45915)
	Unit:PlaySpellVisual(Unit,9312)
	Unit:RegisterEvent("KilJaeden_OrbDespawn",1000,1)
end
function KilJaeden_OrbDespawn(Unit)
	Unit:RemoveFromWorld()
end

RegisterUnitEvent(60000,18,"KilJaeden_OrbDummy")
RegisterUnitEvent(25735,18,"KilJaeden_InitiliazeMeteor")
RegisterUnitEvent(60000,21,"KilJaeden_OrbUpdate")

--[[
	SINISTER REFLECTION AI
	]]

function InitializeSinisterReflection(Unit)
	local tar = Unit:GetClosestPlayer()
	local class = tar:GetPlayerClass()
	Unit:WorldQuery("DELETE FROM ai_agents WHERE entry ='25708';")
	if class == "Warlock" then
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','46190','0','-1','15000','0','0');")
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','47076','0','1','2000','0','0');")
	end
	if class == "Priest" then
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','47077','0','1','1000','0','0');")
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','47079','0','1','10000','0','0');")
		Unit:SetCurrentAgent(4)
	end
	if class == "Shaman" then
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','47071','0','1','10000','0','0');")
		Unit:SetCurrentAgent(1)
	end
	if class == "Hunter" then
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','16496','0','1','100','0','0');")
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','48098','0','1','10000','0','0');")
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','40652','0','1','10000','0','0');")
		Unit:SetCurrentAgent(4)
	end
	if class == "Paladin" then
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','37369','0','1','20000','0','0');")
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','38921','0','1','10000','0','0');")
	end
	if class == "Mage" then
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','47074','0','1','100','0','0');")
		Unit:SetCurrentAgent(4)
	end
	if class == "Rogue" then
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','45897','0','-1','100','0','0');")
	end
	if class == "Druid" then
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','47072','0','-1','100','0','0');")
		Unit:SetCurrentAgent(4)
	end
	if class == "Warrior" then
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','17207','0','-1','5000','0','0');")
		Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25708','4','0','100','0','15576','0','-1','5000','0','0');")
	end
end
function DespawnSinisterReflections(Unit)
	Unit:RemoveFromWorld()
end

RegisterUnitEvent(25708,18,"InitializeSinisterReflection")
RegisterUnitEvent(25708, 2, "DespawnSinisterReflections")

--[[
	~SINISTER REFLECTION AI
		]]
--[[
	SHIELD ORB AI
		]]
local radians = nil
local shieldx = nil
local shieldy = nil
local clockwise = false

function  Initialize_ShieldOrb(Unit)
	Unit:SetCombatCapable(1)
	Unit:SetCombatMeleeCapable(1)
	Unit:SetCombatTargetingCapable(1)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9)
	Unit:EnableFlight()
	Unit:ModifySpeed(5)
	Unit:MonsterMove(Unit:GetX(),Unit:GetY(),Unit:GetZ()+10,5000,768)
	Unit:RegisterEvent("ShieldOrb_AI",5000,1)
	Unit:RegisterEvent("ShieldOrb_Movement",5000,1)
	radians = 0
	shieldx = 0
	shieldy = 0
	if math.random(2) == 1 then
		clockwise = true
	else
		clockwise = false
	end
end
function ShieldOrb_AI(Unit)
	Unit:SetPosition(Unit:GetX(),Unit:GetY(),Unit:GetZ()+10)
	Unit:RegisterAIUpdateEvent(2000)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,0)
	if Unit:GetRandomPlayer(0) then
		(Unit:GetRandomPlayer(0)):AttackReaction(Unit,1,0)
	end
end
function ShieldOrb_Movement(Unit)
	if clockwise == true then
		radians = radians + 0.62818
	else
		radians = radians - 0.62818
	end
	shieldx = cn_kiljaeden:GetX()+math.cos(radians)*math.random(13,17)
	shieldy = cn_kiljaeden:GetY()+math.sin(radians)*math.random(13,17)
	Unit:MoveTo(shieldx,shieldy,Unit:GetZ(),Unit:GetO())
	Unit:RegisterEvent("ShieldOrb_Movement",5000,1)
end
function ShieldOrb_Update(Unit)
	Unit:WipeThreatList()
	if Unit:GetRandomPlayer(0) ~= nil then
		Unit:FullCastSpell(45680)
	end
end
function ShieldOrb_OnWipe(Unit)
	if Unit:GetRandomPlayer(0) == nil then
		Unit:RemoveAIUpdateEvent()
		Unit:RemoveEvents()
		for k,v in pairs(shield_orbtable) do
			if v == Unit then
				table.remove(shield_orbtable,k)
			end
		end
		Unit:RemoveFromWorld()
	end
end
function ShieldOrb_OnDeath(Unit)
	Unit:RemoveAIUpdateEvent()
	Unit:RemoveEvents()
	for k,v in pairs(shield_orbtable) do
		if v == Unit then
			table.remove(shield_orbtable,k)
		end
	end
	Unit:RemoveFromWorld()
end

function HelperKalec_OnSpawn(Unit)
	Unit:EnableFlight()
	Unit:MoveTo(Unit:GetX(),Unit:GetY(),Unit:GetZ()-1,Unit:GetO())
	Unit:MoveTo(Unit:GetX(),Unit:GetY(),Unit:GetZ()+1,Unit:GetO())
	Unit:ModifySpeed(5)
	Unit:CreateWaypoint(1,1702.738037,598.220520,129.048126,0.006295,2000,768,0)
	Unit:CreateWaypoint(2,1727.781128,625.956665,120.866765,1.467142,2000,768,0)
	Unit:CreateWaypoint(3,1693.672974,656.997437,124.239868,3.269632,2000,768,0)
	Unit:CreateWaypoint(4,1668.829346,627.792847,122.001450,4.274939,2000,768,0)
	Unit:SetMovementType(4)
	Unit:FullCastSpell(45670)
end
function HelperKalec_OnReachWp(Unit)
	Unit:SetMovementType(4)
end

RegisterUnitEvent(25319,18,"HelperKalec_OnSpawn")
RegisterUnitEvent(25319,19,"HelperKalec_OnReachWp")



--Temporary Store table.
local controllers = {}

function InitializeOrbOfBlue(Unit)
	local addy = tostring(Unit)
	if activatedorbs[addy] ~= true or spawnedorbs == true then
		table.insert(blueorbs,Unit)
	end
end
function OrbOfBlue_OnActivate(Unit,event,pActivator)
	local addy = tostring(Unit)
	if activatedorbs[addy] == true then
		local drake = Unit:SpawnCreature(25653,pActivator:GetX(),pActivator:GetY(),pActivator:GetZ(),pActivator:GetO(),14,0)
		local dAddy = tostring(drake)
		controllers[dAddy] = pActivator
		activatedorbs[addy] = false
		Unit:Despawn(1,5000)
		local orbtar = Unit:GetCreatureNearestCoords(Unit:GetX(),Unit:GetY(),Unit:GetZ(),25640)
		if orbtar ~= nil then
			orbtar:RemoveFromWorld()
		end
	end
end
function OrbOfBlue_OnDespawn(Unit,event)
	for k,v in pairs(blueorbs) do
		local addy = tostring(v)
		if activatedorbs[addy] == false then
			table.remove(blueorbs,k)
		end
	end
end
	

function OrbTarget_OnSpawn(Unit)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9+UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_DISPLAYID,21908)
	Unit:Root()
	Unit:SetCombatMeleeCapable(1)
	Unit:SetCombatTargetingCapable(1)
	Unit:WipeThreatList()
	Unit:RegisterEvent("InitializeOrbTarget",500,1)
end
function InitializeOrbTarget(Unit)
	Unit:FullCastSpell(37964)
	Unit:FullCastSpell(42709)
end

RegisterUnitEvent(25640,18,"OrbTarget_OnSpawn")
RegisterUnitEvent(25640,18,"OrbTarget_OnSpawn")

function InitBlueDrake(Unit)
	-- Execute Query
	Unit:WorldQuery("DELETE FROM ai_agents WHERE entry ='25653';")
	Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25653','4','0','100','0','45848','0','-1','20000','0','0');")
	Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25653','4','0','100','0','45856','0','-1','10000','0','0');")
	Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25653','4','0','100','0','45860','0','-1','10000','0','0');")
	Unit:WorldQuery("INSERT INTO ai_agents (entry,type,event,chance,maxcount,spell,spelltype,targettype,cooldown,floatMisc1,Misc2) VALUES('25653','4','0','100','0','45862','0','-1','15000','0','0');")
	--Unit:Despawn(1,1)
	Unit:RegisterEvent("BlueDrakeMasterController",500,1)
end
function BlueDrakeMasterController(Unit)
	local addy = tostring(Unit)
	local plr = nil
	if( controllers[addy] ~= nil ) then
		plr = controllers[addy]
		cn_kiljaeden:AttackReaction(plr,1)
		plr:FullCastSpellOnTarget(45839,Unit)
		plr:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9+UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE)
		plr:SetInvisible(1)
	end
	cn_kiljaeden:AttackReaction(Unit,1)
	Unit:RegisterEvent("BlueDrakeDies",119000,1)
end
function BlueDrakeDies(Unit)
	local addy = tostring(Unit)
	local plr = nil
	if( type(controllers[addy]) == "userdata") then
		plr = (controllers[addy])
		plr:RemoveFlag(UnitField.UNIT_FIELD_FLAGS,Unit:GetUInt32Value(UnitField.UNIT_FIELD_FLAGS))
		plr:SetInvisible(0)
		cn_kiljaeden:AttackReaction(plr,1)
		controllers[addy] = nil
	end
	Unit:Die()
end


RegisterGameObjectEvent(188116,2,"InitializeOrbOfBlue")
RegisterGameObjectEvent(187869,2,"InitializeOrbOfBlue")
RegisterGameObjectEvent(188114,2,"InitializeOrbOfBlue")
RegisterGameObjectEvent(188115,2,"InitializeOrbOfBlue")

--[[
RegisterGameObjectEvent(188116,5,"OrbOfBlueUpdate")
RegisterGameObjectEvent(187869,5,"OrbOfBlueUpdate")
RegisterGameObjectEvent(188114,5,"OrbOfBlueUpdate")
RegisterGameObjectEvent(188115,5,"OrbOfBlueUpdate")
]]--

RegisterGameObjectEvent(188116,4,"OrbOfBlue_OnActivate")
RegisterGameObjectEvent(187869,4,"OrbOfBlue_OnActivate")
RegisterGameObjectEvent(188114,4,"OrbOfBlue_OnActivate")
RegisterGameObjectEvent(188115,4,"OrbOfBlue_OnActivate")

RegisterGameObjectEvent(188116,6,"OrbOfBlue_OnDespawn")
RegisterGameObjectEvent(187869,6,"OrbOfBlue_OnDespawn")
RegisterGameObjectEvent(188114,6,"OrbOfBlue_OnDespawn")
RegisterGameObjectEvent(188115,6,"OrbOfBlue_OnDespawn")

RegisterUnitEvent(25653, 18,"InitBlueDrake")
RegisterUnitEvent(25502, 18, "Initialize_ShieldOrb")
RegisterUnitEvent(25502, 4, "ShieldOrb_OnDeath")
RegisterUnitEvent(25502, 2, "ShieldOrb_OnWipe")
RegisterUnitEvent(25502, 21, "ShieldOrb_Update")
--RegisterUnitEvent(25502, 19, "ShieldOrb_OnReachWp")