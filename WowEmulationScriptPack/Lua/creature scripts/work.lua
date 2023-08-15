local Q = WorldDBQuery("SELECT name, paths FROM FlightPaths LIMIT 1000")
local tempt = {}
	if Q then
		repeat	
		table.insert(tempt,{Q:GetUInt320(0),Q:GetUInt320(1)})
		
		until not Q:NextRow()
		return tempt
	end
	
	
	
	tempt
	
	for i,v in pairs(tempt) do
	 msg:add(v[1])
	end