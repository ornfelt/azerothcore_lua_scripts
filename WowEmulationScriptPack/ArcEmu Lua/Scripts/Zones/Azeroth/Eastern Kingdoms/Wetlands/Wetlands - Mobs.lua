--[[

	This is created by zdroid9770  :D

	© Copyright 2012

]]



function Axtroz_OnCombat(pUnit, event)
	pUnit:pUnit:RegisterEvent("Breath", 10000, 0)
	pUnit:pUnit:RegisterEvent("Rend", 15000, 0)
end

function Breath(pUnit, event)
local Main = pUnit:GetMainTank()
	pUnit:FullCastSpellOnTarget(20712, Main)
	if Main ~= nil then
	else
	end
end

function Rend(pUnit, event)
local Main = pUnit:GetMainTank()
pUnit:FullCastSpellOnTarget(20712, Main)
	if Main ~= nil then
	else
	end
end

function Axtroz_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function Axtroz_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(12899, 1, "Axtroz_OnCombat")
RegisterUnitEvent(12899, 2, "Axtroz_OnLeaveCombat")
RegisterUnitEvent(12899, 4, "Axtroz_OnDeath")

--[[
function BalgarastheFoul_OnCombat(pUnit, event)
	pUnit:RegisterEvent("FrostN", 10000, 0)
	pUnit:RegisterEvent("Volley", 15000, 0)
	pUnit:RegisterEvent("Volatile', 20000, 0)
end

function FrostN(pUnit, event)
end
]]--


function BlackSlime_OnCombat(pUnit, event)
	pUnit:RegisterEvent("Sludge", 300000, 0)
end

function Sludge(pUnit, event)
local Target = pUnit:GetMainTarget()
	if Target ~= nil then
		pUnit:FullCastSpellOnTarget(3335, Target)
	else
	end
end

function BlackSlime_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function BlackSlime_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(1030, 1, "BlackSlime_OnCombat")
RegisterUnitEvent(1030, 2, "BlackSlime_OnLeaveCombat")
RegisterUnitEvent(1030, 4, "BlackSlime_OnDeath")

function MosshideGnoll_OnCombat(pUnit, event)
local text = math.random(1,2)
	if(text == 1) then
		pUnit:SendChatMessage(14, 0, "Grrrr... fresh meat!")
	end
	if(text == 2) then
		pUnit:SendChatMessage(14, 0, "More bones to gnaw on...")
	end
end
function MosshideGnoll_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function MosshideGnoll_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(1007, 1, "MosshideGnoll_OnCombat")
RegisterUnitEvent(1007, 2, "MosshideGnoll_OnLeaveCombat")
RegisterUnitEvent(1007, 4, "MosshideGnoll_OnDeath")

function MosshideMongrel_OnCombat(pUnit, event)
	pUnit:pUnit:RegisterEvent("Decay", 10000, 0)
end
function Decay(pUnit, event)
local plr = pUnit:GetMainTank()
	if plr ~= nil then
		pUnit:CastSpellOnTarget(8016, plr)
	else
	end
end
function MosshideMongrel_OnLeaveCombat(pUnit, event)
	pUnit:RemoveEvents()
end

function MosshideMongrel_OnDeath(pUnit, event)
	pUnit:RemoveEvents()
end

RegisterUnitEvent(1008, 1, "MosshideMongrel_OnCombat")
RegisterUnitEvent(1008, 2, "MosshideMongrel_OnLeaveCombat")
RegisterUnitEvent(1008, 4, "MosshideMongrel_OnDeath")