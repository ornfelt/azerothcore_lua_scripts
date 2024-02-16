--This script is for people who want to remove the cooldowns for Up, Up and Away and Skyburst spells
--Up, Up and Away will still have a CD but is reset when you cast Skyburst
--The script will also teach characters specified spells on login if enabled set to true

FlightCooldownModule = {}

FlightCooldownModule.teachSpells = false -- Set to true to enable learning all flight related spells on login
FlightCooldownModule.resetCooldown = false -- Set to true to enable no CD
FlightCooldownModule.castFullHeal = false -- Set to true to enable. This will remove the damage caused to the player by Skyburst, except while in combat

function FlightCooldownModule.LearnSpellsOnLogin(event, player)
    if FlightCooldownModule.teachSpells then
        player:LearnSpell(100210)
        player:LearnSpell(100218)
        player:LearnSpell(100219)
        player:LearnSpell(100220)
        player:LearnSpell(100211)
        player:LearnSpell(100213)
        player:LearnSpell(100214)
        player:LearnSpell(100215)
        player:LearnSpell(100222)
        player:LearnSpell(200049) -- Wing spell
    end
end

function FlightCooldownModule.ResetCooldowns(event, player, spell)
    local spellId = spell:GetEntry()

    if FlightCooldownModule.resetCooldown and (spellId == 100209 or spellId == 100217 or spellId == 100216 or spellId == 100221) then
        player:ResetSpellCooldown(100210)
        player:ResetSpellCooldown(100211)
        player:ResetSpellCooldown(100218)
        player:ResetSpellCooldown(100219)
        player:ResetSpellCooldown(100214)
        player:ResetSpellCooldown(100213)
        player:ResetSpellCooldown(100215)
        player:ResetSpellCooldown(100220)
    elseif FlightCooldownModule.castFullHeal and not player:IsInCombat() and (spellId == 100210 or spellId == 100211 or spellId == 100218 or spellId == 100219 or spellId == 100214 or spellId == 100213 or spellId == 100215 or spellId == 100220) then
        player:CastSpell(player, 17683, true)
    end
end

RegisterPlayerEvent(5, FlightCooldownModule.ResetCooldowns)
RegisterPlayerEvent(3, FlightCooldownModule.LearnSpellsOnLogin)
