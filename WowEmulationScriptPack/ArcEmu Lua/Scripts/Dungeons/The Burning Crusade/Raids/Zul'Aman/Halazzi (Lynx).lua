

--[[
	HALAZZI EVENTS
		]]
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnSpawn(Unit)
	local args = getvars(Unit)
	if(args == nil) or args.HALAZZI == nil then
		setvars(Unit,{HALAZZI = {
		m_phase = 0,
		merge = true,
		halazzihp = 0,
		maxhp = 0,
		lynxptr = nil,
		halazziptr = nil,
		splits = 0,
		}})
	end
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnCombat(Unit)
	local args = getvars(Unit)
	args.HALAZZI.halazziptr = Unit
	args.HALAZZI.maxhp = Unit:GetUInt32Value(UnitField.UNIT_FIELD_MAXHEALTH);
	args.HALAZZI.m_phase = 1
	INSTANCE_ZULAMAN.HALAZZI.Halazzi_PhaseCheck(Unit)
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Get on your knees and bow to da fang and claw!")
	Unit:PlaySoundToSet(12020)
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnKillPlayer(Unit,event,mTarget)
	if(type(mTarget) == "userdata") then
		local choice = math.random(2)
		if choice == 1 then
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You cant fight da power...")
			Unit:PlaySoundToSet(12026)
		elseif choice == 2 then
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You all gonna fail...")
			Unit:PlaySoundToSet(12027)
		end
	end
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnWipe(Unit)
	INSTANCE_ZULAMAN.HALAZZI.Halazzi_SetForm(Unit,"LYNX")
	Unit:RemoveEvents()
	Unit:RemoveAIUpdateEvent()
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnDeath(Unit)
	INSTANCE_ZULAMAN.HALAZZI.Halazzi_SetForm(Unit,"LYNX")
	Unit:RemoveEvents()
	Unit:RemoveAIUpdateEvent()
	Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Chaga... choka'jinn.")
	Unit:PlaySoundToSet(12028)
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_AIUpdate(Unit)
	local args = getvars(Unit)
	local hp = Unit:GetHealthPct()
	if hp <= 75 and hp > 50 and args.HALAZZI.m_phase ~= 2 and args.HALAZZI.splits == 0 and args.HALAZZI.merge == true then
		Unit:RemoveEvents()
		args.HALAZZI.m_phase = 2
		args.HALAZZI.splits = 1
		args.HALAZZI.merge = false
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_Split(Unit)
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_PhaseCheck(Unit)
	elseif hp <= 50 and hp > 25 and args.HALAZZI.m_phase ~= 2 and args.HALAZZI.splits == 1 and args.HALAZZI.merge == true then
		Unit:RemoveEvents()
		args.HALAZZI.m_phase = 2
		args.HALAZZI.splits = 2
		args.HALAZZI.merge = false
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_Split(Unit)
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_PhaseCheck(Unit)
	elseif hp <= 25 and hp > 20 and args.HALAZZI.m_phase ~= 2 and args.HALAZZI.splits == 2 and args.HALAZZI.merge == true then
		Unit:RemoveEvents()
		args.HALAZZI.m_phase = 2
		args.HALAZZI.splits = 3
		args.HALAZZI.merge = false
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_Split(Unit)
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_PhaseCheck(Unit)
	elseif hp <= 20 and hp > 10 and args.HALAZZI.m_phase ~= 3 and args.HALAZZI.splits == 3 and args.HALAZZI.merge == true then
		Unit:RemoveEvents()
		args.HALAZZI.merge = true
		args.HALAZZI.m_phase = 3
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_PhaseCheck(Unit)
	end
	if args.HALAZZI.m_phase == 2 and args.HALAZZI.merge == false and hp <= 20 then -- check whether to merge back.
		args.HALAZZI.merge = true
		args.HALAZZI.m_phase = 1
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_Split(Unit)
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_PhaseCheck(Unit)
	end
end
--[[
	END HALAZZI EVENTS
		]]
