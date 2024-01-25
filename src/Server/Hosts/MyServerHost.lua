local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

local MyServerHost = {
	Name = "MyServerHost",
	State = { Foo = "Bar", Baz = false },
}

function MyServerHost:OnStart()
	self.State.Bar = true
	print(self.State)
	print("Start")
end

function MyServerHost:OnInit()
	print("Init 6")
end

return Refresh.RegisterHost(MyServerHost)
