--[[
   Original Code: Kenuvis                                                      
   ----------------------                               	              
   Dont delete our Credits!!!                                 
   Modified by darkalex								
-------------------------------------------------------------------------------
   LUAppArc Scripting Project. 								
   SVN: http://svn.assembla.com/svn/LUAppArc 						
   LOG: http://burning-azzinoth.de/arcemu/new/frontend/?t=2			
-------------------------------------------------------------------------------
  LUAppArc at rev5 or higher is needed by this script!! Else it WILL NOT WORK  
-----------------------------------------------------------------------------]]

--User Area
------------

--if someone wins, he would random get one of these items
Reward_Items = {15912345,15912346}

--size of one chessfield (developed for 6)
size = 6

--If all Units stop working, whatever happened, after this time, 
--it should be work again. (reset = true/false; time in ms)
reset = true
auto_reset_timer = 180000

--Time in milliseconds, until a Unit would be selected, during stand in the Unit
Select_Timer = 3000

--Time in seconds to move a NPC or select another
Pawn_Timer = 8
Castle_Timer = 10
Horse_Timer = 8
Bishop_Timer = 10
Queen_Timer = 10
King_Timer = 8

--NPC to start the Event (gossiptalk)
Start_NPC = *NPC ID*
--little Eventmanager (only for holding some functions)
Manage_NPC = *NPC ID*

--Lua
--
--CREATURE_EVENT_ON_ENTER_COMBAT = 1,
--CREATURE_EVENT_ON_LEAVE_COMBAT = 2,
--CREATURE_EVENT_ON_KILLED_TARGET = 3,
--CREATURE_EVENT_ON_DIED = 4,
--CREATURE_EVENT_AI_TICK = 5,
--CREATURE_EVENT_ON_SPAWN = 6,
--CREATURE_EVENT_ON_GOSSIP_TALK = 7,
--CREATURE_EVENT_ON_REACH_WP = 8,
--CREATURE_EVENT_ON_LEAVE_LIMBO = 9,
--CREATURE_EVENT_PLAYER_ENTERS_RANGE = 10,
--
--Lua++
--
--CREATURE_EVENT_ON_ENTER_COMBAT = 1,
--CREATURE_EVENT_ON_LEAVE_COMBAT = 2,
--CREATURE_EVENT_ON_TARGET_DIED = 3,
--CREATURE_EVENT_ON_DIED = 4,
--CREATURE_EVENT_ON_TARGET_PARRIED = 5,
--CREATURE_EVENT_ON_TARGET_DODGED = 6,
--CREATURE_EVENT_ON_TARGET_BLOCKED = 7,
--CREATURE_EVENT_ON_TARGET_CRIT_HIT = 8,
--CREATURE_EVENT_ON_PARRY = 9,
--CREATURE_EVENT_ON_DODGED = 10,
--CREATURE_EVENT_ON_BLOCKED = 11,
--CREATURE_EVENT_ON_CRIT_HIT = 12,
--CREATURE_EVENT_ON_HIT = 13,
--CREATURE_EVENT_ON_ASSIST_TARGET_DIED = 14,
--CREATURE_EVENT_ON_FEAR = 15,
--CREATURE_EVENT_ON_FLEE = 16,
--CREATURE_EVENT_ON_CALL_FOR_HELP = 17,
--CREATURE_EVENT_ON_LOAD = 18,
--CREATURE_EVENT_ON_REACH_WP = 19,
--CREATURE_EVENT_ON_LOOT_TAKEN = 20,
--CREATURE_EVENT_ON_AIUPDATE = 21,
--CREATURE_EVENT_ON_EMOTE = 22,
--CREATURE_EVENT_ON_DAMAGE_TAKEN = 23,

--if you want to flow your serverwindow with numbers and other things, change it to "true"
debug = false

------------------------
--User Area ends here!--
------------------------

RegisterUnitEvent(Manage_NPC, 18, "EventManage")
RegisterUnitGossipEvent(Start_NPC, 1, "EventStart")