--[[
	HALAZZI ABILITIES
		]]
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_SaberSlash(Unit)
	local tank = Unit:GetMainTank()
	if(type(tank) == "userdata") then
		local choice = math.random(2)
		if choice == 1 then
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Me gonna carve ya now!")
			Unit:PlaySoundToSet(12023)
		elseif choice == 2 then
			Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"You gonna leave in pieces!")
			Unit:PlaySoundToSet(12024)
		end
		Unit:FullCastSpellOnTarget(43267,tank)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_SaberSlash",math.random(20000,30000),1)
	end
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_ShockSpells(Unit)
	local args = getvars(Unit)
	if args.HALAZZI.merge ~= true then return end
	local rand = math.random(2)
	local plr = Unit:GetRandomPlayer(0)
	if(type(plr) == "userdata") then
		if rand == 1 then
			Unit:FullCastSpellOnTarget(43303,plr)
		elseif rand == 2 then
			Unit:FullCastSpellOnTarget(43305,plr)
		end
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_ShockSpells",math.random(10000,20000),1)
	end
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotem(Unit)
	local totem = Unit:SpawnCreature(24224,Unit:GetX()+math.cos(40,60)*3,Unit:GetY()+math.sin(40,60)*3,Unit:GetZ(),Unit:GetO(),14,20000)
	totem:AttackReaction(Unit:GetNextTarget(),1,0)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotem",math.random(15000,20000),1)
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_PeriodicEnrage(Unit)
	local args = getvars(Unit)
	Unit:FullCastSpell(43139)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_PeriodicEnrage",math.random(10000,15000),1)
end
--[[
	END HALAZZI ABILITIES
		]]
--[[
	HALAZZI CUSTOM FUNCTIONS
		]]
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_Split(Unit)
	local args = getvars(Unit)
	if args.HALAZZI.merge == false then
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_SetForm(Unit,"TROLL")
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"I fight wit' untamed spirit...")
		Unit:PlaySoundToSet(12021)
		args.HALAZZI.halazzihp = Unit:GetHealth()
		Unit:SetUInt32Value(UnitField.UNIT_FIELD_MAXHEALTH,400000)
		args.HALAZZI.lynxptr = Unit:SpawnCreature(24143,Unit:GetX()+math.cos(20,30)*3,Unit:GetY()+math.sin(20,40)*3,Unit:GetZ(),Unit:GetO(),Unit:GetUInt32Value(UnitField.UNIT_FIELD_FACTIONTEMPLATE),0)
		args.HALAZZI.lynxptr:SetUInt32Value(UnitField.UNIT_FIELD_MAXHEALTH,200000)
		args.HALAZZI.lynxptr:AttackReaction(Unit:GetNextTarget(),1,0)
		Unit:FullCastSpell(44054) -- transfigure
	elseif args.HALAZZI.merge == true then
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_SetForm(Unit,"LYNX")
		Unit:SendChatMessage(ChatField.CHAT_MSG_MONSTER_YELL,LangField.LANG_UNIVERSAL,"Spirit, come back to me!")
		Unit:PlaySoundToSet(12022)
		args.HALAZZI.lynxptr:RemoveFromWorld()
		Unit:SetUInt32Value(UnitField.UNIT_FIELD_MAXHEALTH,args.HALAZZI.maxhp)
		Unit:SetUInt32Value(UnitField.UNIT_FIELD_HEALTH,args.HALAZZI.halazzihp)
	end
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_PhaseCheck(Unit)
	local args = getvars(Unit)
	if args.HALAZZI.merge == false and args.HALAZZI.m_phase == 2 then
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_ShockSpells",math.random(10000,20000),1)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotem",math.random(10000,20000),1)
		Unit:RegisterAIUpdateEvent(1000)
	elseif args.HALAZZI.merge == true and args.HALAZZI.m_phase == 1 then
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_SaberSlash",math.random(20000,30000),1)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_ShockSpells",math.random(10000,20000),1)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_PeriodicEnrage",math.random(10000,15000),1)
		Unit:RegisterAIUpdateEvent(1000)
	elseif args.HALAZZI.merge == true and args.HALAZZI.m_phase == 3 then
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_SaberSlash",math.random(20000,30000),1)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_ShockSpells",math.random(10000,20000),1)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_PeriodicEnrage",math.random(10000,15000),1)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotem",math.random(10000,20000),1)
		Unit:RegisterAIUpdateEvent(1000)
	end
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_SetForm(Unit,val)
	if val == "TROLL" then
		Unit:SetUInt32Value(UnitField.UNIT_FIELD_DISPLAYID,22348)
	elseif val == "LYNX" then
		Unit:SetUInt32Value(UnitField.UNIT_FIELD_DISPLAYID,21632)
	end
