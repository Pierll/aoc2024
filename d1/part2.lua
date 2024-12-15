l1 = {}
l2 = {}

--insert input file into tables
file = io.lines("input")
for l in file do
	--table.insert(l1, tonumber(string.sub(l, 1, 5)))
	--table.insert(l2, tonumber(string.sub(l, 8, 13)))
	n1 = string.gsub(l, "%s%s%s%d+", "")
	n2 = string.gsub(l, "%d+%s%s%s", "")
	table.insert(l1, tonumber(n1))
	table.insert(l2, tonumber(n2))
end

-- how many times number appear in list
function howMany(list, number) 
	total = 0
	for _, n in ipairs(list) do
		if n == number then
			total = total + 1
		end
	end
	return total
end

precalc = {} -- map number -> score of apperance
result = 0

for _, n in ipairs(l1) do
	if precalc[n] == nil then
		precalc[n] = n * howMany(l2, n)
	end
	result = result + precalc[n]
end

print(result)