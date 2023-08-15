function Essence_AngerOnCombat(Unit, event)
	setvars(Unit, {dup=0,qtick=0,qactive=0});
	Unit:SendChatMessage(14,0, "Beware - I live!")
	--will look up for sound id -if there is any- when i reach home
	Unit:RegisterEvent("Ess_Aura",1000,0)
	Unit:RegisterEvent("Rand_Quotes",10000, 0)
	Unit:RegisterEvent("Rand_Quotespeech",10000, 0)
	Unit:RegisterEvent("Ess_Seethe",15000, 3)
	Unit:RegisterEvent("Ess_Spells",35000, 0)
end

function Ess_Aura(Unit, event)
	Unit:CastSpell(41337)
end

function Rand_Quotes(Unit, event)
	local args = getvars(Unit);
	local HealthCheck =	Unit:GetHealthPct()
	if (HealthCheck <= 95) then
		args.qactive = 1;
		args.qtick = 1;
	end
	setvars(Unit, args);
end

function Rand_Quotespeech(Unit, event)
	-- math randies mite be inserted in here
	local args = getvars(Unit);
	if (args.qactive == 1 and args.qtick == 1) then
		args.qtick = args.qtick + 1;
		if (args.qtick == 35 ) then
			Unit:SendChatMessage(13,0,"So foolish!");
		end
		if (args.qtick == 75 ) then
			Unit:SendChatMessage(13,0,"I won't be ignored!");
		end
		if (args.qtick == 115) then
			Unit:SendChatMessage(13,0,"On your knees!");
		end
		if (args.qtick == 145) then
			args.qtick = 1;
		end
	end
	setvars(Unit, args);
end

function Ess_Seethe(Unit, event)
-- not blizzlike as there is no if switch target funct(prolly there is one i could use,but cbb)
	Unit:CastSpell(41520)
end

function Ess_Spells(Unit, event)
	local RandSpellz = math.random(1,2)
	if (RandSpellz == 1) then
		local plr =	Unit:GetMainTank(0)
		if (plr ~= nil) then
			Unit:CastSpellOnTarget(41545, plr)
		end
	end
	if (RandzSpellz == 2) then
		local plr =	Unit:GetRandomPlayer(0)
		if (plr ~=nil) then
			Unit:FullCastSpellOnTarget(41377, plr)
		end
	end
end

function Essence_Killed(Unit, event)
	local EssChat = math.random(1, 2)
	if (EssChat == 1) then
		Unit:SendChatMessage(13,0,"Enough, no more!")
	end
	if (EssChat == 2) then
		Unit:SendChatMessage(83,0,"*Maniacal cackle*")
	end
end

function Essence_LeaveCombat(Unit, event)
	local args = getvars(Unit);
	args.dup = 1;
	setvars(Unit, args);
end

function Essence_Death(Unit, event)
	local args = getvars(Unit);
	Unit:SendChatMessage(13,0,"Beware,Cowards!")
	args.dup = 1;
	setvars(Unit, args);
end

--test

RegisterUnitEvent(23420, 1, "Essence_AngerOnCombat")
RegisterUnitEvent(23420, 3, "Essence_Killed")
RegisterUnitEvent(23420, 2, "Essence_LeaveCombat")
RegisterUnitEvent(23420, 4, "Essence_Death")