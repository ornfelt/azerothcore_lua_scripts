--[[
symbol  group name          parser field
------  ----------          ------------
s       syllablesStart      parser_data["start"]
m       syllablesMiddle     parser_data["middle"]
e       syllablesEnd        parser_data["end"]
P       syllablesPre        parser_data["pre"]
p       syllablesPost       parser_data["post"]
v       phonemesVocals      parser_data["vocals"]
c       phonemesConsonants  parser_data["consonants"]
A       customGroupA        parser_data["cga"]
B       customGroupB        parser_data["cgb"]
C       customGroupC        parser_data["cgc"]
D       customGroupD        parser_data["cgd"]
E       customGroupE        parser_data["cge"]
F       customGroupF        parser_data["cgf"]
G       customGroupG        parser_data["cgg"]
H       customGroupH        parser_data["cgh"]
I       customGroupI        parser_data["cgi"]
J       customGroupJ        parser_data["cgj"]
K       customGroupK        parser_data["cgk"]
L       customGroupL        parser_data["cgl"]
M       customGroupM        parser_data["cgm"]
N       customGroupN        parser_data["cgn"]
O       customGroupO        parser_data["cgo"]
v       phonemesVocals      parser_data["vocals"]
?       phonemesConsonants  parser_data["consonants"]
]]
local PATH = string.match(debug.getinfo(1,"S").source,
                          "^@(.+/)[%a%-%d_]+%.lua$") or "./"
local CFGName = "itemdefinitions.cfg"
local function loadrequire(module)
    local loaded
    local function requiref(module)
        loaded = require(module)
    end
    pcall(requiref, module)
    return loaded
end

local RangedTable = require("namegen.rangedtable")

-- ======================
--  VARIABLES
-- ======================

-- the table containing the generators
local namegen_generators_list = {}
local namegen = {}

-- ======================
--  UTILITIES
-- ======================

local function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local function get_path(filename)
    if filename:find("%.cfg$") then
        return PATH .. filename
    else
        return PATH .. filename .. ".cfg"
    end
end

