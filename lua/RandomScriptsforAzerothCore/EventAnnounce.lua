local eventRegistered = false

local function SendWorldAnnouncement(eventid)
  if eventid == 17 then
    SendWorldMessage("The Lich King has sent forth his forces to attack the people of Azeroth. Quickly adventurers, defend your cities!")
  end
end

if not eventRegistered then
  RegisterServerEvent(17, SendWorldAnnouncement)
  eventRegistered = true
end