ACCOUNT_LEVEL = 3

local function PlayerGetValue(event, player, command)
        if (command:find("pvalue") ~= 1) then
                return
        elseif (player:GetGMRank() < ACCOUNT_LEVEL) then
                return false
        end

        local target = player:GetSelection()
        if (target == nil) then
                player:SendBroadcastMessage("You must have a target.")
                return false
        elseif (target:ToPlayer() == nil) then
                player:SendBroadcastMessage("You must target a player.")
                return false
        end

        local pattern = "%S+" -- Separate by spaces
        local parameters = {}
        local parameters = getCommandParameters(command)

        local targetGuid = target:GetGUIDLow()
        target:SaveToDB() -- Save player, otherwise the query result might return old information.
        local totalValue = 0

        local query_string = "SELECT itemEntry, item_name, `count`, owner_guid, cost, cost_name FROM item_instance INNER JOIN elunaworld.item_add ON item_instance.itemEntry = item_add.item WHERE owner_guid = " .. targetGuid .. " AND cost_name = 'Silver' AND cost != 0;"
        local query = CharDBQuery(query_string)


        if(query) then
                repeat
                        itemEntry = tonumber(query:GetInt32(0))
                        itemCost = tonumber(query:GetInt32(4))
                        totalValue = totalValue + itemCost
                        player:SendBroadcastMessage(GetItemLink(itemEntry) .. " - Cost: " .. itemCost .. " " .. GetItemLink(1999999))
                until not query:NextRow()
                        player:SendBroadcastMessage(target:GetName() .." has a total value of " .. totalValue .. " " .. GetItemLink(1999999) .. " with " .. query:GetRowCount() .. " items in total. Run this twice to double-check.")
                else
                        player:SendBroadcastMessage(target:GetName() .." has a total value of 0. Run this twice to double-check.")
        end
        return false


end

RegisterPlayerEvent(42, PlayerGetValue)