-- This file contains script information about the necromancer unit.
-- Necromancer, every 25% HP, summons all dead units around him.
-- Dead units are given buffs based on visual_buffs array

-- necromancer entry ID
NECROMANCER = 1000208

-- the buffs that are applied on resurrection.
visual_buffs = {
	2000071,
}

-- CONSTANTS BELOW:
-- dummy spell, this typically shouldnt be changed but is a constant variable.
DUMMY_SPELL = 2000070

NECROMANCER_SHADOW_BOLT = 72504

GEAR_TOKEN_BUFF = 2000043

GEAR_TOKEN = 1999996

-- check for resurrection
local function Necromancer_Resurrect_Check(eventid, delay, repeats, creature)
	local dead_units = creature:GetCreaturesInRange( 100, 0, 0, 1)
	local units_are_alive = false
	
	if #dead_units == 0 or dead_units == nil then
		-- cancel stuff
	end
	
	for l=1,#dead_units,1 do
		local dead_creature = dead_units[l]
		for b=1,#visual_buffs,1 do
			if dead_creature:HasAura(visual_buffs[b]) == true then
	--			print("found buffed nearby units.")
				units_are_alive = true
			end
		end
	end
	
	if units_are_alive then
	--	print("living nearby units detected. maintaining channeling.")
	else
	--	print("non-buffed units are nearby. cancelling event?")
		
		creature:SetAggroEnabled(true)
		local castedSpell = creature:GetCurrentSpell(2)
		if castedSpell ~= nil then
			castedSpell:Cancel()
		end
	-- resume chasing target
		local tank = creature:GetNearestPlayer(100, 0)
		creature:MoveChase(tank)		
		RemoveEventById( eventid )
	end
end

-- applies the buff after rezzes
local function Necromancer_Resurrect_Buff(eventid, delay, repeats, creature)
	local living_units = creature:GetCreaturesInRange( 100, 0, 2, 1 )
	for m=1,#living_units,1 do
		for n=1,#visual_buffs,1 do
		--	print("adding aura?")
			living_units[m]:AddAura(DUMMY_SPELL, living_units[m])
			
		end
	end
end

local function Necromancer_Resurrect_Buff2(eventid, delay, repeats, creature)
	local living_units = creature:GetCreaturesInRange( 100, 0, 2, 1 )
	for v=1,#living_units,1 do
		for n=1,#visual_buffs,1 do
			if living_units[v]:HasAura(DUMMY_SPELL) == true then
			--	print("hey this guy was alive before")
				living_units[v]:RemoveAura(DUMMY_SPELL)
			else
			--	print("adding aura?")
				living_units[v]:AddAura(visual_buffs[n], living_units[v])
			end
		end
	end
end

