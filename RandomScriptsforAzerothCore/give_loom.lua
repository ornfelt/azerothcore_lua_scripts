--Gives new players starting gear. Currently level 30 rdf gear.

local enabled = false

local T = {
--  [classId] = {item1, item2, item3m, ...}
	[0] = {},
    [1] = {42943, 48718, 42991, 48716, 42949, 48685, 50255, 51980, 51978, 51982, 51981}, -- Warrior
    [2] = {44100, 48685, 44092, 42992, 50255, 48716, 51980, 51978, 51982, 51981}, -- Paladin
    [3] = {42946, 50255, 48677, 42991, 42950, 42944, 51965, 51964, 51963, 51962}, -- Hunter
    [4] = {42944, 48689, 42952, 42991, 50255, 51965, 51964, 51963, 51962}, -- Rogue
    [5] = {42947, 48691, 44107, 42992, 50255, 51973, 51968, 51967, 51972}, -- Priest
    [6] = {42943, 48685, 42949, 42991, 50255}, -- Death Knight
    [7] = {48716, 48716, 42992, 48677, 42950, 42951, 48683, 50255, 51965, 51964, 51963, 51962}, -- Shaman
    [8] = {42947, 48691, 44107, 42992, 50255, 51973, 51968, 51967, 51972}, -- Mage
    [9] = {42947, 48691, 44107, 42992, 50255, 51973, 51968, 51967, 51972}, -- Warlock
    [11] = {42947, 48718, 42952, 42991, 44107, 48691, 48689, 50255, 51965, 51964, 51963, 51962}, -- Druid

}

local function OnCharacterCreate(event, player)
	local class = player:GetClass()
	local level = player:GetLevel()
	local bag1 = player:GetItemByPos(255, 19)
	local bag2 = player:GetItemByPos(255, 20)
	local bag3 = player:GetItemByPos(255, 21)
	local bag4 = player:GetItemByPos(255, 22)
	
	if level < 55 then
		player:AddItem(51996, 1)
		player:AddItem(51992, 1)
		player:AddItem(51994, 1)
		else
		player:RemoveItem(38145, 4)
		end
	
	if class == 3 and bag1 ~= nil then
	player:AddItem(41600, 1)
	player:AddItem(2512, 1800)
	end
	
	
	player:LearnSpell(34091)
	player:LearnSpell(73324)
	if (class == 3) then
	player:LearnSpell(5300)
	player:LearnSpell(1579)
	end
	
		if bag1 == nil then
		player:EquipItem( 41600, 19 )
		else
		player:AddItem(41600, 1)
		end
		if bag2 == nil then
		player:EquipItem( 41600, 20 )
		else
		player:AddItem(41600, 1)
		end
		if bag3 == nil then
		player:EquipItem( 41600, 21 )
		else
		player:AddItem(41600, 1)
		end
		if bag4 == nil then
		player:EquipItem( 41600, 22 )
		else
		player:AddItem(41600, 1)
		end
		
		if level > 55 and player:HasItem( 41600 ) then
		player:EquipItem( 41600, 19 )
		player:EquipItem( 41600, 20 )
		player:EquipItem( 41600, 21 )
		player:EquipItem( 41600, 22 )
		end
		

	for _,v in ipairs(T[class]) do
			player:RemoveItem(v, 9)
			if v == 42992 or v == 42991 or v == 42944 then
            player:AddItem(v, 2)
			else
			player:AddItem(v, 1)
			end
        end
end

if enabled then
--RegisterPlayerEvent(30, OnFirstLogin)
--RegisterPlayerEvent(1, OnCharacterCreate)
RegisterPlayerEvent(30, OnCharacterCreate)
end