--[[
*******************************************************
*          LASP - LUA AREA SCRIPTING PROJECT          *
*                      License                        *
*******************************************************
This software is provided as free and open source by the
staff of The Lua Area Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

Translocation orbs by Yerney
-- ]]

-- //SilverMoon City to UnderCity Orb// --

function SilvertoUnder(pGameObject, event, pMisc)
pMisc:Teleport(0, 1805.0, 336.0, 71.0)
end

RegisterGameObjectEvent(184502, 2, "SilvertoUnder")


-- //UnderCity to SilverMoon City Orb// --

function UndertoSilver(pGameObject, event, pMisc)
pMisc:Teleport(530, 10021.0, -7414.0, 50.0)
end

RegisterGameObjectEvent(182546, 2, "UndertoSilver") 

-- //Falcon Watch down to up// --

function FalconWatchDownUp(pGameObject, event, pMisc)
pMisc:Teleport(530, -592.46, 4097.65, 143.25)
end

RegisterGameObjectEvent(184501, 2, "FalconWatchDownUp") 

-- //Falcon Watch Up to Down// --

function FalconWatchUpDown(pGameObject, event, pMisc)
pMisc:Teleport(530, -588.900024, 4070.80, 4.72)
end

RegisterGameObjectEvent(184500, 2, "FalconWatchDownUp") 