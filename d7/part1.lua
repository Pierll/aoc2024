equations = {}

for l in io.lines("input") do
  local first = true
  local nums = {}
  local res = 0
  for n in string.gmatch(l, "(%d+)") do
    if first then
      res = tonumber(n)
      first = false
    else
      table.insert(nums, tonumber(n))
    end
  end
  
  table.insert(equations, {res = res, nums = nums, solved=false})
  
end

function tablecpy(src)
  local dst = {}
  for _, n in ipairs(src) do
    table.insert(dst, n) 
  end
  return dst
end

function tableprint(tab)
  local str = "{"
  for i = 1, #tab do
    str = str .. tab[i]
    if i < #tab then str = str .. ", " end
  end
  str = str .. "}"
  return str 
end

local results_sum = 0

function solve(res, eqs, sign, sum, path, i) 
   --print("Hello " .. sign .. " " .. tableprint(eqs) .. ", " .. tableprint(path))
  --init sum
  if sum == 0 then
    sum = eqs[1]
    table.remove(eqs, 1)
  end
  table.insert(path, sign)
  if #eqs == 1 then
    if sign == '+' then
      sum = sum + eqs[1]
      --print(sum .. "=" .. sum .. " + " .. eqs[1])
    else
      sum = sum * eqs[1]
      --print(sum .. "=" .. sum .. " * " .. eqs[1])
    end
    
    if sum == res and not equations[i].solved then --don't solve it two times !
      print("for : " .. tableprint(equations[i].nums) .. "," .. tableprint(path) .. "=" .. sum)
      --if sum == res then print("^^^^^^^^^^^^^^^^^^^^ résultat trouvé !") end
      results_sum = results_sum + res
      equations[i].solved = true
    end
    return sum
  end

  if #eqs == 0 then
    print("end recursion: " .. sum)
    return sum
  end
  
  if #eqs >= 2 then
    
    if sign == '+' then 
      --print(sum .. "=" .. sum .. " + " .. eqs[1])
      sum = sum + eqs[1]
    else 
      --print(sum .. "=" .. sum .. " * " .. eqs[1])
      sum = sum * eqs[1]
    end
    
    table.remove(eqs, 1)
    solve(res, tablecpy(eqs), '+', sum, tablecpy(path), i)
    solve(res, tablecpy(eqs), '*', sum, tablecpy(path), i)
  end  
end


for i=1, #equations do
  solve(equations[i].res, tablecpy(equations[i].nums), '+', 0, {}, i)
  solve(equations[i].res, tablecpy(equations[i].nums), '*', 0, {}, i)
end

print("total: ", results_sum)
