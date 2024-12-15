local rules = {}
local updates = {{}}

--load file
local rule_part = true
local i = 1
for l in io.lines("input") do
	if rule_part then
		local n1, n2 = string.match(l, "(%d+)|(%d+)")
		if n1 == nil then 
			rule_part = false 
		else 
			if rules[n1] == nil then rules[n1] = {} end
			table.insert(rules[n1], n2)
		end
	else
		updates[i] = {}
		for n in string.gmatch(l, "(%d+)") do
			table.insert(updates[i], n)
		end
		i = i + 1
	end	
end
print("loaded")
function table_find(t, n) 
	for i, v in ipairs(t) do
		if v == n then return i end
	end
	return nil
end

local sum = 0
for line, update in ipairs(updates) do
	for i = 1, #update do
		local page = update[i]
		if rules[page] ~= nil then
			-- check each rules
			for _, rule in pairs(rules[page]) do
				local pos = table_find(update, rule)
				if pos ~= nil and pos < i then 
					goto continue
				end
			end
		end
	end
	sum = sum + update[math.ceil(#update/2)]
	::continue::
end

print(sum)



