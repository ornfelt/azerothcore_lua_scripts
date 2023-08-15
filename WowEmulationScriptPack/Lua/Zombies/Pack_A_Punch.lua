--First Upgrade
local UpgradeNpcID = 9955001
local AllUpgradeableZombieItems = {
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--1 class
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--2 class
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--3 class
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--4 class
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--5 class
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--6 class
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--7 class
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--8 class
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--9 class
{},--10 class
{{7631249,1,1},{7631250,1,1},{7631251,1,1},{7631252,1,1},{7631253,1,1}},--11 class
}
local function onHelloZombies(event, player, object)
	for i in pairs(AllUpgradeableZombieItems[player:GetClass()]) do
		if(player:HasItem(AllUpgradeableZombieItems[player:GetClass()][i][1]) and player:HasItem(ZombieUpgradeCurrency,AllUpgradeableZombieItems[player:GetClass()][i][3])) then
			player:GossipMenuAddItem(0,"Upgrade "..player:GetItemByEntry(AllUpgradeableZombieItems[player:GetClass()][i][1]):GetName().."\nCost: "..ZombieUpgradeCurrency,AllUpgradeableZombieItems[player:GetClass()][i][3].." "..player:GetItemByEntry(AllUpgradeableZombieItems[player:GetClass()][i][3]):GetName(), 0, AllUpgradeableZombieItems[player:GetClass()][i][1])
		end
	end
	player:GossipSendMenu(100,object)
end

local function onSelectZombies(event, player, object, sender, intid, code, menu_id)
	for i in pairs(AllUpgradeableZombieItems[player:GetClass()]) do
		if(AllUpgradeableZombieItems[player:GetClass()][i][2] == inid) then
			player:AddItem(AllUpgradeableZombieItems[player:GetClass()][i][1]:GetEntry()+10000,1)
			player:RemoveItem(AllUpgradeableZombieItems[player:GetClass()][i][1],1)
			player:RemoveItem(ZombieUpgradeCurrency,AllUpgradeableZombieItems[player:GetClass()][i][3])
		end
	end
	player:GossipComplete()
end

RegisterCreatureGossipEvent( UpgradeNpcID, 1, onHelloZombies )
RegisterCreatureGossipEvent( UpgradeNpcID, 2, onSelectZombies )