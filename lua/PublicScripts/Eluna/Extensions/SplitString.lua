--- Splits a string into a table of substrings, using spaces as the delimiter.
-- Handles quotes and single quotes to allow substrings to contain spaces.
-- @param inputstr The input string to split.
-- @return A table containing the substrings.
function SplitString(inputstr)
    -- table to store substrings
    local t = {}
    
    -- indices for the start and end of the current substring, and the current index in the table
    local e, i = 0, 1
    
    -- loop until we can't find any more substrings
    while true do
        -- index for the start of the next substring
        local b = e+1
        
        -- find the next non-whitespace character
        b = inputstr:find("%S",b) 
        
        -- if we can't find any more substrings, break out of the loop
        if b == nil then 
            break
        end
        
        -- check if the substring starts with a single quote or double quote
        -- else, find the next whitespace character to mark the end of the substring
        if inputstr:sub(b,b) == "'" then
            -- find the end of the substring
            e = inputstr:find("'", b+1)
            
            -- exclude the single quote from the substring
            b = b+1
        elseif inputstr:sub(b,b) == '"' then
             -- find the end of the substring
            e = inputstr:find('"', b+1)
            
            -- exclude the double quote from the substring
            b = b+1
        else
            e = inputstr:find("%s", b+1)
        end
        
        -- if we can't find the end of the substring, set the end index to the end of the input string
        if e == nil then
            e = #inputstr+1
        end
 
        -- add the substring to the table
        t[i] = inputstr:sub(b,e-1)
        
        -- increment the index in the table
        i = i + 1
    end
    
    -- return the table of substrings
    return t
end
