local mathf = {}

mathf.lerp = function(a, b, t)
    return a * (1-t) + (b*t)
end

mathf.rand_norm = function()
	return math.random(1, 100)/100;
end

mathf.random = function(percent)
	return percent>=math.random(1,100)
end

mathf.GetPointNear = function(v1, v2)
	local r = 5;
	local pp = v1
	local vX = pp.X - v2.X;
	local vZ = pp.Z - v2.Z;
	local magV = math.sqrt(vX * vX + vZ * vZ);
	local aX = v2.X + vX / magV * r;
	local aZ = v2.Z + vZ / magV * r;
	return Vector3.new(aX, v2.Y, aZ);
end

mathf.GetPointInFront = function(v1, v2)
	
end

mathf.GetPointBehind = function(v1, v2)
	
end

return mathf
