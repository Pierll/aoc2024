local disk_str = io.lines("input")()
local disk = {}
disk_str:gsub(".",function(c) table.insert(disk,tonumber(c)) end)
local disk_e = {} -- expanded disk
local free_blocks = {}
local used_blocks = {}
-- expand the disk
local char = ''
local digit = 0
local file_id = 0
local disk_e_ptr = 1
for i=1, #disk do
	digit = disk[i]
	if i%2 == 0 then -- empty space
		char = '.'
	else -- file 
		char = file_id
		file_id = file_id + 1
	end
	for j=1, digit do
		if char == '.' then 
			table.insert(free_blocks, disk_e_ptr)
		else 
			table.insert(used_blocks, disk_e_ptr)
		end
		disk_e[disk_e_ptr] = char
		disk_e_ptr = disk_e_ptr + 1
	end
end

print("freeblocks: " .. #free_blocks)
--for _, c in ipairs(disk_e) do io.write(c) end print()

-- defrag the expanded disk
local free_block_pos = 1
local used_block_pos = #used_blocks
local checksum = 0
local checksum_pos = 1
while true do
	::continue::
	--print("freeblock=", free_blocks[free_block_pos], "usedblock=" , used_blocks[used_block_pos])
	disk_e[free_blocks[free_block_pos]] = disk_e[used_blocks[used_block_pos]]
	disk_e[used_blocks[used_block_pos]] = '.'
	free_block_pos = free_block_pos + 1
	used_block_pos = used_block_pos - 1

	checksum = checksum + ((checksum_pos-1) * disk_e[checksum_pos])
	checksum_pos = checksum_pos + 1
	for i=1, #disk_e-1 do
		if disk_e[i] == '.' and disk_e[i+1] ~= '.' then goto continue end
	end
	break
end

-- continue the checksum
for i=checksum_pos, #disk_e do
	if disk_e[checksum_pos] ~= '.' then
		--print(i, disk_e[checksum_pos])
		checksum = checksum + ((checksum_pos-1) * disk_e[checksum_pos])
		checksum_pos = checksum_pos + 1
	end
end
print(checksum)

--for _, c in ipairs(disk_e) do io.write(c) end print()
