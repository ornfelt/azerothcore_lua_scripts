function Pvp_Gold_Reward(_, killer, killed)
local Paccid = killer:GetAccountId()

killer:ModifyMoney(killed:GetCoinage()*(0.05 * ACCT[Paccid].Vip)) -- reward is 0.05 = 5% of victims gold multiplied by killers VIP level

end

RegisterPlayerEvent(6, Pvp_Gold_Reward)

print("Grumbo'z VIP PvP Gold Looter loaded.")
