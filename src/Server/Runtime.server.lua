local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

local Hosts = script.Parent.Hosts

Refresh.Reloader.Watch(Hosts.MyServerHost)

Refresh.Start()
