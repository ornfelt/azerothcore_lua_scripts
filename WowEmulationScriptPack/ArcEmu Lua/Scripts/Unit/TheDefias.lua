--[[ Gastric - TheDefias.lua

This script makes every Defias mob say what they
normally would on retail. Except for the fact i 
can't record all of them and i can't really
randomize the phrase each of them say. Data:
121 Pathstalker
122 Highwayman
215 Night Runner
449 Knuckleduster
450 Renegade Mage
467 The Defias Traitor *EXLUDE* He isn't a defias :<
474 Rogue Wizard
481 Footpad
504 Trapper
550 Messenger
583 Ambusher
589 Pillager
590 Looter
594 Henchman
598 Miner
619 Conjurer
634 OVerseer
636 Blackguard
657 Pirate
824 Digger
909 Night Blade
910 Enchanter

function DefiasThug_onAgro(pUnit, Event)
	pUnit:SendChatMessage (11, 0, "Taste my blade!")
end
RegisterUnitEvent (38, 1, "DefiasThug_onAgro")

function DefiasCutpurse_onAgro(pUnit, Event)
	pUnit:SendChatMessage (11, 0, "Finally, a chance to use my sharpened blade!")
end
RegisterUnitEvent (94, 1, "DefiasCutpurse_onAgro")

function DefiasSmuggler_onAgro(pUnit, Event)
	pUnit:SendChatMessage (11, 0, "I'll teach you to mess with the Defias!")
end
RegisterUnitEvent (95, 1, "DefiasSmuggler_onAgro")

function DefiasBandit_onAgro(pUnit, Event)
	pUnit:SendChatMessage (11, 0, "Taste my blade!")
end
RegisterUnitEvent (116, 1, "DefiasBandit_onAgro")

-- By Gastricpenguin ]]

function DefiasTalk_onAgro(pUnit, Event)
  spin = math.random (1, 11)

      if (spin == 1) then
        pUnit:SendChatMessage (11, 0, "Taste my blade!")
        pUnit:CastSpell(8091)
      elseif (spin == 2) then
       	pUnit:SendChatMessage (11, 0, "Finally, a chance to use my sharpened blade!")
       	pUnit:CastSpell(8091)
      elseif (spin == 3) then
       	pUnit:SendChatMessage (11, 0, "I'll teach you to mess with the Defias!")
       	pUnit:CastSpell(8091)
      elseif (spin == 4) then
       	pUnit:SendChatMessage (11, 0, "Vengeance will be mine")
       	pUnit:CastSpell(8091)
      elseif (spin == 5) then
        pUnit:SendChatMessage (11, 0, "Engarde!")
        pUnit:CastSpell(8091)
      elseif (spin == 6) then
        pUnit:SendChatMessage (11, 0, "Taste my Blade!")
        pUnit:CastSpell(8091)
      elseif (spin == 7) then
        pUnit:SendChatMessage (11, 0, "Attack!")
        pUnit:CastSpell(8091)
      elseif (spin == 8) then
        pUnit:SendChatMessage (11, 0, "For the Defias!")
        pUnit:CastSpell(8091)
      elseif (spin == 9) then
        pUnit:SendChatMessage (11, 0, "You have no chance to survive!")
        pUnit:CastSpell(8091)
      elseif (spin == 10) then
        pUnit:SendChatMessage (11, 0, "You are on your way to destruction!")
        pUnit:CastSpell(8091)
      else
         print ("Error: Gastric - TheDefias.lua: function block() - invalid number rolled")
      end
end
RegisterUnitEvent (38, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (94, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (95, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (116, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (121, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (122, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (215, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (449, 1, "DefiasTalk_onAgro")
--RegisterUnitEvent (450, 1, "DefiasTalk_onAgro")
--RegisterUnitEvent (467, 1, "DefiasTalk_onAgro")
--RegisterUnitEvent (474, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (481, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (504, 1, "DefiasTalk_onAgro")
--RegisterUnitEvent (550, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (583, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (589, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (590, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (594, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (598, 1, "DefiasTalk_onAgro")
--RegisterUnitEvent (619, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (634, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (636, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (657, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (824, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (909, 1, "DefiasTalk_onAgro")
RegisterUnitEvent (910, 1, "DefiasTalk_onAgro")