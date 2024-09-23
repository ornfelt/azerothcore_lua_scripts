
--[[
Setup: Place characters in locations where they will be farming
1. Need to have no commanderUnit
2. Rotate on the spot and TargetNearestEnemy
3. If enemy is found and not in range IWT and pull with generic spell
4. Continue normal class logic
]]--
function mb_BossModule_LevelFarm_PreOnUpdate()
    local class = mb_GetClass("player")

    local classSpell

    if class == "WARRIOR" then
        classSpell = "Charge"
    elseif class == "ROGUE" then
        classSpell = "Sinister Strike"
    elseif class == "MAGE" then
        classSpell = "Frostbolt"
    elseif class == "WARLOCK" then
        classSpell = "Curse of Agony"
    elseif class == "DRUID" then
        classSpell = "Moonfire"
    elseif class == "SHAMAN" then
        classSpell = "Lightning Bolt"
    elseif class == "PALADIN" then
        classSpell = "Hand of Reckoning"
    elseif class == "DEATHKNIGHT" then
        classSpell = "Death Grip"
    elseif class == "PRIEST" then
        classSpell = "Shadow Word: Pain"
    elseif class == "HUNTER" then
        classSpell = "Arcane Shot"
    end

    mb_petAttack = true
    if UnitAffectingCombat("player") then
        mb_commanderUnit = nil
        return false
    end

    if UnitName("target") ~= nil then
        mb_StopMoving()
        mb_IWTCrawl()
        if mb_CastSpellOnTarget(tostring(classSpell)) then
            return false
        end
        return false
    end

    TurnLeftStart()
    TargetNearestEnemy()
end

function mb_BossModule_LevelFarm_OnUpdate()

end

function mb_BossModule_LevelFarm_OnLoad()
    mb_BossModule_PreOnUpdate = mb_BossModule_LevelFarm_PreOnUpdate
end

mb_BossModule_RegisterModule("levelfarm", mb_BossModule_LevelFarm_OnLoad)
