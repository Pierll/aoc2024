--local profile = require("profile")
--local dbg = require("debugger")

local rules = {}
local updates = {{}}

--load file
local rule_part = true
local i = 1
for l in io.lines("input") do
	if rule_part then
		local n1, n2 = string.match(l, "(%d+)|(%d+)")
		n1, n2 = tonumber(n1), tonumber(n2)
		if n1 == nil or n2 == nil then 
			rule_part = false 
		else 
			if rules[n1] == nil then rules[n1] = {} end
			table.insert(rules[n1], n2)
		end
	else
		updates[i] = {}
		local u = 1
		for n in string.gmatch(l, "(%d+)") do
			updates[i][u] = tonumber(n)
			u = u + 1
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

function copyarr(arr1, arr2)
	for k1, v1 in ipairs(arr1) do
		arr2[k1] = v1
	end
end

function cmparr(arr1, arr2) 
	for k1, v1 in ipairs(arr1) do
		if arr2[k1] ~= v1 then return false end 
	end
	return true
end

local sum = 0
--profile.start()
for line, update in ipairs(updates) do
	--print("##### line " .. line .. ", size=" .. #update)
	local bad_update = false
	local update_copy = {}
	copyarr(update, update_copy)
	local is_okay = false
	while not is_okay do
		for i = 1, #update do
			local page = update[i]
			local page_pos = i
			local nbr_rules = 0 -- DEBUG
			if rules[page] ~= nil then nbr_rules = #rules[page] end --DEBUG
			--print("FOR PAGE " .. page .. ", i=" .. i, "nbr of rules: " .. nbr_rules) --DEBUG
			if rules[page] ~= nil then
				-- check each rules
				for _, rule in pairs(rules[page]) do
					local pos = table_find(update, rule)
					--print("page=", page, ", rule=", rule, "pos=", pos, ", i=", i)

					if pos ~= nil and pos < i then 
						--print("[" .. line .. "] " .. "page " .. page .. " (" .. i .. ") after " .. rule .. " (" .. pos .. ")") 
						--print("update[" .. i .. "]" .. " = " .. rule)
						update[page_pos] = rule
						--print("update[" .. pos .. "]" .. " = " .. page)
						update[pos] = page
						page_pos = pos
						bad_update = true
					end
				end
			end
		end
		--print("check: ", check_line(update, rules))
		if not cmparr(update, update_copy) then
			--print("[" .. line .. "]"  .. " Les tableaux sont différents, on recommence")
			copyarr(update, update_copy)
		else 
			--print("[" .. line .. "]"  .. " Les tableaux sont pareil")
			is_okay = true
		end
	end
	--print(update[1], update[2], update[3], update[5], update[6])
	if bad_update then
		sum = sum + update[math.ceil(#update/2)]
	end
	--profile.stop()
	--print(profile.report(10))
	
end

print(sum)


