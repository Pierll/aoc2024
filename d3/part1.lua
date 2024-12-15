local f = io.open("input", "r")
local memory = f:read("*all")

local muls = string.gmatch(memory, "mul%(%d+,%d+%)")

local sum = 0
for mul in muls do
	a, b = string.match(mul, "(%d+),(%d+)")
	sum = sum + (tonumber(a) * tonumber(b))
	--print(a, b)
end
print(sum)