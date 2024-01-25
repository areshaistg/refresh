local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

local Hosts = ReplicatedStorage.Source.Hosts

Refresh.Reloader.Watch(Hosts.MyClientHost)

Refresh.Start()

print("Game Started")
