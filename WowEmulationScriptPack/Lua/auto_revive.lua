local maxlevel = 30


local function SKULY(eventid, delay, repeats, player)


local corpse = player:GetCorpse()

if corpse ~= nil then
local map = corpse:GetMap()
local mapID = map:GetMapId()
local inDungeon = map:IsDungeon()
local inBG = map:IsBattleground()
local isPvP = player:IsPvPFlagged()


if player:GetLevel() <= maxlevel then
if not inBG and not isPvP then
if player:HasAura( 8326 ) then
local O = corpse:GetO()
local X = corpse:GetX()
local Y = corpse:GetY()
local Z = corpse:GetZ()

player:ResurrectPlayer( 100, false )
player:Teleport( mapID, X, Y, Z, O )

player:CastSpell( player, 1302, true )
player:CastSpell( player, 15007, true )
local aura = player:AddAura( 15007, player )
aura:SetDuration( 45000 )
end
end


end

end


end


function Repop(event, player)
player:RegisterEvent(SKULY, 500, 2, player)
end


local function OnLogin(event, player)

	player:RegisterEvent(SKULY, 2000, 5, player)
	
end




RegisterPlayerEvent(3, OnLogin)
RegisterPlayerEvent(35, Repop)