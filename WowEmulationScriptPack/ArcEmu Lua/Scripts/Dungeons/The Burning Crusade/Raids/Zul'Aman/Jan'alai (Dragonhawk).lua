


--[[
	DRAGONHAWK EGG EVENTS
		]]
function INSTANCE_ZULAMAN.JANALAI.JanAlai_EggOnSpawn(Unit)
	local args = getvars(Unit)
	if args ~= nil and type(args.JANALAI) == "table" then
		if Unit:CalcDistance(-34.049107,1212.935547,18.711393) <= 15 then
			for k,v in pairs(args.JANALAI.righteggs) do
				if v == Unit then
					table.remove(args.JANALAI.righteggs,k)
					break
				end
			end
			table.insert(args.JANALAI.righteggs,Unit)
		elseif Unit:CalcDistance(-34.956776,1086.155762,18.712454) <= 15 then
			for k,v in pairs(args.JANALAI.lefteggs) do
				if v == Unit then
					table.remove(args.JANALAI.lefteggs,k)
					break
				end
			end
			table.insert(args.JANALAI.lefteggs,Unit)
		end
	else return end -- variables haven't been intialized.
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_EggOnDeath(Unit)
	local args = getvars(Unit)
	for k,v in pairs(args.JANALAI.righteggs) do
		if v == Unit then
			table.remove(args.JANALAI.righteggs,k)
			Unit:RemoveFromWorld()
		end
	end
	for k,v in pairs(args.JANALAI.lefteggs) do
		if v == Unit then
			table.remove(args.JANALAI.lefteggs,k)
			Unit:RemoveFromWorld()
		end
	end
end

--[[	
	END DRAGONHAWK EGGS
		]]
--[[
	JANALAI EVENTS
		]]
function INSTANCE_ZULAMAN.JANALAI.JanAlai_OnSpawn(Unit)
	local args = getvars(Unit)
	if args == nil or args.JANALAI == nil then
		setvars(Unit,{JANALAI = {
		lefteggs = {},
		righteggs = {},
		hatchcount = {},
		hatchdir = {},
		enrage = 18000,
		summontimer = 90,
		hardenrage = 36000,
		alleggs = false,
		firebombs = math.random(20,45),
		cancast = true,
		}})
	end
	local tbl = Unit:GetInRangeUnits()
	for k,v in pairs(tbl) do
		if v:GetEntry() == 23817 then
			v:OnUnitEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_EggOnSpawn",18,Unit,0)
		end
	end
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_OnCombat(Unit)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_FlameBreath",math.random(10000,15000),1)
	Unit:RegisterAIUpdateEvent(1000)
	Unit:PlaySoundToSet(12031)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Spirits of da wind be your doom!")
	Unit:SetAIState(AI_State.STATE_ATTACKING)
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_OnWipe(Unit)
	local tbl = Unit:GetInRangeFriends()
	for k,v in pairs(tbl) do
		if type(v) == "userdata" and v:GetEntry() == 23598 then
			v:Die()
		end
	end
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_SAY,LangField.LANG_UNIVERSAL,"OnWipe")
	Unit:RemoveEvents()
	Unit:RemoveAIUpdateEvent()
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_OnKillPlayer(Unit,event,mTarget)
	local rand = math.random(2)
	if type(mTarget) ~= "userdata" then return end
	if rand == 1 then
		Unit:PlaySoundToSet(12036)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"It all be over now, mon!")
	elseif rand == 2 then
		Unit:PlaySoundToSet(12037)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Tazaga-choo!")
	end
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_OnDeath(Unit)
	local args = getvars(Unit)
	local tbl = Unit:GetInRangeFriends()
	for k,v in pairs(tbl) do
		if type(v) == "userdata" and v:GetEntry() == 23598 then
			v:Die()
		end
	end
	Unit:PlaySoundToSet(12038)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Zul'jin... got a surprise for you...")
	Unit:RemoveEvents()
	Unit:RemoveAIUpdateEvent()
	args.JANALAI = nil
end
	
