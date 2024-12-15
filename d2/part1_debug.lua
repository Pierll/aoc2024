local report = {}

--load data 
local i = 1
for l in io.lines("input") do
	report[i] = {}
	local j = 1
	for n, _ in string.gmatch(l, "%d+") do
		report[i][j] = tonumber(n)
		j = j + 1
	end
	i = i + 1
end

local result = 0 -- how many reports are safe
local line_nbr = 0
for _, l in ipairs(report) do
	if line_nbr == 995 then
		print("break")
	end
	line_nbr = line_nbr + 1
	print()
	io.write(line_nbr .. ": ")
	if l[1] == l[2] then io.write("!!! " .. l[1] .. " == " .. l[2]) goto skip end
	local debug_increasing = "false"
	local increasing = l[2] >  l[1]
	if increasing then debug_increasing = "true" end
	
	for i=1, #l-1 do
		if l[i] == l[i+1] then io.write("!!! " .. l[i] .. " == " .. l[i+1]) goto skip end
		if l[i+1] > l[i] and not increasing then io.write("!!! " .. l[i+1] .. " > " .. l[i] .. " increasing=" .. debug_increasing) goto skip end
		if l[i+1] < l[i] and increasing then io.write("!!! " .. l[i+1] .. " < " .. l[i] .. " increasing=" .. debug_increasing) goto skip end
		if math.abs(l[i] - l[i+1]) > 3 then io.write("!!!  range= " .. math.abs(l[i] - l[i+1]) .. " (" .. l[i] .. "->" .. l[i+1] .. ")") goto skip end
		
	end
	result = result + 1
	::skip::
end

print("\n\nresultat:")
print(result)