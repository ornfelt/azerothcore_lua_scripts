--[[
    - Redeemer script:
    
    This script allows players to redeem predetermined 
    codes given out during events etc.
    
    Codes are stored in its own table in the character database,
    as well as the rewards that are tied to the said code.
    
    Once a code is redeemed, it will be marked as
    redeemed in the database, as well as what player
    redeemed it and the date/time it was redeemed.
    The code will then be unavailable for future use.
    
    - Available types of code redemptions:
    
    1: Item -- entry = item entry, count = item count
    2: Title -- entry = title id, count = 0
    3: Money -- entry = 0, count = copper amount
    4: Levels
    5: UNUSED
    6: Global buff -- entry = spellId, count = 0
    7: Reputation -- entry = faction, count = amount
    8: Services
    9: Mounts
]]

local Redeemer = {
    Entry = 17249, -- Creature Entry
    ReloadTimer = 30, -- Cache reload timer in seconds
}

function Redeemer.OnGossipHello(event, player, unit)
    player:GossipMenuAddItem(0, "I would like to redeem my secret code.", 0, 1, true, "")

    for k, v in pairs(Redeemer["Cache"]) do
        if(v["account_guid"] == player:GetAccountId()) then
            player:GossipMenuAddItem(0, "Please show me my available codes!", 0, 2)
            break;
        end
    end

    if(player:IsGM()) then
        player:GossipMenuAddItem(0, "Refresh code cache.", 0, 0)
    end

    player:GossipSendMenu(8855, unit)
end

function Redeemer.OnGossipSelect(event, player, object, sender, intid, code)
    if(intid == 1) then
        local sCode = tostring(code)
        
        if(sender > 0) then
            sCode = Redeemer[player:GetAccountId()][sender]
        end
        
        local t = Redeemer["Cache"][sCode]
        
        if(t) then
            if(t["account_guid"] == player:GetAccountId() or t["account_guid"] == 0) then
                if(t["rtype"] == 1) then -- Add Item
                    if(player:GetFreeBagSlots() < 5) then
                        player:SendAreaTriggerMessage("ERROR: Redemption failed, you need at least 5 free bag slots!")
                        player:GossipComplete()
                        return;
                    else
                        player:AddItem(t["entry"], t["count"])
                    end
                elseif(t["rtype"] == 2) then -- Add Title
                    player:SetKnownTitle(t["entry"])
                elseif(t["rtype"] == 3) then -- Give money
                    player:ModifyMoney(t["count"])
                elseif(t["rtype"] == 4) then -- Levels
                    local levels = t["entry"]*t["count"]
                    
                    if(player:GetLevel() >= 70) then
                        player:SendAreaTriggerMessage("ERROR: Redemption failed, you cannot redeem levels past level 70.")
                        player:GossipComplete()
                        return;
                    end
                    
                    if((player:GetLevel() + levels) >= 70) then
                        player:SetLevel(70)
                    else
                        player:SetLevel(player:GetLevel() + levels)
                    end
                elseif(t["rtype"] == 5) then -- UNUSED

                elseif(t["rtype"] == 6) then -- Global buffs
                    if(player:IsMounted()) then
                        player:Dismount()
                    end
                    
                    for k, v in pairs(GetPlayersInWorld()) do
                        if v:IsAlive() then
                            v:CastSpell(v, t["entry"], t["count"])
                        end
                    end
                
                elseif(t["rtype"] == 7) then -- Faction increase
                    if(player:GetReputation(t["entry"]) >= t["count"]) then
                        player:SendAreaTriggerMessage("ERROR: Redemption failed, you have too much reputation with this faction to redeem this code.")
                        player:GossipComplete()
                        return;
                    end
                    
                    player:SetReputation(t["entry"], t["count"])
                elseif(t["rtype"] == 8) then -- Services
                    player:SetAtLoginFlag(t["entry"])
                elseif(t["rtype"] == 9) then -- Mounts
                    local skill = WorldDBQuery("select RequiredSkillRank from item_template where spellid_2 = "..t["entry"]..";"):GetUInt32(0);
                    
                    if(player:GetSkillValue(762) < skill) then
                        player:SendAreaTriggerMessage("ERROR: Redemption failed, you do not have the required riding skill for this mount.")
                        player:GossipComplete()
                        return;
                    end
                    
                    if(player:HasSpell(t["entry"])) then
                        player:SendAreaTriggerMessage("ERROR: Redemption failed, you already have this mount.")
                        player:GossipComplete()
                        return;
                    end
                    
                    player:LearnSpell(t["entry"])
                else
                    player:SendAreaTriggerMessage("ERROR: Redemption failed, wrong redemption type. Please report to developers.")
                    player:GossipComplete()
                    return;
                end
                
                player:SendAreaTriggerMessage("Congratulations! Your code has been successfully redeemed!")
                CharDBExecute("UPDATE redemption SET redeemed=1, player_guid="..player:GetGUIDLow()..", date='"..os.date("%x, %X", os.time()).."' WHERE BINARY passphrase='"..sCode.."';");
                Redeemer["Cache"][sCode] = nil;
            else
                player:SendAreaTriggerMessage("ERROR: Redemption failed, this code is not available for your account.")
            end
        else
            player:SendAreaTriggerMessage("You have entered an invalid code, or your code has already been redeemed.")
        end
    elseif(intid == 2) then
        Redeemer[player:GetAccountId()] = {}
        local i = 1

        for k, v in pairs(Redeemer["Cache"]) do
            if(v["account_guid"] == player:GetAccountId()) then
                if(i <= 10) then
                    player:GossipMenuAddItem(0, tostring(k).." - "..v["count"].."x "..v["description"], i, 1, false, "Are you sure you want to redeem "..tostring(k).."?")
                    Redeemer[player:GetAccountId()][i] = k;
                    i = i + 1
                end
            end
        end
        player:GossipSendMenu(8855, object)
        
        return;
    elseif(intid == 0) then
        Redeemer.LoadCache()
        player:SendAreaTriggerMessage("Available passphrases have been refreshed.")
    end
    player:GossipComplete()
end

function Redeemer.LoadCache(event)
    Redeemer["Cache"] = {}
    
    local q1 = CharDBQuery("SELECT * FROM redemption WHERE redeemed=0;");
    if(q1)then
        repeat
            Redeemer["Cache"][q1:GetString(0)] = {
                -- passphrase
                rtype = q1:GetUInt32(1),
                entry = q1:GetUInt32(2),
                count = q1:GetUInt32(3),
                -- redeemed
                -- player_guid
                -- date
                account_guid = q1:GetUInt32(7),
                description = q1:GetString(8)
            };
        until not q1:NextRow()
        print("[Eluna Redeemer]: Cache initialized. Loaded "..q1:GetRowCount().." results.")
    else
        print("[Eluna Redeemer]: Cache initialized. No results found.")
    end
end

if(Redeemer.ReloadTimer > 0) then
    Redeemer.LoadCache()
    CreateLuaEvent(Redeemer.LoadCache, Redeemer.ReloadTimer*1000, 0)
else
    Redeemer.LoadCache()
end

RegisterCreatureGossipEvent(Redeemer.Entry, 1, Redeemer.OnGossipHello)
RegisterCreatureGossipEvent(Redeemer.Entry, 2, Redeemer.OnGossipSelect)