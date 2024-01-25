--!strict

local TableUtil = {}

function TableUtil.Map(tbl: { [any]: any }, callbackFn: (element: any) -> any): { [any]: any }
	local res = {}
	for i, v in tbl do
		res[i] = callbackFn(v)
	end
	return res
end

function TableUtil.DeepClone(tbl: { [any]: any }): { [any]: any }
	return TableUtil.Map(tbl, function(v)
		if type(v) == "table" then
			return TableUtil.DeepClone(v)
		else
			return v
		end
	end)
end

function TableUtil.PopulateDestination(src: { [any]: any }, dst: { [any]: any })
	for i, v in src do
		if dst[i] == nil then
			if type(v) == "table" then
				dst[i] = TableUtil.DeepClone(v)
			else
				dst[i] = v
			end
		end
	end
end

return TableUtil
