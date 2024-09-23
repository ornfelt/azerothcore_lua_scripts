--[[
Template-Script is written by New-Haven WotLK+ (Krisande#5411)
The purpose of the script is to show you how to realize a full tier set item upgrader!
I will show you how to accomplish this for multiple items done via an array as well as for a single item done via a regular variable

I declared here only the mage tier 5 and tier 4 sets as well as the BiS weapons(from fire mage... and also only mainhand without offhand) out of those sets... 
but you can easily make this working for all classes... 
just use this here as a template! =D

Wish you fun with it!

Sidenote: 
To get the number values of the players class used for the player:GetClass() check open up the ChrClasses.dbc and look at the ID value there! =D
]]

-- declaration of the NPC ID
local NPC_ITEM_UPGRADER = 300000

-- declaration of single items in case u also want to see how to realize a weapon upgrader!
local BIS_MAINHAND_FIREMAGE_NEW = 34336 -- Sunflare - Dagger
local BIS_MAINHAND_FIREMAGE_OLD = 30095 -- Fang of the Leviathan - Sword

-- declaration of upgrade currency items
-- this is used on top of the tierset items needed for the upgrade!
local T5_UPGRADE_CURRENCY = 40753 -- insert your itemid here which u want to set as currency for the t5 upgrade(rn it is on EoV)... you also can declare more currencies of course! =)

-- this is used on top of the weapon needed for the upgrade!
local WEAPON_UPGRADE_CURRENCY = 40753 -- insert your itemid here which u want to set as currency for a weapon upgrade (right now EoV is used)

-- array declarations for the items
-- Tier 5 mage items (used for handing the items out at upgrade from t4)
local MageTier5UpgradeList = {
        30206, -- Cowl of Tirisfal
          30205,  -- Gloves of Tirisfal
            30207, -- Leggings of Tirisfal
              30210, -- Mantle of Tirisfal
                30196, -- Robes of Tirisfal
};
 

-- Tier 4 mage items (used as check if the user rly is eligible to upgrade his items since all items are needed for a full setupgrade)
local MageTier4UpgradeList = {
    29076, -- Collar of the Aldor
      29080, -- Gloves of the Aldor
        29078,  -- Legwraps of the Aldor
          29079, -- Pauldrons of the Aldor
            29077, -- Vestments of the Aldor
};

local function ItemUpgradeOnGossipHello(event, player, creature) -- function to display the gossip with the options to select
    player:GossipClearMenu() -- clears the players gossip so it is prepared for the fresh gossip window
    player:GossipMenuAddItem(0, "I want to Upgrade a T-set please!", 0, 1) -- adds option 1 to the gossip window
    player:GossipMenuAddItem(0, "I want to Upgrade some Weapons please!", 0, 2) -- adds option 2 to the gossip window
    player:GossipMenuAddItem(0, "Close", 0, 3000) -- adds a close option to the gossip window (option 3000)
    player:GossipSendMenu(1, creature) -- sends the gossip menu with all the options to the players gossip window on interactiom with the creature
end

RegisterCreatureGossipEvent(NPC_ITEM_UPGRADER, 1, ItemUpgradeOnGossipHello) -- registers the function which we built above so it actually can be called by the npc on playerinteraction

