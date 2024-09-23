local mvi = require("mount_vendor_items").getItems()
local rs = require("mount_vendor_items").getRidingSkills()
local locales = require("mount_vendor_items").getLocales()
local MV = {}

function MV.CheckLocale(locale)
	return locales[locale] and locale or 1
end

function MV.OnElunaLoaded()
    local check_npc = WorldDBQuery("SELECT * FROM creature_template WHERE entry=590100")
    
    if not check_npc then
        -- WorldDBExecute lines removed
        PrintInfo("Mount Vendor SQL not uploaded. Please add the NPC data manually and restart the server.")
    end
end

function MV.OnVendorHello(event, player, object)
	local locale = MV.CheckLocale(player:GetDbLocaleIndex() + 1)
	
	player:GossipClearMenu()
	
	for i = 1, #rs do
		local loc_skill = locales[locale][rs[i].spellid]
		
		if rs[i].level <= player:GetLevel() and MV.Cswr(player, rs[i].requires) and not player:HasSpell(rs[i].spellid) then
			player:GossipMenuAddItem(1, "|TInterface/icons/"..rs[i].icon..":30:30:-18:0|t "..(loc_skill and loc_skill or rs[i].name), i, 0, false, locales[locale]["Other"][4], rs[i].cost)
		end
	end
	
	for i = 1, #mvi do
		if player:HasSpell(mvi[i].requires) then
			player:GossipMenuAddItem(1, "|TInterface/icons/"..mvi[i].icon..":30:30:-18:0|t "..locales[locale]["Fractions"][i], i, 1)
		end
	end
	
	if rs[1].level <= player:GetLevel() then
		player:GossipSendMenu(590100, object, 0)
	else
		player:GossipComplete()
		
		local loc_bl = locales[locale]["Other"][1]
		local loc_al = locales[locale]["Other"][2]
		
		PrintInfo(loc_bl)
		PrintInfo(loc_al)
		
		player:SendNotification(locales[locale]["Other"][1]..rs[1].level..locales[locale]["Other"][2])
	end
end

function MV.Cswr(player, spellid)
	if spellid then
		return player:HasSpell(spellid)
	end
	
	return true
end

function MV.OnVendorSelect(event, player, object, sender, intid, code, menu_id)
    local locale = MV.CheckLocale(player:GetDbLocaleIndex() + 1)

    if intid == 0 then
        if rs[sender] then
            player:ModifyMoney(-rs[sender].cost)
        else
            PrintError("You can currently only buy one mount at a time. Sorry! --Dinkledork")
            return
        end
        player:LearnSpell(rs[sender].spellid)
        MV.OnVendorHello(1, player, object)
    elseif intid == 1 then
		player:GossipClearMenu()
		
		local mounts = mvi[sender].items
		
		for i = 1, #mounts do
			local loc_skill = locales[locale] and locales[locale][mounts[i].spellid] or nil
			
			if player:HasSpell(mounts[i].requires) and not player:HasSpell(mounts[i].spellid) then
				player:GossipMenuAddItem(1, "|TInterface/icons/"..mounts[i].icon..":30:30:-18:0|t |c"..mounts[i].rarity..(loc_skill and loc_skill or mounts[i].name) .."|R", sender, 100+i, false, locales[locale]["Other"][5], mounts[i].cost)
			end
		end
		
		player:GossipMenuAddItem(1, "|TInterface/icons/Achievement_bg_returnxflags_def_wsg:30:30:-18:0|t " .. locales[locale]["Other"][3], 0, 2)
		
		player:GossipSendMenu(590100, object, 0)
	elseif intid == 2 then
		MV.OnVendorHello(1, player, object)
	else
		local mount = mvi[sender].items[intid-100]
		
		player:ModifyMoney(-mount.cost)
		player:LearnSpell(mount.spellid)
		player:CastSpell(player, 36937)
		MV.OnVendorSelect(2, player, object, sender, 1, code, menu_id)
	end
end

RegisterServerEvent(33, MV.OnElunaLoaded)
RegisterCreatureGossipEvent(590100, 1, MV.OnVendorHello)
RegisterCreatureGossipEvent(590100, 2, MV.OnVendorSelect)