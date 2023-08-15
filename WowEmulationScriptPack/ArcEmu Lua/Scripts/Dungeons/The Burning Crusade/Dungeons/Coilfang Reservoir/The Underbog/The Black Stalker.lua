local CHAT_MSG_MONSTER_YELL = 14
local LANG_UNIVERSAL = 0
function Stalker_Charge(Unit)
	print "Stalker Charge"
	if Unit:GetClosestPlayer() ~= nil then
		Unit:FullCastSpellOnTarget(31715,Unit:GetClosestPlayer())
		Unit:SendChatMessage(CHAT_MSG_MONSTER_YELL,LANG_UNIVERSAL, "CHARGE...")
	end
end

function Stalker_Light(Unit)
	print "Stalker Light"
	if Unit:GetClosestPlayer() ~= nil then
		Unit:FullCastSpellOnTarget(31330,Unit:GetClosestPlayer())
		Unit:SendChatMessage(CHAT_MSG_MONSTER_YELL,LANG_UNIVERSAL, "I will kill you...")
	end
end

function Stalker_Levitate(Unit)
	print "Stalker Levitate"
	if Unit:GetRandomPlayer(0) ~= nil then
		Unit:FullCastSpellOnTarget(31704,Unit:GetRandomPlayer())
		Unit:SendChatMessage(CHAT_MSG_MONSTER_YELL,LANG_UNIVERSAL, "You want to fly...")
	end
end

function Stalker(Unit)
	print "Stalker"
	Unit:RegisterEvent("Stalker_Charge",7000,0)
	Unit:RegisterEvent("Stalker_Light",8000,0)
	Unit:RegisterEvent("Stalker_Levitate",11000,0)
end

RegisterUnitEvent(17882,1,"Stalker")