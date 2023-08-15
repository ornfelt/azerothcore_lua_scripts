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

math.randomseed( os.time( ) )

--[[ HALAZZI ]]--

-- when entering combat
function npc_halazzi_event_combatenter( Unit, Event )
  local vars = getvars( Unit )
	
	vars.npc_halazzi.phase         = 1
	vars.npc_halazzi.shift         = 0
	vars.npc_halazzi.health.b      = Unit:GetMaxHealth( )
	vars.npc_halazzi.child         = nil
	vars.npc_halazzi.spells.saber  = math.random(  7, 10 )
	vars.npc_halazzi.spells.frenzy = math.random( 12, 14 )
	
	Unit:SendChatMessage( 14, 0, "Get on your knees and bow to da fang and claw!" )
	Unit:PlaySoundToSet( 12020 )

  Unit:RegisterEvent( "npc_halazzi_event_pulse", 1000, 1 )	
	setvars( Unit, vars )
end

-- when leaving combat
function npc_halazzi_event_combatleave( Unit, Event )
  Unit:RemoveEvents( )
end

-- when killing a target
function npc_halazzi_event_combatkills( Unit, Event )
  if math.random( 1, 2 ) == 1 then
		Unit:SendChatMessage( 14, 0, "You cant fight da power..." )
		Unit:PlaySoundToSet( 12026 )
  else
		Unit:SendChatMessage( 14, 9, "You all gonna fail..." )
		Unit:PlaySoundToSet( 12027 )
  end
end

-- when killed
function npc_halazzi_event_combatdying( Unit, Event )
	Unit:SendChatMessage( 14, 0, "Chaga... choka'jinn." )
	Unit:PlaySoundToSet( 12028 )
end

-- when being spawned
function npc_halazzi_event_spawn( Unit, Event )
  setvars( Unit, { npc_halazzi = { owner = Unit, child = nil, phase = 0, shift = 0, health = { a = 0, b = 0 }, spells = { saber = -1, frenzy = -1, totem = -1, shock = -1 } } } )
end

-- update pulse, happens every second
function npc_halazzi_event_pulse( Unit, Event )
	if npc_halazzi_phase_checkupdate( Unit, Event ) == true then
	  Unit:RegisterEvent( "npc_halazzi_event_pulse", 1000, 1 )
		return
	end
	
	npc_halazzi_phase_checkspells( Unit, Event )	
  Unit:RegisterEvent( "npc_halazzi_event_pulse", 1000, 1 )	
end

