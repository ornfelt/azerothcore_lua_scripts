--[[function Sulfuron_OnCombat(Unit,event)
	setvars(Unit,{Priests = {}})
	Unit:RegisterEvent("Sulfuron_Spells", 10000, 0)
	Unit:RegisterEvent("Sulfuron_Inspire", 15000, 0)
end

function Sulfuron_OnWipe(Unit,event)
	Unit:RemoveEvents()
	--setvars(Unit,true)
end
function Sulfuron_OnDied(Unit,event)
	Unit:RemoveEvents()
	--setvars(Unit,true)
end
function Sulfuron_Spells(Unit)
	local plr =	Unit:GetRandomPlayer(0)
	local rand = math.random(1,3)
	if rand == 1 then
		Unit:CastSpell(19780)
	elseif rand == 2 then
		Unit:CastSpell(19978)
	elseif rand == 3  and plr ~= nil then
		Unit:CastSpellOnTargeT(19781,plr)
	end
end
function Sulfuron_Inspire(Unit)
	local args = getvars(Unit)
	table.insert(args.Priests,Unit)
	for k,v in pairs(args.Priests) do
		if v ~= nil then
			Unit:CastSpellOnTarget(19779,v)
		end
	end
end

RegisterUnitEvent(12098,1,"Sulfuron_OnCombat")
RegisterUnitEvent(12098,2,"Sulfuron_OnWipe")
RegisterUnitEvent(12098,4,"Sulfuron_OnDied")

--[[
	PRIESTS AI
	]]
	


function Sulfuron_PriestCombat(Unit,event)
	local args = getvars(Unit)
	table.insert(args.Priests,Unit)
	Unit:RegisterEvent("Sulfuron_PriestSpells", 10000, 0)
	Unit:RegisterEvent("Sulfuron_PriestImmunityCheck", 5000, 0)
	Unit:RegisterEvent("Sulfuron_PriestHeal", 15000, 0)
	setvars(Unit, args); -- still need to write the changes back
end
function Sulfuron_PriestWipe(Unit,event)
	Unit:RemoveEvents()
end
function Sulfuron_PriestDied(Unit,event)
	Unit:RemoveEvents()
end
function Sulfuron_PriestSpells(Unit,event)
	local plr =	Unit:GetRandomPlayer(0)
	local rand = math.random(1,2)
	if rand == 1 and plr ~= nil then
		Unit:CastSpell(23952,plr)
	elseif rand == 2 and plr ~= nil then
		Unit:CastSpell(20294, plr)
	end
end
function Sulfuron_PriestImmunityCheck(Unit,event)
	if(Unit:HasAura(1714)== true) or (Unit:HasAura(11719) == true) then
		Unit:RemoveAura(1714)
		Unit:RemoveAura(11719)
	end
	Unit:CastSpell(6513)
end
function Sulfuron_PriestHeal(Unit)
	local tbl = {	Unit:GetInRangeFriends() }
	for k,v in pairs(tbl) do
		if math.random(0,1) < 0.5 then
			Unit:FullCastSpellOnTarget(36144, v)
		end
		break
	end
end

RegisterUnitEvent(11662,1,"Sulfuron_PriestCombat")
RegisterUnitEvent(11662,2,"Sulfuron_PriestWipe")
RegisterUnitEvent(11662,4,"Sulfuron_PriestDied")
]]--