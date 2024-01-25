local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

local function createTool(toolId: string)
	local tool = Instance.new("Tool")
	tool.RequiresHandle = false
	tool:AddTag(`Tool::{toolId}`)
	return tool
end

local ToolGiver = Refresh.RegisterHost({
	Name = "ToolGiver",
	State = {
		Tools = {} :: { [Player]: { Tool } },
	},

	OnStart = function(self)
		print("start")
		local function onPlayerAdded(player: Player)
			self.State.Tools[player] = {}

			self:AddTool(player, createTool("MY_TOOL"))

			local function onCharacterAdded(character: Model)
				for _, tool in self.State.Tools[player] do
					tool:Clone().Parent = player.Backpack
				end
			end

			if player.Character then
				task.spawn(onCharacterAdded, player.Character)
			end
			player.CharacterAdded:Connect(onCharacterAdded)
		end
		for _, player in Players:GetPlayers() do
			if not player:IsA("Player") then
				continue
			end
			task.spawn(onPlayerAdded, player)
		end
		Players.PlayerAdded:Connect(onPlayerAdded)
	end,

	AddTool = function(self: Refresh.BaseHost<{ Tools: { [Player]: { Tool } } }>, player: Player, tool: Tool)
		local array = self.State.Tools[player]
		table.insert(array, tool)
	end,
})

return ToolGiver