RegisterUnitEvent(17469, 18, "Horde_Bauer")    --1
RegisterUnitEvent(21726, 18, "Horde_Turm")     --2
RegisterUnitEvent(21748, 18, "Horde_Pferd")    --3
RegisterUnitEvent(21747, 18, "Horde_Laufer")   --4
RegisterUnitEvent(21750, 18, "Horde_Konigin")  --5
RegisterUnitEvent(21752, 18, "Horde_Konig")    --6

RegisterUnitEvent(17211, 18, "Allianz_Bauer")  --7
RegisterUnitEvent(21160, 18, "Allianz_Turm")   --8
RegisterUnitEvent(21664, 18, "Allianz_Pferd")  --9
RegisterUnitEvent(21682, 18, "Allianz_Laufer") --10
RegisterUnitEvent(21683, 18, "Allianz_Konigin")--11
RegisterUnitEvent(21684, 18, "Allianz_Konig")  --12


Schachspiel = 0
Schachbrett = {}
Pos = {}
Pos2 = {}
en_passant = {}
Ply = 0

function EventManage(Unit)
	Schachbrett[9][4] = Unit
	Unit:RegisterEvent("auto_reset", auto_reset_timer, 0)
end	

function EventStart(Unit)
	if (Schachspiel ~= 0) then
		return
	end
		
	print "Schachevent start..."
	
	local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	
	-- Spieleranfang
	math.randomseed(os.time())
	for i=1,math.random(10,50),1 do
		Schachspiel = math.random(1,2)
	end
	if (Schachspiel == 1) then
		print "Horde start"
	else
	    print "Allianz start"
	end
	
	for a=1,8,1 do
		Schachbrett[a] = {}
		for b=1,8,1 do
			Schachbrett[a][b] = {}
			Schachbrett[a][b] = {0,0}
		end
	end
	

	-- Position des Schachfeld
	Schachbrett[9] = {}
	Schachbrett[9][1] = x - 3.5 * size
	Schachbrett[9][2] = y - 3.5 * size
	Schachbrett[9][3] = z

	print "Virtuelles Schachbrett init..."

		e1 = 3.5 * size
		e2 = 2.5 * size
		e3 = 1.5 * size
		e4 = 0.5 * size
	    -- spawn horde seite
		-- bauern
		Unit:SpawnCreature(17469, x+e1, y+e2, z, 4.680203, 35, 0)
		Unit:SpawnCreature(17469, x+e2, y+e2, z, 4.680203, 35, 0)
		Unit:SpawnCreature(17469, x+e3, y+e2, z, 4.680203, 35, 0)
		Unit:SpawnCreature(17469, x+e4, y+e2, z, 4.680203, 35, 0)
		Unit:SpawnCreature(17469, x-e4, y+e2, z, 4.680203, 35, 0)
		Unit:SpawnCreature(17469, x-e3, y+e2, z, 4.680203, 35, 0)
		Unit:SpawnCreature(17469, x-e2, y+e2, z, 4.680203, 35, 0)
		Unit:SpawnCreature(17469, x-e1, y+e2, z, 4.680203, 35, 0)
		-- türme
		Unit:SpawnCreature(21726, x+e1, y+e1, z, 4.680203, 35, 0)
		Unit:SpawnCreature(21726, x-e1, y+e1, z, 4.680203, 35, 0)
		-- pferd
		Unit:SpawnCreature(21748, x+e2, y+e1, z, 4.680203, 35, 0)
		Unit:SpawnCreature(21748, x-e2, y+e1, z, 4.680203, 35, 0) 
		-- läufer
		Unit:SpawnCreature(21747, x+e3, y+e1, z, 4.680203, 35, 0)
		Unit:SpawnCreature(21747, x-e3, y+e1, z, 4.680203, 35, 0) 
		-- königin
		Unit:SpawnCreature(21750, x+e4, y+e1, z, 4.680203, 35, 0) 
		-- könig
		Unit:SpawnCreature(21752, x-e4, y+e1, z, 4.680203, 35, 0)
		
		-- spawn allianz seite
		-- bauern
		Unit:SpawnCreature(17211, x+e1, y-e2, z, 1.562182, 35, 0)
		Unit:SpawnCreature(17211, x+e2, y-e2, z, 1.562182, 35, 0)
		Unit:SpawnCreature(17211, x+e3, y-e2, z, 1.562182, 35, 0)
		Unit:SpawnCreature(17211, x+e4, y-e2, z, 1.562182, 35, 0)
		Unit:SpawnCreature(17211, x-e4, y-e2, z, 1.562182, 35, 0)
		Unit:SpawnCreature(17211, x-e3, y-e2, z, 1.562182, 35, 0)
		Unit:SpawnCreature(17211, x-e2, y-e2, z, 1.562182, 35, 0)
		Unit:SpawnCreature(17211, x-e1, y-e2, z, 1.562182, 35, 0) 
		-- türme
		Unit:SpawnCreature(21160, x+e1, y-e1, z, 1.562182, 35, 0)
		Unit:SpawnCreature(21160, x-e1, y-e1, z, 1.562182, 35, 0)
		-- pferd
		Unit:SpawnCreature(21664, x+e2, y-e1, z, 1.562182, 35, 0)
		Unit:SpawnCreature(21664, x-e2, y-e1, z, 1.562182, 35, 0)
		-- läufer
		Unit:SpawnCreature(21682, x+e3, y-e1, z, 1.562182, 35, 0)
		Unit:SpawnCreature(21682, x-e3, y-e1, z, 1.562182, 35, 0)
		-- königin
		Unit:SpawnCreature(21683, x+e4, y-e1, z, 1.562182, 35, 0) 
		-- könig
		Unit:SpawnCreature(21684, x-e4, y-e1, z, 1.562182, 35, 0)
		
	print "Alle Schachfiguren gespawnt..."
	
	Unit:MoveTo(x - 4 * size, y, Unit:GetZ(), 6.235291) 
	Unit:SpawnCreature(Manage_NPC, x - 4 * size-0.5, y-0.5, Unit:GetZ(), 6.235291, 35, 0) 
