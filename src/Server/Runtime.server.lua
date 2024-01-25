local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

local Hosts = script.Parent.Hosts

for _, child in Hosts:GetChildren() do
	if not child:IsA("ModuleScript") then
		continue
	end
	Refresh.Reloader.Watch(child)
end

Refresh.Start()
