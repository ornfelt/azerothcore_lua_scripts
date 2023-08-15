-- Defensive Stance Spells --

local SHIELDBLOCK = 2565
local CONCUSSION = 12809
local DEVASTATE = 20243
local SHOCKWAVE = 46968
local HEROIC = 41975

-- Arms Stance Spells -- 



function Yuriv_OnCombat(pUnit, event)
	pUnit:CastSpell(71)
	pUnit:RegisterEvent("Phase2", 1000, 0)
	pUnit:RegisterEvent("ShieldBlock", 20000, 0)
	pUnit:RegisterEvent("HeroicStrike", math.random(5000, 8000), 0)
	pUnit:RegisterEvent("Shockwave", math.random(40000, 45000), 0)
	pUnit:RegisterEvent("Devastate", math.random(3000, 6000), 0)
	pUnit:RegisterEvent("ThunderClap", 12000, 0)
	pUnit:RegisterEvent("Concussion", 24000, 0)
end

function Phase2(pUnit, event)
	if(pUnit:GetHealthPct() < 60) then
		pUnit:RemoveEvents()
		pUnit:RegisterEvent("PhaseRegister", 1000, 1)
		end
end

function Concussion(pUnit, event)
	pUnit:CastSpellOnTarget(CONCUSSION, pUnit:GetMainTank())
end

function ThunderClap(pUnit, event)
	pUnit:CastSpell(69965)
end

function ShieldBlock(pUnit, event)
	pUnit:CastSpell(SHIELDBLOCK)
end

function HeroicStrike(pUnit, event)
	pUnit:CastSpellOnTarget(HEROIC, pUnit:GetMainTank())
end

function Shockwave(pUnit, event)
	pUnit:CastSpellOnTarget(SHOCKWAVE, pUnit:GetMainTank())
end

function Devastate(pUnit, event)
	pUnit:CastSpellOnTarget(DEVASTATE, pUnit:GetMainTank())
end

function PhaseRegister(pUnit, event)
	pUnit:SetUInt32Value(UNIT_FIELD_MINDAMAGE, 5000)
	pUnit:SetUInt32Value(UNIT_FIELD_MAXDAMAGE, 9000)
	pUnit:SendChatMessage(12, 0, "Ill eat you hearth!")
	pUnit:PlaySoundToSet(13542)
	pUnit:CastSpell(54287)
	pUnit:EquipWeapons(49888, 0, 0)
	pUnit:RegisterEvent("MortalStrike", math.random(7000, 14000), 0)
	pUnit:RegisterEvent("HeroicStrike", math.random(9000, 11000), 0)
	pUnit:RegisterEvent("BladeStorm", 45000, 0)
	
end

function Bladestorm(pUnit, event)
	pUnit:WhipeThreatList()
	pUnit:ChannelSpell(69652)
	pUnit:SetCombatCapable(1)
end

	
function MortalStrike(pUnit, event)
	pUnit:CastSpellOnTarget(15708, pUnit:GetMainTank())
end

function HeroicStrike(pUnit, event)
	pUnit:CastSpellOnTarget(69566, pUnit:GetMainTank())
end

function Yuriv_OnLeaveCombat(pUnit, event)
	pUnit:Despawn(5000, 0)
end

RegisterUnitEvent(700020, 1, "Yuriv_OnCombat")
RegisterUnitEvent(700020, 2, "Yuriv_OnLeaveCombat")