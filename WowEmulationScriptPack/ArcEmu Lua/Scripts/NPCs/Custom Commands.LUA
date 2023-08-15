--[[
---------------------------------------------------------
----------\\Diverse custoom command system\\-------------
----------\\Credits: DragonDev Rev 2\\-------------------
---------------------------------------------------------

print("Custom Commands Rev: 2 loaded")
]]
local C = { one = "#event start 1", stop = "#event end 1",
three = "#event idle", info = "#help", win = "#event winner",  
stats = "#coreinfo", check = "#event check",
go = "#event go", B = "#bank", news = "#news enable",
newsdisable = "#news disable", script_revive = "#script force revive",
Npc_remove_events = "#script unit return", plr_lock = "#script lock player",
lua_relaod = "#script reload engine", plr_unlock = "#script unlock player",
reload_world_items = "#database reload world items", relaod_world_creature = "#database reload creature",
reload_world_vendors = "#database reload vendors", remove_all = "#aura removeall",
admin_lock_all = "#adminscript lock all players", admin_unlock_all = "#adminscript unlock all players",
global_summon_all = "#global summon all", NPC_Return = "#script unit active",
reset_target_talents = "#script reset target talents", admin_rehash_server = "#adminscript rehash server",
kick = "#kick player", ban = "#ban player", }
 
------------------------
--\\Modifyable point\\--
------------------------
 
News_Enable = 0 -- disabled by default
news = string.format("Please, obey the rules and be sure to send all bugg reports to our forums")
 
Welcome_Enable = 0 -- disabled by default
Welcome_MSG = string.format("Welcome to World Of the Dam! We hope you enjoy your stay here!")
 
local ACTIVE = 0
local IDLE = 0
 
-----------------------------------------------
--\\Do not modify anything beond this point\\--
-----------------------------------------------
 
Hook = {}
 
function Hook.CustomCommands(event, plr, msg, type, lang)
 
local Target = plr:GetSelection()  
L = {}
Banned = {}  
 
      if(msg == C.one) then -- command to make your event active
        if(plr:IsGm() == true) then      
          ACTIVE = 1
          Waypoint = PerformIngameSpawn(1, 76128, plr:GetMapId(), plr:GetX(), plr:GetY(), plr:GetZ(), plr:GetO(), 1, 0)    
                  for k,v in pairs(GetPlayersInWorld()) do  
          v:SendBroadcastMessage("|cff00ff00[Event MGR]An event has been started by " ..plr:GetName().. " Please type (#event go) to join!")
          plr:SendBroadcastMessage("[Event MGR] The location of your event has been marked by the event waypoint!")
      if(IDLE == 1) then
      plr:SendBroadcastMessage("[Event MGR] An event is already pending")
                    end
            end
      end
end
 
      if(msg == C.stop) then  
        if(plr:IsGm() == true and ACTIVE == 1) then
          ACTIVE = 0
          IDLE = 0
          for k,v in pairs(GetPlayersInWorld()) do
          v:SendBroadcastMessage("|cff00ccff[Event MGR] The event started by " ..plr:GetName().. " Is now over you will be teleported to Gadgetzan in (10 seconds)|r")
          RegisterTimedEvent("eventend", 10000, 1)
       if(Waypoint ~= nil) then -- fixes the crash that occured during testing
                return k
             end
         end
     end
end
 
       if(msg == C.three) then
         if(plr:IsGm() == true) then
           if(ACTIVE == 1) then
       plr:SendBroadcastMessage("You have an event active already")
   else
         IDLE = 1
             for k,v in pairs(GetPlayersInWorld()) do
            v:SendBroadcastMessage("|cff00ccff[Event MGR] An event is currently pending...|r")
               end  
          end
     end
end      
     
       if(msg == C.check) then
         if(plr:IsGm() == true) then
            if(ACTIVE == 0) then
           plr:SendBroadcastMessage("[Event MGR]There are no events active, feel free to start one")
  else
           plr:SendBroadcastMessage("[Event MGR]There is already an event active, check back when it is over")
          end
     end
end    
        if(msg == C.win and ACTIVE == 1) then
          if(plr:IsGm() == true) then
             for k,v in pairs(GetPlayersInWorld()) do
                 v:SendBroadcastMessage("|cff00ccffThe event is now over! " ..Target:GetName().. " Is the winner!")
             Target:SendBroadcastMessage("Congrats you have won the event!!")  
             end
       end
end            
 
        if(msg == C.B) then
          if(plr:IsGm() == true) then
           plr:SendBankWindow(plr)
           end
end  
 
        if(msg == C.news and News_Enable == 0) then
          if(plr:IsGm() == true) then
          News_Enable = 1
          plr:SendBroadcastMessage("Server news has been enabled, it will be broadcasted in (2) minutes")
          end
