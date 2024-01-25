local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

export type MyHandlerState = string
export type MyHandler = Refresh.BaseHandler<MyHandlerState>
local MyHandler: MyHandler = {
	Name = "MyHandler",
	State = "foo",
}

-- function MyHandler:OnInit() end

function MyHandler:OnStart()
	self.Conn = RunService.RenderStepped:Connect(function(_deltaTime: number) end)
end

function MyHandler:OnStop()
	self.Conn:Disconnect()
end

return Refresh.Client.RegisterHandler(MyHandler)
