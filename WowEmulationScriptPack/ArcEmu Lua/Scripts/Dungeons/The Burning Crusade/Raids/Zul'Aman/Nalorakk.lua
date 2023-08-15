

--[[
	NALORAKK HOOKED EVENTS
	]]
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnSpawn(Unit)
	local args = getvars(Unit)
	if args == nil or args.NALORAKK == nil then
		setvars(Unit, {NALORAKK = {
		guardssent = {},
		gauntlet = true,
		wavecount = 0,
		currentform = "TROLL",
		enrage = 600,
		canmove = false,
		} })
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_DONTMOVEWP)
		Unit:CreateWaypoint(1,-19.324257,1418.992554,12.793161,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(2,-51.491978,1419.539429,27.303785,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(3,-79.723747,1418.422119,27.302353,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(4,-80.228577,1395.087280,27.174965,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(5,-80.688975,1377.542969,40.768536,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(6,-79.429787,1362.098877,40.767818,1.570787,0,256,0)
		Unit:CreateWaypoint(7,-80.187447,1316.803833,41.191967,1.568398,0,256,0)
		Unit:CreateWaypoint(8,-81.355270,1300.907959,48.558041,1.532316,0,256,0)
		--Unit:SetOutOfCombatRange(50000)
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnCombat(Unit,event,pAggro)
	local args = getvars(Unit)
	if args.NALORAKK.gauntlet == true then
		INSTANCE_ZULAMAN.NALORAKK.Nalorakk_HandleGauntlet(Unit,event,pAggro)
	elseif args.NALORAKK.gauntlet == false then
		Unit:SetAIState(AI_State.STATE_ATTACKING)
		Unit:SetCombatMeleeCapable(0)
		Unit:SetAllowedToEnterCombat(1)
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_DONTMOVEWP)
		Unit:AttackReaction(pAggro,1,0)
		local aggro = math.random(2)
		if aggro == 1 then
			Unit:PlaySoundToSet(12070)
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You be dead soon enough!")
		else
			Unit:PlaySoundToSet(12076)
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Da Amani gonna rule again!")
		end
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Berserk",1000*60*10,1)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Surge",math.random(20*1000,30*1000),math.fmod(math.random(45*1000,60*1000),math.random(20*1000,30*1000)))
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Mangle",math.random(20*1000,25*1000),math.fmod(math.random(45*1000,60*1000),math.random(20*1000,25*1000)))
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_BrutalSwipe",math.random(40*1000,50*1000),math.fmod(math.random(45*1000,60*1000),math.random(40*1000,50*1000)))
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Transform",math.random(45*1000,60*1000),1)
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnDamageTaken(Unit,event,mAttacker,uint32,int32,fAmount)
	local args = getvars(Unit)
	if args.NALORAKK.gauntlet == false and args.NALORAKK.wavecount == 4 then
		Unit:OnUnitEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnCombat",1,mAttacker,0)
		args.NALORAKK.wavecount = nil
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnWipe(Unit,event)
	local args = getvars(Unit)
	if args.NALORAKK.gauntlet == true then
		Unit:Despawn(100,5000)
		Unit:RemoveAIUpdateEvent()
	else
		Unit:RemoveEvents()
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnKillPlayer(Unit,event,mVictim)
	if(mVictim:IsPlayer() == true) then
		local chance = math.random(2)
		if chance == 2 then
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Now whatchoo got to say?")
			Unit:PlaySoundToSet(12075)
		else
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Mua-ha-ha!")
			Unit:PlaySoundToSet(12076)
		end
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnDeath(Unit,event)
	Unit:RemoveEvents()
	Unit:RemoveAIUpdateEvent()
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I... be waitin' on da udda side....")
	Unit:PlaySoundToSet(12077)
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_AIUpdate(Unit)
	local args = getvars(Unit)
	if args.NALORAKK.gauntlet == true then
		INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Gauntlet_AIUpdate(Unit)
		return
	end
end


RegisterUnitEvent(23576,1,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnCombat")
RegisterUnitEvent(23576,2,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnWipe")
RegisterUnitEvent(23576,3,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnKillPlayer")
RegisterUnitEvent(23576,4,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnDeath")
RegisterUnitEvent(23576,24,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnDamageTaken")
RegisterUnitEvent(23576,18,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnSpawn")
RegisterUnitEvent(23576,21,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_AIUpdate")

--[[ 
	CUSTOM FUNCTIONS ]]

function INSTANCE_ZULAMAN.NALORAKK.CurrentForm(Unit)
	local args = getvars(Unit)
	if type(args) ~= "table" and args.NALORAKK == nil then 
		return nil
	else
		return args.NALORAKK.currentform;
	end
end
function INSTANCE_ZULAMAN.NALORAKK.SetForm(Unit, curform)
	if(type(curform) ~= "string") then
		error("SetForm expecting argument #2 string got "..tostring(type(curform)),2)
		return nil
	end
	if(type(Unit) ~= "userdata") then return nil end
	local args = getvars(Unit)
	if(type(args) ~= "table" or args.NALORAKK == nil) then 
		return nil
	else
		args.NALORAKK.currentform = curform;
	end
end

--[[
	NALORAKk SPELLS
	]]
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Surge(Unit)
	if (INSTANCE_ZULAMAN.NALORAKK.CurrentForm(Unit) ~= "TROLL") then return end
	local plr = Unit:GetRandomPlayer(0)
	if(type(plr) == "userdata") then
		Unit:FullCastSpellOnTarget(42402,plr)
		Unit:PlaySoundToSet(12071)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I bring da pain!")
	else
		error("Nalorakk_Surge expecting type userdata got "..tostring(type(plr)),2)
		return
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_BrutalSwipe(Unit)
	if(INSTANCE_ZULAMAN.NALORAKK.CurrentForm(Unit) ~= "TROLL") then return end
	local tank = Unit:GetMainTank()
	if(type(tank) == "userdata") then
		Unit:FullCastSpellOnTarget(42384,tank)
	else
		error("Nalorakk_BrutalSwipe expecting type userdata got "..tostring(type(tank)),2)
		return
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Mangle(Unit)
	if(INSTANCE_ZULAMAN.NALORAKK.CurrentForm(Unit) ~= "TROLL") then return end
	local tank = Unit:GetMainTank()
	if(type(tank) == "userdata") then
		Unit:FullCastSpellOnTarget(42389,tank)
	else
		error("Nalorakk_Mangle expecting type userdata got "..tostring(type(tank)),2)
		return
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Berserk(Unit)
	Unit:FullCastSpell(41924)
	Unit:PlaySoundToSet(12074)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You had your chance, now it be too late!")
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Slash(Unit)
	if(INSTANCE_ZULAMAN.NALORAKK.CurrentForm(Unit) ~= "BEAR") then return end
	local tank = Unit:GetMainTank()
	if(type(tank) == "userdata") then
		Unit:FullCastSpellOnTarget(42395,tank)
	else
		error("Nalorakk_Slash expecting type userdata got "..tostring(type(tank)),2)
		return
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_RendFlesh(Unit)
	if(INSTANCE_ZULAMAN.NALORAKK.CurrentForm(Unit) ~= "BEAR") then return end
	local tank = Unit:GetMainTank()
	if(type(tank) == "userdata") then
		Unit:FullCastSpellOnTarget(42397,tank)
	else
		error("Nalorakk_RendFlesh expecting type userdata got "..tostring(type(tank)),2)
		return
	end
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_DeafeningRoar(Unit)
	if(INSTANCE_ZULAMAN.NALORAKK.CurrentForm(Unit) ~= "BEAR") then return end
	Unit:FullCastSpell(42398)
end
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Transform(Unit)
	local args = getvars(Unit)
	if args.NALORAKK.enrage < 15 then
		args.NALORAKK.enrage = 0
		return
	end
	args.NALORAKK.enrage = args.NALORAKK.enrage - 45; -- subtract 45 seconds every transform to determine the enrage timer.
	if(INSTANCE_ZULAMAN.NALORAKK.CurrentForm(Unit) == "BEAR") then
		Unit:RemoveEvents()
		Unit:RemoveAura(42594)
		Unit:PlaySoundToSet(12073)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Make way for Nalorakk!")
		INSTANCE_ZULAMAN.NALORAKK.SetForm(Unit,"TROLL")
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Surge",math.random(20*1000,30*1000),math.fmod(45000,math.random(20*1000,30*1000)))
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Mangle",math.random(20*1000,25*1000),math.fmod(45000,math.random(20*1000,25*1000)))
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_BrutalSwipe",math.random(40*1000,50*1000),math.fmod(45000,math.random(40*1000,50*1000)))
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Transform",45000,1)
		if args.NALORAKK.enrage <= 100 then
			Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Berserk",args.NALORAKK.enrage*1000*60,1)
		else
			Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Berserk",args.NALORAKK.enrage*1000,1)
		end
	elseif(INSTANCE_ZULAMAN.NALORAKK.CurrentForm(Unit) == "TROLL") then
		Unit:RemoveEvents()
		Unit:FullCastSpell(42594)
		Unit:PlaySoundToSet(12072)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You call on da beast, you gonna get more dan you bargain for!")
		INSTANCE_ZULAMAN.NALORAKK.SetForm(Unit,"BEAR")
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Slash",math.random(15*1000,20*1000),math.fmod(45000,math.random(15*1000,20*1000)))
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_RendFlesh",math.random(10*1000,15*1000),math.fmod(45000,math.random(10*1000,15*1000)))
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_DeafeningRoar",math.random(20*1000,25*1000),math.fmod(45000,math.random(20*1000,25*1000)))
		Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Transform",45000,1)
		if args.NALORAKK.enrage <= 100 then
			Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Berserk",args.NALORAKK.enrage*1000*60,1)
		else
			Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Berserk",args.NALORAKK.enrage*1000,1)
		end
	end
end
