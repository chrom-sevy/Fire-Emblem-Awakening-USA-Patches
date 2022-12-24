#!/usr/bin/env lua
--[[
	turns debug information from name.StackTrace and addr.StackTrace into asm labels
]]

local function slurpfile (path)
	local fh = assert(io.open(path))
	local data = fh:read "*a"
	fh:close()
	return data
end
local addrs = slurpfile(arg[1])
local names = slurpfile(arg[2])

local seen_idents = {}
for aof=1,#addrs-8,8 do
	local tof, nof = string.unpack("I4I4", addrs, aof)
	local ident = string.unpack("z", names, nof+1)

	if ident:match "%(" then
		local label1 = ident:gsub("%W", "_")
		local label2 = ident:gsub("[(<].*", ""):gsub("%W", "_")

		if not seen_idents[label1:lower()] then
			print(".definelabel", string.format("%s,0x%x", label1, tof))
			seen_idents[label1:lower()] = true
		end

		if not seen_idents[label2:lower()] and #label2 > 0 then
			print(".definelabel", string.format("%s,0x%x", label2, tof))
			seen_idents[label2:lower()] = true
		end
	end
end