end	

--------------------------------------------------
------       private functions Anfang       ------
--------------------------------------------------

function comparing(_x1, _y1, _x2, _y2)
	if (_x1 == _x2) and (_y1 == _y2) then
		return true
	else
		return false
	end
end

function xyi_Output(_Unit)
	if (_Unit == nil) then
		return 0,0,0
	end

	x = 0
	repeat
		x = x+1
		
		if (x > 8) then
			x = 0
			break
		end
	until (_Unit:GetX() < (Schachbrett[9][1]-size) + (x*size)+(size/2)) and (_Unit:GetX() > (Schachbrett[9][1]-size) + (x*size)-(size/2))

	y = 0
	repeat
		y = y+1
		
		if (y > 8) then
			y = 0
			break
		end	
	until(_Unit:GetY() > (Schachbrett[9][2]-size) + (y*size)-(size/2)) and (_Unit:GetY() < (Schachbrett[9][2]-size) + (y*size)+(size/2))
	
	i = 0
	if (x ~= 0) and (y ~= 0) then                     
		if (table.getn(Schachbrett[x][y]) > 1) then
			if (Schachbrett[x][y][2] < 7) and (Schachbrett[x][y][2] > 0) then
				i = 1
			elseif (Schachbrett[x][y][2] > 6) and (Schachbrett[x][y][2] < 13) then
				i = 2
			end
		end
	end
	
	return x, y, i
end

function Check_Feld(_x, _y)
	if (_x < 1) or (_y < 1) or (_x > 8) or (_y > 8) then
		return 3
	end
	
	printout(_x.._y)
	
	if (Schachbrett[_x][_y][2] == 0) then
		return 0
	end
	
	if (Schachbrett[_x][_y][2] < 7) then
		return 1
	end
	
	if (Schachbrett[_x][_y][2] > 6) then
		return 2
	end
	
	return 0
end

function display_board(_Unit, _time)
	for a=-(size/2),(7.5*size),size do
		for b=-(size/2),(7.5*size),size do
			_Unit:SpawnGameObject(1607, Schachbrett[9][1]+a, Schachbrett[9][2]+b, _Unit:GetZ(), 4.71, _time)
		end
	end
	
	c = 0
	
	for a = 0, 7*size, size do
		c = math.abs(c - size)
		for b = c, 7*size, size*2 do
			_Unit:SpawnGameObject(183320, Schachbrett[9][1]+a, Schachbrett[9][2]+b, _Unit:GetZ(), 4.71, _time)
		end
	end	
