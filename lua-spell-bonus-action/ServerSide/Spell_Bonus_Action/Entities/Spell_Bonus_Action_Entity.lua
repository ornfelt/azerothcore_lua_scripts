local Object = require("Library.Object")
local Config = require("Spell_Bonus_Action.Config.Spell_Bonus_Action_Config")
local Spell_Bonus_Action = Object:extend()

function Spell_Bonus_Action:load()
    local data = WorldDBQuery(string.format("SELECT * FROM %s.index_spell_bonus_action", Config.DATABASE))
    if (data) then
        repeat
            local spell_id = data:GetUInt32(0)
            local texture = data:GetString(1)

            if (not self.spells[spell_id]) then
                self.spells[spell_id] = {
                    texture = texture,
                    conditions = { }
                }
            end
        until not data:NextRow()
    end

    local conditions = WorldDBQuery(string.format("SELECT * FROM %s.index_spell_bonus_action_conditions", Config.DATABASE))
    if (conditions) then
        repeat
            local spell_id = conditions:GetUInt32(0)
            local source_type = conditions:GetString(1)
            local source_id = conditions:GetUInt32(2)

            local index = #self.spells[spell_id].conditions + 1
            self.spells[spell_id].conditions[index] = {
                source_type = source_type,
                source_id = source_id,
            }

        until not conditions:NextRow()
        self:Order()
    end
end

function Spell_Bonus_Action:OrderBy(source_type, source_table)
    for spell_id, sub_array in pairs(self.spells) do
        for _, spell_data in pairs(sub_array.conditions) do
            if (spell_data.source_type == source_type) then
                source_table[spell_data.source_id] = spell_id
            end
        end
    end
end

function Spell_Bonus_Action:Order()
    self:OrderBy( "item"    ,  self.items )
    self:OrderBy( "map_id"  ,  self.maps  )
    self:OrderBy( "zone_id" ,  self.zones )
    self:OrderBy( "aura"    ,  self.auras )
    self:OrderBy( "area_id" ,  self.areas )
end

function Spell_Bonus_Action:new()
    self.spells = { }

    self.items = { }
    self.maps = { }
    self.zones = { }
    self.auras = { }
    self.areas = { }

    self:load()
end

local instance = nil
local function singleton()
    if not (instance) then
        instance = Spell_Bonus_Action()
    end
    return instance
end

return instance or singleton()