function npc_halazzi_phase_checkspells( Unit, Event )
  local vars = getvars( Unit )
	local done

	if vars.npc_halazzi.phase == 1 then
		vars.npc_halazzi.spells.saber  = vars.npc_halazzi.spells.saber  - 1
		if vars.npc_halazzi.spells.saber == 0 then
		  Unit:FullCastSpellOnTarget( 43267, Unit:GetMainTank( ) )
			
			if math.random( 1, 4 ) <= 2 then
			  Unit:SendChatMessage( 14, 0, "Me gonna carve ya now!" )
				Unit:PlaySoundToSet( 12023 )
			else
			  Unit:SendChatMessage( 14, 0, "You gonna leave in pieces!" )
				Unit:PlaySoundToSet( 12024 )
			end
			
			done = false
			while done == false do
			  local rand = math.random( 7, 10 )
				
				if vars.npc_halazzi.spells.frenzy ~= rand then
				  vars.npc_halazzi.spells.saber = rand
					done = true
				end
			end
		end
		
		vars.npc_halazzi.spells.frenzy = vars.npc_halazzi.spells.frenzy - 1
		if vars.npc_halazzi.spells.frenzy == 0 then
		  Unit:CastSpell( 43139 )
			
			done = false
			while done == false do
			  local rand = math.random( 12, 14 )
				
				if vars.npc_halazzi.spells.saber ~= rand then
				  vars.npc_halazzi.spells.frenzy = rand
					done = true
				end
			end
		end
	end
	
	if vars.npc_halazzi.phase == 2 then
	  vars.npc_halazzi.spells.totem = vars.npc_halazzi.spells.totem - 1
		if vars.npc_halazzi.spells.totem == 0 then
		  Unit:SpawnCreature( 24224, math.random( Unit:GetX( ) - 5, Unit:GetX( ) + 5 ), math.random( Unit:GetY( ) - 5, Unit:GetY( ) + 5 ), Unit:GetZ( ), Unit:GetO( ), 1890, 60000 )
			
			done = false
			while done == false do
			  local rand = math.random( 7, 9 )
				
				if rand ~= vars.npc_halazzi.spells.shock then
				  vars.npc_halazzi.spells.totem = rand
				  done = true
				end
			end
		end
		
		vars.npc_halazzi.spells.shock = vars.npc_halazzi.spells.shock - 1
		if vars.npc_halazzi.spells.shock == 0 then
		  if math.random( 100 ) < 60 then
			  Unit:FullCastSpellOnTarget( 43303, Unit:GetRandomPlayer( 0 ) )
			else
			  Unit:FullCastSpellOnTarget( 43305, Unit:GetRandomPlayer( 0 ) )
			end
			
			done = false
			while done == false do
			  local rand = math.random( 6, 8 )
				
				if rand ~= vars.npc_halazzi.spells.totem then
				  vars.npc_halazzi.spells.shock = rand
					done = true
				end
			end
		end
	end
	
	if vars.npc_halazzi.phase == 3 then
		vars.npc_halazzi.spells.saber  = vars.npc_halazzi.spells.saber  - 1
		if vars.npc_halazzi.spells.saber == 0 then
		  Unit:FullCastSpellOnTarget( 43267, Unit:GetMainTank( ) )
			
			if math.random( 1, 4 ) <= 2 then
			  Unit:SendChatMessage( 14, 0, "Me gonna carve ya now!" )
				Unit:PlaySoundToSet( 12023 )
			else
			  Unit:SendChatMessage( 14, 0, "You gonna leave in pieces!" )
				Unit:PlaySoundToSet( 12024 )
			end
			
			done = false
			while done == false do
			  local rand = math.random( 7, 9 )
				
				if vars.npc_halazzi.spells.frenzy ~= rand then
				  vars.npc_halazzi.spells.saber = rand
					done = true
				end
			end
		end
		
		vars.npc_halazzi.spells.frenzy = vars.npc_halazzi.spells.frenzy - 1
		if vars.npc_halazzi.spells.frenzy == 0 then
		  Unit:CastSpell( 43139 )
			
			done = false
			while done == false do
			  local rand = math.random( 12, 14 )
				
				if vars.npc_halazzi.spells.saber ~= rand then
				  vars.npc_halazzi.spells.frenzy = rand
					done = true
				end
			end
		end
		
	  vars.npc_halazzi.spells.totem = vars.npc_halazzi.spells.totem - 1
		if vars.npc_halazzi.spells.totem == 0 then
		  Unit:SpawnCreature( 24224, math.random( Unit:GetX( ) - 5, Unit:GetX( ) + 5 ), math.random( Unit:GetY( ) - 5, Unit:GetY( ) + 5 ), Unit:GetZ( ), Unit:GetO( ), 1890, 60000 )
			
			done = false
			while done == false do
			  local rand = math.random( 9, 11 )
				
				if rand ~= vars.npc_halazzi.spells.shock then
				  vars.npc_halazzi.spells.totem = rand
				  done = true
				end
			end
		end
	end
	
	setvars( Unit, vars )
end

function npc_halazzi_phase_checkupdate( Unit, Event )
  local vars    = getvars( Unit )
	local phase   = vars.npc_halazzi.phase
	local shift   = vars.npc_halazzi.shift
	local health  = Unit:GetHealthPct( )
	local health2 = 100
	
	if ( phase == 1 and health < 76 and shift == 0 ) or ( phase == 1 and health < 51 and shift == 1 ) or ( phase == 1 and health < 26 and shift == 2 ) then
	  vars.npc_halazzi.phase        = 2
		vars.npc_halazzi.shift        = vars.npc_halazzi.shift + 1
		vars.npc_halazzi.health.a     = Unit:GetHealth( )
		vars.npc_halazzi.spells.totem = math.random( 2, 4 )
		vars.npc_halazzi.spells.shock = math.random( 6, 8 )
		
		Unit:SetHealth( 400000 )
		Unit:SetMaxHealth( 400000 )
		Unit:SendChatMessage( 14, 0, "I fight wit' untamed spirit..." )
		Unit:PlaySoundToSet( 12021 )
		Unit:SetModel( 22309 )
		Unit:SpawnCreature( 24143, Unit:GetX( ) - 5, Unit:GetY( ) - 5, Unit:GetZ( ), Unit:GetO( ), 1890, 0 )
		Unit:CastSpell( 44054 )
		setvars( Unit, vars )
		return true
	end
	
	if vars.npc_halazzi.child ~= nil then
	  health2 = vars.npc_halazzi.child:GetHealthPct( )
	end
	
	if ( phase == 2 and health < 21 ) or ( phase == 2 and health2 < 11 ) then
		if vars.npc_halazzi.shift == 3 then
			vars.npc_halazzi.phase = 3
			vars.npc_halazzi.spells.saber  = math.random(  7, 10 )
			vars.npc_halazzi.spells.enrage = math.random( 12, 14 )
			vars.npc_halazzi.spells.totem  = math.random(  4,  6 )
		else
			vars.npc_halazzi.phase = 1
			vars.npc_halazzi.spells.saber  = math.random(  7, 10 )
			vars.npc_halazzi.spells.enrage = math.random( 12, 14 )
		end
		
		Unit:SendChatMessage( 14, 0, "Spirit, come back to me!" )
		Unit:PlaySoundToSet( 12022 )
		
		vars.npc_halazzi.child:Despawn( 1, 0 )
		vars.npc_halazzi.child = nil
		Unit:SetMaxHealth( vars.npc_halazzi.health.b )
		Unit:SetHealth( vars.npc_halazzi.health.a )
		Unit:SetModel( 21632 )
		setvars( Unit, vars )
		return true
	end
	
	return false
