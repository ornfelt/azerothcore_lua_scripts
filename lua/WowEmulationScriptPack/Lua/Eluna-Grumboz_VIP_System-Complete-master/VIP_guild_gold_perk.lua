-- Guild Farming perk
-- Originally scripted by FoeReaper
-- Converted to Eluna by Slp13at420
-- This will deposit 10% of a guild members looted gold into there guild bank.
-- this will also use the players VIP level as a multiplier for deposited gold.
--
function GBank_Loot(eventid, player, gold)
local Paccid = player:GetAccountId()

local currency = ""
local convert = 0
local Money = {}
local Vip = ACCT[Paccid].Vip
Money.CopperMath = (math.floor(gold))-(math.floor((gold*0.01)/10^0)*100)
Money.SilverMath = (math.floor(gold*0.01)/10^0)-(math.floor((gold*0.0001)/10^0)*100)
Money.GoldMath = (math.floor(gold*0.0001)/10^0)

	if(gold*0.1 > 0) and (gold*0.1 < 100) then
		currency = " Copper"
		convert = 0.1
	elseif(gold*0.1 >= 100) and (gold*0.1 < 10000) then
		currency = " Silver"
		convert = 0.001
	elseif(gold*0.1 >= 10000) then
		currency = " Gold"
		convert = 0.00001
	end

	if(Money.CopperMath > 0) and (Money.SilverMath > 0) then
		Money.CopperComma = ", "
	else
		Money.CopperComma = ""
	end
	if(Money.SilverMath > 0) and (Money.GoldMath > 0) then
		Money.SilverComma = ", "
	else
		Money.SilverComma = ""
	end

	if(Money.CopperMath > 0) then
		Money.Copper = ""..Money.CopperMath.." Copper"
	else
		Money.CopperComma = ""
		Money.Copper = ""
	end
	if(Money.SilverMath > 0) then
		Money.Silver = ""..Money.SilverMath.." Silver"
	else
		Money.Silver = ""
	end
	if(Money.GoldMath > 0) then
		Money.Gold = ""..Money.GoldMath.." Gold"
	else
		Money.Gold = ""
	end
	
	if(gold > 0) then
		if(player:IsInGuild()) then
			player:GetGuild():DepositBankMoney(player, (math.floor(gold*0.1)*(Vip)))
			player:SendBroadcastMessage("("..(math.floor(((gold)*Vip)*convert)/10^0)..currency.." deposited to guild bank.)")
		end
	end
end

RegisterPlayerEvent(37, GBank_Loot)
print("Grumbo'z VIP Guild Gold Perk loaded.")
