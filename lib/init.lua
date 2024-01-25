--!strict

-- [[ Modules ]] ----------------------------------------
local Modules = script.Modules
local Reloader = require(Modules.Reloader)
local RefreshServer = require(script.RefreshServer)
local RefreshClient = require(script.RefreshClient)

-- [[ Refresh ]] ----------------------------------------
local Refresh = {}

Refresh.Server = RefreshServer
export type BaseHandler<T> = RefreshClient.BaseHandler<T>
Refresh.Client = RefreshClient

Refresh.Reloader = Reloader

return Refresh