end
--[[
	END HALAZZI CUSTOM FUNCTIONS
		]]
		
--[[
	SPIRIT OF LYNX EVENTS
		]]
function INSTANCE_ZULAMAN.HALAZZI.SpiritofLynx_OnCombat(Unit)
	Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.SpiritofLynx_Abilities",3000,1)
	Unit:RegisterAIUpdateEvent(1000)
end
function INSTANCE_ZULAMAN.HALAZZI.SpiritofLynx_AIUpdate(Unit)
	local args = getvars(Unit)
	local hp = Unit:GetHealthPct()
	if args.HALAZZI.m_phase == 2 and hp <= 20 and args.HALAZZI.merge == false then
		args.HALAZZI.merge = true
		args.HALAZZI.m_phase = 1
		INSTANCE_ZULAMAN.HALAZZI.Halazzi_Split(args.HALAZZI.halazziptr)
		Unit:RemoveAIUpdateEvent()
	end
end
--[[
	END SPIRIT OF LYNX EVENTS
		]]
function INSTANCE_ZULAMAN.HALAZZI.SpiritofLynx_Abilities(Unit)
	local tank = Unit:GetMainTank()
	local choice = math.random(2)
	if(type(tank) == "userdata") then
		if choice == 1 then
			Unit:FullCastSpellOnTarget(43243,tank)
		elseif choice == 2 then
			Unit:FullCastSpell(43290)
		end
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.SpiritofLynx_Abilities",math.random(5000,10000),1)
	end
end
--[[
	CORRUPTED TOTEM EVENTS
		]]
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotemOnSpawn(Unit)
	Unit:SetCombatMeleeCapable(1)
	Unit:Root()
	Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotemLightning",1000,1)
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotemOnWipe(Unit)
	Unit:RemoveEvents()
	Unit:RemoveFromWorld()
end
function INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotemLightning(Unit)
	local plr = Unit:GetRandomPlayer(0)
	if(type(plr) == "userdata") then
		Unit:FullCastSpellOnTarget(43301,plr)
		Unit:RegisterEvent("INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotemLightning",1000,1)
	end
end
--[[
	END CORRUPTED TOTEM EVENTS
		]]
	

RegisterUnitEvent(23577,1,"INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnCombat")
RegisterUnitEvent(23577,18,"INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnSpawn")
RegisterUnitEvent(23577,3,"INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnKillPlayer")
RegisterUnitEvent(23577,2,"INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnWipe")
RegisterUnitEvent(23577,4,"INSTANCE_ZULAMAN.HALAZZI.Halazzi_OnDeath")
RegisterUnitEvent(23577,21,"INSTANCE_ZULAMAN.HALAZZI.Halazzi_AIUpdate")
RegisterUnitEvent(24143,21,"INSTANCE_ZULAMAN.HALAZZI.SpiritofLynx_AIUpdate")
RegisterUnitEvent(24143,1,"INSTANCE_ZULAMAN.HALAZZI.SpiritofLynx_OnCombat")
RegisterUnitEvent(24224,18,"INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotemOnSpawn")
RegisterUnitEvent(24224,4,"INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotemOnWipe")
RegisterUnitEvent(24224,2,"INSTANCE_ZULAMAN.HALAZZI.Halazzi_CorruptedTotemOnWipe")