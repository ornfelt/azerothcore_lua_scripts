local spellIds = {100209, 100211, 100210, 100213, 100214, 100215, 100216, 100217, 100218, 100219, 100220, 100180, 100221, 100222} 
local restrictedSpellIds = {100209, 100211, 100210, 100213, 100214, 100215, 100216, 100217, 100218, 100219, 100220, 100180, 100221, 100222} -- remove if you want to have all spells available in raids/dungeons. Just change to {}
local requiredAuraRange = {200049, 200181} 
local requiredLevel = 1 --change me if you want lower level restriction. Don't touch anything else (other than Outland level)
local emoteId = 68 -- obsolete
local soundId = 53774

function CreateDelayedEmoteFunction(playerGuid, emoteId)
    return function()
        local player = GetPlayerByGUID(playerGuid)
        if player then
            player:PerformEmote(emoteId)
        end
    end
end

function OnSpellCast(event, player, spell, skipCheck)
    for i, spellId in ipairs(spellIds) do
        if (spell:GetEntry() == spellId) then
            local hasRequiredAura = false
            for j = requiredAuraRange[1], requiredAuraRange[2] do
                if (player:HasAura(j)) then
                    hasRequiredAura = true
                    break
                end
            end

            local map = player:GetMap()
            local mapId = map:GetMapId()
            local restrictionMessage = "You cannot cast this spell in battlegrounds, dungeons, or raids."
            
            if (mapId == 530 and player:GetLevel() < 70) then -- change 70 to 1
                restrictionMessage = "You must be level 70 to cast this spell in Outland."
            elseif (mapId == 571 and not player:HasSpell(54197)) then -- .learn 54197
                restrictionMessage = "You must have Cold Weather Flying to cast this spell in Northrend."
            end

            local isRestrictedSpell = false
            for _, restrictedSpellId in ipairs(restrictedSpellIds) do
                if (spell:GetEntry() == restrictedSpellId) then
                    isRestrictedSpell = true
                    break
                end
            end

            if isRestrictedSpell and (player:InBattleground() or map:IsDungeon() or map:IsRaid() or (mapId == 530 and player:GetLevel() < 70) or (mapId == 571 and not player:HasSpell(54197))) then
                player:SendAreaTriggerMessage(restrictionMessage)
                spell:Cancel()
                return false
            elseif (not hasRequiredAura and player:GetLevel() >= requiredLevel) then
                player:SendAreaTriggerMessage("You must have wings equipped to cast this spell.")
                spell:Cancel()
                return false
            elseif (hasRequiredAura and player:GetLevel() < requiredLevel) then
                player:SendAreaTriggerMessage("You must be at least level 40 to cast this spell.")
                spell:Cancel()
                return false
            elseif (not hasRequiredAura and player:GetLevel() < requiredLevel) then
                player:SendAreaTriggerMessage("You must be at least level 40 and have wings equipped to cast this spell.")
                spell:Cancel()
                return false
            elseif (spell:GetEntry() == 100210 or spell:GetEntry() == 100218 or spell:GetEntry() == 100219 or spell:GetEntry() == 100220) then
                --player:PerformEmote(emoteId)
                player:PlayDirectSound(soundId)
                local maxHealth = player:GetMaxHealth()
                local healthToReduce = maxHealth * 0.10 -- 10% of max health
                local newHealth = player:GetHealth() - healthToReduce
                local healthPct = (newHealth / maxHealth) * 100
                if healthPct <= 5 then
                    player:Kill(player)
                else
                    player:SetHealth(newHealth)
                end
				
			elseif (spell:GetEntry() == 100209) then
				player:CastSpell(player, 71495, true)
				player:CastSpell(player, 34602, true)
				player:CastSpell(player, 75459, true)


			 local playerRace = player:GetRace()
    if playerRace ~= 10 and playerRace ~= 11 then
        local playerGuid = player:GetGUID()
        CreateLuaEvent(CreateDelayedSpellFunction(playerGuid, 100223), 100, 1)
        CreateLuaEvent(function()
            RemoveAuraIfNotFalling(playerGuid, 100223)
        end, 1400, 1)
    end

			elseif (spell:GetEntry() == 100216) then
				player:CastSpell(player, 75459, true)
				player:CastSpell(player, 34602, true)

			local playerRace = player:GetRace()
    if playerRace ~= 10 and playerRace ~= 11 then
        local playerGuid = player:GetGUID()
        CreateLuaEvent(CreateDelayedSpellFunction(playerGuid, 100223), 100, 1)
        CreateLuaEvent(function()
            RemoveAuraIfNotFalling(playerGuid, 100223)
        end, 1400, 1)
    end

			elseif (spell:GetEntry() == 100217) then
				player:CastSpell(player, 71495, true)
				player:CastSpell(player, 34602, true)
				player:CastSpell(player, 75459, true)

			local playerRace = player:GetRace()
    if playerRace ~= 10 and playerRace ~= 11 then
        local playerGuid = player:GetGUID()
        CreateLuaEvent(CreateDelayedSpellFunction(playerGuid, 100223), 100, 1)
        CreateLuaEvent(function()
            RemoveAuraIfNotFalling(playerGuid, 100223)
        end, 1400, 1)
    end

			elseif (spell:GetEntry() == 100221) then
				player:CastSpell(player, 71495, true)
				player:CastSpell(player, 34602, true)

			local playerRace = player:GetRace()
    if playerRace ~= 10 and playerRace ~= 11 then
        local playerGuid = player:GetGUID()
        CreateLuaEvent(CreateDelayedSpellFunction(playerGuid, 100223), 100, 1)
        CreateLuaEvent(function()
            RemoveAuraIfNotFalling(playerGuid, 100223)
        end, 1400, 1)
    end
             
elseif (spell:GetEntry() == 100211 or spell:GetEntry() == 100213 or spell:GetEntry() == 100214 or spell:GetEntry() == 100215) then
    player:CastSpell(player, 34602, true)
    player:CastSpell(player, 75459, true)

    local playerGuid = player:GetGUID()
    CreateLuaEvent(CreateDelayedEmoteFunction(playerGuid, 53), 100, 1)
end
end
end
end

RegisterPlayerEvent(5, OnSpellCast)
