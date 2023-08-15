--[[ 

        All credit goes to Rochet2 on Ac-web.org for this Awsome Gameobject player!!

]]

-- set item on use spellid 36177
local ITEM_ENTRY = 6948 -- currently set to hearthstone, please change this before using!! Else everyone can use this script.
-- Favourites:
-- Note: Favourites only last until the luaengine restarts (server restarted or luaengine), only the GOs in the GameObjects list will be permanent.
local Save_all_used = false -- use false to save only saved gameobjects to the gameobject fav list, true to save all used gameobjects.
local GameObjects = -- A list of gameobjects that you can spawn without searching ingame or searching for entry. Just add the name and the entry to the list.
{
--	{"NAME", ENTRY},
	{"Wooden Chair", 101779},
	{"Party Table", 180698},
	{"Circle of calling", 178670},
	{"Orgrim's Hammer", 192241},
}



-- Do not touch anything below
local T =
{
	Saved = {},
	Spawned = {},
	Used = {},
	Last = {},
	Options = 25 -- amount of favourites on a page
}

function T.GO(e,x,y,z,o,s,p,pPlayer,obj)
	local GO = pPlayer:SpawnGameObject(e,x,y,z,o, 0, s*100, p, 0)
	if(T.IsGO(obj) and T.IsGO(GO)) then
		if(T.Spawned[tostring(obj)] ~= nil) then
			T.Spawned[tostring(GO)] = 1
			T.Spawned[tostring(obj)] = nil
		end
		if(T.Saved[tostring(pPlayer)][tostring(obj)] ~= nil) then
			T.Saved[tostring(pPlayer)][tostring(GO)] = T.Saved[tostring(pPlayer)][tostring(obj)]
			T.Saved[tostring(pPlayer)][tostring(obj)] = nil
		end
	elseif(obj == nil and T.IsGO(GO)) then
		T.Spawned[tostring(GO)] = 1
	else
		return nil
	end
	return GO
end

