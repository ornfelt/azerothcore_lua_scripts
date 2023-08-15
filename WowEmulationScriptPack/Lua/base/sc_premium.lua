--
-- Premium methods by Daniel S. Reichenbach
--

PremiumSystem = {}
PremiumSystem.__index = PremiumSystem

-- Premium System Settings
PremiumSystem.Settings = {
    Version = "1.2",
    SystemName = "|CFFE55BB0[Premium System]|r",
    ItemEntry = 41002,
    ItemEnable = false,
    CoinsCount = 1,
    ActiveKillCoins = false,
    ActiveLoginAnnounce = false,
};

setmetatable(PremiumSystem, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function PremiumSystem.new(player)
    local self = setmetatable({}, PremiumSystem)

    if (player ~= nil) then
        -- store Account Id for updating data etc.
        self.AccountId = player:GetAccountId()

        -- query premium settings
        local PlayerPremiumStatus = AuthDBQuery("SELECT * FROM account_premium WHERE id = "..self.AccountId)
        if (PlayerPremiumStatus ~= nil) then
            self.Id             = PlayerPremiumStatus:GetInt8(0)
            self.Rank           = PlayerPremiumStatus:GetInt8(1)
            self.Coins          = PlayerPremiumStatus:GetInt32(2)
            self.ExpireDate     = PlayerPremiumStatus:GetString(3)
            self.PremiumState   = PlayerPremiumStatus:GetBool(4)
        else
            -- no premium settings found, set defaults
            self.Id             = nil
            self.Rank           = 0
            self.Coins          = 0
            self.ExpireDate     = nil
            self.PremiumState   = false
        end
    end
    return self
end

function PremiumSystem:GetAccountId()
    return self.Id
end

function PremiumSystem:GetRank()
    return self.Rank
end

function PremiumSystem:ModifyCoins(value)
    if value ~= nil then
        AuthDBQuery("UPDATE account_premium SET coins = coins + "..value.." WHERE id = "..self.AccountId)
    end
end

function PremiumSystem:GetCoins()
    return self.Coins
end

function PremiumSystem:GeExpireDate()
    return self.ExpireDate
end

function PremiumSystem:IsActive()
    return self.PremiumState
end

function PremiumSystem:CheckExpireDate()
    local ts = os.time()
    if (os.date('%Y-%m-%d %H:%M:%S', ts) > self.ExpireDate) then
        AuthDBQuery("UPDATE account_premium SET active = 0 WHERE id = "..self.AccountId)
        return true
    end
end

function PremiumSystem:SetAccount()
    AuthDBQuery(string.format("INSERT INTO account_premium (`id`) VALUES (%s)", self.AccountId))
end
