#!/usr/bin/env lua
--[[
	turns name.StackTrace and addr.StackTrace into a python script for Ghidra to import.
]]

local function slurpfile (path)
	local fh = assert(io.open(path))
	local data = fh:read "*a"
	fh:close()
	return data
end
local names = slurpfile(arg[1])
local addrs = slurpfile(arg[2])

io.write[[
# auto-generated
text = r'''
]]
for aof=1,#addrs-8,8 do
	local tof, nof = string.unpack("I4I4", addrs, aof)
	io.stdout:write(string.format("createFunction(toAddr(0x%x),%q)\n", tof, string.unpack("z", names, nof+1):gsub("%b()", ""):gsub("::", "__"):gsub(" ", "_")))
	if ((aof>>3)+1) % 1000 == 0 then
		io.stdout:write "\n"
	end
end
io.write[[
'''
for line in text.split("\n\n"):
	print(line)
	exec(line)
]]
