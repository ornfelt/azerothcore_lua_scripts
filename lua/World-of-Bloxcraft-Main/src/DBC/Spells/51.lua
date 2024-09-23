local Database = require(workspace.DatabaseHandler)
local Opcodes = require(workspace.Opcodes)
local char = script.Caster.Value
if char:IsA("Player") then
	char = char.Character
end
local target = script.Target.Value
if target:IsA("Player") then
	target = target.Character
end
local speed = 85
local startPos = char.LeftHand.CFrame
local endPos = target.PrimaryPart.CFrame
local movingObject = game.ReplicatedStorage.SpellObjects["51"].Gobject:Clone()
movingObject.Parent = workspace
movingObject:SetPrimaryPartCFrame(char.PrimaryPart.CFrame)
movingObject:SetPrimaryPartCFrame(startPos)
local explosion = game.ReplicatedStorage.SpellObjects["1"].Fireball.Explode.A0:Clone()
local function lerp(a, b, t)
	return a:Lerp(b, t)
end

local function getTravelTime(distance, speed)
	return distance / speed
end

local function moveToTarget()
	local distance = (movingObject.PrimaryPart.Position - endPos.p).Magnitude
	local travelTime = getTravelTime(distance, speed)
	local startTime = tick()

	local function updateProjectile()
		local elapsedTime = tick() - startTime
		local t = elapsedTime / travelTime

		if t >= 1 then
			movingObject:SetPrimaryPartCFrame(endPos)

			for _,v in next, movingObject:GetChildren() do
				if v:IsA("ParticleEmitter") then
					v.Parent = target:findFirstChild("UpperTorso");
				end
			end
			return false
		end

		movingObject:SetPrimaryPartCFrame(lerp(startPos, endPos, t))
		return true
	end

	-- Connect updateProjectile function to RenderStepped
	local connection
	connection = game:GetService("RunService").RenderStepped:Connect(function()
		if not updateProjectile() then
			connection:Disconnect()
			movingObject:Destroy()
			explosion.Parent = target:findFirstChild("UpperTorso");
			for _,v in next,explosion:GetChildren() do
				v:Emit();
			end
			wait(0.35);
			for _,v in next,target:findFirstChild'UpperTorso':GetChildren() do
				if v:IsA("ParticleEmitter") then
					v:Destroy();
				end
			end
			script.Disabled = true
			script:Destroy()
		end
	end)
end

moveToTarget()
