local NPC_ENTRY = 200005
local SMSG_NPC_TEXT_UPDATE = 384
local MAX_GOSSIP_TEXT_OPTIONS = 8
local missingLearning = true

local skills = {
    { id = 1, spellId = 264, skillId = 45, skillName = 'Arcos' },
    { id = 2, spellId = 5011, skillId = 226, skillName = 'Ballestas' },
    { id = 3, spellId = 2567, skillId = 176, skillName = 'Armas arrojadizas' },
    { id = 4, spellId = 1180, skillId = 173, skillName = 'Dagas' },
    { id = 5, spellId = 200, skillId = 229, skillName = 'Arma de asta' },
    { id = 6, spellId = 198, skillId = 54, skillName = 'Mazas' },
    { id = 7, spellId = 199, skillId = 160, skillName = 'Mazas de dos manos' },
    { id = 8, spellId = 266, skillId = 46, skillName = 'Armas de fuego' },
    { id = 9, spellId = 201, skillId = 43, skillName = 'Espadas de una mano' },
    { id = 10, spellId = 202, skillId = 55, skillName = 'Espadas de dos manos' },
    { id = 11, spellId = 5009, skillId = 228, skillName = 'Varitas' },
    { id = 12, spellId = 196, skillId = 44, skillName = 'Hachas de una mano' },
    { id = 13, spellId = 197, skillId = 172, skillName = 'Hachas de dos manos' },
    { id = 14, spellId = 227, skillId = 136, skillName = 'Bastones' },
    { id = 15, spellId = 204, skillId = 95, skillName = 'Defensa' },
    { id = 16, spellId = 203, skillId = 162, skillName = 'Sin armas' },
}

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

function checkSpells(_skills, _player)
    local missingSkillCount = 0
    for key, value in pairs(_skills) do
        if ((_player:HasSpell(value.spellId) and (_player:GetSkillValue(value.skillId) ~= 400))) then
            missingSkillCount = missingSkillCount + 1
        end
    end
    if missingSkillCount > 0 then return true else return false end
end

function OnGossipHello(_event, _player, _object)
    if (_player:IsInCombat() == false) then
        _player:GossipClearMenu()
        _player:GossipSetText("Saludos |c990B0Bee$n|h|r. Bienvenido al Servidor. Mi objetivo es subirte la habilidad de armas hasta el 400. Pero primero necesitas visitar el instructor para aprender dicha habilidad si no la conoces.$B$B- Requiere nivel 80.$B- Requiere conocer la habilidad.")
        if (_player:GetLevel() == 80) then
            for key, value in pairs(skills) do
                if ((_player:HasSpell(value.spellId) and (_player:GetSkillValue(value.skillId) ~= 400))) then
                    _player:GossipMenuAddItem(0, value.skillName, 1, value.id)
                end
            end
            if (missingLearning == checkSpells(skills, _player)) then
                _player:GossipMenuAddItem(0, 'Aprender todo', 1, #skills + 1)
            end
        end
        _player:GossipSendMenu(0x7FFFFFFF, _object)
    end
end

function OnGossipSelect(_event, _player, _object, _sender, _intid, _code, _menuid)
    for key, value in pairs(skills) do
        if (_intid == value.id) then
            _player:AdvanceSkill(value.skillId, _player:GetMaxSkillValue(value.skillId))
        end
    end
    if (_intid == #skills + 1) then
        _player:AdvanceSkillsToMax()
    end
    _player:GossipComplete()
end

RegisterCreatureGossipEvent(NPC_ENTRY, 1, OnGossipHello)
RegisterCreatureGossipEvent(NPC_ENTRY, 2, OnGossipSelect)
