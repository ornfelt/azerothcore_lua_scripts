


function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_HandleGauntlet(Unit,event,pAggro)
	local args = getvars(Unit)
	local guard1,guard2,guard3;
	guard1 = Unit:GetCreatureNearestCoords(17.345501,1418.599976,12.047500,23582)
	guard2 = Unit:GetCreatureNearestCoords(19.094801,1420.569946,12.073000,23542)
	guard3 = Unit:GetCreatureNearestCoords(14.541300,1411.640015,12.082000,23542)
	if(type(guard1) == "userdata") then
		table.insert(args.NALORAKK.guardssent,guard1)
		guard1:CreateWaypoint(1,-0.238281,1424.033174,11.795671,Unit:GetO(),0,256,0)
		guard1:CreateWaypoint(2,2.186747,1446.615479,10.219745,Unit:GetO(),0,256,0)
		guard1:CreateWaypoint(3,11.535601,1465.176514,5.695276,Unit:GetO(),0,256,0)
		guard1:CreateWaypoint(4,40.059956,1461.173462,0.158273,Unit:GetO(),0,256,0)
		guard1:CreateWaypoint(5,pAggro:GetX(),pAggro:GetY(),pAggro:GetZ(),Unit:GetO(),0,256,0)
	end
	if(type(guard2) == "userdata") then
		table.insert(args.NALORAKK.guardssent,guard2)
		guard2:CreateWaypoint(1,-0.238281,1424.033174,11.795671,Unit:GetO(),0,256,0)
		guard2:CreateWaypoint(2,2.186747,1446.615479,10.219745,Unit:GetO(),0,256,0)
		guard2:CreateWaypoint(3,11.535601,1465.176514,5.695276,Unit:GetO(),0,256,0)
		guard2:CreateWaypoint(4,40.059956,1461.173462,0.158273,Unit:GetO(),0,256,0)
		guard2:CreateWaypoint(5,pAggro:GetX(),pAggro:GetY(),pAggro:GetZ(),Unit:GetO(),0,256,0)
	end
	if(type(guard3) == "userdata") then
		table.insert(args.NALORAKK.guardssent,guard3)
		guard3:CreateWaypoint(1,-0.238281,1424.033174,11.795671,Unit:GetO(),0,256,0)
		guard3:CreateWaypoint(2,2.186747,1446.615479,10.219745,Unit:GetO(),0,256,0)
		guard3:CreateWaypoint(3,11.535601,1465.176514,5.695276,Unit:GetO(),0,256,0)
		guard3:CreateWaypoint(4,40.059956,1461.173462,0.158273,Unit:GetO(),0,256,0)
		guard3:CreateWaypoint(5,pAggro:GetX(),pAggro:GetY(),pAggro:GetZ(),Unit:GetO(),0,256,0)
	end
	for k,v in pairs(args.NALORAKK.guardssent) do
		v:DisableRespawn()
		v:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
	end
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Get da move on, guards! It be killin' time! ")
	Unit:PlaySoundToSet(12066)
	Unit:Emote(25,0)
	args.NALORAKK.wavecount = 1
	Unit:SetCombatCapable(1)
	Unit:RegisterAIUpdateEvent(1000)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.NALORAKK.Nalorakk_MoveToWaypoint",200,1)
end