end	

function Select(_Unit)
	_Unit:CastSpell(32261)
		display_board(_Unit, 3000)
	printout("Select: ".._Unit:GetName())
end

function printout(_Text)
	if debug then
		print (_Text)
	end
end

--------------------------------------------------
------		private functions Ende			------
--------------------------------------------------

--------------------------------------------------
------			Steuerung @ testing			------
--------------------------------------------------

function Check(Unit)
	if (Schachspiel ~= 0) then
	
		Ply = Unit:GetClosestPlayer()
		local x,y = xyi_Output(Unit)
		
		if ((Schachbrett[x][y][2] < 7) and (Schachspiel == 1)) or ((Schachbrett[x][y][2] > 6) and (Schachspiel == 2)) then
			if (Ply ~= nil) then
			    xp,yp = xyi_Output(Ply)
			    x,y = xyi_Output(Unit)
				if comparing(xp, yp, x, y) then
					Schachbrett[x][y][1]:RemoveEvents()
					Schachbrett[x][y][1]:RegisterEvent("Timer", Select_Timer, 1)
				end
			end
		end
	end
end

function Timer(Unit)
	local x,y  = xyi_Output(Unit)
	local xp,yp = xyi_Output(Ply)
	
	printout("Timer: "..Unit:GetName())
	printout(Ply:GetName())
	printout("x "..x)
	printout("y "..y)
	printout("xp "..xp)
	printout("yp "..yp)
	
	if comparing(xp, yp, x, y) then
		Schachspiel = 0
		Select(Unit)
	    zahler = 0
	    
	    Unit:RemoveEvents()
	    Unit:RegisterEvent(Schachbrett[x][y][3][1], 1000, Schachbrett[x][y][3][2])
	    
		a = Schachbrett[x][y][3][2]/5
		if (math.floor(a+0.5) > 1) then
	       Unit:RegisterEvent("Select", 2000, math.floor(a+0.5))
		end
		
	else
		Unit:RegisterEvent("Check", 500, 0)
	end
end

function GoTo_Timer(Unit)
	local xp = Ply:GetX()
	local yp = Ply:GetY()
	
    
	printout("GoTo_Timer: "..Unit:GetName())
	printout(Ply:GetName())
	printout("x "..x)
	printout("y "..y)
	printout("xp "..xp)
	printout("yp "..yp)
	printout("Pos1 "..Pos[1])
	printout("Pos2 "..Pos[2])
    
	if (xp == Pos[1]) and (yp == Pos[2]) then
	   	local x, y, f = xyi_Output(Unit)

		-- reset the autoreset_timer
		printout("Autoreset_timer reset") 
	    Schachbrett[9][4]:RemoveEvents()
	    Schachbrett[9][4]:RegisterEvent("auto_reset", auto_reset_timer, 0)		
		
		Unit:RemoveEvents()
		
		enemy = -f+3
		

		if (Check_Feld(x+Pos[3], y+Pos[4]) == enemy) then
            Schachbrett[x+Pos[3]][y+Pos[4]][1]:RemoveEvents()
            
            if (Schachbrett[x+Pos[3]][y+Pos[4]][1] == 6) then
               math.randomseed(os.time())
			   Ply:Additem(Reward_Items[math.random(1,table.getn(Reward_Items))],1)
   			   
				Unit:SendChatMessage(12, 0, "Allianz wins")
			   Schachspiel = 0
			   Schachbrett[9][4]:RemoveEvents()
            elseif (Schachbrett[x+Pos[3]][y+Pos[4]][1] == 12) then
               math.randomseed(os.time())
			   Ply:Additem(Reward_Items[math.random(1,table.getn(Reward_Items))],1)
   			   
				Unit:SendChatMessage(12, 0, "Horde wins")
			   Schachspiel = 0
			   Schachbrett[9][4]:RemoveEvents()
            end 
			          
			Schachbrett[x+Pos[3]][y+Pos[4]][1]:Despawn(1,0)
		end

		xmove = Unit:GetX()+(Pos[3]*size)
		ymove = Unit:GetY()+(Pos[4]*size)
		Unit:MoveTo(xmove, ymove, Unit:GetZ(), Unit:GetO())
		
		Schachbrett[x+Pos[3]][y+Pos[4]] = {Schachbrett[x][y][1], Schachbrett[x][y][2], Schachbrett[x][y][3], false}
		Schachbrett[x][y] = {0,0}

        
		if (Pos[5] == "en passant input") then
		    en_passant = {Pos[6], Pos[7]}
		elseif (Pos[5] == "en passant kickout") then
			printout(en_passant[1])
			printout(en_passant[2]-Pos[4])
			Schachbrett[en_passant[1]][en_passant[2]-Pos[4]][1]:RemoveEvents()
			Schachbrett[en_passant[1]][en_passant[2]-Pos[4]][1]:Despawn(1,0)
			Schachbrett[en_passant[1]][en_passant[2]-Pos[4]] = {0,0}
			en_passant = {}
		else
			en_passant = {}
		end

		Schachspiel = enemy
		if (enemy == 2) then
			print "Allianz start"
		else
			print "Horde start"
		end
		who_is(Schachbrett[9][4])
		
		Pos = {}
        Unit:RegisterEvent("Check", 500, 0)
	end
