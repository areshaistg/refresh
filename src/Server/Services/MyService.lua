local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

local MyService = {
	Name = "MyService",
	State = { Foo = "Bar", Baz = false },
}

function MyService:OnStart()
	self.State.Bar = true
	print(self.State)
end

return Refresh.Server.RegisterService(MyService)
