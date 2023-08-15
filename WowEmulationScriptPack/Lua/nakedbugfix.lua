--  ___ ___ _ __      _____   ___  ___    ___ ___ ___  _   ___ _  __
-- | __| __| |\ \    / / _ \ / _ \|   \  | _ \ __| _ \/_\ / __| |/ /
-- | _|| _|| |_\ \/\/ / (_) | (_) | |) | |   / _||  _/ _ \ (__| ' < 
-- |_| |___|____\_/\_/ \___/ \___/|___/  |_|_\___|_|/_/ \_\___|_|\_\


local function NakedBugFix(event, player)
  if not (player:HasAura(54844)) then
    player:AddAura(54844, player)
    player:RemoveAura(54844)
  end
end

RegisterPlayerEvent(3, NakedBugFix)
RegisterPlayerEvent(27, NakedBugFix)
RegisterPlayerEvent(28, NakedBugFix)