local function ItemUpgradeOnGossipSelect(event, player, creature, sender, intid, code, menu_id) -- function to determine what should happen when an option got pressed
    local WeaponTokenString = "Emblem of Valor" -- insert the name of your currency here
    local TierSetTokenString = "Emblem of Valor" -- insert the name of your currency here!
    if (intid == 1) then -- if user selected option 1 then:
        player:GossipClearMenu() -- clear gossip menu
        player:GossipMenuAddItem(0, "I want to Upgrade my T4 set to T5 please!", 0, 100, false, "Do you really want to upgrade your items? All your T4 items will be taken away and you will get T5 items handed out instead! The upgrade will cost you 20 " ..TierSetTokenString.. ".") -- add a new gossip item which asks on selection if the user is sure about his selection and shows him what the upgrade will cost (option100)
        player:GossipMenuAddItem(0, "Back", 0, 4000) -- adds a back option to get back to the first window (option 4000)
        player:GossipSendMenu(2, creature) -- sends the new gossip menu to the gossip window (we do this so the user has multiple menus available at one npc)
        
    elseif (intid == 2) then -- else if user selected option 2 then:
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "I want to upgrade my 'Fang of the Leviathan' to 'Sunflare' please", 0, 200, false, "Do you really want to upgrade your 'Sunflare' to the 'Fang of Leviathan'? This will cost you 10 " ..WeaponTokenString.. ".") -- add a new gossip item which asks on selection if the user is sure about his selection and shows him what the upgrade will cost
        player:GossipMenuAddItem(0, "Back", 0, 4000) -- adds a back option to get back to the first window (option 4000)
        player:GossipSendMenu(3, creature) -- sends the new gossip menu to the gossip window (we do this so the user has multiple menus available at one npc)
        
    elseif (intid == 100) then -- else if user selected option 100 then:
        if player:GetClass() == 8 then -- checks for the players class (8 = mageclass)    
            if player:HasItem(MageTier4UpgradeList[1]) and player:HasItem(MageTier4UpgradeList[2]) and player:HasItem(MageTier4UpgradeList[3]) and player:HasItem(MageTier4UpgradeList[4]) and player:HasItem(MageTier4UpgradeList[5]) then
                if player:HasItem(T5_UPGRADE_CURRENCY, 20) then
                    for i, item in ipairs(MageTier5UpgradeList) do
                        player:RemoveItem(MageTier4UpgradeList[1], 1)
                        player:RemoveItem(MageTier4UpgradeList[2], 1)
                        player:RemoveItem(MageTier4UpgradeList[3], 1)
                        player:RemoveItem(MageTier4UpgradeList[4], 1)
                        player:RemoveItem(MageTier4UpgradeList[5], 1)
                        player:AddItem(item, 1)
                    end
                    player:RemoveItem(T5_UPGRADE_CURRENCY, 20)
                    player:SendAreaTriggerMessage("You have successfully upgraded your tier set!")
                    player:GossipComplete()
                else
                    player:SendAreaTriggerMessage("You do not have enough " .. TierSetTokenString .. " to upgrade your tier set.")  -- sends an areatrigger message to the player that he does not own enough of the tokens needed for the trade
                    player:GossipComplete()
                end
            else -- for more class checks change this else here properly to elseif player:GetClass() == InsertClassIdHere
                player:SendAreaTriggerMessage("You do not have all the required items to upgrade your tier set.") -- sends this message in case the player doesn't have all t4 items needed
                player:GossipComplete()
            end
        else
            player:SendAreaTriggerMessage("You are right now with a non mage class at an Item Upgrader which is currently setted up only for 1 mage set!") -- change this text  
        end
    
    elseif (intid == 200) then -- else if player selected option 200 then:
        if (player:HasItem(WEAPON_UPGRADE_CURRENCY, 10)) then -- checks if the player has 10 pieces of the desired upgrade currency
            if (player:HasItem(BIS_MAINHAND_FIREMAGE_OLD, 1)) then -- checks if the player has the needed item to proceed with the upgrade
                player:RemoveItem(BIS_MAINHAND_FIREMAGE_OLD, 1) -- if all checks are fullfilled remove the item one time from the player
                player:AddItem(BIS_MAINHAND_FIREMAGE_NEW, 1) -- as well as hand out the new item one time
                player:RemoveItem(WEAPON_UPGRADE_CURRENCY, 10) -- and remove 10 currency emblems
                player:GossipComplete()
            else
                player:SendAreaTriggerMessage("You do not own the needed item and thus the trade can't be completed!") -- sends an areatrigger message to the player that he doesn't own the weapon needed for the trade
                player:GossipComplete()
            end
        else
            player:SendAreaTriggerMessage("You do not own 10 pieces of the " ..WeaponTokenString.. "!") -- sends an areatrigger message to the player that he does not own enough of the tokens needed for the trade
            player:GossipComplete()
        end

    elseif (intid == 3000) then -- else if player selected option 3000 then:
        player:GossipComplete() -- close gossip menu
        player:SendAreaTriggerMessage("See ya later!") -- send areatrigger message with a goodbye message

    elseif (intid == 4000) then -- else if player selection option 4000 then show the initial menu!
        player:GossipClearMenu()
        player:GossipMenuAddItem(0, "I want to Upgrade a T-set please!", 0, 1) 
        player:GossipMenuAddItem(0, "I want to Upgrade some Weapons please!", 0, 2)
        player:GossipMenuAddItem(0, "Close", 0, 3000)
        player:GossipSendMenu(4, creature)
    end
end

RegisterCreatureGossipEvent(NPC_ITEM_UPGRADER, 2, ItemUpgradeOnGossipSelect)
            
                