end  
 
        if(msg == C.newsdisable and News_enable == 1) then
          if(plr:IsGm() == true) then
        News_Enable = 0
        plr:SendBroadcastMessage("Server news has been disabled")
        RemoveTimedEvent("News_Broadcast")
        end
end
            if(News_Enable == 1) then
        RegisterTimedEvent("News_Broadcast", 120000, 0)
end
            if(msg == C.script_revive) then
              if(plr:IsGm() == true) then
              Target:ResurrectPlayer(Target)
              Target:SetHealthPct(100)
              end
end
            if(msg == C.Npc_remove_events) then
              if(plr:IsGm() == true) then
                if(Target:IsPlayer() == true) then
              plr:SendBroadcastMessage("Your target must be an NPC")
       else  
               Target:SetCombatCapable(1)
               Target:ReturnToSpawnPoint()  
               Target:RemoveEvents()  
               plr:SendBroadcastMessage("NPC " ..Target:GetName().. " Has been disabled")
              end
        end
end
            if(msg == C.NPC_return) then
              if(plr:IsGm() == true) then
                if(Target:IsPlayer() == true) then
               plr:SendBroadcastMessage("Your target must be an NPC")
         else
               Target:SetCombatCapable(0)  
               plr:SendBroadcastMessage("NPC " ..Target:GetName().. " Has been enabled")
               end
        end
end
 
 
        if(msg == C.plr_lock) then
          if(plr:IsGm() == true) then
            Target:SetPlayerLock(true)
            L[tostring(plr)] = 1 -- player is now saved as "Locked"
            plr:SendBroadcastMessage("Locking target")  
            Target:SendBroadcastMessage("|cffff0000You character has been locked from control by|r " ..plr:GetName())
            end
end
        if(msg == C.plr_unlock) then
          if(plr:IsGm() == true) then
            Target:SetPlayerLock(false)
            L[tostring(plr)].plr = 0 --- players "Lock" is no longer saved
            plr:SendBroadcastMessage("Unlocking target")
            Target:SendBroadcastMessage("You character is now back in your control")      
            end
end
 
        if(msg == C.admin_lock_all) then
          if(plr:GetGmRank() == "az") then
            for k,v in pairs(GetPlayersInWorld()) do
              if(v:IsGm() == false) then
                v:SetPlayerLock(true)
                v:SendBroadcastMessage("Everyone on the server has been locked from control by " ..plr:GetName())
                  end
             end
       end
end  
 
        if(msg == C.admin_unlock_all) then
          if(plr:GetGmRank() == "az") then
               for k,v in pairs(GetPlayersInWorld()) do
                   v:SetPlayerLock(false)
                   v:SendBroadcastMessage("Everyone on the server now has control of there characters")
                    end
           end
end
 
        if(msg == C.reload_world_items) then
          if(plr:IsGm() == true) then
            ReloadTable("items")
            print("world table (Items) has been reloaded by " ..plr:GetName())
            plr:SendBroadcastMessage("Item tables were reloaded successfully!")
            end
end
         if(msg == C.reload_world_creature) then
           if(plr:IsGm() == true) then
            ReloadTable("creature_names")
            ReloadTable("creature_proto")
            print("world table (Creature_Names) and (Creature_Proto) has been reloaded by " ..plr:GetName())
            plr:SendBroadcastMessage("Creature tables were reloaded successfully!")
            end
end
          if(msg == C.reload_world_vendors) then
            if(plr:IsGm() == true) then
            ReloadTable("vendors")
            print("world table (vendors) has been reloaded by " ..plr:GetName())
            plr:SendBroadcastMessage("Vendor tables were reloaded successfully!")
            end
end
 
          if(msg == C.remove_all) then
            if(plr:IsGm() == true) then
              plr:RemoveAllAuras()
              plr:SendBroadcastMessage("All auras have been removed")
              end
end
          if(msg == C.global_summon_all) then
            if(plr:IsGm() == true) then
              for k,v in pairs(GetPlayersInWorld()) do
                  v:Teleport(plr:GetMapId(), plr:GetX(), plr:GetY(), plr:GetZ())
                  end
         end
end
          if(msg == C.reset_target_talents) then
            if(plr:IsGm() == true) then
              Target:ResetTalents()
              Target:SendBroadcastMessage("GM " ..plr:GetName().. " Has reset your talent points")
              plr:SendBroadcastMessage("Reseting your targets talent points")
              end
end
 
          if(msg == C.admin_rehash_server) then
            if(plr:GetGmRank() == "az") then
              Rehash()
            end
end
 
          if(msg == C.kick) then
            if(plr:IsGm() == true) then
            Target:SoftDisconnect()
            end
