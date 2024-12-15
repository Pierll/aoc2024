local mat = {{}} -- word matrix
local x, y = 1, 1 --guard position
local dir = "N" -- what direction guard is facing
local DIRS = {["^"] = "N", ["v"] = "S", ["<"] = "W", [">"] = "E"} -- map facing direction
local ROTATIONS = {N="E", E="S", S="W", W="N"}
local SKINS = {N="^", S="v", E=">", W="<"} --only for cosmetics

-- read file and create matrix
local f = assert(io.open("input_example", "r"))
local i, j = 1, 1
for c in f:lines(1) do
	if string.find("^v<>", c, 1, true) ~= nil then -- locate the guard position
		x, y = j, i 
		dir = DIRS[c] 
	end 
	if c == '\n' then 
		i = i + 1
		j = 1
		mat[i] = {}
	else
		mat[i][j] = c
		j = j + 1
	end
end
f:close()


--print("guard init pos: ", x, y, ", dir=", dir)
while true do
	old_x, old_y = x, y
	
	if (dir == "N" and mat[y-1] ~= nil and mat[y-1][x] ~= '#') or (dir == "N" and mat[y-1] == nil)  then y = y - 1 end 
	if (dir == "S" and mat[y+1] ~= nil and mat[y+1][x] ~= '#') or (dir == "S" and mat[y+1] == nil) then y = y + 1 end 
	if dir == "W" and mat[y][x-1] ~= '#' then x = x - 1 end 
	if dir == "E" and mat[y][x+1] ~= '#' then x = x + 1 end 

	if old_x == x and old_y == y then -- there is an obstacle 
		-- try to rotate right
		dir = ROTATIONS[dir]
		mat[y][x] = SKINS[dir]
	else
		mat[old_y][old_x] = 'X'
		if mat[y] == nil or mat[y][x] == nil then --guard leave the map
			break
		end
		
	end
end

local distinct_pos = 0
-- count the "X" on the map
for i = 1, #mat do
	for j = 1, #mat[i] do
		if mat[i][j] == 'X' then distinct_pos = distinct_pos + 1 end
	end
end

print(distinct_pos)
