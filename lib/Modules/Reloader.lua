--!nonstrict

-- [[ Services ]] ----------------------------------------
local RunService = game:GetService("RunService")

-- [[ Reloader ]] ----------------------------------------
local CLONED_MODULE = "__cloned_module_tag"

local Reloader = {}

function Reloader.Watch(module: ModuleScript)
	if RunService:IsStudio() then
		local cache = module:Clone()
		cache:AddTag(CLONED_MODULE)
		cache.Parent = module.Parent
		require(cache)
		module.Changed:Connect(function()
			print("Reload!")
			cache:Destroy()
			cache = module:Clone()
			cache:AddTag(CLONED_MODULE)
			cache.Parent = module.Parent
			require(cache)
		end)
	else
		require(module)
	end
end

return Reloader