end
          if(msg == C.ban) then
            if(plr:IsGm() == true) then
            Target:SoftDisconnect()
            Banned[tostring(plr)] = 1  
            player:SendBroadcastMessage("Your target has been banned from your servers, please keep in mind that you can not un-ban a baned player")
            end
end
 
         if(msg == C.stats) then
          if(plr:IsGm() == true) then
       plr:SendBroadcastMessage("Core Information")
       plr:SendBroadcastMessage("Server Core: ArcEmu")
       plr:SendBroadcastMessage("Core Revision: " ..GetArcemuRevision())
       plr:SendBroadcastMessage("Script Engine: " ..GetLuaEngine())
       plr:SendBroadcastMessage("Script Engine Version: " ..GetLuaEngineVersion())
       end
end
     
 
       if(msg == C.info) then
         if(plr:IsGm() == true) then
       plr:SendBroadcastMessage("Your # Gm commands are as followed")
       plr:SendBroadcastMessage("------------------------------------------")
       plr:SendBroadcastMessage("#event start 1 (Starts an event)")
       plr:SendBroadcastMessage("#event end 1 (Force ends an event)")
       plr:SendBroadcastMessage("#event idle (Sends out a messgae to all players that an event is in progress")
       plr:SendBroadcastMessage("#event go (Teleports you to an active event, this command is also avalable to players!)")
       plr:SendBroadcastMessage("#event winner (Declares the winner of your event, and boradcasts it to everyone on the server")  
       plr:SendBroadcastMessage("#coreinfo (Displays the servers core information, added for Dev's)")
       plr:SendBroadcastMessage("#news enable (Enables the boradcasting of server news)")
       plr:SendBroadcastMessage("#news disable (Disables the broadcasting of server news)")
       plr:SendBroadcastMessage("#bank (Checks your bank tab, Added for fun")  
       plr:SendBroadcastMessage("#script force revive (Forces your target to revive)")  
       plr:SendBroadcastMessage("#script lock player (locks a player from all control)")
       plr:SendBroadcastMessage("#script unlock player(gives the player control of his character once more)")  
       plr:SendBroadcastMessage("#script unit return (Removes an NPc's script events, added for Dev's)")
       plr:SendBroadcastMessage("#script reload engine (Reloads the cores script engine, added for Dev's)")
       plr:SendBroadcastMessage("#script reset target talents (Resets the talent points of your selected player)")
       plr:SendBroadcastMessage("#adminscript lock all players (locks all players on the server, Admin only)")
       plr:SendBroadcastMessage("#adminscript unlock all players (unlocks all players on the server, Admin only)")  
       plr:SendBroadcastMessage("#adminscript rehash server (Reloads the servers configuration files, Admin only)")
       plr:SendBroadcastMessage("#database reload world items (Reloads the database table (Items))")  
       plr:SendBroadcastMessage("#database reload world creature (Reloads both creature database tables)")
       plr:SendBroadcastMessage("#database reload world vendors (Reloads all vendor tables)")  
       plr:SendBroadcastMessage("#aura removeall (Removes all auras from you)")
       plr:SendBroadcastMessage("#global summon all (Summons every player on the server)")
       plr:SendBroadcastMessage("#kick player (Disconnects a player from the server)")
       plr:SendBroadcastMessage("#ban player (Bans a player from the server)")
       plr:SendBroadcastMessage("-------------------------------------------")
       end
end
 
      if(msg == C.go) then
        plr:Teleport(Waypoint:GetMapId(), Waypoint:GetX(), Waypoint:GetY(), Waypoint:GetZ(), Waypoint:GetO())
        end
end    
 
function eventend()
      Waypoint:Despawn(10, 0)
      for k,v in pairs(Waypoint:GetInRangePlayers()) do    
      v:Teleport(1, -7139.164, -3782.587, 8.7)
      end
end
 
function News_Broadcast()
   for k,v in pairs(GetPlayersInWorld()) do
       v:SendBroadcastMessage("|cFFFFA500[Server News] "..news)
       end
end  
 
function Hook.Welcome(event, plr)
if(Welcome_Enable == 1) then
   plr:SendBroadcastMessage(Welcome_MSG)
       end
end
 
RegisterServerHook(3, "Hook.Welcome")  
 
function Check_If_Locked(event, plr)
if(L[tostring(plr)] == 1) then
plr:SendBroadcastMessage("|cffff0000Your character has been Locked, you may not have use of your character until a GM grants you control, Don't break the rules|r")
plr:SetPlayerLock(true)
return L[tostring(plr)]
       end
end
 
function Check_If_Banned(event, plr)
if(Banned[tostring(plr)] == 1) then
plr:SoftDisconnect()
return Banned[tostring(plr)]
      end
end
 
RegisterServerHook(4, "Check_If_Banned")
RegisterServerHook(4, "Check_If_Locked")
RegisterServerHook(16, "Hook.CustomCommands")