realTime = gapTime*24*60*60*1000 -- no touch
local npcID = 232323
local gapTime = 2 --days till reset
local fileName = "lastTime.txt"

local function UpdateAH()
VendorRemoveAllItems(npcID)
local Q = WorldDBQuery("SELECT item, count, incrtime, extended FROM black_market ORDER BY RAND() LIMIT 10")
	if Q then
		repeat
			local item, count, incrtime, extended = Q:GetUInt32(0), Q:GetUInt32(1), Q:GetUInt32(2), Q:GetUInt32(3)
			AddVendorItem( npcID, item, count, incrtime, extended)
		until not Q:NextRow()
	end 
end

local function onUpdate(eventid, delay, repeats, worldobject)
	local file = ""
	if(file_exists(fileName)) then
		file = io.open(fileName, "r")
		io.input(file)
		if(tonumber(io.read()) < GetCurrTime()) then
			fixTime()
			io.close(file)
			io.open(fileName, "w")
			file:write(GetCurrTime() + realTime)
			file:close()
			UpdateAH()
		else 
			io.close(file)
		end
	else
		file = io.open(fileName, "w")
		file:write(GetCurrTime() + realTime)
		file:close()
	end
end

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end
	
worldobject:RegisterEvent(Timed, 600000, 5)