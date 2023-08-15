-------------------------------------------------------------------
-- This script is created by zdroid9770; please do not edit this --
-- script and claim it as your own, as of All rights are claimed --
-- by me.                                                        --
--                     Copyright© zdroid9770					 --
-------------------------------------------------------------------

function JahnTreigen_phase1(Unit, Event)
	if Unit:GetHealthPct() < 95 then
		Unit:RemoveEvents()
		Unit:SetModel(20295)
		Unit:SetScale(0.6)
		Unit:FullCastSpell(32372)
		Unit:FullCastSpell(32372)
		Unit:RegisterEvent("JahnTreigen_phase19",1000, 0)
		Unit:RegisterEvent("JahnTreigen_Cyclone",10000, 0)
		Unit:RegisterEvent("JahnTreigen_Crystal",6500, 0)
	end
end

function JahnTreigen_Cyclone(Unit, Event)
    local plr = Unit:GetMainTank()
	if (plr ~= nil) then
		Unit:FullCastSpellOnTarget(42495, plr)
	end
end

function JahnTreigen_Crystal(Unit, Event)
    local plr = Unit:GetMainTank()
	if (plr ~= nil) then
		Unit:FullCastSpellOnTarget(29765, plr)
	end
end

function JahnTreigen_phase19(Unit, Event) 
	if Unit:GetHealthPct() < 70 then
		Unit:RemoveEvents()
		Unit:SetModel(19951)
		Unit:SetScale(1.1)
		Unit:CastSpell(41117)
		Unit:CastSpell(34522)
		Unit:CastSpell(34522)
		Unit:RegisterEvent("JahnTreigen_Darkstrike",6500, 0)
		Unit:RegisterEvent("JahnTreigen_Darkdot",9000, 0)
		Unit:RegisterEvent("JahnTreigen_phase20",1000, 0)
	end
end

function JahnTreigen_Darkstrike(Unit, Event)
    local plr = Unit:GetMainTank()
	if (plr ~= nil) then
		Unit:FullCastSpellOnTarget(19777, plr)
	end
end

function JahnTreigen_Darkdot(Unit, Event)
   local plr = Unit:GetMainTank()
	if (plr ~= nil) then
		Unit:FullCastSpellOnTarget(45271, plr)
	end
end

function JahnTreigen_phase20(Unit, Event)
	if Unit:GetHealthPct() < 50 then
		Unit:RemoveEvents()
		Unit:SetModel(7871)
		Unit:SetScale(2)
		Unit:FullCastSpell(17431)
		Unit:FullCastSpell(17431)
		Unit:RegisterEvent("JahnTreigen_Mortalarmor",10000, 0)
		Unit:RegisterEvent("JahnTreigen_Whirlwind",6000, 0)
		Unit:RegisterEvent("JahnTreigen_Rend",14000, 0)
		Unit:RegisterEvent("JahnTreigen_phase21",1000, 0)
	end
end

function JahnTreigen_Mortalarmor(Unit, Event)
    local plr = Unit:GetMainTank()
	if (plr ~= nil) then
		Unit:FullCastSpellOnTarget(43529, plr)
	end
end

function JahnTreigen_Whirlwind(Unit, Event)
	Unit:FullCastSpell(40219)
end

function JahnTreigen_Rend(Unit, Event)
    local plr = Unit:GetMainTank()
	if (plr ~= nil) then
		Unit:FullCastSpell(36991, plr)
	end
end

function JahnTreigen_phase21(Unit, Event)
	if Unit:GetHealthPct() < 20 then
		Unit:RemoveEvents();
		Unit:SetModel(20282)
		Unit:SetScale(0.6)
		Unit:FullCastSpell(23971)
		Unit:FullCastSpell(15711)
		Unit:FullCastSpell(15711)
		Unit:RegisterEvent("JahnTreigen_Engulflames",8000, 0)
		Unit:RegisterEvent("JahnTreigen_Flameblast",12000, 0)
		Unit:RegisterEvent("JahnTreigen_Flamebuffet",19500, 0)
		Unit:RegisterEvent("JahnTreigen_phase22",1000, 0)
	end
end

function JahnTreigen_Engulflames(Unit, Event)
    local plr = Unit:GetMainTank()
	if (plr ~= nil) then
		Unit:FullCastSpellOnTarget(20019, plr)
	end
end

function JahnTreigen_Flameblast(Unit, Event)
	Unit:FullCastSpell(40631)
end

function JahnTreigen_Flamebuffet(Unit, Event)
    local plr = Unit:GetMainTank()
	if (plr ~= nil) then
		Unit:FullCastSpell(41596)
	end
end

function JahnTreigen_phase22(Unit, Event)
	if Unit:GetHealthPct() < 5 then
		Unit:SetModel(16257)
		Unit:RemoveEvents();
		Unit:RegisterEvent("JahnTreigen_start",1000, 0)
	end
end

function JahnTreigen_start(Unit, Event)
	Unit:RegisterEvent("JahnTreigen_phase1",1000, 0)
end

RegisterUnitEvent(3887, 1, "JahnTreigen_start")