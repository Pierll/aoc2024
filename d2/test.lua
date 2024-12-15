function test(a) 
	table.insert(a, 2, 666)
end

a = {1,2,3}
test(a)
print(a[2])
