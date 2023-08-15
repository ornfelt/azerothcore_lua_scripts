--[[ Gastric - VenomclawBehemoth.lua

Venomclaw Behemoth LUA script

Outline of the fight: ( [#] = Phase number )
[0] - Weaken the boss to phase one (80% hp)
[1] - Tank and spank part. The Behemoth will spit out
a few whirlwind attacks but nothing major
[2] - At 70% He will use stoneform and increase damage
a little bit. This is where healers come in a step it up.
[3] - At 60% He will charge at random players then run
back to the tank
[4] - At 50% he will increase the number of whirlwind
attacks and increase damage.
[5] - This is the best part, at 25% he will not be able
to be attacked. He will stop the fight, stand up, and yell
'IM CHARGIN MAH LAZER'. He will begin to grow in size,
at this point, the whole fucking raid should get behind him.
Once he is at his max scale, he will yell "SHOOP DA WHOOP"
and fire a massive lazer into anyone in front of him.
[6] - After phase 5, he will become attackable again and then
it will be a simple tank and spank.

-- By Gastricpenguin ]]

--[[ PHAS E ONE]] --
function Vencomclaw_Phase1(Unit, event)
	if Unit:GetHealthPct() < 72 then
		Unit:RemoveEvents()
		Unit:SendChatMessage(12, 0, "The skin becomes dense with pain!")
		Unit:CastSpell(20594)
		Unit:RegisterEvent("Venomclaw_Strike",6000, 0)
		Unit:RegisterEvent("Venomclaw_Phase2",1000, 0)
	end
end

function Venomclaw_Strike(Unit)
	Unit:CastSpell(3130)
end

--[[ PHASE TWO]]--
function Venomclaw_Phase2(Unit, event)
	if Unit:GetHealthPct() < 62 then
		Unit:RemoveEvents()
		Unit:SendChatMessage(12, 0, "CHARGE!")
		Unit:CastSpell(31715)
		Unit:RegisterEvent("Venomclaw_charge",8000, 0)
		Unit:RegisterEvent("Venomclaw_Phase3",1000, 0)
	end
end

function Venomclaw_charge(Unit)
	Unit:CastSpell(31715)
end

--[[ PHASE THREE ]]--
function Venomclaw_Phase3(Unit, event)
	if Unit:GetHealthPct() < 52 then
		Unit:RemoveEvents()
		Unit:SendChatMessage(12, 0, "Take this!")
		Unit:CastSpell(36981)
		Unit:RegisterEvent("Venomclaw_spin",10000, 0)
		Unit:RegisterEvent("Venomclaw_Phase4",1000, 0)
	end
end

function Venomclaw_spin(Unit)
	Unit:CastSpell(36981)
end

--[[ PHASE FOUR ]]--
function Venomclaw_Phase4(Unit, event)
	if Unit:GetHealthPct() <= 26 then
		Unit:RemoveEvents()
		Unit:SetCombatCapable(1)
		Unit:SetScale(4)
		Unit:CastSpell(18501)
		Unit:SendChatMessage(12, 0, "IMA CHARGIN MAH LAZER!")
		Unit:RegisterEvent("Venomclaw_shoop",7000, 0)
	end
end

function Venomclaw_shoop(Unit, event)
	Unit:RemoveEvents()
	Unit:SetScale(3)
	Unit:CastSpell(37433)
	Unit:SetCombatCapable(0)
	Unit:SendChatMessage(12, 0, "SHOOP DA WHOOP!")
end

function Venomclaw_OnCombat(Unit, event)
	Unit:SendChatMessage(11, 0, "Feline fists of fury, don't fail me now!")
	Unit:RegisterEvent("Vencomclaw_Phase1",1000, 0)
	Unit:RegisterEvent("Venomclaw_Strike",6000, 0)
end

function Venomclaw_OnLeaveCombat(Unit)
	Unit:RemoveEvents()
end

function Venomclaw_OnKilledTarget(Unit)
	Unit:SendChatMessage(11, 0, "Your soul belongs to me now!")
	Unit:CastSpell(36981)
end

function Venomclaw_Death(Unit)
	Unit:SendChatMessage(12, 0, "Charles no! Ye got in mah head charles!")
	Unit:RemoveEvents()
end

RegisterUnitEvent(100250, 1, "Venomclaw_OnCombat")
RegisterUnitEvent(100250, 2, "Venomclaw_OnLeaveCombat")
RegisterUnitEvent(100250, 3, "Venomclaw_OnKilledTarget")
RegisterUnitEvent(100250, 4, "Venomclaw_Death")