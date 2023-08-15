--< Made by Utsjitimmie and Underseas from projectsilvermoon.net >--
--< Ask us if you want to use (a part of) this script in your repack >--
--< You may ofcourse use it for your server without asking >--

--< Have fun!
--< ~Utsjitimmie
--< ~Underseas

--26351 Blue Big
function cast_bluebig(pUnit)
    pUnit:CastSpell(26351)
end
RegisterUnitEvent(10002501, 19, "cast_bluebig")
RegisterUnitEvent(15885,18, "cast_bluebig")

--26351 Blue Big Cluster
function cast_bluebigcluster(pUnit)
    pUnit:CastSpell(26351)
    pUnit:CastSpell(26351)
    pUnit:CastSpell(26351)
    pUnit:CastSpell(26351)
end
RegisterUnitEvent(15911,18, "cast_bluebigcluster")

--26352 Green Big
function cast_greenbig(pUnit)
    pUnit:CastSpell(26352)
end
RegisterUnitEvent(10002502, 19, "cast_greenbig")
RegisterUnitEvent(15886,18, "cast_greenbig")

--26352 Green Big Cluster
function cast_greenbigcluster(pUnit)
    pUnit:CastSpell(26352)
    pUnit:CastSpell(26352)
    pUnit:CastSpell(26352)
    pUnit:CastSpell(26352)
end
RegisterUnitEvent(15912,18, "cast_greenbigcluster")

--26354 Red Big
function cast_redbig(pUnit)
    pUnit:CastSpell(26354)
end
RegisterUnitEvent(10002503, 19, "cast_redbig")
RegisterUnitEvent(15888,18, "cast_redbig")

--26354 Red Big Cluster
function cast_redbigcluster(pUnit)
    pUnit:CastSpell(26354)
    pUnit:CastSpell(26354)
    pUnit:CastSpell(26354)
    pUnit:CastSpell(26354)
end
RegisterUnitEvent(15914,18, "cast_redbigcluster")

--26355 White Big
function cast_whitebig(pUnit)
    pUnit:CastSpell(26355)
end
RegisterUnitEvent(10002504, 19, "cast_whitebig")
RegisterUnitEvent(15889,18, "cast_whitebig")

--26355 Lucky Cluster
function cast_luckycluster(pUnit)
    pUnit:CastSpell(26355)
    pUnit:CastSpell(26355)
    pUnit:CastSpell(26355)
    pUnit:CastSpell(26355)
end
RegisterUnitEvent(15918,18, "cast_luckycluster")

--26356 Yellow Big
function cast_yellowbig(pUnit)
    pUnit:CastSpell(26356)
end
RegisterUnitEvent(10002505, 19, "cast_yellowbig")
RegisterUnitEvent(15890,18, "cast_yellowbig")