function INSTANCE_ZULAMAN.JANALAI.JanAlai_CanCast(Unit)
	local args = getvars(Unit)
	if args.JANALAI.cancast == false then
		args.JANALAI.cancast = true
	end
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_AIUpdate(Unit)
	local args = getvars(Unit)
	if args.JANALAI.enrage > 0 then
		args.JANALAI.enrage = args.JANALAI.enrage - 1
	end
	if args.JANALAI.hardenrage > 0 then
	args.JANALAI.hardenrage = args.JANALAI.hardenrage - 1
	end
	if args.JANALAI.summontimer > 0 then
	args.JANALAI.summontimer = args.JANALAI.summontimer -1
	end
	if args.JANALAI.firebombs > 0 then
		args.JANALAI.firebombs = args.JANALAI.firebombs -1
	end
	if Unit:GetHealthPct() <= 35 then
		INSTANCE_ZULAMAN.JANALAI.JanAlai_SpawnAllEggs(Unit)
		args.JANALAI.alleggs = true
	end
	if Unit:GetHealthPct() <= 25 and args.JANALAI.enrage < 0 then
		args.JANALAI.enrage = 0
	end
	if args.JANALAI.enrage == 0 and args.JANALAI.cancast == true then
		Unit:FullCastSpell(44779)
		args.JANALAI.enrage = 18000
	elseif args.JANALAI.enrage == 0 and args.JANALAI.cancast == false then
		args.JANALAI.enrage = args.JANALAI.enrage +1
	end
	if args.JANALAI.hardenrage == 0 and args.JANALAI.cancast == true then
		Unit:FullCastSpell(48017)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You done run outta time!")
		Unit:PlaySoundToSet(12035)
		args.JANALAI.hardenrage = 36000
	elseif args.JANALAI.hardenrage == 0 and args.JANALAI.cancast == false then
		args.JANALAI.hardenrage = args.JANALAI.hardenrage +1
	end
	if args.JANALAI.summontimer == 0 and args.JANALAI.cancast == true then
		Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_CanCast",2000,1)
		args.JANALAI.cancast = false
		INSTANCE_ZULAMAN.JANALAI.JanAlai_SpawnHatchers(Unit)
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Where ma hatcha? Get to work on dem eggs!")
		Unit:PlaySoundToSet(12033)
		args.JANALAI.summontimer = 90
	elseif args.JANALAI.summontimer == 0 and args.JANALAI.cancast == false then
		args.JANALAI.summontimer = args.JANALAI.summontimer +1
	end
	if args.JANALAI.firebombs == 0 and args.JANALAI.cancast == true then
		args.JANALAI.cancast = false
		INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombsStart(Unit)
		args.JANALAI.firebombs = math.random(20,45)
	elseif args.JANALAI.firebombs == 0 and args.JANALAI.cancast == false then
		args.JANALAI.firebombs = args.JANALAI.firebombs +1
	end
end

function INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombsStart(Unit)
	local args = getvars(Unit)
	Unit:RemoveEvents()
	local tbl = Unit:GetInRangePlayers()
	Unit:SetPosition(-34.416424,1149.927246,19.152180)
	Unit:MoveTo(Unit:GetX()+3,Unit:GetY()+2,Unit:GetZ(),Unit:GetO())
	Unit:FullCastSpell(33002)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I burn ya now!")
	Unit:PlaySoundToSet(12032)
	for k,v in pairs(tbl) do
		if Unit:GetDistance(v) >= 10 then
			v:Teleport(Unit:GetMapId(),Unit:GetX(),Unit:GetY(),Unit:GetZ())
			v:FullCastSpell(33002)
		end
	end
	Unit:StopMovement(2000)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombFinish",1500,1)
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombFinish(Unit)
	Unit:SetAttackTimer(5000,1)
	local rand = math.random(40,60)
	local valuetoadd = math.fmod(360,rand)
	local angle = valuetoadd
	local x,y = Unit:GetX(),Unit:GetY()
	while rand > 0 do
		x = math.cos(angle/math.pi)*math.random(2,20)
		y = math.sin(angle/math.pi)*math.random(2,20)
		Unit:SpawnCreature(23920,Unit:GetX()+x,Unit:GetY()+y,Unit:GetZ(),Unit:GetO(),14,0)
		angle = angle+valuetoadd
		rand = rand -1
	end
	Unit:SpawnCreature(70000,-53.389011,1149.769043,18.706196,0.022104,14,11000)
	Unit:SpawnCreature(70000,-33.579123,1175.321777,18.709953,4.702080,14,11000)
	Unit:SpawnCreature(70000,-11.923369,1149.371338,18.711403,3.076304,14,11000)
	Unit:SpawnCreature(70000,-34.317654,1125.089111,18.711653,1.509432,14,11000)
	Unit:RegisterAIUpdateEvent(1000)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_FlameBreath",math.random(10000,20000),1)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_CanCast",12000,1)
