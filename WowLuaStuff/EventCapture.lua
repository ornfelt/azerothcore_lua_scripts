-- will capture events and spit them out into a json

-- Init frame to listen for events
abFrame = CreateFrame("FRAME", "AbotEventFrame")
abEventTable = {}

function abEventHandler(self, event, ...)
    table.insert(abEventTable, {time(), event, {...}})
end

if abFrame:GetScript("OnEvent") == nil then
    abFrame:SetScript("OnEvent", abEventHandler)
end
-- register/unregister for event
abFrame:RegisterEvent("eventName")
abFrame:UnregisterEvent("eventName")

-- dump the events to a json
abEventJson='['
for a,b in pairs(abEventTable)do 
    abEventJson=abEventJson..'{'
    for c,d in pairs(b)do 
        if type(d)=="table"then 
            abEventJson=abEventJson..'\"args\": ['
            for e,f in pairs(d)do 
                abEventJson=abEventJson..'\"'..f..'\"'
                if e<=table.getn(d)then 
                    abEventJson=abEventJson..','
                end 
            end;
            abEventJson=abEventJson..']}'
            if a<table.getn(abEventTable)then 
                abEventJson=abEventJson..','
            end 
        else 
            if type(d)=="string"then 
                abEventJson=abEventJson..'\"event\": \"'..d..'\",'
            else 
                abEventJson=abEventJson..'\"time\": \"'..d..'\",'
            end 
        end 
    end 
end;
abEventJson=abEventJson..']'
abEventTable={}

-- on exit call
abFrame:UnregisterAllEvents()