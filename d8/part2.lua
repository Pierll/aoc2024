antennas = {}
antipodes = {}
local size_x, size_y = 0, 0 --size of the grid
f = assert(io.open("input", "r"))
local x, y = 1, 1, 1
for c in f:lines(1) do -- read file and create matrix
  if c ~= '.' and c ~= '\n' then
    if antennas[c] == nil then antennas[c] = {} end
    table.insert(antennas[c], {x=x, y=y})
    x = x + 1
  elseif c == '\n' then
    y = y + 1
    if size_x == 0 then size_x = x-1 end
    x = 1
  else
    x = x + 1
  end
end
size_y = y - 1
f:close()

function find_antipode(a1, a2)
   local ant1, ant2 = {}, {} -- antipodes 
 
   if not (ant1.x >= 1 and ant1.x <= size_x and ant1.y >= 1 and ant1.y <= size_y) then
      ant1 = nil
   end
   if not (ant2.x >= 1 and ant2.x <= size_x and ant2.y >= 1 and ant2.y <= size_y) then
      ant2 = nil
   end
   return {ant1, ant2}
   
end

local unique_ant = 0

for k, antgroup in pairs(antennas) do
  for i, antenna in ipairs(antgroup) do
    local a1 = antenna
    for u=i+1, #antgroup do
      local a2 = antgroup[u]
      local ants = find_antipode(a1, a2)
      for _, ant in pairs(ants) do
        if antipodes[ant.y] == nil or antipodes[ant.y][ant.x] == nil then 
          if antipodes[ant.y] == nil then antipodes[ant.y] = {} end
          antipodes[ant.y][ant.x] = 1
          unique_ant = unique_ant + 1 
        end 
      end
    end
  end
end

print(unique_ant)