end

function RegUnit(_Unit, _table)
	if (Schachspiel > 0) then
		printout("RegUnit: ".._Unit:GetName())
		_Unit:RegisterEvent("Check", 500, 0)
		_Unit:CastSpell(32261)

        x, y = xyi_Output(_Unit)
		Schachbrett[x][y] = _table
		
		_Unit:RegisterEvent("who_is", 500, 1)
		
		printout("x "..x)
		printout("y "..y)
	end
end

function who_is(_Unit)
	if (Schachspiel == 1) then
		_Unit:SendChatMessage(12,0,"Horde start")
	else
	    _Unit:SendChatMessage(12,0,"Allianz start")
	end	
end

function auto_reset(Unit)
	if reset and (Schachspiel ~= 0) then
	
		printout("Autoreset")
		
		for a=1,8,1 do
			for b=1,8,1 do
			    temp = Schachbrett[a][b]
			    Schachbrett[a][b] = {0,0}
				
				if (type(temp[1]) == "userdata") then
					printout("Field rewrite")
					Schachbrett[a][b] = temp
					Schachbrett[a][b][1]:RemoveEvents()
					Schachbrett[a][b][1]:RegisterEvent("Check", 500, 0)
				end
			end
		end
	end
end

--------------------------------------------------
------			Movements @ testing			------
--------------------------------------------------

function Queen_GoTo(Queen)
 	local x,y,f = xyi_Output(Queen)
 	local xp,yp = xyi_Output(Ply)

	zahler = zahler+1
	
	printout("Queen_GoTo: "..Queen:GetName())
	printout(Ply:GetName())
	printout("x "..x)
	printout("y "..y)
	printout("xp "..xp)
	printout("yp "..yp)
	printout("f "..f)
	printout("Zähler "..zahler)	

	if comparing(xp, yp, x, y) then
		Check(Queen)
	else
		if (xp < x) then
			xort = -1
		elseif (xp > x) then 
			xort = 1
		else
			xort = 0
		end
		
		if (yp < y) then
			yort = -1
		elseif (yp > y) then
			yort = 1
		else
			yort = 0
		end
	
		for i=1,7,1 do
			printout("i "..i)
			printout("Check_Feld "..Check_Feld(x+(i*xort),y+(i*yort)))
			printout(x+(i*xort))
			printout(y+(i*yort))
			printout(comparing(x+(i*xort),y+(i*yort), xp, yp))
			if (Check_Feld(x+(i*xort),y+(i*yort)) ~= f) and (comparing(x+(i*xort),y+(i*yort), xp, yp)) then
				Pos[1] = Ply:GetX()
				Pos[2] = Ply:GetY()
				Pos[3] = i*xort
				Pos[4] = i*yort
				Queen:RegisterEvent("GoTo_Timer", 900, 1)
				break
			elseif (Check_Feld(x+(i*xort),y+(i*yort)) ~= 0) then
				break
			end
		end
	end

	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		Queen:RemoveEvents()
		Queen:RegisterEvent("Check", 500, 0)
	end
