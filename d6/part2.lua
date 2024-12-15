local mat = {{}} -- word matrix
local x, y = 1, 1 --guard position
local dir = "N" -- what direction guard is facing
local DIRS = {["^"] = "N", ["v"] = "S", ["<"] = "W", [">"] = "E"} -- map facing direction
local ROTATIONS = {N="E", E="S", S="W", W="N"}

-- read file and create matrix
local f = assert(io.open("input", "r"))
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

function is_loop(mat, x, y, dir)
	local visited = {}
	local old_x, old_y = 0
	while true do
		old_x, old_y = x, y
		
		if (dir == "N" and mat[y-1] ~= nil and mat[y-1][x] ~= '#') or (dir == "N" and mat[y-1] == nil)  then y = y - 1 end 
		if (dir == "S" and mat[y+1] ~= nil and mat[y+1][x] ~= '#') or (dir == "S" and mat[y+1] == nil) then y = y + 1 end 
		if dir == "W" and mat[y][x-1] ~= '#' then x = x - 1 end 
		if dir == "E" and mat[y][x+1] ~= '#' then x = x + 1 end 

		if old_x == x and old_y == y then -- there is an obstacle 
			if visited[y] == nil then 
				visited[y] = {} 
			elseif visited[y][x] == nil then 
				visited[y][x] = {}
			elseif visited[y][x][dir] == nil then
				visited[y][x][dir] = 1
			else
				visited[y][x][dir] = visited[y][x][dir] + 1 
				if visited[y][x][dir] == 2 then return true end
			end
			
			-- try to rotate right
			dir = ROTATIONS[dir]
		else
			if mat[y] == nil or mat[y][x] == nil then --guard leave the map
				return false
			end
		end
	end
end

local obstacles = 0

for i = 1, #mat do
	print("row " .. i)
	for j = 1, #mat[i] do
		if mat[i][j] == '.' then 
			mat[i][j] = '#'
			if is_loop(mat, x, y, dir) then
				obstacles = obstacles + 1
			end
			mat[i][j] = '.'
		end
	end
end

print(obstacles)