local function split(str)
    local t = {}
    for v in string.gmatch(str:gsub(",", ""), "%S+") do
        t[#t + 1] = v
    end
    return t
end



-- ======================
--  PARSERS
-- ======================

local function parse_rules(rules)
    local rules_weight = {}
    local rule_pattern = [[^%%*(%d*)(%S+)]]
    for _, v in pairs(rules) do
        local chance, rule = string.match(v, rule_pattern)
        chance = chance == "" and 100 or tonumber(chance)
        rules_weight[#rules_weight + 1] = {chance, rule}
    end
    return RangedTable(rules_weight)
end

local function parse_property(name, value, parser_data)
    local v = name == "name" and value or split(value)
        if name == "name" then
        parser_data["name"] = v
    elseif name == "syllablesStart" then
        parser_data["start"] = v
    elseif name == "syllablesMiddle" then
        parser_data["middle"] = v
    elseif name == "syllablesEnd" then
        parser_data["end"] = v
    elseif name =="syllablesPre" then
        parser_data["pre"] = v
    elseif name =="syllablesPost" then
        parser_data["post"] = v
    elseif name == "phonemesVocals" then
        parser_data["vocals"] = v
    elseif name =="phonemesConsonants" then
        parser_data.consonants = v
    elseif name == "rules" then
        parser_data["rules"] = parse_rules(v)
    elseif name == "illegal" then
        -- /* illegal strings are converted to lowercase */
        parser_data.illegal = split(string.lower(value))
    else
        local cg = string.match(name, "^customGroup(%a)")
        if cg then
            parser_data["cg" .. cg:lower()] = v
        else
            return false
        end
    end
    return true
end

local function parse_lines(path, data)
    local data
    local name_pattern = [[name ?"(.+)" ?{]]
    local property_pattern = [[ +(.+) = "(.+)"]]
    local end_body_pattern = [[}]]

    local body = false
    for line in io.lines(path) do
        local name = string.match(line, name_pattern)
        if name ~= nil then
            namegen_generators_list[name] = {}
            data = namegen_generators_list[name]
            parse_property("name", name, data)
            body = true
        elseif body == true then
            if string.match(line, end_body_pattern) then
                body = false
            else
                local name, value = string.match(line, property_pattern)
                if name and value then
                    parse_property(name, value, data)
                end
            end
        end
    end
end

local function parse_index()
    local path = get_path(CFGName)
    if not file_exists(path) then
        error(string.format("File \"%s\" not found!\n",path))
    end
    parse_lines(get_path(CFGName))
end


-- ======================
--  WORD VALIDATION
-- ======================

-- check for occurrences of triple characters (case-insensitive)
local function word_has_triples(str)
    local str = str:lower()
    for i = 1, #str - 2 do
        local a = str:sub(i, i)
        local b = str:sub(i+1, i+1)
        local c = str:sub(i+2, i+2)
        if a == b and a == c then
            return true
        end
    end
    return false
end

-- check for occurrences of illegal strings (case-insensitive)
local function word_has_illegal(data, str)
    local str = str:lower()

    if not data.illegal then return false end

    for i  = 1, #data.illegal do
        if str:find(data.illegal[i]) then
            return true
        end
    end
    return false
end

-- check for repeated syllables (case-insensitive)
local function word_repeated_syllables(str)
    local word = str:lower():gsub("['%-_]", "")

    for step = 2, math.min(5, math.floor(#str / 2)) do
        for i = 1, #word - step + 1 do
            local search = word:sub(i, i + step - 1)
            local sub = word:sub(i + step, (i + step) + step - 1)
            if search == sub then
                return true
            end
        end
    end
    return false
end

-- verify if the word passes the above checks
local function word_is_ok(data, str)
    return ((#str > 0) and
            not word_has_triples(str) and
            not word_has_illegal(data, str) and
            not word_repeated_syllables(str))
end

-- removes double, leading and ending spaces
local function word_prune_spaces(str)
    str = str:gsub(" +$", "")
    str = str:gsub("^ +", "")
    str = str:gsub(" +", " ")
    return str
end

local function get_lst_from_token(token, data)
    if token == 'P' then
        return data["pre"]
    elseif token == 's' then
        return data["start"]
    elseif token == 'm' then
        return data["middle"]
    elseif token == 'e' then
        return data["end"]
    elseif token == 'p' then
        return data["post"]
    elseif token == 'v' then
        return data["vocals"]
    elseif token == 'c' then
        return data["consonants"]
    elseif token == '?' then
        return ((random(1, 2) == 1) and data.vocals or
               data.consonants)
    elseif token >= "A" and token < "P" then
        return data["cg" .. token:lower()]
    elseif token == "'" then
        return {"'"}
    end
end

local function generate_custom(name, rule)
    local random = math.random

    local data = namegen_generators_list[name]
    if data == nil then
        error(string.format("The name \"%s\" has not been found.\n",name))
    end

    -- start name generation
    local buf, i, it
    repeat
        buf = ""
        i = 1
        while i <= #rule do
            it = rule:sub(i, i)
            -- append normal character
            if ((it >= 'a' and it <= 'z') or
                (it >= 'A' and it <= 'Z') or
                it == '\'' or it == '-')
            then
                buf = buf .. it
            elseif it == '/' then
                -- special character
                i = i + 1
                buf = buf .. it
            elseif it == '_' then
                -- convert underscore to space
                buf = buf .. " "
            -- interpret a wildcard
            elseif it == '$' then
                local chance = 100;
                i = i + 1
                local it = rule:sub(i, i)
                -- food for the randomiser
                if it >= '0' and it <= '9' then
                    chance = 0
                    while it >= '0' and it <= '9' do
                        chance = chance * 10
                        chance = chance + tonumber(it)
                        i = i + 1
                        it = rule:sub(i, i);
                    end
                end
                -- evaluate the wildcard according to its chance
                if chance >= random(100) then
                    local lst = get_lst_from_token(it, data)
                    if lst == nil then
                        error(string.format(
                            [[Wrong rules syntax(it:"%s", rule:"%s")]],
                            it, rule))
                    end
                    -- got the list, now choose something on it
                    if #lst == 0 then
                        error(string.format(
                            "No data found in the requested string (wildcard %s). Check your name generation rule %s.",
                            it,rule
                        ))
                    else
                        buf = buf .. (lst[random(1, #lst)]:gsub('_', ' '))
                    end
                end
            end
            i = i + 1
        end
    until word_is_ok(data, buf)

    -- prune undesired spaces and return the name
    return word_prune_spaces(buf)
end

-- generate a new name with one of the rules from set
local function generate(name)
    local data = namegen_generators_list[name]
    if data == nil then
        error(string.format("The name \"%s\" has not been found.\n",name))
    end
    -- check if the rules list is present */
    if data.rules:size() == 0 then
        error("The rules list is empty!")
    end

    -- choose the rule */
    local res = generate_custom(name, data.rules:choice())
    return res
end

local function possible_rules(str)
    local res = {[str] = true}
    while true do
        local changed = false
        local count = #res
        for rule, _ in pairs(res) do
            local chance_rule = rule:match(
                "%$?[%a_'%- ]*(%$%d+[%a_'%- ]+)%$*.*$")
            -- print(rule, chance_rule)
            if chance_rule then
                local a = rule:gsub(chance_rule, "")
                local b = rule:gsub("%$%d+", "$", 1)
                -- print(rule, a, b)
                res[rule] = nil
                res[a] = true
                res[b] = true
                changed = true
                break
            end
        end
        if not changed then break end
    end
    --[[
    print(str)
    for k, _ in pairs(res) do
        print(k)
    end
    ]]--
    return res
end

local function exhaust_rules(name)
    local data = namegen_generators_list[name]
    local rules = {}
    for v in data.rules:values() do
        rules[#rules + 1] = v
    end
    local plain_rules = {}
    for _, rule in ipairs(rules) do
        local possible = possible_rules(rule)
        for plain, _ in pairs(possible) do
            plain_rules[#plain_rules + 1] = plain
        end
    end
    return plain_rules
end

local function combine_strings(...)
    local str
    for _, v in pairs(...) do
        str = (str and " " or "") .. v
    end
    return str
end

local function map_all(fcn, tab, idx, ...)
    -- http://stackoverflow.com/a/13059680/5496529
    if idx < 1 then
        fcn(...)
    else
        local t = tab[idx]
        for i = 1, #t do map_all(fcn, tab, idx-1, t[i], ...) end
    end
end

local function exhaust_set(name)
    local names = {}
    local data = namegen_generators_list[name]
    local rules = exhaust_rules(name)
    local function combine(...)
        local t = {...}
        local str
        for i, v in ipairs(t) do
            if v ~= nil and v ~= "" then
                str = (str and (str .. v) or v)
            end
        end
        print(str)
        str = word_prune_spaces(str)
        names[str] = str
    end
    for _, rule in ipairs(rules) do
        local groups = {}
        local tokens = split(rule:gsub("%$", " "))
        for _, token in ipairs(tokens) do
            for c in string.gmatch(token, ".") do
                local lst = (get_lst_from_token(c, data) or
                             {[1] = c:gsub("_", " ")})
                if lst == nil then
                    error("invalid list", c)
                end
                groups[#groups + 1] = lst
            end
        end
        map_all(combine, groups, #groups)
    end
    return names
end


local function get_sets()
    local t = {}
    for k, _ in pairs(namegen_generators_list) do
        if namegen_generators_list[k].rules then
            t[#t + 1] = k
        end
    end
    return t
end


-- ------------------------------
--  load default sets (as specified on `namegen.index`)
-- ------------------------------
parse_index()


-- ------------------------------
--  publicly available functions
-- ------------------------------

namegen.get_sets = get_sets
namegen.generate = generate
namegen.generate_custom = generate_custom
namegen.exhaust_set = exhaust_set
namegen.exhaust_rules = exhaust_rules

return namegen
