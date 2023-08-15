function DarknessAbolisher_entercombat(pUnit, Event)
     pUnit:SendChatMessage(12, 0, "Petty adventurers you will feel my wrath!")
end
RegisterUnitEvent (1337139, 1, "DarknessAbolisher_entercombat")

function DarknessAbolisher_die(pUnit, Event)
      pUnit:SendChatMessage(12, 0, "How could this have happened?! This is not the end!")

end
RegisterUnitEvent (1337139, 4, "DarknessAbolisher_die")

