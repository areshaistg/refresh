--!strict

-- [[ Modules ]] ----------------------------------------
local Modules = script.Modules
local Reloader = require(Modules.Reloader)
local TableUtil = require(Modules.TableUtil)

-- [[ Refresh ]] ----------------------------------------
local Refresh = {}

Refresh.Reloader = Reloader

Refresh.HasStarted = false

type Readonly<T> = T
export type BaseHost<T> = {
	State: Readonly<T>,
	Name: string,
	OnInit: (self: BaseHost<T>) -> ()?,
	OnStart: (self: BaseHost<T>) -> ()?,
	OnStop: (self: BaseHost<T>) -> ()?,
	[any]: (self: BaseHost<T>, ...any) -> ...any | any,
}

Refresh.Hosts = {} :: { [string]: BaseHost<unknown> }

function Refresh.RegisterHost<T>(host: BaseHost<T>): BaseHost<T>
	local prevHost = Refresh.Hosts[host.Name]
	if prevHost then
		if prevHost.OnStop then
			prevHost.OnStop(prevHost)
		end

		local prevState = prevHost.State :: T
		if type(prevState) == "table" then
			TableUtil.PopulateDestination(host.State, prevState)
		end

		host.State = prevState
	end

	if host.OnInit then
		host.OnInit(host)
	end

	if Refresh.HasStarted and host.OnStart then
		host.OnStart(host)
	end

	Refresh.Hosts[host.Name] = host
	return host
end

function Refresh.Start()
	if Refresh.HasStarted then
		warn("Refresh: has already started")
		return
	end
	Refresh.HasStarted = true
	for _, host in Refresh.Hosts do
		if host.OnStart then
			host.OnStart(host)
		end
	end
end

return Refresh
