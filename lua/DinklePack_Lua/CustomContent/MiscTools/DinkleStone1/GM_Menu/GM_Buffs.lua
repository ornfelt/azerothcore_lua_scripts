--[[


]]

local GM_BUFFS_GossipID = 9910003
local GMSpells = {
	["NoTimeLimit"] = {
			{"Saronite Barrier\nReduce All Damage Taken by 99%.", 63364},
			{"Uber Heal Over Time\nHeal to full every second.", 1908},
			{"Berserk \n240% Damage, 160% Attack/Cast Speed.", 72525},
			{"Rage\n300% Damage, Damage taken Reduce by 95% , 100% Movement Speed.", 66776},
			{"LeCraft Test Spell\nHaste 200%", 6560},
	},
	["Cast"] ={
			{"Greater Heal\nHeals for over 100k", 63760},
			{"King's Blessing\n20% all stats, Damage taken Reduce by 35% and rez you.", 100003},
			{"Increases all stats", 100137},
	}

}

--(Start) Pulles for the guid for the player
local function getPlayerCharacterGUID(player)
    local query = CharDBQuery(string.format("SELECT guid FROM characters WHERE name='%s'", player:GetName()))

    if query then 
      local row = query:GetRow()

      return tonumber(row["guid"])
    end

    return nil
  end
--(End)
function GMBuffsGossip(event, player)
	if player:GetGMRank() < 3 then
		return
	end
	player:GossipClearMenu()
	player:GossipMenuAddItem(3, "|TInterface\\Icons\\Inv_drink_22:34|t GM Buffs", 0, 1)
	for event, v in ipairs(GMSpells.NoTimeLimit) do
			hasAura = player:HasAura(v[2])
			if hasAura then
			player:GossipMenuAddItem(0,"|cff3cba54[ON]|r "..v[1], 0, v[2])
			else			
			player:GossipMenuAddItem(0,"|cffff3347[OFF]|r "..v[1], 0, v[2])
			end
	end
	for event, v in ipairs(GMSpells.Cast) do
			player:GossipMenuAddItem(0,"|cff03d3fc[Cast]|r "..v[1], 0, v[2])		
	end
	player:GossipMenuAddItem(4, "|TInterface\\Icons\\Achievement_bg_returnxflags_def_wsg:34|t [Back]", 0, 98)
	player:GossipSendMenu(1, player, GM_BUFFS_GossipID)
end

--(Start)
local function GM_BUFFS_OnSelect(event, player, _, sender, intid, code)
local PlayerName = player:GetName()
	if(intid == 1) then --List
		GMBuffsGossip(event, player)
	end
	if(intid == 2) then --Reduce All Damage Taken by 99%
			local target = player:GetSelection()
			if not target then
				local target = player
			end
			player:CastSpell( target, 63760, true )
	end
	for event, v in ipairs(GMSpells.NoTimeLimit) do
		if(intid == v[2]) then --No time limit Buffs
			local hasAura = player:HasAura(v[2])
			if hasAura then
				player:RemoveAura(v[2])
			else
				player:AddAura(v[2], player)
			end		
			GMBuffsGossip(event, player)
		end
	end
	for event, v in ipairs(GMSpells.Cast) do
		if(intid == v[2]) then --Cast Spells
			local target = player:GetSelection()
			if not target then
				local target = player
			end
			player:CastSpell( target, v[2], true )
			GMBuffsGossip(event, player)
		end
	end
	if(intid == 98) then --Back
		GMSettingsMenuGossip(event, player)
	end
	if(intid == 99) then --Close
		player:SendAreaTriggerMessage("Good Bye!")
		player:GossipComplete()
	end
end
--(End)
--(Start) Command: Check
local function PrintRewardStatsCheck(event, player, command)
	if (command == "heal" and player:GetGMRank() >= 3 )then
		GM_BUFFS_OnSelect(event, player, _, sender, 2, code)
		return false
	end
end
--(end)
RegisterPlayerGossipEvent(GM_BUFFS_GossipID, 2, GM_BUFFS_OnSelect)
RegisterPlayerEvent(42, PrintRewardStatsCheck)
