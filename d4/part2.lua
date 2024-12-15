mat = {{}} -- word matrix

-- read file and create matrix
f = assert(io.open("input", "r"))
local i = 1
for c in f:lines(1) do
  if c == '\n' then 
    table.insert(mat, {}) i = i + 1 
  else
    table.insert(mat[i], c)
  end
end
f:close()
print("loaded")
function find_xmas(mat, x, y, size_x, size_y)
  --print("-->search:", x, y, "(", mat[y][x], ")")
  local xmas_count = 0
  -- M on top
  if mat[y-1][x-1] == 'M' and mat[y-1][x+1] == 'M' and mat[y+1][x-1] == 'S' and mat[y+1][x+1] == 'S' then
  	xmas_count = xmas_count + 1
  end
  -- M on bottom
  if mat[y+1][x-1] == 'M' and mat[y+1][x+1] == 'M' and mat[y-1][x-1] == 'S' and mat[y-1][x+1] == 'S' then
    	xmas_count = xmas_count + 1
  end
  -- M on right side
  if mat[y+1][x+1] == 'M' and mat[y-1][x+1] == 'M' and mat[y-1][x-1] == 'S' and mat[y+1][x-1] == 'S' then
       	xmas_count = xmas_count + 1
  end
  -- M on left side 
  if mat[y+1][x-1] == 'M' and mat[y-1][x-1] == 'M' and mat[y-1][x+1] == 'S' and mat[y+1][x+1] == 'S' then
         	xmas_count = xmas_count + 1
    end
  
  return xmas_count
end

local size_x, size_y = #mat[1], #mat
local x, y = 1, 2
local xmas_count = 0
while y < size_y-1 do
  --print(x,y)
  x = x + 1
  if mat[y][x] == 'A' then 
    xmas_count = xmas_count + find_xmas(mat, x, y, size_x, size_y)
  end

  if x == size_x-2 then 
    y = y + 1
    x = 1
  end
end

print(xmas_count)
