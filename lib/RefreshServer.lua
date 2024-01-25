--!strict

-- [[ Modules ]] ----------------------------------------
local Modules = script.Parent.Modules
local TableUtil = require(Modules.TableUtil)

-- [[ Refresh Server ]] ----------------------------------------
local RefreshServer = {
	Services = {} :: { [string]: BaseService<unknown> },
	Started = false,
}

type Readonly<T> = T

export type BaseService<T> = {
	State: Readonly<T>,
	Name: string,
	OnInit: (self: BaseService<T>) -> ()?,
	OnStart: (self: BaseService<T>) -> ()?,
	OnStop: (self: BaseService<T>) -> ()?,
	[any]: (self: BaseService<T>, ...any) -> ...any | any,
}

function RefreshServer.RegisterService<T>(service: BaseService<T>): BaseService<T>
	local prevService = RefreshServer.Services[service.Name]
	if prevService then
		if prevService.OnStop then
			prevService.OnStop(prevService)
		end

		local prevState = prevService.State :: T
		if type(prevState) == "table" then
			TableUtil.PopulateDestination(service.State, prevState)
		end

		service.State = prevState
	end

	if service.OnInit then
		service.OnInit(service)
	end

	if RefreshServer.Started and service.OnStart then
		service.OnStart(service)
	end

	RefreshServer.Services[service.Name] = service
	return service
end

function RefreshServer.Start()
	if RefreshServer.Started then
		warn("RefreshServer: has already started")
		return
	end
	RefreshServer.Started = true
	for _, service in RefreshServer.Services do
		if service.OnStart then
			service.OnStart(service)
		end
	end
end

return RefreshServer
