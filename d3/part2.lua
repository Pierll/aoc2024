local f = io.open("bigboy.txt", "r")
local memory = f:read("*all")

local good_zones = {}
local pos = 1
local sfind = string.find
repeat
	local dont_pos = string.find(memory, "don't%(%)", pos) 
	if dont_pos == nil then break end
	table.insert(good_zones, {pos, dont_pos})
	if dont_pos > pos then pos = dont_pos end
	local _, do_pos = string.find(memory, "do%(%)", pos)	
	if do_pos == nil then break end
	pos = do_pos
until false
table.insert(good_zones, {pos, #memory})

-- calculate the mul() value in the do() zones
local sum = 0
for _, slice in ipairs(good_zones) do
	local muls = string.gmatch(memory:sub(slice[1], slice[2]), "mul%(%d+,%d+%)")
	for mul in muls do
		a, b = string.match(mul, "(%d+),(%d+)")
		sum = sum + (tonumber(a) * tonumber(b))
	end
end
print(sum)