RegisterUnitEvent(23582,4,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_HandleGauntlet")

function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_MoveToWaypoint(Unit)
	Unit:SetAllowedToEnterCombat(0)
	Unit:StopMovement(0)
	Unit:SetAIState(AI_State.STATE_SCRIPTMOVE)
	Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
	Unit:MoveToWaypoint(1)
end

RegisterUnitEvent(23581,4,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_MoveToWaypoint")

function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnReachWp(Unit,event,null,wp)
	local args = getvars(Unit)
	if wp == 1 then
		args.NALORAKK.canmove = true
	elseif wp == 2 then
		args.NALORAKK.canmove = true
	elseif wp == 3 then
		args.NALORAKK.canmove = true
	elseif wp == 4 then
		args.NALORAKK.canmove = true
	elseif wp == 5 then
		args.NALORAKK.canmove = true
	elseif wp == 6 then
		args.NALORAKK.canmove = true
	elseif wp == 7 then
		args.NALORAKK.canmove = true
	end
end

RegisterUnitEvent(23522,4,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_OnReachWp")

function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Gauntlet_AIUpdate(Unit)
	local args = getvars(Unit)
	local wp = Unit:GetCurrentWaypoint()
	local plr = Unit:GetClosestPlayer()
	if args.NALORAKK.gauntlet == true then
		if wp == 1 and table.getn(args.NALORAKK.guardssent) == 0 and args.NALORAKK.canmove == true and Unit:GetDistance(plr) <= 50 then
			Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
			Unit:MoveToWaypoint(wp+1)
			args.NALORAKK.canmove = false
		elseif wp == 2 and table.getn(args.NALORAKK.guardssent) == 0 and args.NALORAKK.canmove == true and args.NALORAKK.wavecount == 1 and Unit:GetDistance(plr) <= 100 then
			local GetRandomAdd = function()
				local randtable = { 23542,23581,24225}
				local randentry = randtable[math.random(1,table.getn(randtable))];
				return randentry
			end
			args.NALORAKK.wavecount = 2
			Unit:Emote(25,0)
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Guards, go already! Who you more afraid of, dem... or me?")
			Unit:PlaySoundToSet(12067)
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(GetRandomAdd(),-58.663849,1423.417603,27.307653,Unit:GetO(),1890,0))
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(GetRandomAdd(),-64.003815,1422.918823,27.303940,Unit:GetO(),1890,0))
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(GetRandomAdd(),-64.086685,1417.019409,27.303940,Unit:GetO(),1890,0))
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(GetRandomAdd(),-58.663849,1423.417603,27.307653,Unit:GetO(),1890,0))
			for k,v in pairs(args.NALORAKK.guardssent) do
				v:DisableRespawn()
				v:CreateWaypoint(1,-50.805714+math.cos(math.random(20,40))*3,1418.623657+math.sin(math.random(20,40))*3,27.179335,Unit:GetO(),0,256,0)
				v:CreateWaypoint(2,-18.245897+math.cos(math.random(20,40))*3,1419.292480+math.sin(math.random(20,40))*3,12.730953,Unit:GetO(),0,256,0)
				v:CreateWaypoint(3,-0.159436+math.cos(math.random(20,40))*3,1425.261841+math.sin(math.random(20,40))*3,11.777050,Unit:GetO(),0,256,0)
				v:CreateWaypoint(4,1.573907+math.cos(math.random(20,40))*3,1455.735229+math.sin(math.random(20,40))*3,9.368050,Unit:GetO(),0,256,0)
				v:CreateWaypoint(5,36.152603+math.cos(math.random(20,40))*3,1463.635864+math.sin(math.random(20,40))*3,1.008603,Unit:GetO(),0,256,0)
				v:CreateWaypoint(6,44.759525+math.cos(math.random(20,40))*3,1440.297729+math.sin(math.random(20,40))*3,0.188035,Unit:GetO(),0,256,0)
				v:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
			end
			--Unit:SetAIState(AI_State.STATE_SCRIPTMOVE)
			Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
			Unit:MoveToWaypoint(wp+1)
			args.NALORAKK.canmove = false
		elseif wp == 3 and table.getn(args.NALORAKK.guardssent) == 0 and args.NALORAKK.canmove == true and Unit:GetDistance(plr) <= 50 then
			Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
			Unit:MoveToWaypoint(wp+1)
			args.NALORAKK.canmove = false
		elseif wp == 4 and table.getn(args.NALORAKK.guardssent) == 0 and args.NALORAKK.canmove == true and Unit:GetDistance(plr) <= 50 then
			Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
			Unit:MoveToWaypoint(wp+1)
			args.NALORAKK.canmove = false
		elseif wp == 5 and table.getn(args.NALORAKK.guardssent) == 0 and args.NALORAKK.canmove == true and args.NALORAKK.wavecount == 2 and Unit:GetDistance(plr) <= 50 then
			args.NALORAKK.wavecount = 3
			Unit:Emote(25,0)
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Ride now! Ride out dere and bring me back some heads!")
			Unit:PlaySoundToSet(12068)
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(23580,-86.509805,1372.588745,40.776428,Unit:GetO(),1890,0))
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(23580,-74.132805,1372.929199,40.763882,Unit:GetO(),1890,0))
			for k,v in pairs(args.NALORAKK.guardssent) do
				v:WipeCurrentTarget()
				v:DisableRespawn()
				v:CreateWaypoint(1,-79.662476+math.cos(math.random(20,40))*3,1377.553101+math.sin(math.random(20,40))*3,40.766491,Unit:GetO(),0,256,0)
				v:CreateWaypoint(2,-79.885071+math.cos(math.random(20,40))*3,1394.976318+math.sin(math.random(20,40))*3,27.174772,Unit:GetO(),0,256,0)
				v:CreateWaypoint(3,-80.066025+math.cos(math.random(20,40))*3,1417.475586+math.sin(math.random(20,40))*3,27.302441,Unit:GetO(),0,256,0)
				v:CreateWaypoint(4,-50.805714+math.cos(math.random(20,40))*3,1418.623657+math.sin(math.random(20,40))*3,27.179335,Unit:GetO(),0,256,0)
				v:CreateWaypoint(5,-18.245897+math.cos(math.random(20,40))*3,1419.292480+math.sin(math.random(20,40))*3,12.730953,Unit:GetO(),0,256,0)
				v:CreateWaypoint(6,-0.159436+math.cos(math.random(20,40))*3,1425.261841+math.sin(math.random(20,40))*3,11.777050,Unit:GetO(),0,256,0)
				v:CreateWaypoint(7,1.573907+math.cos(math.random(20,40))*3,1455.735229+math.sin(math.random(20,40))*3,9.368050,Unit:GetO(),0,256,0)
				v:CreateWaypoint(8,36.152603+math.cos(math.random(20,40))*3,1463.635864+math.sin(math.random(20,40))*3,1.008603,Unit:GetO(),0,256,0)
				v:CreateWaypoint(9,44.759525+math.cos(math.random(20,40))*3,1440.297729+math.sin(math.random(20,40))*3,0.188035,Unit:GetO(),0,256,0)
				v:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
				v:MoveToWaypoint(1)
			end
			--Unit:SetAIState(AI_State.STATE_SCRIPTMOVE)
			Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
			Unit:MoveToWaypoint(wp+1)
			args.NALORAKK.canmove = false
		elseif wp == 6 and table.getn(args.NALORAKK.guardssent) == 0 and args.NALORAKK.canmove == true and Unit:GetDistance(plr) <= 50 then
			Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
			Unit:MoveToWaypoint(wp+1)
			args.NALORAKK.canmove = false
		elseif wp == 7 and table.getn(args.NALORAKK.guardssent) == 0 and args.NALORAKK.canmove == true and Unit:GetDistance(plr) <= 80 and args.NALORAKK.wavecount == 3 and args.NALORAKK.gauntlet == true then
			local GetRandomAdd = function()
				local randtable = { 23542,23581,24225}
				local randentry = randtable[math.random(1,table.getn(randtable))];
				return randentry
			end
			Unit:SetMovementType(MovementType.MOVEMENTTYPE_WANTEDWP)
			Unit:MoveToWaypoint(wp+1)
			Unit:RemoveAIUpdateEvent()
			args.NALORAKK.wavecount = 4
			args.NALORAKK.gauntlet = false
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I be losin' me patience! Go on: make dem wish dey was never born!")
			Unit:PlaySoundToSet(12069)
			Unit:Emote(25,0)
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(23580,-68.145760,1317.887085,41.172745,Unit:GetO(),1890,0))
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(23580,-94.955421,1316.371460,40.862305,Unit:GetO(),1890,0))
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(GetRandomAdd(),-90.012367,1318.510010,40.908222,Unit:GetO(),1890,0))
			table.insert(args.NALORAKK.guardssent,Unit:SpawnCreature(GetRandomAdd(),-79.167320,1318.090676,41.151787,Unit:GetO(),1890,0))
			for k,v in pairs(args.NALORAKK.guardssent) do
				v:DisableRespawn()
				v:CreateWaypoint(1,-80.717232+math.cos(math.random(20,40))*3,1343.276123+math.sin(math.random(20,40))*3,40.772724,Unit:GetO(),0,256,0)
				v:CreateWaypoint(2,-79.662476+math.cos(math.random(20,40))*3,1377.553101+math.sin(math.random(20,40))*3,40.766491,Unit:GetO(),0,256,0)
				v:CreateWaypoint(3,-79.885071+math.cos(math.random(20,40))*3,1394.976318+math.sin(math.random(20,40))*3,27.174772,Unit:GetO(),0,256,0)
				v:CreateWaypoint(4,-80.066025+math.cos(math.random(20,40))*3,1417.475586+math.sin(math.random(20,40))*3,27.302441,Unit:GetO(),0,256,0)
				v:CreateWaypoint(5,-50.805714+math.cos(math.random(20,40))*3,1418.623657+math.sin(math.random(20,40))*3,27.179335,Unit:GetO(),0,256,0)
				v:CreateWaypoint(6,-18.245897+math.cos(math.random(20,40))*3,1419.292480+math.sin(math.random(20,40))*3,12.730953,Unit:GetO(),0,256,0)
				v:CreateWaypoint(7,-0.159436+math.cos(math.random(20,40))*3,1425.261841+math.sin(math.random(20,40))*3,11.777050,Unit:GetO(),0,256,0)
				v:CreateWaypoint(8,1.573907+math.cos(math.random(20,40))*3,1455.735229+math.sin(math.random(20,40))*3,9.368050,Unit:GetO(),0,256,0)
				v:CreateWaypoint(9,36.152603+math.cos(math.random(20,40))*3,1463.635864+math.sin(math.random(20,40))*3,1.008603,Unit:GetO(),0,256,0)
				v:CreateWaypoint(10,44.759525+math.cos(math.random(20,40))*3,1440.297729+math.sin(math.random(20,40))*3,0.188035,Unit:GetO(),0,256,0)
				v:SetMovementType(MovementType.MOVEMENTTYPE_FORWARDTHANSTOP)
			end
		end
	end
end

RegisterUnitEvent(23522,4,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_Gauntlet_AIUpdate")

--[[ Guards Events ]]
function INSTANCE_ZULAMAN.NALORAKK.Nalorakk_GuardsOnDeath(Unit)
	local args = getvars(Unit)
	if type(args.NALORAKK) == "table" and args.NALORAKK.gauntlet == true then
		for k,v in pairs(args.NALORAKK.guardssent) do
			if v == Unit then
				table.remove(args.NALORAKK.guardssent,k)
			end
		end
	end
end

RegisterUnitEvent(23522,4,"INSTANCE_ZULAMAN.NALORAKK.Nalorakk_GuardsOnDeath")