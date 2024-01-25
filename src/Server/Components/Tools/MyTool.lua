local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Component = require(ReplicatedStorage.DevPackages.Component)

local MyTool = Component.Create({
	Tag = "Tool::MY_TOOL",
})

function MyTool.Start(self)
	print("Start")
	print(self.Instance)
end

function MyTool.Stop(self)
	print("Stop")
	print(self.Instance)
end

return MyTool
