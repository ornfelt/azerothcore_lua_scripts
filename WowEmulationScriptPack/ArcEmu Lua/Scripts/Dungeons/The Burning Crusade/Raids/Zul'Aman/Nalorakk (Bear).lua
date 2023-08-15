--[[ Boss - Felmyst.lua

This script was written and is protected
by the GPL v2. This script was released
by Performer of the Blua Scripting
Project. Please give proper accredidations
when re-releasing or sharing this script
with others in the emulation community.

Credits to GregPohlod of Hypnotic-wow.com

~~End of License Agreement
-- Performer, November 1st, 2008. ]]



function Nalorakk_OnCombat(Unit, event, miscunit, misc)
Unit:SendChatMessage(12, 0, "You be dead soon enough!")
Unit:RegisterEvent("Nalorakk_Bear", 68000, 1)
Unit:RegisterEvent("Nalorakk_Troll", 168000, 1)
Unit:RegisterEvent("Nalorakk_Bear2", 291000, 1)
Unit:RegisterEvent("Nalorakk_Troll2", 378000, 1)
Unit:RegisterEvent("Nalorakk_Bear3", 487000, 1)
Unit:RegisterEvent("Nalorakk_Troll3", 554000, 1)
Unit:RegisterEvent("Nalorakk_Brutal_Swipe", 13000, 4)
Unit:RegisterEvent("Nalorakk_Mangle", 29000, 2)
Unit:RegisterEvent("Nalorakk_Surge", 21000, 3)
end

function Nalorakk_Bear(Unit, event, miscunit, misc)
Unit:RegisterEvent("Nalorakk_Lacerating_Slash", 28000, 3)
Unit:RegisterEvent("Nalorakk_Rend_Flesh", 18000, 5)
Unit:RegisterEvent("Nalorakk_Deafening_Roar", 24000, 4)
Unit:SendChatMessage(12, 0, "You call on da beast, you gonna get more dan you bargain for!!")
Unit:SetModel(21635)
Unit:SetScale(2)
end

function Nalorakk_Bear2(Unit, event, miscunit, misc)
Unit:RegisterEvent("Nalorakk_Lacerating_Slash", 28000, 3)
Unit:RegisterEvent("Nalorakk_Rend_Flesh", 18000, 4)
Unit:RegisterEvent("Nalorakk_Deafening_Roar", 24000, 3)
Unit:SendChatMessage(12, 0, "You call on da beast, you gonna get more dan you bargain for!!")
Unit:SetModel(21635)
Unit:SetScale(2)
end

function Nalorakk_Bear3(Unit, event, miscunit, misc)
Unit:RegisterEvent("Nalorakk_Lacerating_Slash", 28000, 2)
Unit:RegisterEvent("Nalorakk_Rend_Flesh", 18000, 3)
Unit:RegisterEvent("Nalorakk_Deafening_Roar", 24000, 2)
Unit:SendChatMessage(12, 0, "You call on da beast, you gonna get more dan you bargain for!!")
Unit:SetModel(21635)
Unit:SetScale(2)
end

function Nalorakk_Troll(Unit, event, miscunit, misc)
Unit:RegisterEvent("Nalorakk_Brutal_Swipe", 13000, 9)
Unit:RegisterEvent("Nalorakk_Mangle", 29000, 4)
Unit:RegisterEvent("Nalorakk_Surge", 21000, 6)
Unit:SendChatMessage(12, 0, "Make way for Nalorakk!")
Unit:SetModel(21631)
Unit:SetScale(1)
end

function Nalorakk_Troll2(Unit, event, miscunit, misc)
Unit:RegisterEvent("Nalorakk_Brutal_Swipe", 13000, 8)
Unit:RegisterEvent("Nalorakk_Mangle", 27000, 4)
Unit:RegisterEvent("Nalorakk_Surge", 21000, 5)
Unit:SendChatMessage(12, 0, "Make way for Nalorakk!")
Unit:SetModel(21631)
Unit:SetScale(1)
end

function Nalorakk_Troll3(Unit, event, miscunit, misc)
Unit:RegisterEvent("Nalorakk_Brutal_Swipe", 13000, 0)
Unit:RegisterEvent("Nalorakk_Mangle", 29000, 0)
Unit:RegisterEvent("Nalorakk_Surge", 21000, 0)
Unit:SendChatMessage(12, 0, "Make way for Nalorakk!")
Unit:SetModel(21631)
Unit:SetScale(1)
end

function Nalorakk_Brutal_Swipe(pUnit, event, miscunit, misc)
pUnit:FullCastSpellOnTarget(42384, pUnit:GetMainTank())
end

function Nalorakk_Mangle(pUnit, event, miscunit, misc)
pUnit:FullCastSpellOnTarget(33987, pUnit:GetMainTank())
end

function Nalorakk_Surge(pUnit, event, miscunit, misc)
pUnit:FullCastSpellOnTarget(42402, pUnit:GetRandomPlayer(0))
end

function Nalorakk_Lacerating_Slash(pUnit, event, miscunit, misc)
pUnit:FullCastSpellOnTarget(42395, pUnit:GetMainTank())
end

function Nalorakk_Rend_Flesh(pUnit, event, miscunit, misc)
pUnit:FullCastSpellOnTarget(42397, pUnit:GetMainTank())
end

function Nalorakk_Deafening_Roar(pUnit, event, miscunit, misc)
pUnit:CastSpell(42398, pUnit:GetMainTank())
end

function Nalorakk_OnLeaveCombat(Unit, event, miscunit, misc)
Unit:RemoveEvents()
Unit:SetModel(21631)
end

function Nalorakk_OnDied(Unit, event, miscunit, misc)
Unit:RemoveEvents()
Unit:SendChatMessage(12, 0, "I... be waitin' on da udda side.... ")
end

function Nalorakk_OnKilledTarget(Unit, event, miscunit, misc)
Unit:SendChatMessage(12, 0, "Now whatchoo got to say?")
end

RegisterUnitEvent(23576, 1, "Nalorakk_OnCombat")
RegisterUnitEvent(23576, 2, "Nalorakk_OnLeaveCombat")
RegisterUnitEvent(23576, 3, "Nalorakk_OnKilledTarget")
RegisterUnitEvent(23576, 4, "Nalorakk_OnDied")