end
	
function INSTANCE_ZULAMAN.JANALAI.JanAlai_FlameBreath(Unit)
	local args = getvars(Unit)
	if args.JANALAI.cancast == true then
		local plr = Unit:GetRandomPlayer(0)
		if type(plr) == "userdata" then
			Unit:SetAttackTimer(3000,0)
			Unit:FullCastSpell(43140)
			Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_FlameBreath",math.random(10000,20000),1)
		else
			print("FlameBreath expecting userdata type got "..tostring(type(plr)))
		end
	elseif args.JANALAI.cancast == false then
		Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_FlameBreath",1000,1)
	end
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_SpawnAllEggs(Unit)
	local args = getvars(Unit)
	if args.JANALAI.alleggs == true then return end
	Unit:PlaySoundToSet(12034)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I show you strength... in numbers. ")
	if table.getn(args.JANALAI.righteggs) > 0 then
		for k,v in pairs(args.JANALAI.righteggs) do
			v:SpawnCreature(23598,v:GetX(),v:GetY(),v:GetZ(),v:GetO(),14,0)
			v:Die()
		end
	end
	if table.getn(args.JANALAI.lefteggs) > 0 then
		for k,v in pairs(args.JANALAI.lefteggs) do
			v:SpawnCreature(23598,v:GetX(),v:GetY(),v:GetZ(),v:GetO(),14,0)
			v:Die()
		end
	end
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_SpawnHatchers(Unit)
	Unit:SpawnCreature(23818,-72.722145,1157.109009,5.577517,Unit:GetO(),14,0)
	Unit:SpawnCreature(23818,-73.532204,1144.523315,5.521172,Unit:GetO(),14,0)
end

--[[
	END JANALAI EVENTS
		]]
--[[	
	AMANI'SHI HATCHER EVENTS
	]]
function INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherOnSpawn(Unit)
	Unit:DisableRespawn() -- disable respawns.
	local args = getvars(Unit)
	if type(args.JANALAI) ~= "table" then return end
	local choice = math.random(2)
	if choice == 1 then
		local guid = tostring(Unit:GetGUID())
		args.JANALAI.hatchdir[guid] = "left"
		args.JANALAI.hatchcount[guid] = 1
		Unit:SetAIState(AI_State.STATE_SCRIPTMOVE)
		Unit:SetAllowedToEnterCombat(0)
		Unit:SetCombatMeleeCapable(1)
		Unit:CreateWaypoint(1,-56.316452,1153.245605,18.732151,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(2,-33.359863,1173.800293,18.709618,1.563488,0,256,0)
		Unit:CreateWaypoint(3,-33.244007,1212.529663,18.709618,1.563488,0,256,0)
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
	elseif choice == 2 then
		local guid = tostring(Unit:GetGUID())
		args.JANALAI.hatchdir[guid] = "right"
		args.JANALAI.hatchcount[guid] = 1
		Unit:SetAllowedToEnterCombat(0)
		Unit:SetAIState(AI_State.STATE_SCRIPTMOVE)
		Unit:SetCombatMeleeCapable(1)
		Unit:CreateWaypoint(1,-56.194130,1148.044800,18.736595,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(2,-33.759674,1130.854126,18.710993,4.696612,0,256,0)
		Unit:CreateWaypoint(3,-34.495575,1086.375610,18.710993,4.601580,0,256,0)
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
	end
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherOnReachWp(Unit,event,null,wp)
	local args = getvars(Unit)
	local guid = tostring(Unit:GetGUID())
	if wp == 3 and args.JANALAI.hatchdir[guid] == "right" and table.getn(args.JANALAI.righteggs) > 0 then
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_DONTMOVEWP)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherStartHatching",100,1)
	elseif wp == 3 and args.JANALAI.hatchdir[guid] == "left" and table.getn(args.JANALAI.lefteggs) > 0 then
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_DONTMOVEWP)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherStartHatching",100,1)
	end
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherOnWipe(Unit)
	Unit:RemoveEvents()
	Unit:Despawn(100,0)
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherStartHatching(Unit)
	local guid = tostring(Unit:GetGUID())
	local args = getvars(Unit)
	if(type(args.JANALAI) ~= "table") then return end
	if args.JANALAI.hatchdir[guid] == "right" and table.getn(args.JANALAI.righteggs) > 0 then
		Unit:FullCastSpell(43734)
		for i = 1,args.JANALAI.hatchcount[guid],1 do
			if table.getn(args.JANALAI.righteggs) == 0 then break end
			if table.getn(args.JANALAI.righteggs) == 0 and table.getn(args.JANALAI.lefteggs) == 0 then
				Unit:RemoveEvents()
				Unit:RemoveFromWorld()
				return
			end
			local chosenegg = args.JANALAI.righteggs[math.random(1,table.getn(args.JANALAI.righteggs))]
			if type(chosenegg) == "userdata" then
				chosenegg:SpawnCreature(23598,chosenegg:GetX(),chosenegg:GetY(),chosenegg:GetZ(),chosenegg:GetO(),14,0)
				chosenegg:Die()
				args.JANALAI.hatchcount[guid] = args.JANALAI.hatchcount[guid]+1
			else
				print("chosenegg expected userdata type got "..tostring(type(chosenegg)))
			end
		end
		Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherStartHatching",4000,1)
	elseif args.JANALAI.hatchdir[guid] == "right" and table.getn(args.JANALAI.righteggs) == 0 and table.getn(args.JANALAI.lefteggs) > 0 then -- Eggs are empty on the right side, lets go left and start hatching.
		Unit:DeleteAllWaypoints()
		Unit:CreateWaypoint(1,-33.393459,1204.481934,18.710060,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(2,-33.456745,1126.305542,18.711605,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(3,-34.605965,1086.905151,18.711605,Unit:GetO(),0,256,0)
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
	elseif args.JANALAI.hatchdir[guid] == "left" and table.getn(args.JANALAI.lefteggs) > 0 then
		Unit:FullCastSpell(43734)
		for i = 1,args.JANALAI.hatchcount[guid],1 do
			if table.getn(args.JANALAI.lefteggs) == 0 then break end
			if table.getn(args.JANALAI.lefteggs) == 0 and table.getn(args.JANALAI.righteggs) == 0 then
				Unit:RemoveEvents()
				Unit:RemoveFromWorld()
				return
			end
			local chosenegg = args.JANALAI.lefteggs[math.random(1,table.getn(args.JANALAI.lefteggs))]
			if type(chosenegg) == "userdata" then
				chosenegg:SpawnCreature(23598,chosenegg:GetX(),chosenegg:GetY(),chosenegg:GetZ(),chosenegg:GetO(),14,0)
				chosenegg:Die()
				args.JANALAI.hatchcount[guid] = args.JANALAI.hatchcount[guid]+1
			else
				print("chosenegg expected userdata type got "..tostring(type(chosenegg)))
			end
		end
		Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherStartHatching",4000,1)
	elseif args.JANALAI.hatchdir[guid] == "left" and table.getn(args.JANALAI.lefteggs) == 0 and table.getn(args.JANALAI.righteggs) > 0 then
		args.JANALAI.hatchdir[guid] = "right"
		Unit:DeleteAllWaypoints()
		Unit:CreateWaypoint(1,-34.605965,1086.905151,18.711605,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(2,-33.456745,1126.305542,18.711605,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(3,-33.393459,1204.481934,18.710060,Unit:GetO(),0,256,0)
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
	end
end

--[[
	DRAGON HAWK EVENTS
		]]
function INSTANCE_ZULAMAN.JANALAI.JanAlai_DragonHawkOnSpawn(Unit)
	Unit:DisableRespawn()
	local args = getvars(Unit)
	if type(args.JANALAI) ~= "table" then return end
	if Unit:CalcDistance(-33.565357,1213.487183,18.709780) <= 15 then
		Unit:EnableFlight()
		Unit:CreateWaypoint(1,-33.028015,1203.774536,18.711439,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(2,-34.061836,1174.993042,18.711439,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(3,-34.545757+math.cos(math.random(20,40))*3,1149.110718+math.sin(math.random(20,40))*3,19.149067,Unit:GetO(),0,768,0)
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
	elseif Unit:CalcDistance(-34.956776,1086.155762,18.712454) <= 15 then
		Unit:EnableFlight()
		Unit:CreateWaypoint(1,-34.423855,1095.421143,18.711573,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(2,-33.870293,1126.015137,18.711357,Unit:GetO(),0,256,0)
		Unit:CreateWaypoint(3,-34.545757+math.cos(math.random(20,40))*3,1149.110718+math.sin(math.random(20,40))*3,19.149067,Unit:GetO(),0,768,0)
		Unit:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
	end
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_DragonHawkOnReachWp(Unit,event,null,wp)
	if wp == 3 then
		Unit:AttackReaction(Unit:GetClosestTarget(),1,0)
	end
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_DragonHawkOnHit(Unit,event,mTarget)
	if(type(mTarget) == "userdata") then
		Unit:FullCastSpellOnTarget(43299,mTarget)
	end
end
--[[
	END DRAGONHAWK EVENTS
		]]
--[[
	FIRE BOMB EVENTS
	]]
function INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombOnSpawn(Unit)
	Unit:DisableRespawn()
	Unit:SetCombatMeleeCapable(1)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9+UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_DISPLAYID,20374)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombExplode",10000,1)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_SpellVisual",200,1)
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_SpellVisual(Unit)
	Unit:FullCastSpell(42726)
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombOnDeath(Unit)
	Unit:RemoveFromWorld()
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombExplode(Unit)
	Unit:FullCastSpell(42630)
	Unit:Die()
end
--[[
	END FIREBOMB EVENTS
		]]
--[[
	FIRE WALL EVENTS	
	]]
function INSTANCE_ZULAMAN.JANALAI.JanAlai_FireWallOnSpawn(Unit)
	Unit:DisableRespawn()
	Unit:SetCombatMeleeCapable(1)
	Unit:SetUInt32Value(UnitField.UNIT_FIELD_FLAGS,UnitFieldFlags.UNIT_FLAG_NOT_ATTACKABLE_9+UnitFieldFlags.UNIT_FLAG_NOT_SELECTABLE)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.JANALAI.JanAlai_FireWallSpellVisual",200,1)
end
function INSTANCE_ZULAMAN.JANALAI.JanAlai_FireWallSpellVisual(Unit)
	Unit:FullCastSpell(43113)
end

RegisterUnitEvent(23578,18,"INSTANCE_ZULAMAN.JANALAI.JanAlai_OnSpawn")
RegisterUnitEvent(23578,1,"INSTANCE_ZULAMAN.JANALAI.JanAlai_OnCombat")
RegisterUnitEvent(23578,21,"INSTANCE_ZULAMAN.JANALAI.JanAlai_AIUpdate")
RegisterUnitEvent(23578,2,"INSTANCE_ZULAMAN.JANALAI.JanAlai_OnWipe")
RegisterUnitEvent(23578,3,"INSTANCE_ZULAMAN.JANALAI.JanAlai_OnKillPlayer")
RegisterUnitEvent(23578,4,"INSTANCE_ZULAMAN.JANALAI.JanAlai_OnDeath")
RegisterUnitEvent(23817,18,"INSTANCE_ZULAMAN.JANALAI.JanAlai_EggOnSpawn")
RegisterUnitEvent(23817,4,"INSTANCE_ZULAMAN.JANALAI.JanAlai_EggOnDeath")
RegisterUnitEvent(23818,18,"INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherOnSpawn")
RegisterUnitEvent(23818,19,"INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherOnReachWp")
RegisterUnitEvent(23818,4,"INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherOnWipe")
RegisterUnitEvent(23818,2,"INSTANCE_ZULAMAN.JANALAI.JanAlai_HatcherOnWipe")
RegisterUnitEvent(23920,18,"INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombOnSpawn")
RegisterUnitEvent(23920,4,"INSTANCE_ZULAMAN.JANALAI.JanAlai_FireBombOnDeath")
RegisterUnitEvent(70000,18,"INSTANCE_ZULAMAN.JANALAI.JanAlai_FireWallOnSpawn")
RegisterUnitEvent(23598,18,"INSTANCE_ZULAMAN.JANALAI.JanAlai_DragonHawkOnSpawn")
RegisterUnitEvent(23598,13,"INSTANCE_ZULAMAN.JANALAI.JanAlai_DragonHawkOnHit")
RegisterUnitEvent(23598,13,"INSTANCE_ZULAMAN.JANALAI.JanAlai_DragonHawkOnReachWp")