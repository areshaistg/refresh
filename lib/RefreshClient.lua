--!strict

-- [[ Modules ]] ----------------------------------------
local Modules = script.Parent.Modules
local TableUtil = require(Modules.TableUtil)

-- [[ Refresh Client ]] ----------------------------------------
local RefreshClient = {
	Handlers = {} :: { [string]: BaseHandler<unknown> },
	Started = false,
}

type Readonly<T> = T

export type BaseHandler<T> = {
	State: Readonly<T>,
	Name: string,
	OnInit: (self: BaseHandler<T>) -> ()?,
	OnStart: (self: BaseHandler<T>) -> ()?,
	OnStop: (self: BaseHandler<T>) -> ()?,
	[any]: (self: BaseHandler<T>, ...any) -> ...any | any,
}

function RefreshClient.RegisterHandler<T>(handler: BaseHandler<T>): BaseHandler<T>
	local prevHandler = RefreshClient.Handlers[handler.Name]
	if prevHandler then
		if prevHandler.OnStop then
			prevHandler.OnStop(prevHandler)
		end

		local prevState = prevHandler.State :: T
		if type(prevState) == "table" then
			TableUtil.PopulateDestination(handler.State, prevState)
		end

		handler.State = prevState
	end

	if handler.OnInit then
		handler.OnInit(handler)
	end

	if RefreshClient.Started and handler.OnStart then
		handler.OnStart(handler)
	end

	RefreshClient.Handlers[handler.Name] = handler
	return handler
end

function RefreshClient.Start()
	if RefreshClient.Started then
		warn("RefreshClient: has already started")
		return
	end
	RefreshClient.Started = true
	for _, handler in RefreshClient.Handlers do
		if handler.OnStart then
			handler.OnStart(handler)
		end
	end
end

return RefreshClient
