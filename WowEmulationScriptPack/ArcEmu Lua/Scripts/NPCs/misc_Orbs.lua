--[[ misc_Orbs.lua - Author: HellSpawn
********************************
*                                                            *
* The LUA++ Scripting Project        *
*                                                            *
********************************

This software is provided as free and open source by the
staff of The LUA++ Scripting Project, in accordance with 
the AGPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

~~End of License Agreement
-- LUA++ staff, March 26, 2008. ]]


--Falcon Watch lower area to roof--

function Falcon_Orb(pGameObject, Event, pMisc)
    pMisc:Teleport(530, -592.200012, 4070.199951, 143.257993)
end

RegisterGameObjectEvent(184501, 2, "Falcon_Orb")
--Falcon Watch Roof to lower area--

function Falconroof_Orb(pGameObject, Event, pMisc)
    pMisc:Teleport(530, -588.900024, 4070.800049, 4.724170)
end

RegisterGameObjectEvent(184500, 2, "Falconroof_Orb")

--Duskwither Spire lower area to roof

function Duskwither_Orb(pGameObject, Event, pMisc)
    pMisc:Teleport(530, 9330.629883, -7811.870117, 136.569000)
end

RegisterGameObjectEvent(184911, 2, "Duskwither_Orb")

--Duskwither Spire roof to lower area

function Duskwitherroof_Orb(pGameObject, Event, pMisc)
    pMisc:Teleport(530, 9334.351563, -7880.743164, 74.910004)
end

RegisterGameObjectEvent(184912, 2, "Duskwitherroof_Orb")