end

RegisterUnitEvent( 23577,  1, "npc_halazzi_event_combatenter" )
RegisterUnitEvent( 23577,  2, "npc_halazzi_event_combatleave" )
RegisterUnitEvent( 23577,  3, "npc_halazzi_event_combatkills" )
RegisterUnitEvent( 23577,  4, "npc_halazzi_event_combatdying" )
RegisterUnitEvent( 23577, 18, "npc_halazzi_event_spawn" )

--[[ SPIRIT OF THE LYNX ]]--
function npc_halazzilynxspirit_event_combatenter( Unit, Event )
  Unit:RegisterEvent( "npc_halazzilynxspirit_event_flurry", math.random( 3, 4 ) * 1000, 1 )
end

function npc_halazzilynxspirit_event_combatleave( Unit, Event )
  Unit:RemoveEvents( )
end

function npc_halazzilynxspirit_event_spawn( Unit, Event )
  local vars = getvars( Unit )
	
	vars.npc_halazzi.child = Unit
	Unit:SetTauntedBy( vars.npc_halazzi.owner:GetMainTank( ) )
	setvars( Unit, vars )
end

function npc_halazzilynxspirit_event_flurry( Unit, Event )
  Unit:CastSpell( 43290 )
	Unit:RegisterEvent( "npc_halazzilynxspirit_event_shred", math.random( 4, 5 ) * 1000, 1 )
end

function npc_halazzilynxspirit_event_shred( Unit, Event )
  Unit:FullCastSpellOnTarget( 43243, Unit:GetMainTank( ) )
	Unit:RegisterEvent( "npc_halazzilynxspirit_event_flurry", math.random( 3, 4 ) * 1000, 1 )
end

RegisterUnitEvent( 24143,  1, "npc_halazzilynxspirit_event_combatenter" )
RegisterUnitEvent( 24143,  2, "npc_halazzilynxspirit_event_combatleave" )
RegisterUnitEvent( 24143, 18, "npc_halazzilynxspirit_event_spawn" )

--[[ CORRUPTED LIGHTNING TOTEM ]]--
function npc_halazzitotem_event_combatenter( Unit, Event )
  Unit:RegisterEvent( "npc_halazzitotem_event_castlightning", math.random( 4, 6 ) * 1000, 1 )
end

function npc_halazzitotem_event_combatleave( Unit, Event )
  Unit:RemoveEvents( )
	Unit:Despawn( 1, 1 )
end

function npc_halazzitotem_event_spawn( Unit, Event )
  Unit:SetCombatCapable( 1 )
end

function npc_halazzitotem_event_castlightning( Unit, Event )
  Unit:FullCastSpellOnTarget( 43301, Unit:GetClosestPlayer( ) )
  Unit:RegisterEvent( "npc_halazzitotem_event_castlightning", math.random( 4, 6 ) * 1000, 1 )
end

RegisterUnitEvent( 24224,  1, "npc_halazzitotem_event_combatenter" )
RegisterUnitEvent( 24224,  2, "npc_halazzitotem_event_combatleave" )
RegisterUnitEvent( 24224, 18, "npc_halazzitotem_event_spawn" )
