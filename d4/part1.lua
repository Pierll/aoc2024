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

function find_xmas(mat, x, y, size_x, size_y)

  local xmas_count = 0
  local left, right, up, down = x >= 4, x <= size_x - 3, y >= 4, y <= size_y - 3 -- bound checking
  --print(left, right, up, down)
  --check left
  if left and mat[y][x-1] == 'M' and mat[y][x-2] == 'A' and mat[y][x-3] == 'S' then 
    xmas_count = xmas_count + 1
  end
  --check right
  if right and mat[y][x+1] == 'M' and mat[y][x+2] == 'A' and mat[y][x+3] == 'S' then 
    xmas_count = xmas_count + 1
  end
  --check up
  if up and mat[y-1][x] == 'M' and mat[y-2][x] == 'A' and mat[y-3][x] == 'S' then 
    xmas_count = xmas_count + 1
  end
  --check down
  if down and mat[y+1][x] == 'M' and mat[y+2][x] == 'A' and mat[y+3][x] == 'S' then 
    xmas_count = xmas_count + 1
  end
  --check down right diagonal 
  if down and right and mat[y+1][x+1] == 'M' and mat[y+2][x+2] == 'A' and mat[y+3][x+3] == 'S' then
    xmas_count = xmas_count + 1
  end

  --check down left diagonal 
  if down and left and mat[y+1][x-1] == 'M' and mat[y+2][x-2] == 'A' and mat[y+3][x-3] == 'S' then
    xmas_count = xmas_count + 1
  end

  --check up right diagonal 
  if up and right and mat[y-1][x+1] == 'M' and mat[y-2][x+2] == 'A' and mat[y-3][x+3] == 'S' then
    xmas_count = xmas_count + 1
  end

  --check up left diagonal 
  if up and left and mat[y-1][x-1] == 'M' and mat[y-2][x-2] == 'A' and mat[y-3][x-3] == 'S' then
    xmas_count = xmas_count + 1
  end
  
  return xmas_count
end

local size_x, size_y = #mat[1], #mat
local x, y = 0, 1
local xmas_count = 0
while y < size_y do
  x = x + 1
  if mat[y][x] == 'X' then 
    xmas_count = xmas_count + find_xmas(mat, x, y, size_x, size_y)
  end

  if x == size_x-1 then 
    y = y + 1
    x = 0
  end
end

print(xmas_count)