end

function Pawn_GoTo(Pawn)
 	local x, y, f = xyi_Output(Pawn)
  	local xp,yp = xyi_Output(Ply)
	zahler = zahler+1
	
	i = f-(2*(1/f))
	
	printout("Pawn_GoTo: "..Pawn:GetName())
	printout(Ply:GetName())
	printout("x "..x)
	printout("y "..y)
	printout("xp "..xp)
	printout("yp "..yp)
	printout("i "..i)
	printout("f "..f)
	printout("Check_Feld "..Check_Feld(xp, yp))
	printout("Zähler "..zahler)
	
	if comparing(xp, yp, x, y) then
		Check(Pawn)
	elseif comparing(xp, yp, x-1, y+i) and (Check_Feld(x-1, y+i) == 2*(1/f)) then
		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
		Pos[3] = -1
		Pos[4] = i
		Pawn:RegisterEvent("GoTo_Timer", 900, 1)
	elseif comparing(xp, yp, x+1, y+i) and (Check_Feld(x+1, y+i) == 2*(1/f)) then
		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
		Pos[3] = 1
		Pos[4] = i
		Pawn:RegisterEvent("GoTo_Timer", 900, 1)
	elseif comparing(xp, yp, x, y+i) and (Check_Feld(x, y+i) == 0) then
  		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
     	Pos[3] = 0
     	Pos[4] = i
		Pawn:RegisterEvent("GoTo_Timer", 900, 1)
	elseif (Schachbrett[x][y][4]) and comparing(xp, yp, x, y+2*i) and (Check_Feld(x, y+2*i) == 0) then
  		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
		Pos[3] = 0
		Pos[4] = 2*i
		Pos[5] = "en passant input"
		Pos[6] = x
		Pos[7] = y+i
		Pawn:RegisterEvent("GoTo_Timer", 900, 1)
	elseif (en_passant ~= {}) then
	    if comparing(xp, yp, en_passant[1], en_passant[2]) and comparing(xp, yp, x-1, y+i) then
            Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = -1
			Pos[4] = i
			Pos[5] = "en passant kickout"
   			Pawn:RegisterEvent("GoTo_Timer", 900, 1)
		elseif comparing(xp, yp, en_passant[1], en_passant[2]) and comparing(xp, yp, x+1, y+i) then
            Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = 1
			Pos[4] = i
			Pos[5] = "en passant kickout"
   			Pawn:RegisterEvent("GoTo_Timer", 900, 1)
		end
	end
			

	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		Pawn:RemoveEvents()
		Pawn:RegisterEvent("Check", 500, 0)
	end		
end

function Castle_GoTo(Castle)
 	local x,y,f = xyi_Output(Castle)
 	local xp,yp = xyi_Output(Ply)
 	
 	local xort = 0
 	local yort = 0
	zahler = zahler+1

	printout("Castle_GoTo: "..Castle:GetName())
	printout(Ply:GetName())
	printout("x "..x)
	printout("y "..y)
	printout("xp "..xp)
	printout("yp "..yp)
	printout("f "..f)
	printout("Zähler "..zahler)
		
	if comparing(xp, yp, x, y) then
		Check(Castle)
	else
		if (x == xp) then
			if (yp < y) then
				yort = -1
			else
				yort = 1
			end
		elseif (yp == y) then
			if (xp < x) then
				xort = -1
			else
				xort = 1
			end
		end
			printout(xort)
			printout(yort)	
	end
		
	for i=1,7,1 do
		printout("i "..i)
		printout("Check_Feld "..Check_Feld(x+(i*xort),y+(i*yort)))
		printout(x+(i*xort))
		printout(y+(i*yort))
		printout(comparing(x+(i*xort),y+(i*yort), xp, yp))
		if (Check_Feld(x+(i*xort),y+(i*yort)) ~= f) and (comparing(x+(i*xort),y+(i*yort), xp, yp)) then
			Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = i*xort
			Pos[4] = i*yort
			Castle:RegisterEvent("GoTo_Timer", 900, 1)
			break
		elseif (Check_Feld(x+(i*xort),y+(i*yort)) ~= 0) then
			break
		end	
	end
	
	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		Castle:RemoveEvents()
		Castle:RegisterEvent("Check", 500, 0)
	end		
