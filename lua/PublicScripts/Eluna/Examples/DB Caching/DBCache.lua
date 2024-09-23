--[[    This is an example of caching database variables in Eluna.
 
    Following the script itself is also a database query for
    the example database table. The script is set up to query
    the character database, this can be changed by replacing 
    CharDBQuery with WorldDBQuery. You can also use CharDBExecute 
    or WorldDBExecute for delayed queries, less resource intensive,
    but can possibly be slower as they are queued.
 
    Below database structure of "example_table" would be as follows:
    - id, GuildLevel, CurrentXP
    
    After the query has been ran, the cache can then be accessed 
    like this:
 
    local gLevel = DatabaseCache[id]["GuildLevel"]
]]
 
local DatabaseCache = {}
 
local function LoadDatabase()
    local ExampleQuery = CharDBQuery("SELECT * FROM example_table;");
    if(ExampleQuery)then
        repeat
            DatabaseCache[ExampleQuery:GetUInt32(0)] = {
                GuildLevel = ExampleQuery:GetUInt32(1),
                CurrentXP = ExampleQuery:GetUInt32(2)
            };
        until not ExampleQuery:NextRow()
    end
end