function T.SaveUsed(obj, str, Saved)
	if((Save_all_used or Saved) and T.IsGO(obj)) then
		local S = true
		for k,v in ipairs(T.Used[str]) do
			if(v[2] == obj:GetEntry()) then
				S = false
				break
			end
		end
		if(S) then
			T.Used[str][#T.Used[str]+1] = {obj:GetName(), obj:GetEntry()}
		end
	end
end

function T.RFW(Unit, str) -- remove from world
	if(Unit ~= nil) then
		T.Saved[str][tostring(Unit)] = nil
		T.Spawned[tostring(Unit)] = nil
		Unit:Despawn(0, 0)
	end
end

function T.IsGO(Unit)
	if(Unit ~= nil and type(Unit) == "userdata" and Unit:GetName() ~= nil) then -- Check that the unit is not nil, is an unit and its is actually in the world.
		return true
	end
	return false
end

function T.Count(Page)
	if(not Page or Page < 1) then
		return 1
	else
		return (Page*T.Options)
	end
end

function T.Max(Count, LData)
	if(LData - Count >= T.Options) then
		return Count+T.Options-1, true
	else
		return LData, false
	end
end

function T.GetMenu(pUnit, e, pPlayer, pMisc, intid)
	local str = tostring(pPlayer)
	if(T[str] == nil) then
		T[str] = {false, 0.3, false, false, 0}
		T.Used[str] = GameObjects
		T.Saved[str] = {}
	end
	if(T.IsGO(T[str][1])) then
		pUnit:GossipCreateMenu(100, pPlayer, 0)
		if(T[str][4]) then
			pUnit:GossipMenuAddItem(4, "Use player X", 19, 0, '', 0)
			pUnit:GossipMenuAddItem(4, "Use player Y", 20, 0, '', 0)
			pUnit:GossipMenuAddItem(4, "Use player Z", 17, 0, '', 0)
			pUnit:GossipMenuAddItem(4, "Use player facing", 18, 0, '', 0)
		else
			pUnit:GossipMenuAddItem(2, "Move North", 4, 0, '', 0)
			pUnit:GossipMenuAddItem(2, "Move South", 6, 0, '', 0)
			pUnit:GossipMenuAddItem(2, "Move East", 5, 0, '', 0)
			pUnit:GossipMenuAddItem(2, "Move West", 7, 0, '', 0)
			pUnit:GossipMenuAddItem(2, "Up", 8, 0, '', 0)
			pUnit:GossipMenuAddItem(2, "Down", 9, 0, '', 0)
			pUnit:GossipMenuAddItem(2, "Turn right", 10, 0, '', 0)
			pUnit:GossipMenuAddItem(2, "Turn left", 11, 0, '', 0)
		end
		pUnit:GossipMenuAddItem(2, "Grow", 12, 0, '', 0)
		pUnit:GossipMenuAddItem(2, "Shrink", 13, 0, '', 0)
		-- pUnit:GossipMenuAddItem(2, "Set phase", 14, 1, '', 0)
		pUnit:GossipMenuAddItem(3, "SAVE", 2, 0, '', 0)
		pUnit:GossipMenuAddItem(9, "DELETE", 1, 0, 'Sure?', 0)
		pUnit:GossipMenuAddItem(4, "Change multiplier: "..T[str][2], 3, 1, '', 0)
		pUnit:GossipMenuAddItem(4, "Toggle move commands", 21, 0, '', 0)
		-- pUnit:GossipMenuAddItem(4, "Face north: "..tostring(T[str][3]), 15, 0, '', 0)
		pUnit:GossipMenuAddItem(4, "Selection", 100, 0, '', 0)
		pUnit:GossipSendMenu(pPlayer)
	else
		T.SelectTarget(pUnit, pPlayer, false)
	end
end

function T.SelectTarget(pUnit, pPlayer, Back)
	local str = tostring(pPlayer)
	pUnit:GossipCreateMenu(100, pPlayer, 0)
	if(T.IsGO(T[str][1])) then
		pUnit:GossipMenuAddItem(8, "Selected: "..T[str][1]:GetName().." Multiplier: "..T[str][2], 0, 0, '', 0)
		pUnit:GossipMenuAddItem(2, "Go to current selection", 16, 0, '', 0)
		pUnit:GossipMenuAddItem(4, "Duplicate selected", 61, 0, '', 0)
	else
		pUnit:GossipMenuAddItem(8, "Selected: None", 0, 0, '', 0)
	end
	if(T.Last[str] ~= nil) then
		pUnit:GossipMenuAddItem(4, "Respawn last used", 62, 0, '', 0)
	end
	pUnit:GossipMenuAddItem(4, "Spawn GO", 55, 1, '', 0)
	pUnit:GossipMenuAddItem(4, "Select .gob sel", 60, 0, '', 0)
	pUnit:GossipMenuAddItem(4, "Duplicate .gob sel", 58, 0, '', 0)
	if(#T.Used[str] > 0) then
		pUnit:GossipMenuAddItem(3, "Used objects", 101, 0, '', 0)
	end
	if(Back) then
		pUnit:GossipMenuAddItem(7, "Back..", 0, 0, '', 0)
	end
	pUnit:GossipSendMenu(pPlayer)
end

function T.Select(pUnit, e, pPlayer, id, intid, code)
	local str = tostring(pPlayer)
	if(T.IsGO(T[str][1]) and T[str][1]:GetMapId() ~= pPlayer:GetMapId()) then
		pPlayer:SendBroadcastMessage("You are on a different map with the selected object.")
		T.GetMenu(pUnit, e, pPlayer, pMisc, intid)
		return
	elseif(code ~= nil) then
		if(intid == 3) then
			local code = (tonumber(code))
			if(code <= 0) then
				pPlayer:SendBroadcastMessage("Only numbers above 0.")
			else
				T[str][2] = code
			end
		else
			local code = math.ceil(tonumber(code))
			if(code < 1) then
				pPlayer:SendBroadcastMessage("Only numbers above 1")
			else
				if(intid == 55) then
					local x,y,z,o = pPlayer:GetLocation()
					local Sel = T.GO(code,x,y,z,o,1,pPlayer:GetPhase(),pPlayer)
					if (Sel == nil) then
						pPlayer:SendBroadcastMessage("non-existing unit")
					else
						T[str][1] = Sel
						T.SaveUsed(Sel, str)
					end
				elseif(intid == 14) then
					if(T.IsGO(T[str][1])) then
						local Target = T[str][1]
						local x,y,z,o = Target:GetLocation()
						T[str][1] = T.GO(Target:GetEntry(),x,y,z,o,Target:GetScale(),code,pPlayer,Target)
						T.RFW(Target, str)
					else
						pPlayer:SendBroadcastMessage("non-existing unit")
					end
				end
			end
		end
	elseif(intid == 0) then
		-- T.GetMenu(pUnit, e, pPlayer, pMisc, intid)
	elseif(intid == 58) then
		local Target = pPlayer:GetSelectedGO()
		if(Target == nil) then
			pPlayer:SendBroadcastMessage("Nothing selected currently with .gob sel")
		else
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,y,z,o,Target:GetScale(),Target:GetPhase(),pPlayer)
			pPlayer:SendBroadcastMessage(T[str][1]:GetName().." copied")
			T.SaveUsed(Target, str)
		end
	elseif(intid == 60) then
		local Target = pPlayer:GetSelectedGO()
		if(Target == nil) then
			pPlayer:SendBroadcastMessage("Nothing selected currently with .gob sel")
		else
			if(T.Spawned[tostring(Target)] ~= nil) then
				local tstr = tostring(Target)
				if(T.Saved[str][tstr] ~= nil) then
					WorldDBQuery("DELETE FROM gameobject_spawns WHERE id = "..T.Saved[str][tstr]..";")
					T.Saved[str][tstr] = nil
				end
				T[str][1] = Target
				pPlayer:SendBroadcastMessage(Target:GetName().." selected")
				T.SaveUsed(Target, str)
			else
				pPlayer:SendBroadcastMessage("Object not spawned with GOmove or in this session. Duplicate instead. This avoids non-temporary GOs to appear on restart")
			end
		end
	elseif(intid == 1) then
		if(T.IsGO(T[str][1]) and T.Spawned[tostring(T[str][1])]) then
			local tstr = tostring(T[str][1])
			if(T.Saved[str][tstr] ~= nil) then
				WorldDBQuery("DELETE FROM gameobject_spawns WHERE id = "..T.Saved[str][tstr]..";")
				T.Saved[str][tstr] = nil
			end
			T.Spawned[tstr] = nil
			T[str][1]:Despawn(0, 0)
			T[str][1] = false
			pPlayer:SendBroadcastMessage("Gameobject deleted")
		else
			pPlayer:SendBroadcastMessage("Object not spawned with GOmove or in this session. Delete with .gob sel .gob del instead")
		end
	elseif(intid == 2) then
		if(T.IsGO(T[str][1])) then
			local Q = WorldDBQuery("SELECT id FROM gameobject_spawns ORDER BY id DESC LIMIT 1;")
			local I = 1
			if(Q) then
				I = Q:GetColumn(0):GetLong()+1
			end
			T.Saved[str][tostring(T[str][1])] = I
			WorldDBQuery("INSERT INTO `gameobject_spawns` (`id`, `Entry`, `map`, `position_x`, `position_y`, `position_z`, `Facing`, `orientation1`, `orientation2`, `orientation3`, `orientation4`, `State`, `Flags`, `Faction`, `Scale`, `stateNpcLink`, `phase`, `overrides`) VALUES ("..I..", "..T[str][1]:GetEntry()..", "..T[str][1]:GetMapId()..", "..T[str][1]:GetX()..", "..T[str][1]:GetY()..", "..T[str][1]:GetZ()..", "..T[str][1]:GetO()..", 0, 0, 0, 0, 1, 0, 0, "..T[str][1]:GetScale()..", 0, "..T[str][1]:GetPhase()..", 0);")
			T.SaveUsed(T[str][1], str, true)
			T[str][1] = false
			pPlayer:SendBroadcastMessage("Unit saved")
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid >= 4 and intid <= 7) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			if(intid == 4) then
				T[str][1] = T.GO(Target:GetEntry(),x+T[str][2],y,z,o,Target:GetScale(),Target:GetPhase(),pPlayer,Target)
				T.RFW(Target, str)
			elseif(intid == 5) then
				T[str][1] = T.GO(Target:GetEntry(),x,y-T[str][2],z,o,Target:GetScale(),Target:GetPhase(),pPlayer,Target)
				T.RFW(Target, str)
			elseif(intid == 6) then
				T[str][1] = T.GO(Target:GetEntry(),x-T[str][2],y,z,o,Target:GetScale(),Target:GetPhase(),pPlayer,Target)
				T.RFW(Target, str)
			elseif(intid == 7) then
				T[str][1] = T.GO(Target:GetEntry(),x,y+T[str][2],z,o,Target:GetScale(),Target:GetPhase(),pPlayer,Target)
				T.RFW(Target, str)
			end
			if(T[str][3]) then
				pPlayer:SetPosition(pPlayer:GetX(), pPlayer:GetY(), pPlayer:GetZ(), 0)
			end
		end
	elseif(intid == 8) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,y,z+T[str][2],o,Target:GetScale(),Target:GetPhase(),pPlayer,Target)
			T.RFW(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 9) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,y,z-T[str][2],o,Target:GetScale(),Target:GetPhase(),pPlayer,Target)
			T.RFW(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 12) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,y,z,o,Target:GetScale()+T[str][2],Target:GetPhase(),pPlayer,Target)
			T.RFW(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 13) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			if(Target:GetScale()-T[str][2] > 0.1) then
				local x,y,z,o = Target:GetLocation()
				T[str][1] = T.GO(Target:GetEntry(),x,y,z,o,Target:GetScale()-T[str][2],Target:GetPhase(),pPlayer,Target)
				T.RFW(Target, str)
			end
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 15) then
		if(T[str][3]) then
			T[str][3] = false
		else
			T[str][3] = true
			pPlayer:SetPosition(pPlayer:GetX(), pPlayer:GetY(), pPlayer:GetZ(), 0)
		end
	elseif(intid == 100) then
		T.SelectTarget(pUnit, pPlayer, true)
		return
	elseif(intid == 16) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			pPlayer:Teleport(Target:GetMapId(), Target:GetX(), Target:GetY(), Target:GetZ(), Target:GetO())
			T.SelectTarget(pUnit, pPlayer, true)
			return
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
			T.SelectTarget(pUnit, pPlayer, true)
			return
		end
	elseif(intid == 10) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,y,z,o-T[str][2],Target:GetScale(),Target:GetPhase(),pPlayer,Target)
			T.RFW(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 11) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,y,z,o+T[str][2],Target:GetScale(),Target:GetPhase(),pPlayer,Target)
			T.RFW(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 17) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,y,pPlayer:GetZ(),o,Target:GetScale(),Target:GetPhase(),pPlayer,Target)
			T.RFW(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 18) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,y,z,pPlayer:GetO(),Target:GetScale(),Target:GetPhase(),pPlayer,Target)
			T.RFW(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 19) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),pPlayer:GetX(),y,z,o,Target:GetScale(),Target:GetPhase(),pPlayer,Target)
			T.RFW(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 20) then
		if(T.IsGO(T[str][1])) then
			local Target = T[str][1]
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,pPlayer:GetY(),z,o,Target:GetScale(),Target:GetPhase(),pPlayer,Target)
			T.RFW(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 21) then
		if(T[str][4]) then
			T[str][4] = false
		else
			T[str][4] = true
		end
	elseif(intid == 101) then --  Favourites / used list
		if(not T[str][5] or T[str][5] < 1) then
			T[str][5] = 0
		end
		local Page = T[str][5]
		pUnit:GossipCreateMenu(100, pPlayer, 0)
		local Count = T.Count(Page)
		local Max, Next = T.Max(Count, #T.Used[str])
		for i = Count, Max do
			pUnit:GossipMenuAddItem(4, (T.Used[str][i][1]).." Entry: "..(T.Used[str][i][2]), 500+i, 0, '', 0)
		end
		if(Next) then
			pUnit:GossipMenuAddItem(7, "Next page", 490, 0, '', 0)
		end
		if(Page > 0) then
			pUnit:GossipMenuAddItem(7, "Previous page", 491, 0, '', 0)
		end
		pUnit:GossipMenuAddItem(7, "Back..", 0, 0, '', 0)
		pUnit:GossipSendMenu(pPlayer)
		return
	elseif(intid >= 500) then
		local Target = pPlayer
		local x,y,z,o = Target:GetLocation()
		local Sel = T.GO(T.Used[str][intid-500][2],x,y,z,o,1,Target:GetPhase(),pPlayer)
		if (Sel == nil) then
			pPlayer:SendBroadcastMessage("non-existing unit")
		else
			T[str][1] = Sel
			T.SaveUsed(Sel, str)
		end
	elseif(intid == 61) then
		local Target = T[str][1]
		if(T.IsGO(T[str][1])) then
			local x,y,z,o = Target:GetLocation()
			T[str][1] = T.GO(Target:GetEntry(),x,y,z,o,Target:GetScale(),Target:GetPhase(),pPlayer)
			pPlayer:SendBroadcastMessage(T[str][1]:GetName().." copied")
			T.SaveUsed(Target, str)
		else
			pPlayer:SendBroadcastMessage("non-existing unit")
		end
	elseif(intid == 62) then
		local Sel = T.GO(T.Last[str][1],T.Last[str][2],T.Last[str][3],T.Last[str][4],T.Last[str][5],T.Last[str][6],T.Last[str][7],pPlayer)
		if (Sel == nil) then
			pPlayer:SendBroadcastMessage("non-existing unit")
		else
			T[str][1] = Sel
		end
	elseif(intid == 490) then
		T[str][5] = T[str][5] + 1
		T.Select(pUnit, e, pPlayer, id, 101)
		return
	elseif(intid == 491) then
		T[str][5] = T[str][5] - 1
		T.Select(pUnit, e, pPlayer, id, 101)
		return
	-- elseif(intid == 0) then
	end
	if(T.IsGO(T[str][1])) then
		local x,y,z,o = T[str][1]:GetLocation()
		T.Last[str] = {T[str][1]:GetEntry(),x,y,z,o,T[str][1]:GetScale(), T[str][1]:GetPhase()}
	end
	T.GetMenu(pUnit, e, pPlayer, pMisc, intid)
end

RegisterItemGossipEvent(ITEM_ENTRY, 1, T.GetMenu)
RegisterItemGossipEvent(ITEM_ENTRY, 2, T.Select)