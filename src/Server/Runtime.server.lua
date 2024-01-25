local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

local Services = script.Parent.Services

Refresh.Reloader.Watch(Services.MyService)

Refresh.Server.Start()