end	

function Horse_GoTo(Horse)
 	local x,y,f = xyi_Output(Horse)
 	local xp,yp = xyi_Output(Ply)
	zahler = zahler+1
		
	if comparing(xp, yp, x, y) then
		Timer(Horse)
	else
		if (Check_Feld(x+1, y-2) ~= f) and (math.abs(xp-x)+math.abs(yp-y) == 3) and ((math.abs(xp-x) == 1) or (math.abs(xp-x) == 2)) then
			Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = xp-x
			Pos[4] = yp-y
			Horse:RegisterEvent("GoTo_Timer", 900, 1)
		end
	end
	
	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = 2
		Horse:RemoveEvents()
		Horse:RegisterEvent("Check", 500, 0)
	end		
end	

function Bishop_GoTo(Bishop)
 	local x,y,f = xyi_Output(Bishop)
 	local xp,yp = xyi_Output(Ply)
	zahler = zahler+1

	if comparing(xp, yp, x, y) then
		Check(Bishop)
	else
	    if (xp < x) then
	    	xort = -1
	    else
	    	xort = 1
	    end
	    
	    if (yp < y) then
	    	yort = -1
	    else
	    	yort = 1
	    end
	    
	    for i=1,7,1 do
	    	if (Check_Feld(x+(i*xort),y+(i*yort)) ~= f) and (comparing(x+(i*xort),y+(i*yort), xp, yp)) then
				Pos[1] = Ply:GetX()
				Pos[2] = Ply:GetY()
				Pos[3] = i*xort
				Pos[4] = i*yort
				Bishop:RegisterEvent("GoTo_Timer", 900, 1)
				break
			elseif (Check_Feld(x+(i*xort),y+(i*yort)) ~= 0) then
				break
			end	
		end	    	
	end

	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		Bishop:RemoveEvents()
		Bishop:RegisterEvent("Check", 500, 0)
	end
end

function King_GoTo(King)
 	local x,y,f = xyi_Output(King)
 	local xp,yp = xyi_Output(Ply)
	zahler = zahler+1
	
	printout("King_GoTo: "..King:GetName())
	printout(Ply:GetName())
	printout("x "..x)
	printout("y "..y)
	printout("xp "..xp)
	printout("yp "..yp)
	printout("f "..f)
	printout("Zähler "..zahler)

	if comparing(xp, yp, x, y) then
		Check(King)
	else
		for i=-1,1,1 do
			for o=-1,1,1 do
				printout(i..o)
				printout(Check_Feld(x+i,y+o))
				printout(comparing(x+i,y+o, xp, yp))
		    	if (Check_Feld(x+i,y+o) ~= f) and (comparing(x+i,y+o, xp, yp)) then
					Pos[1] = Ply:GetX()
					Pos[2] = Ply:GetY()
					Pos[3] = i
					Pos[4] = o
					King:RegisterEvent("GoTo_Timer", 900, 1)
					break
				end
			end
		end

		if (Schachbrett[x][y][4]) then
		    printout("Rochade possible")
			if (f == 1) then
				a = 8
				b = 2
			else
			    a = 1
			    b = 8
			end
			
			printout(Schachbrett[xp][yp][2])
			printout(b)			
			
			if (Schachbrett[xp][yp][2] == b) then
		        if (xp == 8) then
		            printout(Schachbrett[6][a][1])
					printout(Schachbrett[6][a][1])
		            printout(Schachbrett[7][a][1])
					if (Schachbrett[5][a][1] == 0) and (Schachbrett[6][a][1] == 0) and (Schachbrett[7][a][1] == 0) then
				        Pos[1] = Ply:GetX()
						Pos[2] = Ply:GetY()
						Pos[3] = 2
						Pos[4] = 0
						
				        Pos2 = {}
						Pos2[1] = Ply:GetX()
						Pos2[2] = Ply:GetY()
						Pos2[3] = -3
						Pos2[4] = 0
						Pos2[5] = Schachbrett[xp][yp]
						
						King:RegisterEvent("GoTo_Timer", 950, 1)
						King:RegisterEvent("Rochade", 900, 1)
					end
				else
					printout(Schachbrett[2][a][1])
		            printout(Schachbrett[3][a][1])
				    if (Schachbrett[3][a][1] == 0) and (Schachbrett[2][a][1] == 0) then
				        Pos[1] = Ply:GetX()
						Pos[2] = Ply:GetY()
						Pos[3] = -2
						Pos[4] = 0
						
				        Pos2 = {}
						Pos2[1] = Ply:GetX()
						Pos2[2] = Ply:GetY()
						Pos2[3] = 2
						Pos2[4] = 0
						Pos2[5] = Schachbrett[xp][yp]
						
						King:RegisterEvent("GoTo_Timer", 950, 1)
						King:RegisterEvent("Rochade", 900, 1)
					end
				end 
			end
		end
	end

	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		King:RemoveEvents()
		King:RegisterEvent("Check", 500, 0)
	end
