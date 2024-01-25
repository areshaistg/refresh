local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Refresh = require(ReplicatedStorage.Packages.Refresh)

local Handlers = ReplicatedStorage.Source.Handlers

Refresh.Reloader.Watch(Handlers.MyHandler)

Refresh.Client.Start()

print("Game Started")
