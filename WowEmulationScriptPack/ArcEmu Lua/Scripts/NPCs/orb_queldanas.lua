function QuelDanasOrbOne(pGameObject, Event, pMisc)
    pMisc:Teleport(530, 12783.344727, -6880.589355, 23.791157)
end

function QuelDanasOrbTwo(pGameObject, Event, pMisc)
    pMisc:Teleport(530, 12791.011719, -6891.227539, 31.820141)
end

RegisterGameObjectEvent(187428, 2, "QuelDanasOrbOne")
RegisterGameObjectEvent(187431, 2, "QuelDanasOrbTwo")