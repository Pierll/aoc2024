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

function check_report(l)
	local increasing = l[2] > l[1]
	
	for i=1, #l-1 do
		if l[i] == l[i+1] then return false end
		if l[i+1] > l[i] and not increasing then return false end
		if l[i+1] < l[i] and increasing then return false end
		if math.abs(l[i] - l[i+1]) > 3 then return false end		
	end
	
	return true
end



local result = 0 -- how many reports are safe
for _, l in ipairs(report) do	
	local ignore = 0 -- the level we ignore (start with noone)
	for i = 1, #l do
		--print("i=", i, "#l=", #l, ", ignore=", ignore)
		local ignore_num = 0 -- number we ignore
		if ignore ~= 0 then
			ignore_num = l[ignore]
			table.remove(l, ignore)
		end
		if check_report(l) then
			result = result + 1
			--print("breaking")
			break
		end 
		
		if ignore ~= 0 then
			table.insert(l, ignore, ignore_num)
		end
		
		ignore = ignore + 1
		
	end
end

print(result)

