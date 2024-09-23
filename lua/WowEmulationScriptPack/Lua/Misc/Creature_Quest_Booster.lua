local CreatureId = 654654
local token = 511500

local Quests = {
{6867075,350001},--warrior
{6847075,350001},--paladin
{6887075,350001},--hunter
{6837075,350001},--rogue
{6897075,350001},--priest
{6857075,350001},--DK
{6817075,350001},--shaman
{6827075,350001},--mage
{6807075,350001},--warlock
{},--blank(class ID 10)
{6877075,350001},--druid
} 

local Armor = {
{2169859,2169863},--warrior
{2169853,2169861,2169863},--paladin
{2169852,2169863},--hunter
{2169850,2169863},--rogue
{2169856,2169863},--priest
{2169858,2169863},--DK
{2169857,2169862,2169863},--shaman
{2169855,2169863},--mage
{2169854,2169863},--warlock
{},--blank(class ID 10)
{2169851,2169860,2169863},--druid
}

function onHelloQuest(event, player, object)
	if(player:HasItem(token)) then
		player:GossipMenuAddItem( 0, "Yes, I understand that by clicking this button, my character will receive a boost to complete the quest chain as well as provide me with some armor to continue my journey. I understand that I can no longer fully complete the introduction story, and I understand that I am losing out on the rewards that would be provided to me; should I have completed the quest chain.", 0, 1)
	end
	player:GossipSendMenu(100,object)
end

function onSelectQuest(event, player, object, sender, intid, code, menu_id)
	if(intid == 1) then
	local FuckBoosters = false;
		local class = player:GetClass()
			for i in pairs(Quests[class]) do
				if(player:GetQuestStatus(Quests[class][i]) == 0) then
					player:Teleport(571,-11742,11917.900,136.30,2.346)
					player:AddQuest(Quests[class][i])
					player:CompleteQuest(Quests[class][i])
					player:RewardQuest(Quests[class][i])
				else
					FuckBoosters = true
				end
			end
			for i in pairs(Armor[class]) do
				if(FuckBoosters == false) then
					player:AddItem(Armor[class][i],1)
					player:RemoveItem(511500, 1)
				end
			end
			
	end
	player:GossipComplete()
end

RegisterCreatureGossipEvent(CreatureId, 1, onHelloQuest )
RegisterCreatureGossipEvent( CreatureId, 2, onSelectQuest )