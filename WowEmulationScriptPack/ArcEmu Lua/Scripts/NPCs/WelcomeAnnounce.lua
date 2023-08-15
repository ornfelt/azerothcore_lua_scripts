--[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]--
--[ Welcome Announce - Customizable ]--
--[   Credits to RakkorZ - ZxOxZ.   ]--
--[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]--
 
FIRSTENTER = {}
 
--[~~~~~~~~]--
--[ Config ]--
--[~~~~~~~~]--
 
FIRSTENTER.ServerName = "Edit this at: Tunes Repack\repack\scripts" --Change "ServerName" with your Server Name.
 
--[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]--
--[ Don't modify anything below! ]--
--[~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~]--
 
function FIRSTENTER.PlayerOnFirstEnterWorldWelcome(event, player)
        if (player:GetPlayerClass() == "Warrior") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFFC79C6E"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
        if (player:GetPlayerClass() == "Hunter") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFFABD473"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
        if (player:GetPlayerClass() == "Mage") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFF69CCF0"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
        if (player:GetPlayerClass() == "Priest") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFFFFFFFF"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
        if (player:GetPlayerClass() == "Warlock") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFF9482C9"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
        if (player:GetPlayerClass() == "Shaman") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFF2459FF"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
        if (player:GetPlayerClass() == "Druid") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFFFF7D0A"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
        if (player:GetPlayerClass() == "Paladin") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFFF58CBA"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
        if (player:GetPlayerClass() == "Rogue") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFFFFF569"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
        if (player:GetPlayerClass() == "Death Knight") then
                SendWorldMessage("|CFF35bab8<"..FIRSTENTER.ServerName.." - Announce>|r - |CFFbbbbbbWelcome our New Player:|r |CFFC41F3B"..player:GetName().."|r|CFFbbbbbb!|r", 2)
        end
end
 
RegisterServerHook(3, "FIRSTENTER.PlayerOnFirstEnterWorldWelcome")