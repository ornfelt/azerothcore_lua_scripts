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
Start_NPC = 295
--little Eventmanager (only for holding some functions)
Manage_NPC = 295
--IDs of the chess pieces for horde and alliance
local HordeCreatureIDs = {
17469,--pawn
21726,--rook
21748,--knight
21747,--bishop
21750,--queen
21752,--king
}
local AllianceCreatureIDs = {
17211,--pawn
21160,--rook
21664,--knight
21682,--bishop
21683,--queen
21684,--king
}
--if you want to flow your serverwindow with numbers and other things, change it to "true"
debug = true


--dont edit below unless you're Tester
Chess_Set = 0
Chessboard = {}
Pos = {}
Pos2 = {}
inpass = {}
Ply = 0

function EventManage(event, Unit)
	Chessboard[9][4] = Unit
	Unit:RegisterEvent(auto_reset, auto_reset_timer, 0)
end	

function EventStart(event, player, object)
	if (Chess_Set ~= 0) then
		return
	end
		
	print "event start..."
	
	local x = player:GetX()
	local y = player:GetY()
	local z = player:GetZ()
	
	-- Spieleranfang
	math.randomseed(os.time())
	for i=1,math.random(10,50),1 do
		Chess_Set = math.random(1,2)
	end
	if (Chess_Set == 1) then
		print "Horde start"
	else
	    print "Alliance start"
	end
	
	for a=1,8,1 do
		Chessboard[a] = {}
		for b=1,8,1 do
			Chessboard[a][b] = {}
			Chessboard[a][b] = {0,0}
		end
	end
	

	-- Position des SchachField
	Chessboard[9] = {}
	Chessboard[9][1] = x - 3.5 * size
	Chessboard[9][2] = y - 3.5 * size
	Chessboard[9][3] = z

	print "virtual Chessboard start..."

		e1 = 3.5 * size
		e2 = 2.5 * size
		e3 = 1.5 * size
		e4 = 0.5 * size
	    -- spawn horde seite
		-- Pawn
		player:SpawnCreature(17469, x+e1, y+e2, z, 4.680203, 5, 0)
		player:SpawnCreature(17469, x+e2, y+e2, z, 4.680203, 5, 0)
		player:SpawnCreature(17469, x+e3, y+e2, z, 4.680203, 5, 0)
		player:SpawnCreature(17469, x+e4, y+e2, z, 4.680203, 5, 0)
		player:SpawnCreature(17469, x-e4, y+e2, z, 4.680203, 5, 0)
		player:SpawnCreature(17469, x-e3, y+e2, z, 4.680203, 5, 0)
		player:SpawnCreature(17469, x-e2, y+e2, z, 4.680203, 5, 0)
		player:SpawnCreature(17469, x-e1, y+e2, z, 4.680203, 5, 0)
		-- Rook
		player:SpawnCreature(21726, x+e1, y+e1, z, 4.680203, 5, 0)
		player:SpawnCreature(21726, x-e1, y+e1, z, 4.680203, 5, 0)
		-- Knight
		player:SpawnCreature(21748, x+e2, y+e1, z, 4.680203, 5, 0)
		player:SpawnCreature(21748, x-e2, y+e1, z, 4.680203, 5, 0) 
		-- Bishop
		player:SpawnCreature(21747, x+e3, y+e1, z, 4.680203, 5, 0)
		player:SpawnCreature(21747, x-e3, y+e1, z, 4.680203, 5, 0) 
		-- Queen
		player:SpawnCreature(21750, x+e4, y+e1, z, 4.680203, 5, 0) 
		-- King
		player:SpawnCreature(21752, x-e4, y+e1, z, 4.680203, 5, 0)
		
		-- spawn alliance seite
		-- Pawn
		player:SpawnCreature(17211, x+e1, y-e2, z, 1.562182, 5, 0)
		player:SpawnCreature(17211, x+e2, y-e2, z, 1.562182, 5, 0)
		player:SpawnCreature(17211, x+e3, y-e2, z, 1.562182, 5, 0)
		player:SpawnCreature(17211, x+e4, y-e2, z, 1.562182, 5, 0)
		player:SpawnCreature(17211, x-e4, y-e2, z, 1.562182, 5, 0)
		player:SpawnCreature(17211, x-e3, y-e2, z, 1.562182, 5, 0)
		player:SpawnCreature(17211, x-e2, y-e2, z, 1.562182, 5, 0)
		player:SpawnCreature(17211, x-e1, y-e2, z, 1.562182, 5, 0) 
		-- Rook
		player:SpawnCreature(21160, x+e1, y-e1, z, 1.562182, 5, 0)
		player:SpawnCreature(21160, x-e1, y-e1, z, 1.562182, 5, 0)
		-- Knight
		player:SpawnCreature(21664, x+e2, y-e1, z, 1.562182, 5, 0)
		player:SpawnCreature(21664, x-e2, y-e1, z, 1.562182, 5, 0)
		-- Bishop
		player:SpawnCreature(21682, x+e3, y-e1, z, 1.562182, 5, 0)
		player:SpawnCreature(21682, x-e3, y-e1, z, 1.562182, 5, 0)
		-- Queen
		player:SpawnCreature(21683, x+e4, y-e1, z, 1.562182, 5, 0) 
		-- King
		player:SpawnCreature(21684, x-e4, y-e1, z, 1.562182, 5, 0)
		
	print "All chess pieces spawned..."
	
	player:MoveTo(2,x - 4 * size, y, player:GetZ(), true) 
	player:SpawnCreature(Manage_NPC, x - 4 * size-0.5, y-0.5, player:GetZ(), 6.235291, 5, 0) 
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
	until (_Unit:GetX() < (Chessboard[9][1]-size) + (x*size)+(size/2)) and (_Unit:GetX() > (Chessboard[9][1]-size) + (x*size)-(size/2))

	y = 0
	repeat
		y = y+1
		
		if (y > 8) then
			y = 0
			break
		end	
	until(_Unit:GetY() > (Chessboard[9][2]-size) + (y*size)-(size/2)) and (_Unit:GetY() < (Chessboard[9][2]-size) + (y*size)+(size/2))
	
	i = 0
	if (x ~= 0) and (y ~= 0) then                     
		if (#Chessboard[x][y] > 1) then
			if (Chessboard[x][y][2] < 7) and (Chessboard[x][y][2] > 0) then
				i = 1
			elseif (Chessboard[x][y][2] > 6) and (Chessboard[x][y][2] < 13) then
				i = 2
			end
		end
	end
	
	return x, y, i
end

function Check_Field(_x, _y)
	if (_x < 1) or (_y < 1) or (_x > 8) or (_y > 8) then
		return 3
	end
	
	print(_x.._y)
	
	if (Chessboard[_x][_y][2] == 0) then
		return 0
	end
	
	if (Chessboard[_x][_y][2] < 7) then
		return 1
	end
	
	if (Chessboard[_x][_y][2] > 6) then
		return 2
	end
	
	return 0
end

function display_board(_Unit, _time)
	for a=-(size/2),(7.5*size),size do
		for b=-(size/2),(7.5*size),size do
			_Unit:SummonGameObject(1607, Chessboard[9][1]+a, Chessboard[9][2]+b, _Unit:GetZ(), 4.71, _time)
		end
	end
	
	c = 0
	
	for a = 0, 7*size, size do
		c = math.abs(c - size)
		for b = c, 7*size, size*2 do
			_Unit:SummonGameObject(183320, Chessboard[9][1]+a, Chessboard[9][2]+b, _Unit:GetZ(), 4.71, _time)
		end
	end	
end	

function Select(_Unit)
	_Unit:CastSpell(32261)
		display_board(_Unit, 3000)
	print("Select: ".._Unit:GetName())
end


--------------------------------------------------
------		private functions Ende			------
--------------------------------------------------

--------------------------------------------------
------			Steuerung @ testing			------
--------------------------------------------------

function Check(eventid, delay, repeats, Unit)
	if (Chess_Set ~= 0) then

		Ply = Unit:GetPlayersInRange()[1]
		local x,y = xyi_Output(Unit)
		
		if ((Chessboard[x][y][2] < 7) and (Chess_Set == 1)) or ((Chessboard[x][y][2] > 6) and (Chess_Set == 2)) then
			if (Ply ~= nil) then
			    xp,yp = xyi_Output(Ply)
			    x,y = xyi_Output(Unit)
				if comparing(xp, yp, x, y) then
					Chessboard[x][y][1]:RemoveEvents()
					Chessboard[x][y][1]:RegisterEvent(Timer, Select_Timer, 1)
				end
			end
		end
	end
end

function Timer(Unit)
	local x,y  = xyi_Output(Unit)
	local xp,yp = xyi_Output(Ply)
	
	print("Timer: "..Unit:GetName())
	print(Ply:GetName())
	print("x "..x)
	print("y "..y)
	print("xp "..xp)
	print("yp "..yp)
	
	if comparing(xp, yp, x, y) then
		Chess_Set = 0
		Select(Unit)
	    counter = 0
	    
	    Unit:RemoveEvents()
	    Unit:RegisterEvent(Chessboard[x][y][3][1], 1000, Chessboard[x][y][3][2])
	    
		a = Chessboard[x][y][3][2]/5
		if (math.floor(a+0.5) > 1) then
	       Unit:RegisterEvent(Select, 2000, math.floor(a+0.5))
		end
		
	else
		Unit:RegisterEvent(Check, 500, 0)
	end
end

function GoTo_Timer(Unit)
	local xp = Ply:GetX()
	local yp = Ply:GetY()
	
    
	print("GoTo_Timer: "..Unit:GetName())
	print(Ply:GetName())
	print("x "..x)
	print("y "..y)
	print("xp "..xp)
	print("yp "..yp)
	print("Pos1 "..Pos[1])
	print("Pos2 "..Pos[2])
    
	if (xp == Pos[1]) and (yp == Pos[2]) then
	   	local x, y, f = xyi_Output(Unit)

		-- reset the autoreset_timer
		print("Autoreset_timer reset") 
	    Chessboard[9][4]:RemoveEvents()
	    Chessboard[9][4]:RegisterEvent(auto_reset, auto_reset_timer, 0)		
		
		Unit:RemoveEvents()
		
		enemy = -f+3
		

		if (Check_Field(x+Pos[3], y+Pos[4]) == enemy) then
            Chessboard[x+Pos[3]][y+Pos[4]][1]:RemoveEvents()
            
            if (Chessboard[x+Pos[3]][y+Pos[4]][1] == 6) then
               math.randomseed(os.time())
			   Ply:Additem(Reward_Items[math.random(1,table.getn(Reward_Items))],1)
   			   
				Unit:SendChatMessage(12, 0, "Alliance wins")
			   Chess_Set = 0
			   Chessboard[9][4]:RemoveEvents()
            elseif (Chessboard[x+Pos[3]][y+Pos[4]][1] == 12) then
               math.randomseed(os.time())
			   Ply:Additem(Reward_Items[math.random(1,table.getn(Reward_Items))],1)
   			   
				Unit:SendChatMessage(12, 0, "Horde wins")
			   Chess_Set = 0
			   Chessboard[9][4]:RemoveEvents()
            end 
			          
			Chessboard[x+Pos[3]][y+Pos[4]][1]:Despawn(1,0)
		end

		xmove = Unit:GetX()+(Pos[3]*size)
		ymove = Unit:GetY()+(Pos[4]*size)
		Unit:MoveTo(1,xmove, ymove, Unit:GetZ(),true)
		
		Chessboard[x+Pos[3]][y+Pos[4]] = {Chessboard[x][y][1], Chessboard[x][y][2], Chessboard[x][y][3], false}
		Chessboard[x][y] = {0,0}

        
		if (Pos[5] == "in pass input") then
		    inpass = {Pos[6], Pos[7]}
		elseif (Pos[5] == "in pass kickout") then
			print(inpass[1])
			print(inpass[2]-Pos[4])
			Chessboard[inpass[1]][inpass[2]-Pos[4]][1]:RemoveEvents()
			Chessboard[inpass[1]][inpass[2]-Pos[4]][1]:Despawn(1,0)
			Chessboard[inpass[1]][inpass[2]-Pos[4]] = {0,0}
			inpass = {}
		else
			inpass = {}
		end

		Chess_Set = enemy
		if (enemy == 2) then
			print "Alliance start"
		else
			print "Horde start"
		end
		who_is(Chessboard[9][4])
		
		Pos = {}
        Unit:RegisterEvent(Check, 500, 0)
	end
end

function RegUnit(_Unit, _table)
	if (Chess_Set > 0) then
		print("RegUnit: ".._Unit:GetName())
		_Unit:RegisterEvent(Check, 500, 0)
		_Unit:CastSpell(_Unit,32261,true)

        x, y = xyi_Output(_Unit)
		Chessboard[x][y] = _table
		
		_Unit:RegisterEvent(who_is, 500, 1)
	end
end

function who_is(eventid, delay, repeats, _Unit)
	if (Chess_Set == 1) then
		_Unit:SendUnitSay("Horde start",1)
	else
	    _Unit:SendUnitSay("Alliance start",1)
	end	
end

function auto_reset(Unit)
	if reset and (Chess_Set ~= 0) then
		print("Autoreset")		
		for a=1,8,1 do
			for b=1,8,1 do
			    temp = Chessboard[a][b]
			    Chessboard[a][b] = {0,0}
				
				if (type(temp[1]) == "userdata") then
					print("Field rewrite")
					Chessboard[a][b] = temp
					Chessboard[a][b][1]:RemoveEvents()
					Chessboard[a][b][1]:RegisterEvent(Check, 500, 0)
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

	counter = counter+1
	
	print("Queen_GoTo: "..Queen:GetName())
	print(Ply:GetName())
	print("x "..x)
	print("y "..y)
	print("xp "..xp)
	print("yp "..yp)
	print("f "..f)
	print("counter "..counter)	

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
			print("i "..i)
			print("Check_Field "..Check_Field(x+(i*xort),y+(i*yort)))
			print(x+(i*xort))
			print(y+(i*yort))
			print(comparing(x+(i*xort),y+(i*yort), xp, yp))
			if (Check_Field(x+(i*xort),y+(i*yort)) ~= f) and (comparing(x+(i*xort),y+(i*yort), xp, yp)) then
				Pos[1] = Ply:GetX()
				Pos[2] = Ply:GetY()
				Pos[3] = i*xort
				Pos[4] = i*yort
				Queen:RegisterEvent(GoTo_Timer, 900, 1)
				break
			elseif (Check_Field(x+(i*xort),y+(i*yort)) ~= 0) then
				break
			end
		end
	end

	if (Chess_Set == 0) and (counter == Chessboard[x][y][3][2]) then
		Chess_Set = f
		Queen:RemoveEvents()
		Queen:RegisterEvent(Check, 500, 0)
	end
end

function Pawn_GoTo(Pawn)
 	local x, y, f = xyi_Output(Pawn)
  	local xp,yp = xyi_Output(Ply)
	counter = counter+1
	
	i = f-(2*(1/f))
	
	print("Pawn_GoTo: "..Pawn:GetName())
	print(Ply:GetName())
	print("x "..x)
	print("y "..y)
	print("xp "..xp)
	print("yp "..yp)
	print("i "..i)
	print("f "..f)
	print("Check_Field "..Check_Field(xp, yp))
	print("counter "..counter)
	
	if comparing(xp, yp, x, y) then
		Check(Pawn)
	elseif comparing(xp, yp, x-1, y+i) and (Check_Field(x-1, y+i) == 2*(1/f)) then
		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
		Pos[3] = -1
		Pos[4] = i
		Pawn:RegisterEvent(GoTo_Timer, 900, 1)
	elseif comparing(xp, yp, x+1, y+i) and (Check_Field(x+1, y+i) == 2*(1/f)) then
		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
		Pos[3] = 1
		Pos[4] = i
		Pawn:RegisterEvent(GoTo_Timer, 900, 1)
	elseif comparing(xp, yp, x, y+i) and (Check_Field(x, y+i) == 0) then
  		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
     	Pos[3] = 0
     	Pos[4] = i
		Pawn:RegisterEvent(GoTo_Timer, 900, 1)
	elseif (Chessboard[x][y][4]) and comparing(xp, yp, x, y+2*i) and (Check_Field(x, y+2*i) == 0) then
  		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
		Pos[3] = 0
		Pos[4] = 2*i
		Pos[5] = "in pass input"
		Pos[6] = x
		Pos[7] = y+i
		Pawn:RegisterEvent(GoTo_Timer, 900, 1)
	elseif (inpass ~= {}) then
	    if comparing(xp, yp, inpass[1], inpass[2]) and comparing(xp, yp, x-1, y+i) then
            Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = -1
			Pos[4] = i
			Pos[5] = "in pass kickout"
   			Pawn:RegisterEvent(GoTo_Timer, 900, 1)
		elseif comparing(xp, yp, inpass[1], inpass[2]) and comparing(xp, yp, x+1, y+i) then
            Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = 1
			Pos[4] = i
			Pos[5] = "in pass kickout"
   			Pawn:RegisterEvent(GoTo_Timer, 900, 1)
		end
	end
			

	if (Chess_Set == 0) and (counter == Chessboard[x][y][3][2]) then
		Chess_Set = f
		Pawn:RemoveEvents()
		Pawn:RegisterEvent(Check, 500, 0)
	end		
end

function Castle_GoTo(Castle)
 	local x,y,f = xyi_Output(Castle)
 	local xp,yp = xyi_Output(Ply)
 	
 	local xort = 0
 	local yort = 0
	counter = counter+1

	print("Castle_GoTo: "..Castle:GetName())
	print(Ply:GetName())
	print("x "..x)
	print("y "..y)
	print("xp "..xp)
	print("yp "..yp)
	print("f "..f)
	print("counter "..counter)
		
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
			print(xort)
			print(yort)	
	end
		
	for i=1,7,1 do
		print("i "..i)
		print("Check_Field "..Check_Field(x+(i*xort),y+(i*yort)))
		print(x+(i*xort))
		print(y+(i*yort))
		print(comparing(x+(i*xort),y+(i*yort), xp, yp))
		if (Check_Field(x+(i*xort),y+(i*yort)) ~= f) and (comparing(x+(i*xort),y+(i*yort), xp, yp)) then
			Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = i*xort
			Pos[4] = i*yort
			Castle:RegisterEvent(GoTo_Timer, 900, 1)
			break
		elseif (Check_Field(x+(i*xort),y+(i*yort)) ~= 0) then
			break
		end	
	end
	
	if (Chess_Set == 0) and (counter == Chessboard[x][y][3][2]) then
		Chess_Set = f
		Castle:RemoveEvents()
		Castle:RegisterEvent(Check, 500, 0)
	end		
end	

function Horse_GoTo(Horse)
 	local x,y,f = xyi_Output(Horse)
 	local xp,yp = xyi_Output(Ply)
	counter = counter+1
		
	if comparing(xp, yp, x, y) then
		Timer(Horse)
	else
		if (Check_Field(x+1, y-2) ~= f) and (math.abs(xp-x)+math.abs(yp-y) == 3) and ((math.abs(xp-x) == 1) or (math.abs(xp-x) == 2)) then
			Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = xp-x
			Pos[4] = yp-y
			Horse:RegisterEvent(GoTo_Timer, 900, 1)
		end
	end
	
	if (Chess_Set == 0) and (counter == Chessboard[x][y][3][2]) then
		Chess_Set = 2
		Horse:RemoveEvents()
		Horse:RegisterEvent(Check, 500, 0)
	end		
end	

function Bishop_GoTo(Bishop)
 	local x,y,f = xyi_Output(Bishop)
 	local xp,yp = xyi_Output(Ply)
	counter = counter+1

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
	    	if (Check_Field(x+(i*xort),y+(i*yort)) ~= f) and (comparing(x+(i*xort),y+(i*yort), xp, yp)) then
				Pos[1] = Ply:GetX()
				Pos[2] = Ply:GetY()
				Pos[3] = i*xort
				Pos[4] = i*yort
				Bishop:RegisterEvent(GoTo_Timer, 900, 1)
				break
			elseif (Check_Field(x+(i*xort),y+(i*yort)) ~= 0) then
				break
			end	
		end	    	
	end

	if (Chess_Set == 0) and (counter == Chessboard[x][y][3][2]) then
		Chess_Set = f
		Bishop:RemoveEvents()
		Bishop:RegisterEvent(Check, 500, 0)
	end
end

function King_GoTo(King)
 	local x,y,f = xyi_Output(King)
 	local xp,yp = xyi_Output(Ply)
	counter = counter+1
	
	print("King_GoTo: "..King:GetName())
	print(Ply:GetName())
	print("x "..x)
	print("y "..y)
	print("xp "..xp)
	print("yp "..yp)
	print("f "..f)
	print("counter "..counter)

	if comparing(xp, yp, x, y) then
		Check(King)
	else
		for i=-1,1,1 do
			for o=-1,1,1 do
				print(i..o)
				print(Check_Field(x+i,y+o))
				print(comparing(x+i,y+o, xp, yp))
		    	if (Check_Field(x+i,y+o) ~= f) and (comparing(x+i,y+o, xp, yp)) then
					Pos[1] = Ply:GetX()
					Pos[2] = Ply:GetY()
					Pos[3] = i
					Pos[4] = o
					King:RegisterEvent(GoTo_Timer, 900, 1)
					break
				end
			end
		end

		if (Chessboard[x][y][4]) then
		    print("castling possible")
			if (f == 1) then
				a = 8
				b = 2
			else
			    a = 1
			    b = 8
			end
			
			print(Chessboard[xp][yp][2])
			print(b)			
			
			if (Chessboard[xp][yp][2] == b) then
		        if (xp == 8) then
		            print(Chessboard[6][a][1])
					print(Chessboard[6][a][1])
		            print(Chessboard[7][a][1])
					if (Chessboard[5][a][1] == 0) and (Chessboard[6][a][1] == 0) and (Chessboard[7][a][1] == 0) then
				        Pos[1] = Ply:GetX()
						Pos[2] = Ply:GetY()
						Pos[3] = 2
						Pos[4] = 0
						
				        Pos2 = {}
						Pos2[1] = Ply:GetX()
						Pos2[2] = Ply:GetY()
						Pos2[3] = -3
						Pos2[4] = 0
						Pos2[5] = Chessboard[xp][yp]
						
						King:RegisterEvent(GoTo_Timer, 950, 1)
						King:RegisterEvent(Castling, 900, 1)
					end
				else
					print(Chessboard[2][a][1])
		            print(Chessboard[3][a][1])
				    if (Chessboard[3][a][1] == 0) and (Chessboard[2][a][1] == 0) then
				        Pos[1] = Ply:GetX()
						Pos[2] = Ply:GetY()
						Pos[3] = -2
						Pos[4] = 0
						
				        Pos2 = {}
						Pos2[1] = Ply:GetX()
						Pos2[2] = Ply:GetY()
						Pos2[3] = 2
						Pos2[4] = 0
						Pos2[5] = Chessboard[xp][yp]
						
						King:RegisterEvent(GoTo_Timer, 950, 1)
						King:RegisterEvent(Castling, 900, 1)
					end
				end 
			end
		end
	end

	if (Chess_Set == 0) and (counter == Chessboard[x][y][3][2]) then
		Chess_Set = f
		King:RemoveEvents()
		King:RegisterEvent(Check, 500, 0)
	end
end

function Castling(Unit)
	local xp,yp = xyi_Output(Ply)
	local x,y = xyi_Output(Chessboard[xp][yp][1])
	
	print(Castling)
	print("xp "..xp)
	print("yp "..yp)
	print("Pos2[1] "..Pos2[1])
	print("Pos2[2] "..Pos2[2])
	

	if comparing(Ply:GetX(), Ply:GetY(), Pos2[1], Pos2[2]) then

		xmove = Chessboard[xp][yp][1]:GetX()+(Pos2[3]*size)
		ymove = Chessboard[xp][yp][1]:GetY()+(Pos2[4]*size)
		Chessboard[xp][yp][1]:MoveTo(3,xmove, ymove, Chessboard[xp][yp][1]:GetZ(), true)
		
		Chessboard[x+Pos2[3]][y+Pos2[4]] = {Chessboard[x][y][1], Chessboard[x][y][2], Chessboard[x][y][3], false}
		Chessboard[x][y] = {0,0}     
	end
end
	
--------------------------------------------------
------			Unit Registration			------
--------------------------------------------------
   
function Horde_Pawn(event, Unit)
	RegUnit(Unit, {Unit, 1, {"Pawn_GoTo", Pawn_Timer}, true})       
end
   
function Horde_Rook(event, Unit)
	RegUnit(Unit, {Unit, 2, {"Castle_GoTo", Castle_Timer}, true})
end

function Horde_Knight(event, Unit)
	RegUnit(Unit, {Unit, 3, {"Horse_GoTo", Horse_Timer}})
end

function Horde_Bishop(event, Unit)
	RegUnit(Unit, {Unit, 4, {"Bishop_GoTo", Bishop_Timer}})
end

function Horde_Queen(event, Unit)
	RegUnit(Unit, {Unit, 5, {"Queen_GoTo", Queen_Timer}})
end

function Horde_King(event, Unit)
	RegUnit(Unit, {Unit, 6, {"King_GoTo", King_Timer}, true})
end

function Alliance_Pawn(event, Unit)
	RegUnit(Unit, {Unit, 7, {"Pawn_GoTo", Pawn_Timer}, true})
end
   
function Alliance_Rook(event, Unit)
	RegUnit(Unit, {Unit, 8, {"Castle_GoTo", Castle_Timer}, true})
end

function Alliance_Knight(event, Unit)
	RegUnit(Unit, {Unit, 9, {"Horse_GoTo", Horse_Timer}})
end

function Alliance_Bishop(event, Unit)
	RegUnit(Unit, {Unit, 10, {"Bishop_GoTo", Bishop_Timer}})
end

function Alliance_Queen(event, Unit)
	RegUnit(Unit, {Unit, 11, {"Queen_GoTo", Queen_Timer}})
end

function Alliance_King(event, Unit)
	RegUnit(Unit, {Unit, 12, {"King_GoTo", King_Timer}, true})
end

RegisterCreatureEvent(Manage_NPC, 5, EventManage)
RegisterCreatureGossipEvent(Start_NPC, 1, EventStart)

RegisterCreatureEvent(HordeCreatureIDs[1], 5, Horde_Pawn)    --1
RegisterCreatureEvent(HordeCreatureIDs[2], 5, Horde_Rook)     --2
RegisterCreatureEvent(HordeCreatureIDs[3], 5, Horde_Knight)    --3
RegisterCreatureEvent(HordeCreatureIDs[4], 5, Horde_Bishop)   --4
RegisterCreatureEvent(HordeCreatureIDs[5], 5, Horde_Queen)  --5
RegisterCreatureEvent(HordeCreatureIDs[6], 5, Horde_King)    --6

RegisterCreatureEvent(AllianceCreatureIDs[1], 5, Alliance_Pawn)  --7
RegisterCreatureEvent(AllianceCreatureIDs[2], 5, Alliance_Rook)   --8
RegisterCreatureEvent(AllianceCreatureIDs[3], 5, Alliance_Knight)  --9
RegisterCreatureEvent(AllianceCreatureIDs[4], 5, Alliance_Bishop) --10
RegisterCreatureEvent(AllianceCreatureIDs[5], 5, Alliance_Queen)--11
RegisterCreatureEvent(AllianceCreatureIDs[6], 5, Alliance_King)  --12
