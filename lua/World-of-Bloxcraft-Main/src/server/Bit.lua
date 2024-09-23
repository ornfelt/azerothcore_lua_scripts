local BitOps = {}

-- Bitwise AND operation
function BitOps.AND(a, b)
	local result = 0
	local bitval = 1
	while a > 0 and b > 0 do
		if a % 2 == 1 and b % 2 == 1 then -- if last bits of both numbers are 1
			result = result + bitval      -- add bitval to result
		end
		bitval = bitval * 2 -- move to next bit
		a = math.floor(a / 2)
		b = math.floor(b / 2)
	end
	return result
end

-- Bitwise OR operation
function BitOps.OR(a, b)
	local result = 0
	local bitval = 1
	while a > 0 or b > 0 do
		if a % 2 == 1 or b % 2 == 1 then
			result = result + bitval
		end
		bitval = bitval * 2
		a = math.floor(a / 2)
		b = math.floor(b / 2)
	end
	return result
end

-- Bitwise XOR operation
function BitOps.XOR(a, b)
	local result = 0
	local bitval = 1
	while a > 0 or b > 0 do
		if (a % 2 == 1 and b % 2 == 0) or (a % 2 == 0 and b % 2 == 1) then
			result = result + bitval
		end
		bitval = bitval * 2
		a = math.floor(a / 2)
		b = math.floor(b / 2)
	end
	return result
end

-- Bitwise NOT operation
function BitOps.NOT(a)
	local result = 0
	local bitval = 1
	while a > 0 do
		if a % 2 == 0 then
			result = result + bitval
		end
		bitval = bitval * 2
		a = math.floor(a / 2)
	end
	return result
end

return BitOps
