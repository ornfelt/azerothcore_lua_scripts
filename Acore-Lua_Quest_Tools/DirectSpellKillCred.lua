--This script was created by Dinkledork
--Spell cast on npc counts as kill credit. Invalidates any npc not listed in your local SWG_IDS. Great for quests where maybe you need to bandage npcs or something of the sort.

local SWG_IDS = {68, 400013, 400033, 400014, 1976} --NPCs you want the spell to be castable on
local SPELL_ID = 100141 --SpellID for quest spell needed to be cast on npcs

function OnSpellCast(event, caster, spell)
    local target = spell:GetTarget()
    if target and spell:GetEntry() == SPELL_ID then
        local isValidTarget = false
        for _, swgID in ipairs(SWG_IDS) do
            if target:GetEntry() == swgID then
                isValidTarget = true
                break
            end
        end
        if not isValidTarget then
            caster:SendBroadcastMessage("Invalid target for this spell.") --Comes back invalid if target is not part of the SWG_IDS
            spell:Cancel()
        else
            -- give kill credit to NPC ID 68
            caster:KilledMonsterCredit(68) --SWG_IDS all give kill credit for this npcid, meaning you don't have to modify killcredit tables in sql
        end
    end
end

RegisterPlayerEvent(5, OnSpellCast)
