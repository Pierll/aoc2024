
l1 = {}
l2 = {}

--insert input file into tables
file = io.lines("input")
for l in file do
	table.insert(l1, tonumber(string.sub(l, 1, 5)))
	table.insert(l2, tonumber(string.sub(l, 8, 13)))
end

result = 0
table.sort(l1)
table.sort(l2)

for i=1, #l1 do
	diff = 0
	if l1[i] < l2[i] then
		diff = l2[i] - l1[i]
	else 
		diff = l1[i] - l2[i]
	end
	result = result + diff
end

print(result)