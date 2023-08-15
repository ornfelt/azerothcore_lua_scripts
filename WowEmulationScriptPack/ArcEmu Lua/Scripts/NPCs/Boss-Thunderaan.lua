--[[***************************
*      .-.                *
*      `-.. ..-. + +      *
*      `-''-'' '          *
*  OpenSource Scripting   *
*          Team           *
* http://sunplusplus.info *
*                         *
***************************
This software is provided as free and open source by the
staff of the Sun++ Scripts Project, in accordance with 
the GPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

Sun++ Team, July 2008
~~End of License Agreement
Made by rdn]]

local CHAT_MSG_MONSTER_YELL = 14
local LANG_UNIVERSAL = 0
local ThunderaanID = 14435
function KnockbackRepeat(unit)
	local plr=unit:GetMainTank()
	if plr ~= nil then
		unit:CastSpell(19813)
	end
end

function WipeAggro(unit)
	unit:ClearThreatList()
end

function OnCombat(unit)
	unit:Root()
	unit:SendChatMessage(CHAT_MSG_MONSTER_YELL,LANG_UNIVERSAL,"My power is discombobulatingly devastating! It is ludicrous that these mortals even attempt to enter my realm!")
	unit:PlaySoundToSet(8436)
	unit:RegisterEvent("KnockbackRepeat",15000,0)
	unit:RegisterEvent("WipeAggro",15000,0)
end

function OnLeave(unit)
	unit:Despawn(1000, 0)
end

function OnDied(unit)
	unit:RemoveEvents()
	unit:PlaySoundToSet(8435)
end

RegisterUnitEvent(ThunderaanID, 1, "OnCombat")
RegisterUnitEvent(ThunderaanID, 2, "OnLeave")
RegisterUnitEvent(ThunderaanID, 4, "OnDied")