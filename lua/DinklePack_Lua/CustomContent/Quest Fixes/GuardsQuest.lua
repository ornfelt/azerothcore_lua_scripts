local StormwindGuardInterrogation = {}

StormwindGuardInterrogation.GUARD_IDS = {68, 1976, 29712}
StormwindGuardInterrogation.SPELL_ID = 80200
StormwindGuardInterrogation.AURA_ID = 80200
StormwindGuardInterrogation.QUEST_ID = 30035
StormwindGuardInterrogation.CHANCE_TO_REVEAL = 17

StormwindGuardInterrogation.PLAYER_INTERROGATION_PHRASES = {"I know about the Defias in the city. Tell me what you know or face the consequences!", "Speak up! Are you colluding with the Defias?", "Don't play innocent with me! I know you let the Defias enter the City!"}
StormwindGuardInterrogation.GUARD_REVEAL_PHRASES = {"I... I had to, alright? I have mouths to feed at home. They paid us a bit to turn a blind eye... They're getting in over the wall behind the High Elf Embassy. Please... just don't throw me in a cell."}
StormwindGuardInterrogation.GUARD_NO_IDEA_PHRASES = {"I have no idea what you're talking about!", "Defias? In the city? Ridiculous!", "You're talking nonsense!"}

function StormwindGuardInterrogation.IsStormwindGuard(unit)
    local entry = unit:GetEntry()
    for i = 1, #StormwindGuardInterrogation.GUARD_IDS do
        if StormwindGuardInterrogation.GUARD_IDS[i] == entry then
            return true
        end
    end
    return false
end

function StormwindGuardInterrogation.GuardDespawn(eventId, delay, repeats, unit)
    unit:DespawnOrUnsummon(0)
end

function StormwindGuardInterrogation.GuardQuestSpellCast(event, player, spell, skipCheck)
    if spell:GetEntry() == StormwindGuardInterrogation.SPELL_ID then
        local unit = player:GetSelection()
        local playerGUID = player:GetGUID()
        if unit and StormwindGuardInterrogation.IsStormwindGuard(unit) then
            if unit:HasAura(StormwindGuardInterrogation.AURA_ID) then
                spell:Cancel()
                player:SendBroadcastMessage("You've already interrogated this guard. Try interrogating a different one.")
                return false
            else
                player:SendUnitSay(StormwindGuardInterrogation.PLAYER_INTERROGATION_PHRASES[math.random(#StormwindGuardInterrogation.PLAYER_INTERROGATION_PHRASES)], 0)
                local function GuardResponse(eventId, delay, repeats, unit)
                    local player = GetPlayerByGUID(playerGUID)
                    if player then
                        local rand = math.random(100)
                        if rand <= StormwindGuardInterrogation.CHANCE_TO_REVEAL then
                            unit:PerformEmote(20) 
                            unit:SendUnitSay(StormwindGuardInterrogation.GUARD_REVEAL_PHRASES[math.random(#StormwindGuardInterrogation.GUARD_REVEAL_PHRASES)], 0)
                            unit:RegisterEvent(StormwindGuardInterrogation.GuardDespawn, 10000, 1)
                            unit:AddAura(StormwindGuardInterrogation.AURA_ID, unit)
                            if player:HasQuest(StormwindGuardInterrogation.QUEST_ID) then
                                player:CompleteQuest(StormwindGuardInterrogation.QUEST_ID)
                            end
                        else
                            unit:SendUnitSay(StormwindGuardInterrogation.GUARD_NO_IDEA_PHRASES[math.random(#StormwindGuardInterrogation.GUARD_NO_IDEA_PHRASES)], 0)
                        end
                    end
                end
                unit:RegisterEvent(GuardResponse, 4000, 1)
            end
        else
            spell:Cancel()
            player:SendBroadcastMessage("You can only interrogate a Stormwind Guard.")
            return false
        end
    end
end

RegisterPlayerEvent(5, StormwindGuardInterrogation.GuardQuestSpellCast)