-- this is what happens at the end of channeling the resurrect
local function Necromancer_Initial_Cast(eventid, delay, repeats, creature)
	local dead_units = creature:GetCreaturesInRange( 100, 0, 0, 2)
	
	for b=1,#dead_units,1 do
		local dead_creature = dead_units[b]
		local dice_roll = math.random(1, #visual_buffs)
		local old_x, old_y, old_z, old_o = dead_creature:GetLocation()
		local x, y, z, o = dead_creature:GetHomePosition()
		dead_creature:NearTeleport(x, y, z, o)
		dead_creature:Respawn()
		local new_creature = dead_creature:GetNearestCreature( 1, dead_creature:GetEntry(), 0, 1)
		dead_creature:NearTeleport( x, y, z - 300, o )
		dead_creature:SaveToDB()
		if new_creature ~= nil then
			new_creature:NearTeleport(old_x, old_y, old_z, old_o)
		else
			print("error on necromancer")
		end
	end
	creature:RegisterEvent(Necromancer_Resurrect_Buff2, 0, 1)

	creature:RegisterEvent(Necromancer_Resurrect_Check, 2000, 0)
end

-- this is how we spam shadowfury on dead bodies
local function Necromancer_Channel_Visual(eventid, delay, repeats, creature)
	local dead_units = creature:GetCreaturesInRange( 100, 0, 0, 2)
	
	for b=1,#dead_units,1 do
		local x, y, z, o = dead_units[b]:GetLocation()	
		dead_units[b]:CastSpellAoF( x, y, z, 2000073, true)
	end
end

-- rezzes nearby enemies, plays sound line.
local function Necromancer_Resurrect(creature)
	-- necromancer casts channeled spell
	creature:SetAggroEnabled( false )
	creature:ClearInCombat()
	creature:MoveExpire()
	creature:CastSpell(creature, 2000074, false)
	
	-- send custom necromancer sound
	local players_in_range = creature:GetPlayersInRange(200, 0, 0)
	for v=1,#players_in_range,1 do
		players_in_range[v]:PlayDirectSound( 20000, players_in_range[v] )
	end
	creature:SendUnitSay("The restless dead await!", 0)
	
	-- begin rest of cool shit
	creature:RegisterEvent(Necromancer_Initial_Cast, 6000, 1)
	creature:RegisterEvent(Necromancer_Channel_Visual, 2000, 3)
	creature:RegisterEvent(Necromancer_Resurrect_Buff, 0, 1)
end

-- shadowbolt volley every 10 seconds
local function Necromancer_Shadowbolt_Volley(eventid, delay, repeats, creature)
	local nearby_players = creature:GetPlayersInRange( 100, 0, 1 )
	for z=1,#nearby_players,1 do
		if nearby_players[z]:IsInCombat() then
			creature:CastSpell( nearby_players[z], NECROMANCER_SHADOW_BOLT, true )
		end
	end
	
	local players_in_range = creature:GetPlayersInRange(100, 0, 0)
	for v=1,#players_in_range,1 do
		players_in_range[v]:PlayDirectSound( 20001, players_in_range[v] )
	end
	creature:SendUnitSay("Let darkness guide me!", 0)	
end

local function Necromancer_Combat_Enter(event, creature, target)
	local players_in_range = creature:GetPlayersInRange(200, 0, 0)
	for v=1,#players_in_range,1 do
		players_in_range[v]:PlayDirectSound( 20002, players_in_range[v] )
	end
	creature:SendUnitSay("None shall survive.", 0)	
	creature:RegisterEvent(Necromancer_Shadowbolt_Volley, 10000, 0)
end

local function Necromancer_Combat_Exit(event, creature)
	creature:RemoveAura(DUMMY_SPELL)
	creature:RemoveEvents()
end

local function Necromancer_Die_Target(event, creature, victim)
	-- send custom necromancer sound
	local players_in_range = creature:GetPlayersInRange(200, 0, 0)
	for v=1,#players_in_range,1 do
		players_in_range[v]:PlayDirectSound( 20003, players_in_range[v] )
	end
	creature:SendUnitSay("Die!", 0)	
	return
end

local function Necromancer_Die(event, creature, killer)
	local players_in_range = creature:GetPlayersInRange(200, 0, 0)
	for v=1,#players_in_range,1 do
		players_in_range[v]:PlayDirectSound( 20004, players_in_range[v] )
	end
	creature:SendUnitSay("They'll all be mine, in the end...", 0)	
	
	creature:RemoveAura(DUMMY_SPELL)
	creature:RemoveEvents()
	
	SendWorldMessage("[SERVER]: The wind in the air grows chill, as a powerful force in the world dies...")
	PrintInfo("[NECROMANCER]: Boss has died from " ..killer:GetName().. ".")
	
	local players_in_range = creature:GetPlayersInRange( 100, 0, 0 )
	for m=1,#players_in_range,1 do
		players_in_range[m]:AddAura(GEAR_TOKEN_BUFF, players_in_range[m])
		players_in_range[m]:AddItem(GEAR_TOKEN, 12)
		local aura = players_in_range[m]:GetAura(GEAR_TOKEN_BUFF)
		aura:SetStackAmount(6)
	end
end


local function Necromancer_Damage_Taken(event, creature, attacker, damage)
	local aura = creature:GetAura(DUMMY_SPELL)
	local creature_health_pct = creature:GetHealthPct()
	local new_health_pct = (creature:GetHealth() - damage) / creature:GetMaxHealth() 
	if creature:HasAura(2000074) == true then
		creature:DealHeal( creature, 72484, damage )
	--	print("channelling detected. no damage taken?")
		return false
	end
	
	-- the return falses are places we can stop the script from firing earliest
	if new_health_pct > .75 then
		creature:RemoveAura(DUMMY_SPELL)
		return
	-- aura should only = 3 after .25 has been applied
	elseif creature:HasAura(DUMMY_SPELL) == true and aura:GetStackAmount() == 3 then
		return
	end
	
	if new_health_pct <= .75 and creature:HasAura(DUMMY_SPELL) == false then
		-- apply dummy aura, 1 stack.
		creature:AddAura(DUMMY_SPELL, creature)
		Necromancer_Resurrect(creature)
	elseif creature:HasAura(DUMMY_SPELL) == true and aura:GetStackAmount() == 1 and new_health_pct <= .50 then
		-- set stack to 2
		aura:SetStackAmount(2)
		Necromancer_Resurrect(creature)
	elseif creature:HasAura(DUMMY_SPELL) == true and aura:GetStackAmount() == 2 and new_health_pct <= .25 then
		-- set stack to 3
		aura:SetStackAmount(3)
		Necromancer_Resurrect(creature)
	end
end
-- ClearUniqueCreatureEvents( entry )
-- eventId = WorldObject:RegisterEvent( function, delay, repeats )
-- RegisterUniqueCreatureEvent( guid, instance_id, event, function )

RegisterCreatureEvent( NECROMANCER, 1, Necromancer_Combat_Enter )
RegisterCreatureEvent( NECROMANCER, 9, Necromancer_Damage_Taken )
RegisterCreatureEvent( NECROMANCER, 2, Necromancer_Combat_Exit )
RegisterCreatureEvent( NECROMANCER, 4, Necromancer_Die )
RegisterCreatureEvent( NECROMANCER, 3, Necromancer_Die_Target )