local gobID1 = 1815000
local gobID2 = 1815001
local gobID3 = 1815002
local gobID4 = 1815003
local gobID5 = 1816820
local gobID6 = 1816821
local gobID7 = 1816822
local gobID8 = 1816823
local gobID9 = 1816824

local aura1 = 700145
local aura2 = 700146
local aura3 = 700147
local aura4 = 700148

local function cauldron(event, go, player)
    local chance = math.random(10)
    if(chance > 9) then
        player:AddAura(aura1,player)
    elseif(chance > 6) then
        player:AddAura(aura2,player)
    elseif(chance > 3) then
        player:AddAura(aura3,player)
    elseif(chance > 2) then
        player:AddAura(aura4,player)
	else
		player:Kill(player)
    end
end



RegisterGameObjectEvent( gobID1, 14, cauldron )
RegisterGameObjectEvent( gobID2, 14, cauldron )
RegisterGameObjectEvent( gobID3, 14, cauldron )
RegisterGameObjectEvent( gobID4, 14, cauldron )
RegisterGameObjectEvent( gobID5, 14, cauldron )
RegisterGameObjectEvent( gobID6, 14, cauldron )
RegisterGameObjectEvent( gobID7, 14, cauldron )
RegisterGameObjectEvent( gobID8, 14, cauldron )
RegisterGameObjectEvent( gobID9, 14, cauldron )
