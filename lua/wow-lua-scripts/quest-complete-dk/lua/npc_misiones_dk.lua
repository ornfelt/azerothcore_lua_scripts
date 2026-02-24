-- Acá iría el entry del npc que pongas en la DB
local npcEntry = 200000
local SMSG_NPC_TEXT_UPDATE = 384
local MAX_GOSSIP_TEXT_OPTIONS = 8

-- Razas
local HUMANO = 1
local ORCO = 2
local ENANO = 3
local ELFO_NOCTURNO = 4
local NO_MUERTO = 5
local TAUREN = 6
local GNOMO = 7
local TROLL = 8
local ELFO_DE_SANGRE = 10
local DRAENEI = 11


function Player:GossipSetText(text, textID)
    local data = CreatePacket(SMSG_NPC_TEXT_UPDATE, 100);
    data:WriteULong(textID or 0x7FFFFFFF)
    for i = 1, MAX_GOSSIP_TEXT_OPTIONS do
        data:WriteFloat(0) -- Probability
        data:WriteString(text) -- Text
        data:WriteString(text) -- Text
        data:WriteULong(0) -- language
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
        data:WriteULong(0) -- emote
    end
    self:SendPacket(data)
end

-- Esta función sirve para crear los gossip (opciones del menú)
function OnGossipHello(event, player, object)
    -- Si el jugador no esta en combate
    if (player:IsInCombat() == false) then
        -- Limpio el menú de opciones del jugador
        player:GossipClearMenu()
        player:GossipSetText("Saludos $n. Debido a que me han dicho que te pachorra completas todas la misiones que te he encomendado, y a que mi ejercito cada vez está más corto de gente, decidí completarte las misiones así podes seguir con tu aventura. Pero no vayas a unir a la alianza o la horda, recorda que te traje a este mundo que me dieras una mano. Nos vemos.$B$BPD. Nos vemos en el trono de hielo traidor.")
            -- Si el jugador es un Caballero de la Muerte
            -- Y no fue recompensado por la misión El camino de los reyes (Alianza)
            teamId = player:GetTeam()
            if (teamId == 0) then
            	questRewardStatus = player:GetQuestRewardStatus(13188)
            else
            	questRewardStatus = player:GetQuestRewardStatus(13189)
            end
            if ((player:GetClass() == 6) and (questRewardStatus == false)) then
                -- Agrego las opciones al menú
                player:GossipMenuAddItem(0, '¡Completame las misiones por favor!', 1, 10)
            end
        player:GossipSendMenu(0x7FFFFFFF, object)
    end
end

function OnGossipSelect(event, player, object, sender, intid, code, menuid)
    if (intid == 10) then
        quests = {12593, 12619, 12842, 12848, 12636, 12641, 12657, 12850, 12670, 12678, 12680, 12687, 12679, 12733, 12711, 12697, 12698, 12700, 12701, 12706, 12714, 12849, 12715, 12716, 12717, 12718, 12719, 12722, 12720, 12723, 12724, 12725, 12727, 12738, 12751, 12754, 12755, 12756, 12757, 12778, 12779, 12800, 12801, 13165, 13166}
        for i, quest in ipairs(quests) do
            questRewardStatus = player:GetQuestRewardStatus(quest)
            if (questRewardStatus == false) then
                player:AddQuest(quest)
                player:CompleteQuest(quest)
                player:RewardQuest(quest)
            end
        end
        teamId = player:GetTeam()
        if (teamId == 0) then
            questRewardStatus = player:GetQuestRewardStatus(13188)
            if (questRewardStatus == false) then
                if (player:GetRace() == HUMANO) then
                    player:AddQuest(12742)
                    player:CompleteQuest(12742)
                    player:RewardQuest(12742)
                end
                if (player:GetRace() == ELFO_NOCTURNO) then
                    player:AddQuest(12743)
                    player:CompleteQuest(12743)
                    player:RewardQuest(12743)
                end
                if (player:GetRace() == DRAENEI) then
                    player:AddQuest(12746)
                    player:CompleteQuest(12746)
                    player:RewardQuest(12746)
                end
                if (player:GetRace() == ENANO) then
                    player:AddQuest(12744)
                    player:CompleteQuest(12744)
                    player:RewardQuest(12744)
                end
                if (player:GetRace() == GNOMO) then
                    player:AddQuest(12745)
                    player:CompleteQuest(12745)
                    player:RewardQuest(12745)
                end
                player:AddQuest(13188)
                player:CompleteQuest(13188)
                player:RewardQuest(13188)
                -- Teletransporto al jugador a Ventormenta spell: 17334
                player:CastSpell(player, 17334, false)
            end
        end
        if (teamId == 1) then
            questRewardStatus = player:GetQuestRewardStatus(13189)
            if (questRewardStatus == false) then
                if (player:GetRace() == ELFO_DE_SANGRE) then
                    player:AddQuest(12747)
                    player:CompleteQuest(12747)
                    player:RewardQuest(12747)
                end
                if (player:GetRace() == ORCO) then
                    player:AddQuest(12748)
                    player:CompleteQuest(12748)
                    player:RewardQuest(12748)
                end
                if (player:GetRace() == TAUREN) then
                    player:AddQuest(12739)
                    player:CompleteQuest(12739)
                    player:RewardQuest(12739)
                end
                if (player:GetRace() == NO_MUERTO) then
                    player:AddQuest(12750)
                    player:CompleteQuest(12750)
                    player:RewardQuest(12750)
                end
                if (player:GetRace() == TROLL) then
                    player:AddQuest(12749)
                    player:CompleteQuest(12749)
                    player:RewardQuest(12749)
                end
                player:AddQuest(13189)
                player:CompleteQuest(13189)
                player:RewardQuest(13189)
                -- Teletransporto al jugador a Orgrimmar spell: 17609
                player:CastSpell(player, 17609, false)
            end
        end
        player:GossipComplete()
    end
end

RegisterCreatureGossipEvent(npcEntry, 1, OnGossipHello)
RegisterCreatureGossipEvent(npcEntry, 2, OnGossipSelect)