end

function Rochade(Unit)
	local xp,yp = xyi_Output(Ply)
	local x,y = xyi_Output(Schachbrett[xp][yp][1])
	
	printout("Rochade")
	printout("xp "..xp)
	printout("yp "..yp)
	printout("Pos2[1] "..Pos2[1])
	printout("Pos2[2] "..Pos2[2])
	

	if comparing(Ply:GetX(), Ply:GetY(), Pos2[1], Pos2[2]) then

		xmove = Schachbrett[xp][yp][1]:GetX()+(Pos2[3]*size)
		ymove = Schachbrett[xp][yp][1]:GetY()+(Pos2[4]*size)
		Schachbrett[xp][yp][1]:MoveTo(xmove, ymove, Schachbrett[xp][yp][1]:GetZ(), Schachbrett[xp][yp][1]:GetO())
		
		Schachbrett[x+Pos2[3]][y+Pos2[4]] = {Schachbrett[x][y][1], Schachbrett[x][y][2], Schachbrett[x][y][3], false}
		Schachbrett[x][y] = {0,0}     
	end
end
	
--------------------------------------------------
------			Unit Registration			------
--------------------------------------------------
   
function Horde_Bauer(Unit)
	RegUnit(Unit, {Unit, 1, {"Pawn_GoTo", Pawn_Timer}, true})       
end
   
function Horde_Turm(Unit)
	RegUnit(Unit, {Unit, 2, {"Castle_GoTo", Castle_Timer}, true})
end

function Horde_Pferd(Unit)
	RegUnit(Unit, {Unit, 3, {"Horse_GoTo", Horse_Timer}})
end

function Horde_Laufer(Unit)
	RegUnit(Unit, {Unit, 4, {"Bishop_GoTo", Bishop_Timer}})
end

function Horde_Konigin(Unit)
	RegUnit(Unit, {Unit, 5, {"Queen_GoTo", Queen_Timer}})
end

function Horde_Konig(Unit)
	RegUnit(Unit, {Unit, 6, {"King_GoTo", King_Timer}, true})
end

function Allianz_Bauer(Unit)
	RegUnit(Unit, {Unit, 7, {"Pawn_GoTo", Pawn_Timer}, true})
end
   
function Allianz_Turm(Unit)
	RegUnit(Unit, {Unit, 8, {"Castle_GoTo", Castle_Timer}, true})
end

function Allianz_Pferd(Unit)
	RegUnit(Unit, {Unit, 9, {"Horse_GoTo", Horse_Timer}})
end

function Allianz_Laufer(Unit)
	RegUnit(Unit, {Unit, 10, {"Bishop_GoTo", Bishop_Timer}})
end

function Allianz_Konigin(Unit)
	RegUnit(Unit, {Unit, 11, {"Queen_GoTo", Queen_Timer}})
end

function Allianz_Konig(Unit)
	RegUnit(Unit, {Unit, 12, {"King_GoTo", King_Timer}, true})
end
