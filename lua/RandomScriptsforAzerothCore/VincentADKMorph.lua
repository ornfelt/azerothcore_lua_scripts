local morph_commands = {
    ["#sally"] = 2043,
    ["#newthrall"] = 4527,
	["#oldthrall"] = 27656,
	["#cairne"] = 4307,
	["#velen"] = 17822,
	["#sylvanas"] = 28213,
	["#voljin"] = 10357,
	["#anduin"] = 11655,
	["#magni"] = 3597,
	["#tyrande"] = 7274,
	["#jaina"] = 2970,
	["#varian"] = 28127,
	["#bolvar"] = 5566,
	["#oldtirion"] = 9477,
	["#newtirion"] = 31011,
	["#vereesa"] = 28222,
	["#rhonin"] = 16024,
	["#putress"] = 27611,
	["#alexstraza"] = 28227,
	["#chromie"] = 24877,
	["#arthas"] = 24949,
	["#lk"] = 22234,
	["#saurfang"] = 14732,
	["#onyxia"] = 8570,
	["#nefarian"] = 9472,
	["#darkranger"] = 30073,
	["#millhouse"] = 19942,
}

local demorph_commands = {
    ["#demorph"] = true,
    ["#vincent"] = true,
}

local function MorphPlayer(event, player, message, type, language)
    local lower_message = string.lower(message)
    local morph_id = morph_commands[lower_message]

    if morph_id then
        player:SetDisplayId(morph_id)
        player:CastSpell(player, 51908, true) -- Added visual transform spell
        player:SendBroadcastMessage("You have been morphed into " .. lower_message:sub(2) .. "!")
        return false
    elseif demorph_commands[lower_message] then
        player:DeMorph()
        player:CastSpell(player, 51908, true) -- Added visual transform spell
        player:SendBroadcastMessage("Your morph has been reset to your original appearance.")
        return false
    end
end

RegisterPlayerEvent(18, MorphPlayer)