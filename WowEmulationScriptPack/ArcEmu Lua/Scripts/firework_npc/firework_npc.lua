--[[  
	
    Hungarian Half Scripting team (HHScripts).
    Copyright (C) 2009  Twl

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

--]]

local npcid = 999940


FeuerwerksNPCs = {}
local Gossip_ID = 0

function Feuerwerk_Menu(Item)
	Item:GossipMenuAddItem(30, "Fireworks", Gossip_ID, 0)
end	 

function Feuerwerk_Select(Item,_,id)
	if (id == Gossip_ID) then
		for _,Unit in pairs(FeuerwerksNPCs) do
			Feuerwerk_Feuer(Unit)
		end
	end
end	

if PDA then
	PDA.AddModule(4, Feuerwerk_Menu)
	PDA.AddModule(2, Feuerwerk_Select)
	Gossip_ID = PDA.GetID()
end

function Feuerwerk_OnGossipTalk(Unit)
	Feuerwerk_Feuer(Unit)
end

function Feuerwerk_OnSpawn(Unit)
	table.insert(FeuerwerksNPCs, Unit)
end

function Feuerwerk_Feuer(Unit)
	Unit:CastSpell(46830)
	Unit:CastSpell(46835)
	Unit:CastSpell(46829)
	Unit:CastSpell(46847)
	Unit:CastSpell(11543)
	Unit:CastSpell(11542)
	Unit:CastSpell(47004)
	Unit:CastSpell(11352)
	Unit:CastSpell(6668)
	Unit:CastSpell(30161)
	Unit:CastSpell(11541)
	Unit:CastSpell(25465)
	Unit:CastSpell(11540)
end

RegisterUnitEvent(999940, 18, "Feuerwerk_OnSpawn")
RegisterUnitGossipEvent(999940, 1, "Feuerwerk_OnGossipTalk")
