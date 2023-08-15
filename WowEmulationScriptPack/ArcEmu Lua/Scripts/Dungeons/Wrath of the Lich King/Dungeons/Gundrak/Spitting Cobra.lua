 --[[
   ******************************************************************
   *	 _____              ___                           _         *
   *	(  _  )            (  _`\               _        ( )_       *
   *	| (_) | _ __   ___ | (_(_)   ___  _ __ (_) _ _   | ,_)      *
   *	|  _  |( '__)/'___)`\__ \  /'___)( '__)| |( '_`\ | |        *
   *	| | | || |  ( (___ ( )_) |( (___ | |   | || (_) )| |_       *
   *	(_) (_)(_)  `\____)`\____)`\____)(_)   (_)| ,__/'`\__)      *
   *	                                          | |               *
   *	                                          (_)               *
   *	                                                            *
   *	               OpenSource Scripting Team                    *
   *	                <http://www.arcemu.org>                     *
   *	                                                            *
   ******************************************************************
  
   This software is provided as free and open source by the
staff of The ArcScript Project, in accordance with 
the GPL license. This means we provide the software we have 
created freely and it has been thoroughly tested to work for 
the developers, but NO GUARANTEE is made it will work for you 
as well. Please give credit where credit is due, if modifying,
redistributing and/or using this software. Thank you.

Staff of ArcScript Project, Feb 2008
~~End of License Agreement

#############################################################

-- ]]
-- Scripted By:  n4xD

function Spitting_Cobra_OnCombat(Unit, Event)
Unit:RegisterEvent("Spitting_Cobra_Cobra_Strike", math.random(25000, 28000), 0)
Unit:RegisterEvent("Spitting_Cobra_Venom_Spit", math.random(14000, 18000), 0)
end

function Spitting_Cobra_OnLeaveCombat(Unit, Event)
Unit:RemoveEvents()
end

function Spitting_Cobra_OnKillTarget(Unit, Event)
end

function Spitting_Cobra_OnDeath(Unit, Event)
Unit:RemoveEvents()
end

RegisterUnitEvent(29774, 1, "Spitting_Cobra_OnCombat")
RegisterUnitEvent(29774, 2, "Spitting_Cobra_OnLeaveCombat")
RegisterUnitEvent(29774, 3, "Spitting_Cobra_OnKillTarget")
RegisterUnitEvent(29774, 4, "Spitting_Cobra_OnDeath")

function Spitting_Cobra_Cobra_Strike(Unit, Event)
Unit:FullCastSpellOnTarget(55703,	Unit:GetMainTank())
end

function Spitting_Cobra_Venom_Spit(Unit, Event)
Unit:FullCastSpellOnTarget(55700,	Unit:GetRandomPlayer(0))
end
