--[[
    Clamps a value between a minimum and maximum range.

    @function Clamp
    @param value number The value to clamp
    @param min number The minimum allowed value
    @param max number The maximum allowed value
    @return number The clamped value between min and max
]]
--

function Clamp(value, min, max)
	return math.min(math.max(value, min), max)
end

--[[
    Splits a string into a table using the specified separator.

    @function SplitString
    @param str string The string to split
    @param sep string The separator to use for splitting
    @return table Table containing the split string parts
]]
--
function SplitString(str, sep)
	if type(str) ~= "string" then
		return {}
	end
	local t = {}
	for s in string.gmatch(str, "([^" .. sep .. "]+)") do
		table.insert(t, s)
	end
	return t
end

--[[
    Calculates the Levenshtein distance between two strings.
    The Levenshtein distance is the minimum number of single-character edits
    required to change one string into another.

    @function Levenshtein
    @param str1 string The first string to compare
    @param str2 string The second string to compare
    @return number The Levenshtein distance between the two strings, or -1 if invalid input
]]
--
function Levenshtein(str1, str2)
	-- Input validation
	if type(str1) ~= "string" or type(str2) ~= "string" then
		return -1
	end

	-- Handle empty strings
	if #str1 == 0 then
		return #str2
	end
	if #str2 == 0 then
		return #str1
	end

	local len1, len2 = #str1, #str2
	local matrix = {}

	-- Initialize first row
	for i = 0, len1 do
		matrix[i] = { [0] = i }
	end
	-- Initialize first column
	for j = 0, len2 do
		matrix[0][j] = j
	end

	-- Main calculation loop with early exit optimization
	for i = 1, len1 do
		for j = 1, len2 do
			if str1:sub(i, i) == str2:sub(j, j) then
				matrix[i][j] = matrix[i - 1][j - 1]
			else
				matrix[i][j] = math.min(
					matrix[i - 1][j] + 1, -- Deletion
					matrix[i][j - 1] + 1, -- Insertion
					matrix[i - 1][j - 1] + 1 -- Substitution
				)
			end
		end
	end

	return matrix[len1][len2]
end
