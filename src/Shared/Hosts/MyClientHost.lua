local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

export type MyClientHost = Refresh.BaseHost<string>
local MyClientHost: MyClientHost = {
	Name = "MyClientHost",
	State = "foo",
}

-- function MyClientHost:OnInit() end

function MyClientHost:OnStart()
	self.Conn = RunService.RenderStepped:Connect(function(_deltaTime: number) end)
	print("Foo")
end

function MyClientHost:OnStop()
	self.Conn:Disconnect()
end

return Refresh.RegisterHost(MyClientHost)
