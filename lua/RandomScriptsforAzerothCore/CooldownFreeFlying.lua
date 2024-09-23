--This script is for people who want to remove the cooldowns for Up, Up and Away and Skyburst spells
--Up, Up and Away will still have a CD but is reset when you cast Skyburst

local resetCooldown = false -- Set to true to enable
local castFullHeal = false -- Set to true to enable. This will remove the damage caused to the player by Skyburst

local function ResetCooldowns(event, player, spell)
    local spellId = spell:GetEntry()

    if resetCooldown and (spellId == 100209 or spellId == 100217 or spellId == 100216 or spellId == 100221) then
        player:ResetSpellCooldown(100210)
        player:ResetSpellCooldown(100211)
        player:ResetSpellCooldown(100218)
        player:ResetSpellCooldown(100219)
        player:ResetSpellCooldown(100214)
        player:ResetSpellCooldown(100213)
        player:ResetSpellCooldown(100215)
        player:ResetSpellCooldown(100220)
    elseif castFullHeal and not player:IsInCombat() and (spellId == 100210 or spellId == 100211 or spellId == 100218 or spellId == 100219 or spellId == 100214 or spellId == 100213 or spellId == 100215 or spellId == 100220) then
        player:CastSpell(player, 17683, true)
    end
end

RegisterPlayerEvent(5, ResetCooldowns)

