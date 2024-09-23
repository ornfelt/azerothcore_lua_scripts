function reloadElunaEngine(event, player, command)
if command == "reload scripts" or command == "reloadscripts" then
ReloadEluna()
end
end

RegisterPlayerEvent(42, reloadElunaEngine)