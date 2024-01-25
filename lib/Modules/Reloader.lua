--!nonstrict

-- [[ Services ]] ----------------------------------------
local Rewire = require(script.Parent.Parent.Parent.Rewire)

-- [[ Reloader ]] ----------------------------------------
local Reloader = {}
Reloader.RewireInstance = Rewire.HotReloader.new()

function Reloader.Watch(module: ModuleScript)
	Reloader.RewireInstance:listen(module, function(cloned_mod)
		require(cloned_mod)
	end, function() end)
end

return Reloader
